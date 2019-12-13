import * as diff from 'fast-array-diff'
import { $values } from './private/Data'
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
	 * The data's length.
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
	 * Initializes the data.
	 * @constructor
	 * @since 0.7.0
	 */
	constructor(items?: Array<T>, options?: DataOptions<T>) {

		super()

		if (options) {
			if (options.isEqual) this.isEqual = options.isEqual
			if (options.isNewer) this.isNewer = options.isNewer
		}

		if (items == null) {
			items = []
		}

		this[$values] = items.slice(0)
	}

	/**
	 * Indicates whether a value exists.
	 * @method has
	 * @since 0.7.0
	 */
	public has(value: T) {
		return this[$values].includes(value)
	}

	/**
	 * Retrieve a value at a specified index.
	 * @method get
	 * @since 0.7.0
	 */
	public get(index: number): T | undefined {
		return this[$values][index]
	}

	/**
	 * Indicates whether every values matche the predicate.
	 * @method every
	 * @since 0.7.0
	 */
	public every(predicate: (value: T, index: number, array: Array<T>) => boolean) {
		return this[$values].every(predicate)
	}

	/**
	 * Indicates whether some values matche the predicate.
	 * @method some
	 * @since 0.7.0
	 */
	public some(predicate: (value: T, index: number, array: Array<T>) => boolean) {
		return this[$values].some(predicate)
	}

	/**
	 * Finds the first value that matches the predicate.
	 * @method find
	 * @since 0.7.0
	 */
	public find(predicate: (value: T, index: number, array: Array<T>) => boolean) {
		return this[$values].find(predicate)
	}

	/**
	 * Loop through each values.
	 * @method each
	 * @since 0.7.0
	 */
	public each(callback: (value: T, index: number, array: Array<T>) => boolean) {
		return this[$values].forEach(callback)
	}

	/**
	 * Inserts an array of values at the end.
	 * @method append
	 * @since 0.7.0
	 */
	public append(values: Array<T>) {
		return this.insert(values, this.length)
	}

	/**
	 * Inserts an array of values at a specified index.
	 * @method insert
	 * @since 0.7.0
	 */
	public insert(values: Array<T>, index: number) {

		if (index > this.length) {
			index = this.length
		} else if (index < 0) {
			index = 0
		}

		this[$values].splice(index, 0, ...values)

		this.emit<DataInsertEvent<T>>('insert', { data: { index, items: values } })

		return this
	}

	/**
	 * Removes an array of values.
	 * @method remove
	 * @since 0.7.0
	 */
	public remove(values: Array<T>) {

		let index = this[$values].indexOf(values[0])
		if (index < this.minIndex ||
			index > this.maxIndex) {
			return this
		}

		this[$values].splice(index, values.length)

		this.emit<DataRemoveEvent<T>>('remove', { data: { index, items: values } })

		return this
	}

	/**
	 * Patches the current values using the specified values.
	 * @method update
	 * @since 0.7.0
	 */
	public update(values: Array<T>) {

		let length = this.length
		if (length == 0) {
			return this.reset(values)
		}

		let patch = this.patch(values)
		if (patch == null) {
			return this
		}

		if (patch.removes == length) {
			this.reset(values)
			return this
		}

		this.emit('modify', { data: patch.ops })

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

			this.emit<DataUpdateEvent<T>>('update', { data: { index, value: newValue } })
		}

		this.emit('commit')

		return this
	}

	/**
	 * Resets the values.
	 * @method reset
	 * @since 0.7.0
	 */
	public reset(values: Array<T>) {
		this[$values] = values.slice(0)
		this.emit<DataReloadEvent<T>>('reload')
		return this
	}

	/**
	 * Clear the values.
	 * @method clear
	 * @since 0.7.0
	 */
	public clear() {
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

		let inserts = patches.filter(op => op.type[0] == 'a').reduce((acc, val) => acc += val.items.length, 0)
		let removes = patches.filter(op => op.type[0] == 'r').reduce((acc, val) => acc += val.items.length, 0)

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
	items: Array<T>
}

/**
 * @type DataRemoveEvent
 * @since 0.7.0
 */
export type DataRemoveEvent<T> = {
	index: number
	items: Array<T>
}

/**
 * @type DataUpdateEvent
 * @since 0.7.0
 */
export type DataUpdateEvent<T> = {
	index: number
	value: T
}

/**
 * @type DataUpdateEvent
 * @since 0.7.0
 */
export type DataReloadEvent<T> = {

}
