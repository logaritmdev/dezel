import { bridge } from '../decorator/bridge'
import { native } from '../decorator/native'
import { Emitter } from '../event/Emitter'

@bridge('dezel.graphic.Image')

/**
 * Manages an image's data.
 * @class Image
 * @super Emitter
 * @since 0.1.0
 */
export class Image extends Emitter {

	//--------------------------------------------------------------------------
	// Static Methods
	//--------------------------------------------------------------------------

	/**
	 * Returns a promise that resolves when an image is loaded.
	 * @method load
	 * @since 0.1.0
	 */
	public static load(source: string): Promise<Image> {

		let image = new Image(source)
		if (image.complete) {
			return Promise.resolve(image)
		}

		return new Promise((success, failure) => {
			image.on('load', () => success(image))
			image.on('error', () => failure(image))
		})
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The image's source.
	 * @property source
	 * @since 0.1.0
	 */
	@native public source: string = ''

	/**
	 * The image's natural width.
	 * @property width
	 * @since 0.1.0
	 */
	public get width(): number {
		return this.native.width
	}

	/**
	 * The image's natural height.
	 * @property height
	 * @since 0.1.0
	 */
	public get height(): number {
		return this.native.height
	}

	/**
	 * Whether the image is loading.
	 * @property loading
	 * @since 0.1.0
	 */
	public get loading(): boolean {
		return this.native.loading
	}

	/**
	 * Whether the image is completely loaded.
	 * @property complete
	 * @since 0.1.0
	 */
	public get complete(): boolean {
		return this.native.complete
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(source: string) {

		super()

		if (source) {
			this.source = source
		}
	}

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

	/**
	 * @property native
	 * @since 0.1.0
	 * @hidden
	 */
	public native: any

	/**
	 * @method nativeLoad
	 * @since 0.1.0
	 * @hidden
	 */
	nativeLoad() {
		this.emit('load')
	}

	/**
	 * @method nativeError
	 * @since 0.1.0
	 * @hidden
	 */
	nativeError(error: string) {
		this.emit('error', { data: { error } })
	}
}