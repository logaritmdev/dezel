import { View } from '../view/View'
import { $screen } from './symbol/Frame'
import { $frame } from './symbol/Screen'
import { Screen } from './Screen'
import './style/Frame.style'

/**
 * @class Frame
 * @super View
 * @since 0.7.0
 */
export class Frame extends View {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property screen
	 * @since 0.7.0
	 */
	public get screen(): Screen {
		return this[$screen]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.4.0
	 */
	constructor(screen: Screen) {
		super()
		this[$screen] = screen
		this[$screen][$frame] = this
		this.append(screen)
	}

	/**
	 * @method embed
	 * @since 0.7.0
	 */
	public embed(view: View) {
		view.append(this)
		return this
	}

	/**
	 * @method destroy
	 * @since 0.4.0
	 */
	public destroy() {

		if (this[$screen]) {
			this[$screen][$frame] = null
		}

		return super.destroy()
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $screen
	 * @since 0.7.0
	 * @hidden
	 */
	private [$screen]: Screen
}