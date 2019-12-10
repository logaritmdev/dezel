import { $view } from './symbol/StateList'
import { native } from '../native/native'
import { View } from './View'

/**
 * @class StateList
 * @since 0.7.0
 */
export class StateList {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property view
	 * @since 0.7.0
	 */
	public get view(): View {
		return this[$view]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	constructor(view: View) {
		this[$view] = view
	}

	/**
	 * @method has
	 * @since 0.7.0
	 */
	public has(state: string): boolean {
		return native(this.view).hasState(state)
	}

	/**
	 * @method append
	 * @since 0.7.0
	 */
	public append(state: string) {
		native(this.view).appendState(state)
		return this
	}

	/**
	 * @method remove
	 * @since 0.7.0
	 */
	public remove(state: string) {
		native(this.view).removeState(state)
		return this
	}

	/**
	 * @method toggle
	 * @since 0.7.0
	 */
	public toggle(state: string) {
		native(this.view).toggleState(state)
		return this
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $view
	 * @since 0.7.0
	 * @hidden
	 */
	private [$view]: View

}