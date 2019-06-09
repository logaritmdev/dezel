import { BUILT } from '../view/View'
import { Component } from '../view/View'
import { View } from '../view/View'

/**
 * @symbol OWNER
 * @since 0.7.0
 */
export const OWNER = Symbol('owner')

/**
 * @symbol VALUE
 * @since 0.7.0
 */
export const VALUE = Symbol('value')

/**
 * A nullable reference to an object.
 * @class Reference
 * @since 0.7.0
 */
export class Reference<T extends View> {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The reference's value.
	 * @property value
	 * @since 0.7.0
	 */
	public get value(): T | null | undefined {

		let owner = this[OWNER]
		if (owner &&
			owner instanceof Component) {
			owner.build()
		}

		return this[VALUE]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	public constructor(owner: View) {
		this[OWNER] = owner
	}

	/**
	 * Sets the reference' value.
	 * @method set
	 * @since 0.7.0
	 */
	public set(value: T) {
		this[VALUE] = value
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property [VALUE]
	 * @since 0.7.0
	 * @hidden
	 */
	private [OWNER]: View

	/**
	 * @property [VALUE]
	 * @since 0.7.0
	 * @hidden
	 */
	private [VALUE]: T | null | undefined = null

}
