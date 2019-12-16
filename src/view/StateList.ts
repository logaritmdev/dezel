import { $view } from './private/StateList'
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
	 * The state list's view.
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
	 * Initializes the state list.
	 * @constructor
	 * @since 0.7.0
	 */
	constructor(view: View) {
		this[$view] = view
	}

	/**
	 * Indicates whether the view has a state.
	 * @method has
	 * @since 0.7.0
	 */
	public has(state: string): boolean {
		return native(this.view).hasState(state)
	}

	/**
	 * Appends a state to the view.
	 * @method append
	 * @since 0.7.0
	 */
	public append(state: string) {
		native(this.view).appendState(state)
		return this
	}

	/**
	 * Removes a state from the view.
	 * @method remove
	 * @since 0.7.0
	 */
	public remove(state: string) {
		native(this.view).removeState(state)
		return this
	}

	/**
	 * Toggles a state from the view.
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