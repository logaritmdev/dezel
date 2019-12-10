import { $value } from './symbol/Reference'
import { Placeholder } from './Placeholder'
import { View } from './View'

/**
 * @class Reference
 * @since 0.7.0
 * @hidden
 */
export class Reference<T extends View | Placeholder> {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property value
	 * @since 0.7.0
	 */
	public get value(): T | null {
		return this[$value]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method set
	 * @since 0.7.0
	 */
	public set(value: T) {

		if (this[$value] == null) {
			this[$value] = value
			return this
		}

		throw new Error(
			`Reference error: Reference has already been set.`
		)
	}

	/**
	 * @method get
	 * @since 0.7.0
	 */
	public get(): T {

		let value = this[$value]
		if (value != null) {
			return value
		}

		throw new Error(
			`Reference error: Unable to return a null reference.`
		)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $value
	 * @since 0.7.0
	 * @hidden
	 */
	private [$value]: T | null = null

}