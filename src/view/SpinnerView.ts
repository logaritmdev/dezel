import { bridge } from '../decorator/bridge'
import { native } from '../decorator/native'
import { View } from './View'

import './SpinnerView.ds'

@bridge('dezel.view.SpinnerView')

/**
 * Displays a spinning indicator.
 * @class SpinnerView
 * @super View
 * @since 0.1.0
 */
export class SpinnerView extends View {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The spinner view's active status.
	 * @property active
	 * @since 0.1.0
	 */
	@native public active!: boolean

	/**
	 * The spinner view's color.
	 * @property color
	 * @since 0.1.0
	 */
	@native public color!: string
}