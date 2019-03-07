import { View } from '../view/View'

import './Footer.ds'
import './Footer.ds.ios'
import './Footer.ds.android'

/**
 * Displays the screen area that contains the screen's bottom content.
 * @class Footer
 * @super View
 * @since 0.1.0
 */
export class Footer extends View {

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
		this.id = 'footer'
	}
}