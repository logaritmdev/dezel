import { View } from '../view/View'
import { $screen } from './symbol/Enclosure'
import { Screen } from './Screen'
import './style/Enclosure.style'

/**
 * @class Enclosure
 * @super View
 * @since 0.4.0
 */
export class Enclosure extends View {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property screen
	 * @since 0.4.0
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
		this[$screen].enclosure = this
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
			this[$screen].enclosure = null
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