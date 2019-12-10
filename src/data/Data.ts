import * as diff from 'fast-array-diff'
import { $values } from './symbol/Data'
import { iterator } from '../iterator'
import { Emitter } from '../event/Emitter'

/**
 * @class Data
 * @super Emitter
 * @since 0.7.0
 */
export class Data<T> extends Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property length
	 * @since 0.7.0
	 */
	public get length(): number {
		return this[$values].length
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	constructor(data?: Array<T> | Data<T>, options?: DataOptions<T>) {

		super()

		if (options) {
			if (options.isEqual) this.isEqual = options.isEqual
			if (options.isNewer) this.isNewer = options.isNewer
		}

		if (data == null) {
			data = []
		}

		if (data instanceof Data) {
			this[$values] = data[$values].slice(0)
			return
		}

		this[$values] = data.slice(0)
	}

	/**
	 * @method has
	 * @since 0.7.0
	 */
	public has(index: number) {
		return index > -1 && index < this.length
	}

	/**
	 * @method get
	 * @since 0.7.0
	 */
	public get(index: number): T | undefined {
		return this[$values][index]
	}

	/**
	 * @method find
	 * @since 0.7.0
	 */
	public find(predicate: (value: T) => boolean) {

		for (let value of this[$values]) {
			let found = predicate(value)
			if (found == true) {
				return value
			}
		}

		return null
	}

	/**
	 * @method findIndex
	 * @since 0.7.0
	 */
	public findIndex(predicate: (value: T) => boolean) {

		let value = this.find(predicate)
		if (value) {
			return this[$values].indexOf(value)
		}

		return null
	}
	/**
	 * @method append
	 * @since 0.7.0
	 */
	public append(data: Array<T>) {
		return this.insert(data, this.length)
	}

	/**
	 * @method insert
	 * @since 0.7.0
	 */
	public insert(rows: Array<T>, index: number) {

		if (index > this.length) {
			index = this.length
		} else if (index < 0) {
			index = 0
		}

		this[$values].splice(index, 0, ...rows)

		this.emit<DataInsertEvent<T>>('insert', { data: { index, rows } })

		return this
	}

	/**
	 * @method remove
	 * @since 0.7.0
	 */
	public remove(rows: Array<T>) {

		let index = this[$values].indexOf(rows[0])
		if (index < this.minIndex ||
			index > this.maxIndex) {
			return this
		}

		this[$values].splice(index, rows.length)

		this.emit<DataRemoveEvent<T>>('remove', { data: { index, rows } })

		return this
	}

	/**
	 * @method update
	 * @since 0.7.0
	 */
	public update(data: Array<T>) {

		let length = this.length
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

			let index = this[$values].indexOf(oldValue)
			if (index == -1) {
				continue
			}

			this[$values][index] = newValue

			this.emit<DataChangeEvent<T>>('change', { data: { index, value: newValue } })
		}

		this.emit('update')

		return this
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 */
	public reset(data: Array<T>) {

		this[$values] = data.slice(0)
		this.emit<DataReloadEvent<T>>('reload')

		return this
	}

	/**
	 * @method clear
	 * @since 0.7.0
	 */
	public clear() {

		if (this.length == 0) {
			return this
		}

		this[$values] = []
		this.emit<DataReloadEvent<T>>('reload')

		return this
	}

	//--------------------------------------------------------------------------
	// Iterator
	//--------------------------------------------------------------------------

	/**
	 * @property [Symbol.iterator]
	 * @since 0.7.0
	 */
	[Symbol.iterator]() {
		return iterator(this[$values])
	}

	//--------------------------------------------------------------------------
	// Data API
	//--------------------------------------------------------------------------

	/**
	 * @property $values
	 * @since 0.7.0
	 * @hidden
	 */
	private [$values]: Array<T> = []

	/**
	 * @property minIndex
	 * @since 0.7.0
	 * @hidden
	 */
	private get minIndex(): number {
		return 0
	}

	/**
	 * @property maxIndex
	 * @since 0.7.0
	 * @hidden
	 */
	private get maxIndex(): number {
		return this[$values].length - 1
	}

	/**
	 * @property isEqual
	 * @since 0.7.0
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
	 * @since 0.7.0
	 * @hidden
	 */
	private isNewer: any = (a: T, b: T): boolean => {
		return true
	}

	/**
	 * @method patch
	 * @since 0.7.0
	 * @hidden
	 */
	private patch(data: Array<T>) {

		let updates: Array<{
			newValue: T,
			oldValue: T
		}> = []

		let patches = diff.getPatch(this[$values], data, (a: T, b: T) => {

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
 * @interface DataOptions
 * @since 0.7.0
 */
export interface DataOptions<T> {
	isEqual?: (a: T, b: T) => boolean
	isNewer?: (a: T, b: T) => boolean
}

/**
 * @type DataInsertEvent
 * @since 0.7.0
 */
export type DataInsertEvent<T> = {
	index: number
	rows: Array<T>
}

/**
 * @type DataRemoveEvent
 * @since 0.7.0
 */
export type DataRemoveEvent<T> = {
	index: number
	rows: Array<T>
}

/**
 * @type DataChangeEvent
 * @since 0.7.0
 */
export type DataChangeEvent<T> = {
	index: number
	value: T
}

/**
 * @type DataChangeEvent
 * @since 0.7.0
 */
export type DataReloadEvent<T> = {

}
