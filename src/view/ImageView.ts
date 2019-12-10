import { setValueOf } from '../jsx/symbol/createElement'
import { bridge } from '../native/bridge'
import { native } from '../native/native'
import { Image } from '../graphic/Image'
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
	 * @property source
	 * @since 0.4.0
	 */
	@native public source!: Image | string | null

	/**
	 * @property imageFit
	 * @since 0.4.0
	 */
	@native public imageFit!: 'contain' | 'cover'

	/**
	 * @property imagePosition
	 * @since 0.7.0
	 */
	@native public imagePosition!: 'top left' | 'top right' | 'top center' | 'left' | 'right' | 'center' | 'bottom left' | 'bottom right' | 'bottom center'

	/**
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
	 */
	public [setValueOf] = function (this: ImageView, value: number | string | boolean) {
		this.source = String(value)
	}
}