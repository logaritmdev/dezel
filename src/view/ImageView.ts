import { bound } from '../decorator/bound'
import { watch } from '../decorator/watch'
import { bridge } from '../decorator/bridge'
import { native } from '../decorator/native'
import { Event } from '../event/Event'
import { Image } from '../graphic/Image'
import { View } from './View'

import './ImageView.ds'

/**
 * @symbol IMAGE
 * @since 0.1.0
 */
export const IMAGE = Symbol('image')

@bridge('dezel.view.ImageView')

/**
 * Displays a single image.
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
	@native public source?: Image | string | null

	/**
	 * The image view's image container fitting.
	 * @property imageFit
	 * @since 0.4.0
	 */
	@native public imageFit!: 'contain' | 'cover' | 'none'

	/**
	 * The image view's image vertical point from which it will be positioned.
	 * @property imageAnchorTop
	 * @since 0.1.0
	 */
	@native public imageAnchorTop!: 'top' | 'center' | 'bottom' | number | string

	/**
	 * The image view's image horizontal point from which it will be positioned.
	 * @property imageAnchorLeft
	 * @since 0.1.0
	 */
	@native public imageAnchorLeft!: 'left' | 'center' | 'right' | number | string

	/**
	 * The image view's image top position.
	 * @property imageTop
	 * @since 0.1.0
	 */
	@native public imageTop!: number

	/**
	 * The image view's image left position.
	 * @property imageLeft
	 * @since 0.1.0
	 */
	@native public imageLeft!: number

	/**
	 * The image view's image width.
	 * @property imageWidth
	 * @since 0.1.0
	 */
	@native public imageWidth!: 'auto' | number

	/**
	 * The image view's image height;
	 * @property imageHeight
	 * @since 0.1.0
	 */
	@native public imageHeight!: 'auto' | number

	/**
	 * The image view's image filter.
	 * @property imageFilter
	 * @since 0.5.0
	 */
	@native public imageFilter?: 'grayscale' | null

	/**
	 * The image view's image tint color.
	 * @property imageTint
	 * @since 0.1.0
	 */
	@native public imageTint?: string | null

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * TODO
	 * @method setDefaultValue
	 * @since 0.4.0
	 */
	public setDefaultValue(value: string | number | boolean) {
		this.source = String(value)
	}
}