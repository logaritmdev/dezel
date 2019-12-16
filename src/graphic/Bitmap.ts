import { bridge } from '../native/bridge'
import { native } from '../native/native'
import { Emitter } from '../event/Emitter'

@bridge('dezel.graphic.Bitmap')

/**
 * @class Image
 * @super Emitter
 * @since 0.7.0
 */
export class Bitmap extends Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The bitmap's source.
	 * @property source
	 * @since 0.7.0
	 */
	@native public source: string = ''

	/**
	 * The bitmap's width.
	 * @property width
	 * @since 0.7.0
	 */
	public get width(): number {
		return native(this).width
	}

	/**
	 * The bitmap's height.
	 * @property height
	 * @since 0.7.0
	 */
	public get height(): number {
		return native(this).height
	}

	/**
	 * Whether the bitmap is loading.
	 * @property loading
	 * @since 0.7.0
	 */
	public get loading(): boolean {
		return native(this).loading
	}

	/**
	 * Whether the bitmap is loaded.
	 * @property loaded
	 * @since 0.7.0
	 */
	public get loaded(): boolean {
		return native(this).loaded
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the bitmap.
	 * @constructor
	 * @since 0.7.0
	 */
	constructor(source?: string) {

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