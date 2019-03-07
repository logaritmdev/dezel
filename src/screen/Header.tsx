import { View } from '../view/View'

import './Header.ds'
import './Header.ds.ios'
import './Header.ds.android'

/**
 * Displays the screen area that contains the screen's top content.
 * @class Header
 * @super View
 * @since 0.1.0
 */
export class Header extends View {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the component.
	 * @constructor
	 * @since 0.1.0
	 */
	constructor() {
		super()
		this.id = 'header'
	}
}