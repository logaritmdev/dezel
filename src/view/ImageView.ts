import { Image } from '../graphic/Image'
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
	 * @property source
	 * @since 0.4.0
	 */
	@native public source!: Image | string | null

	/**
	 * @property imageFit
	 * @since 0.4.0
	 */
	@native public imageFit!: 'contain' | 'cover' | 'none'

	/**
	 * @property imageAnchorTop
	 * @since 0.1.0
	 */
	@native public imageAnchorTop!: 'top' | 'center' | 'bottom' | number | string

	/**
	 * @property imageAnchorLeft
	 * @since 0.1.0
	 */
	@native public imageAnchorLeft!: 'left' | 'center' | 'right' | number | string

	/**
	 * @property imageTop
	 * @since 0.1.0
	 */
	@native public imageTop!: number | string

	/**
	 * @property imageLeft
	 * @since 0.1.0
	 */
	@native public imageLeft!: number | string

	/**
	 * @property imageWidth
	 * @since 0.1.0
	 */
	@native public imageWidth!: 'auto' | number

	/**
	 * @property imageHeight
	 * @since 0.1.0
	 */
	@native public imageHeight!: 'auto' | number

	/**
	 * @property imageFilter
	 * @since 0.5.0
	 */
	@native public imageFilter!: 'grayscale' | 'none'

	/**
	 * @property imageTint
	 * @since 0.1.0
	 */
	@native public imageTint!: 'transparent' | string

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method setDefaultValue
	 * @since 0.4.0
	 */
	public setDefaultValue(value: string | number | boolean) {
		this.source = String(value)
	}
}