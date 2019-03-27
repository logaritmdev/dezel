import * as diff from 'fast-array-diff'
import { Dictionary } from 'lodash'
import { bound } from '../decorator/bound'
import { watch } from '../decorator/watch'
import { Emitter } from '../event/Emitter'

/**
 * @symbol DATA
 * @since 0.1.0
 */
export const DATA = Symbol('data')

/**
 * @symbol ROWS
 * @since 0.1.0
 */
export const ROWS = Symbol('rows')

/**
 * The comparator values.
 * @enum Comparison
 * @since 0.2.0
 */
export interface DataSourceOptions<T> {
	isEqual?: (a: T, b: T) => boolean
	isNewer?: (a: T, b: T) => boolean
	filter?: (a: T) => boolean
}

/**
 * Manages an array of data.
 * @class DataSource
 * @super Emitter
 * @since 0.1.0
 */
export class DataSource<T> extends Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The data source filtered data.
	 * @property data
	 * @since 0.1.0
	 */
	public get data(): Array<T> {

		if (this.invalid == true) {
			this.invalid = false
			this[ROWS] = this.generate()
		}

		return this[ROWS]
	}

	/**
	 * The data source's size.
	 * @property size
	 * @since 0.1.0
	 */
	public get size(): number {

		if (this.invalid == true) {
			this.invalid = false
			this[ROWS] = this.generate()
		}

		return this[ROWS].length
	}

	/**
	 * @property invalid
	 * @since 0.1.0
	 * @hidden
	 */
	private invalid: boolean = false

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the data source with optional data.
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(data?: Array<T> | DataSource<T>, options?: DataSourceOptions<T>) {

		super()

		if (options) {
			if (options.isEqual) this.isEqual = options.isEqual
			if (options.isNewer) this.isNewer = options.isNewer
			if (options.filter) this.filter = options.filter
		}

		if (data == null) {
			data = []
		}

		if (data instanceof DataSource) {
			this[DATA] = data[DATA].slice(0)
			this[ROWS] = data[ROWS].slice(0)
			return
		}

		data = data.slice(0)

		this[DATA] = data
		this[ROWS] = data
	}

	/**
	 * Indicates whether the data sources has data at a specified row index.
	 * @method has
	 * @since 0.1.0
	 */
	public has(index: number) {
		return index > -1 && index < this.size
	}

	/**
	 * Returns the data at a specified row index.
	 * @method get
	 * @since 0.1.0
	 */
	public get(index: number): T | undefined {
		return this[ROWS][index]
	}

	/**
	 * Finds a value from the filtered data.
	 * @method find
	 * @since 0.1.0
	 */
	public find(predicate: (value: T) => boolean) {

		for (let value of this[ROWS]) {
			let found = predicate(value)
			if (found == true) {
				return value
			}
		}

		return null
	}

	/**
	 * Finds the index of a value from the filtered data.
	 * @method findIndex
	 * @since 0.1.0
	 */
	public findIndex(predicate: (value: T) => boolean) {

		let value = this.find(predicate)
		if (value) {
			return this[ROWS].indexOf(value)
		}

		return null
	}

	/**
	 * Appends data to the data source.
	 * @method append
	 * @since 0.1.0
	 */
	public append(data: Array<T>) {
		return this.insert(data, this.size)
	}

	/**
	 * Inserts data in the data source at a specified index.
	 * @method insert
	 * @since 0.1.0
	 */
	public insert(rows: Array<T>, index: number) {

		if (index > this.size) {
			index = this.size
		} else if (index < 0) {
			index = 0
		}

		this.invalid = true
		this[DATA].splice(index, 0, ...rows)
		this.emit<DataSourceInsertEvent<T>>('insert', { data: { index, rows } })

		return this
	}

	/**
	 * Removes data from the data source at a specified index.
	 * @method remove
	 * @since 0.1.0
	 */
	public remove(rows: Array<T>) {

		let index = this[DATA].indexOf(rows[0])
		if (index < this.minIndex ||
			index > this.maxIndex) {
			return this
		}

		this.invalid = true
		this[DATA].splice(index, rows.length)
		this.emit<DataSourceRemoveEvent<T>>('remove', { data: { index, rows } })

		return this
	}

	/**
	 * Updates the data.
	 * @method update
	 * @since 0.2.0
	 */
	public update(data: Array<T>) {

		let length = this.data.length
		if (length == 0) {
			this.reset(data)
			return this
		}

		let patch = this.patch(data)
		if (patch == null) {
			return this
		}

		if (patch.removes == length) {
			this.reset(data)
			return this
		}

		this.emit('commit', { data: patch.ops })

		for (let operation of patch.ops) switch (operation.type) {

			case 'add':
				this.insert(operation.items, operation.newPos)
				break

			case 'remove':
				this.remove(operation.items)
				break
		}

		for (let update of patch.updates) {

			let newValue = update.newValue
			let oldValue = update.oldValue

			let index = this.data.indexOf(oldValue)
			if (index == -1) {
				continue
			}

			this.invalid = true
			this[DATA][index] = newValue
			this.emit<DataSourceChangeEvent<T>>('change', { data: { index, value: newValue } })
		}

		this.emit('update')

		return this
	}

	/**
	 * Reset the data source data with new data.
	 * @method reset
	 * @since 0.1.0
	 */
	public reset(data: Array<T>) {

		this.invalid = true
		this[DATA] = data.slice(0)
		this.emit<DataSourceReloadEvent<T>>('reload')

		return this
	}

	/**
	 * Refreshes the current data.
	 * @method reload
	 * @since 0.1.0
	 */
	public reload() {

		this.invalid = true
		this.emit<DataSourceReloadEvent<T>>('reload')

		return this
	}

	/**
	 * Removes all the data source data.
	 * @method clear
	 * @since 0.1.0
	 */
	public clear() {

		if (this.size == 0) {
			return this
		}

		this.invalid = false
		this[DATA] = []
		this[ROWS] = []

		this.emit<DataSourceReloadEvent<T>>('reload')

		return this
	}

	//--------------------------------------------------------------------------
	// Data API
	//--------------------------------------------------------------------------

	/**
	 * Iterator
	 * @property [Symbol.iterator]
	 * @since 0.1.0
	 */
	[Symbol.iterator]() {
		return this[ROWS]
	}

	/**
	 * @property [DATA]
	 * @since 0.1.0
	 * @hidden
	 */
	private [DATA]: Array<T> = []

	/**
	 * @property [ROWS]
	 * @since 0.1.0
	 * @hidden
	 */
	private [ROWS]: Array<T> = []

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property minIndex
	 * @since 0.1.0
	 * @hidden
	 */
	private get minIndex(): number {
		return 0
	}

	/**
	 * @property maxIndex
	 * @since 0.1.0
	 * @hidden
	 */
	private get maxIndex(): number {
		return this[DATA].length - 1
	}

	/**
	 * @property isEqual
	 * @since 0.2.0
	 * @hidden
	 */
	private isEqual: any = (a: T, b: T): boolean => {

		let aa = a as any
		let bb = b as any

		let ida = aa.id || aa._id
		let idb = bb.id || bb._id

		if (ida == null &&
			idb == null) {
			return a == b
		}

		return ida == idb
	}

	/**
	 * @property isNewer
	 * @since 0.2.0
	 * @hidden
	 */
	private isNewer: any = (a: T, b: T): boolean => {
		return true
	}

	/**
	 * @property filter
	 * @since 0.5.0
	 * @hidden
	 */
	private filter?: DataSourceFilter<T> | null = null

	/**
	 * @method generate
	 * @since 0.1.0
	 * @hidden
	 */
	private generate() {

		let filter = this.filter
		if (filter == null) {
			return this[DATA]
		}

		return this[DATA].filter(filter)
	}

	/**
	 * @method patch
	 * @since 0.2.0
	 * @hidden
	 */
	private patch(data: Array<T>) {

		let updates: Array<{ newValue: T, oldValue: T }> = []

		let patches = diff.getPatch(this.data, data, (a: T, b: T) => {

			if (this.isEqual(a, b) == false) {
				return false
			}

			if (this.isNewer(a, b) == true) {
				updates.push({
					oldValue: a,
					newValue: b
				})
			}

			return true
		})

		if (patches.length == 0 &&
			updates.length == 0) {
			return null
		}

		let inserts = patches.filter(op => op.type == 'add').reduce((acc, val) => acc += val.items.length, 0)
		let removes = patches.filter(op => op.type == 'remove').reduce((acc, val) => acc += val.items.length, 0)

		return {
			ops: patches,
			inserts: inserts,
			removes: removes,
			updates: updates
		}
	}
}

/**
 * @type DataSourceFilter
 * @since 0.1.0
 */
export type DataSourceFilter<T> = (data: T, index: number) => boolean

/**
 * @type DataSourceReloadEvent
 * @since 0.1.0
 */
export type DataSourceReloadEvent<T> = {

}

/**
 * @type DataSourceInsertEvent
 * @since 0.1.0
 */
export type DataSourceInsertEvent<T> = {
	index: number
	rows: Array<T>
}

/**
 * @type DataSourceRemoveEvent
 * @since 0.1.0
 */
export type DataSourceRemoveEvent<T> = {
	index: number
	rows: Array<T>
}

/**
 * @type DataSourceChangeEvent
 * @since 0.2.0
 */
export type DataSourceChangeEvent<T> = {
	index: number
	value: T
}
