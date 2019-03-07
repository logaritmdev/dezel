import { Event } from '../event/Event'
import { View } from '../view/View'
import { ViewInsertEvent } from '../view/View'
import { ViewRemoveEvent } from '../view/View'
import { Screen } from './Screen'

import './Enclosure.ds'
import './Enclosure.ds.ios'
import './Enclosure.ds.android'

/**
 * @symbol SCREEN
 * @since 0.4.0
 */
export const SCREEN = Symbol('screen')

/**
 * @class Enclosure
 * @super View
 * @since 0.4.0
 * @hidden
 */
export class Enclosure extends View {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The wrapped screen.
	 * @property screen
	 * @since 0.4.0
	 */
	public get screen(): Screen {
		return this[SCREEN]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the component.
	 * @constructor
	 * @since 0.4.0
	 */
	constructor(screen: Screen) {
		super()
		this[SCREEN] = screen
		this[SCREEN].enclosure = this
		this.append(screen)
	}

	/**
	 * @inherited
	 * @method destroy
	 * @since 0.4.0
	 */
	public destroy() {

		if (this[SCREEN]) {
			this[SCREEN].enclosure = null
		}

		super.destroy()
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property [SCREEN]
	 * @since 0.4.0
	 * @hidden
	 */
	private [SCREEN]: Screen
}