import { View } from '../view/View'
import { Touch } from './Touch'

/**
 * @symbol TOUCHES
 * @since 0.4.0
 */
export const TOUCHES = Symbol('touches')

/**
 * Manages a list of touches.
 * @class TouchList
 * @since 0.3.0
 */
export class TouchList {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The amount of touches.
	 * @property length
	 * @since 0.4.0
	 */
	public get length(): number {
		return this[TOUCHES].length
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.4.0
	 */
	constructor(touches: Array<Touch>) {
		this[TOUCHES] = touches
	}

	/**
	 * Returns the touch at a specified index.
	 * @method item
	 * @since 0.4.0
	 */
	public item(index: number) {
		return this[TOUCHES][index]
	}

	/**
	 * Finds a specified touch within the list.
	 * @method find
	 * @since 0.4.0
	 */
	public find(touch: Touch) {
		return this[TOUCHES].find(item => item.identifier == touch.identifier)
	}

	/**
	 * Finds the touch that hits the specified view.
	 * @method hits
	 * @since 0.4.0
	 */
	public hits(view: View) {
		return this[TOUCHES].find(item => item.hits(view))
	}

	//--------------------------------------------------------------------------
	// Symbols
	//--------------------------------------------------------------------------

	/**
	 * Iterator
	 * @property [Symbol.iterator]
	 * @since 0.4.0
	 */
	[Symbol.iterator]() {
		return this[TOUCHES]
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property [TOUCHES]
	 * @since 0.4.0
	 * @hidden
	 */
	[TOUCHES]: Array<Touch> = []
}