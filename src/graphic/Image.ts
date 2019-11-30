import { Emitter } from '../event/Emitter'
import { bridge } from '../native/bridge'
import { native } from '../native/native'

@bridge('dezel.graphic.Image')

/**
 * TODO
 * Merge in componetn IMage
 * @class Image
 * @super Emitter
 * @since 0.1.0
 */
export class Image extends Emitter {

	//--------------------------------------------------------------------------
	// Static Methods
	//--------------------------------------------------------------------------

	/**
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
	 * @property source
	 * @since 0.1.0
	 */
	@native public source: string = ''

	/**
	 * @property width
	 * @since 0.1.0
	 */
	public get width(): number {
		return native(this).width
	}

	/**
	 * @property height
	 * @since 0.1.0
	 */
	public get height(): number {
		return native(this).height
	}

	/**
	 * @property loading
	 * @since 0.1.0
	 */
	public get loading(): boolean {
		return native(this).loading
	}

	/**
	 * @property complete
	 * @since 0.1.0
	 */
	public get complete(): boolean {
		return native(this).complete
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
	 * @method nativeOnLoad
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnLoad() {
		this.emit('load')
	}

	/**
	 * @method nativeOnError
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnError(error: string) {
		this.emit('error', { data: { error } })
	}
}