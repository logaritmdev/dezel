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
	 * @property tint
	 * @since 0.1.0
	 */
	@native public tint!: string

	/**
	 * @property spin
	 * @since 0.1.0
	 */
	@native public spin!: boolean

}