package ca.logaritm.dezel.modules.graphic

import android.graphics.Bitmap
import ca.logaritm.dezel.application.activity
import ca.logaritm.dezel.core.*

/**
 * An image image manager.
 * @class JavaScriptImage
 * @since 0.7.0
 */
open class JavaScriptImage(context: JavaScriptContext) : JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The image's image.
	 * @property data
	 * @since 0.7.0
	 */
	open var data: Bitmap? = null

	/**
	 * @property loader
	 * @since 0.7.0
	 * @hidden
	 */
	private var loader: ImageLoader = ImageLoader(context.activity)

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Loads the image from the specified source.
	 * @method load
	 * @since 0.7.0
	 */
	open fun load(source: String) {

		this.data = null
		this.loading.reset(false)
		this.complete.reset(false)

		this.protect()

		this.loader.load(source) { image ->
			this.set(image)
			this.unprotect()
		}
	}

	/**
	 * Sets the image's data.
	 * @method set
	 * @since 0.7.0
	 */
	open fun set(image: Bitmap?) {

		if (image != null) {
			this.data = image
			this.loading.reset(false)
			this.complete.reset(true)
			this.callMethod("nativeOnLoad")
			return
		}

		this.data = null
		this.loading.reset(false)
		this.complete.reset(false)
		this.callMethod("nativeOnError")
	}

	//--------------------------------------------------------------------------
	// JS Properties
	//--------------------------------------------------------------------------

	/**
	 * The image's source.
	 * @property source
	 * @since 0.7.0
	 */
	public val source by lazy {
		JavaScriptProperty() { value ->
			this.load(value.string)
		}
	}

	/**
	 * Whether the image is loading.
	 * @property loading
	 * @since 0.7.0
	 */
	public val loading by lazy {
		JavaScriptProperty(false)
	}

	/**
	 * Whether the image is completely loaded.
	 * @property complete
	 * @since 0.7.0
	 */
	public val complete by lazy {
		JavaScriptProperty(false)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_width
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_width(callback: JavaScriptGetterCallback) {
		callback.returns(this.data?.width?.toDouble() ?: 0.0)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_height
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_height(callback: JavaScriptGetterCallback) {
		callback.returns(this.data?.height?.toDouble() ?: 0.0)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_loading
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_loading(callback: JavaScriptGetterCallback) {
		callback.returns(this.loading)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_complete
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_complete(callback: JavaScriptGetterCallback) {
		callback.returns(this.complete)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_source
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_source(callback: JavaScriptGetterCallback) {
		callback.returns(this.source)
	}

	/**
	 * @method jsSet_source
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_source(callback: JavaScriptSetterCallback) {
		this.source.reset(callback.value, this)
	}
}
