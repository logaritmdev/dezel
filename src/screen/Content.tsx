import { View } from '../view/View'

import './Content.ds'
import './Content.ds.ios'
import './Content.ds.android'

/**
 * Displays the screen area that contains the screen's main content.
 * @class Content
 * @super View
 * @since 0.1.0
 */
export class Content extends View {

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
		this.id = 'content'
	}
}