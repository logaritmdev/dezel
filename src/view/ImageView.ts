import { setValueOf } from '../jsx/private/createElement'
import { bridge } from '../native/bridge'
import { native } from '../native/native'
import { View } from './View'

@bridge('dezel.view.ImageView')

/**
 * @class ImageView
 * @super View
 * @since 0.1.0
 */
export class ImageView extends View {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The image view's source.
	 * @property source
	 * @since 0.4.0
	 */
	@native public source!: string | null

	/**
	 * The image view's image fit mode.
	 * @property imageFit
	 * @since 0.4.0
	 */
	@native public imageFit!: 'contain' | 'cover'

	/**
	 * The image view's image position.
	 * @property imagePosition
	 * @since 0.7.0
	 */
	@native public imagePosition!: 'top left' | 'top right' | 'top center' | 'left' | 'right' | 'center' | 'bottom left' | 'bottom right' | 'bottom center'

	/**
	 * The image view's tint.
	 * @property tint
	 * @since 0.1.0
	 */
	@native public tint!: 'transparent' | string

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @property setValueOf
	 * @since 0.7.0
	 * @hidden
	 */
	public [setValueOf] = function (this: ImageView, value: number | string | boolean) {
		this.source = String(value)
	}
}