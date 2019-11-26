import * as diff from 'fast-array-diff'
import { Emitter } from '../event/Emitter'
import { $data } from './symbol/DataSource'
import { $rows } from './symbol/DataSource'
import { iterator } from '../iterator'

/**
 * @class DataSource
 * @super Emitter
 * @since 0.1.0
 */
export class DataSource<T> extends Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property data
	 * @since 0.1.0
	 */
	public get data(): Array<T> {

		if (this.invalid == true) {
			this.invalid = false
			this[$rows] = this.generate()
		}

		return this[$rows]
	}

	/**
	 * @property size
	 * @since 0.1.0
	 */
	public get size(): number {

		if (this.invalid == true) {
			this.invalid = false
			this[$rows] = this.generate()
		}

		return this[$rows].length
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
			this[$data] = data[$data].slice(0)
			this[$rows] = data[$rows].slice(0)
			return
		}

		data = data.slice(0)

		this[$data] = data
		this[$rows] = data
	}

	/**
	 * @method has
	 * @since 0.1.0
	 */
	public has(index: number) {
		return index > -1 && index < this.size
	}

	/**
	 * @method get
	 * @since 0.1.0
	 */
	public get(index: number): T | undefined {
		return this[$rows][index]
	}

	/**
	 * @method find
	 * @since 0.1.0
	 */
	public find(predicate: (value: T) => boolean) {

		for (let value of this[$rows]) {
			let found = predicate(value)
			if (found == true) {
				return value
			}
		}

		return null
	}

	/**
	 * @method findIndex
	 * @since 0.1.0
	 */
	public findIndex(predicate: (value: T) => boolean) {

		let value = this.find(predicate)
		if (value) {
			return this[$rows].indexOf(value)
		}

		return null
	}

	/**
	 * @method append
	 * @since 0.1.0
	 */
	public append(data: Array<T>) {
		return this.insert(data, this.size)
	}

	/**
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
		this[$data].splice(index, 0, ...rows)
		this.emit<DataSourceInsertEvent<T>>('insert', { data: { index, rows } })

		return this
	}

	/**
	 * @method remove
	 * @since 0.1.0
	 */
	public remove(rows: Array<T>) {

		let index = this[$data].indexOf(rows[0])
		if (index < this.minIndex ||
			index > this.maxIndex) {
			return this
		}

		this.invalid = true
		this[$data].splice(index, rows.length)
		this.emit<DataSourceRemoveEvent<T>>('remove', { data: { index, rows } })

		return this
	}

	/**
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
			this[$data][index] = newValue
			this.emit<DataSourceChangeEvent<T>>('change', { data: { index, value: newValue } })
		}

		this.emit('update')

		return this
	}

	/**
	 * @method reset
	 * @since 0.1.0
	 */
	public reset(data: Array<T>) {

		this.invalid = true
		this[$data] = data.slice(0)
		this.emit<DataSourceReloadEvent<T>>('reload')

		return this
	}

	/**
	 * @method reload
	 * @since 0.1.0
	 */
	public reload() {

		this.invalid = true
		this.emit<DataSourceReloadEvent<T>>('reload')

		return this
	}

	/**
	 * @method clear
	 * @since 0.1.0
	 */
	public clear() {

		if (this.size == 0) {
			return this
		}

		this[$data] = []
		this[$rows] = []

		this.invalid = false

		this.emit<DataSourceReloadEvent<T>>('reload')

		return this
	}

	//--------------------------------------------------------------------------
	// Iterator
	//--------------------------------------------------------------------------

	/**
	 * @property [Symbol.iterator]
	 * @since 0.1.0
	 */
	[Symbol.iterator]() {
		return iterator(this[$rows])
	}

	//--------------------------------------------------------------------------
	// Data API
	//--------------------------------------------------------------------------

	/**
	 * @property $data
	 * @since 0.7.0
	 * @hidden
	 */
	private [$data]: Array<T> = []

	/**
	 * @property $rows
	 * @since 0.7.0
	 * @hidden
	 */
	private [$rows]: Array<T> = []

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
		return this[$data].length - 1
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
	private filter: DataSourceFilter<T> | null = null

	/**
	 * @method generate
	 * @since 0.1.0
	 * @hidden
	 */
	private generate() {

		let filter = this.filter
		if (filter == null) {
			return this[$data]
		}

		return this[$data].filter(filter)
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
 * @enum DataSourceOptions
 * @since 0.2.0
 */
export interface DataSourceOptions<T> {
	isEqual?: (a: T, b: T) => boolean
	isNewer?: (a: T, b: T) => boolean
	filter?: (a: T) => boolean
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
