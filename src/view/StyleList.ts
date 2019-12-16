import { $view } from './private/StyleList'
import { native } from '../native/native'
import { View } from './View'

/**
 * @class StyleList
 * @since 0.7.0
 */
export class StyleList {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The style list's view.
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
	 * Initializes the style list.
	 * @constructor
	 * @since 0.7.0
	 */
	constructor(view: View) {
		this[$view] = view
	}

	/**
	 * Indicates whether the view has a style.
	 * @method has
	 * @since 0.7.0
	 */
	public has(style: string): boolean {
		return native(this.view).hasStyle(style)
	}

	/**
	 * Appends a style to the view.
	 * @method append
	 * @since 0.7.0
	 */
	public append(style: string) {
		native(this.view).appendStyle(style)
		return this
	}

	/**
	 * Removes a style from the view.
	 * @method remove
	 * @since 0.7.0
	 */
	public remove(style: string) {
		native(this.view).removeStyle(style)
		return this
	}

	/**
	 * Toggles a style from the view.
	 * @method toggle
	 * @since 0.7.0
	 */
	public toggle(style: string) {
		native(this.view).toggleStyle(style)
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