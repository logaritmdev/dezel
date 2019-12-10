import { $touches } from './symbol/TouchList'
import { iterator } from '../iterator'
import { View } from '../view/View'
import { Touch } from './Touch'

/**
 * @class TouchList
 * @since 0.3.0
 */
export class TouchList implements Iterable<Touch> {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property length
	 * @since 0.4.0
	 */
	public get length(): number {
		return this[$touches].length
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.4.0
	 */
	constructor(touches: Array<Touch>) {
		this[$touches] = touches
	}

	/**
	 * @method get
	 * @since 0.7.0
	 */
	public get(index: number) {
		return this[$touches][index]
	}

	/**
	 * @method has
	 * @since 0.7.0
	 */
	public has(touch: Touch) {
		return this[$touches].includes(touch)
	}

	/**
	 * @method every
	 * @since 0.7.0
	 */
	public every(callback: TouchListCallback) {
		return this[$touches].every(callback)
	}

	/**
	 * @method some
	 * @since 0.7.0
	 */
	public some(callback: TouchListCallback) {
		return this[$touches].some(callback)
	}

	/**
	 * @method each
	 * @since 0.7.0
	 */
	public each(callback: TouchListCallback) {
		return this[$touches].forEach(callback)
	}

	/**
	 * @method hits
	 * @since 0.7.0
	 */
	public hits(target: View) {
		return this[$touches].find(touch => touch.hits(target)) != null
	}

	//--------------------------------------------------------------------------
	// Symbols
	//--------------------------------------------------------------------------

	/**
	 * @property [Symbol.iterator]
	 * @since 0.4.0
	 */
	public [Symbol.iterator]() {
		return iterator<Touch>(this[$touches])
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $touches
	 * @since 0.7.0
	 * @hidden
	 */
	private [$touches]: Array<Touch> = []
}

/**
 * @type TouchListCallback
 * @since 0.7.0
 */
export type TouchListCallback = (touch: Touch, index: number, array: ReadonlyArray<Touch>) => boolean