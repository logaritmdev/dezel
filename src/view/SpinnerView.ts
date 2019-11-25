import { bridge } from '../native/bridge'
import { native } from '../native/native'
import { View } from './View'

@bridge('dezel.view.SpinnerView')

/**
 * @class SpinnerView
 * @super View
 * @since 0.1.0
 */
export class SpinnerView extends View {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property active
	 * @since 0.1.0
	 */
	@native public active!: boolean

	/**
	 * @property color
	 * @since 0.1.0
	 */
	@native public color!: string
}