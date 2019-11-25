import { View } from '../view/View'
import { $touches } from './symbol/TouchList'
import { iterator } from '../iterator'
import { Touch } from './Touch'

/**
 * Manages a list of touches.
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
	 * @method item
	 * @since 0.4.0
	 */
	public item(index: number) {
		return this[$touches][index]
	}

	/**
	 * @method hits
	 * @since 0.7.0
	 */
	public hits(target: View) {

		let result = this[$touches].find(touch => touch.hits(target))
		if (result) {
			return true
		}

		return false
	}

	//--------------------------------------------------------------------------
	// Symbols
	//--------------------------------------------------------------------------

	/**
	 * Iterator
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
