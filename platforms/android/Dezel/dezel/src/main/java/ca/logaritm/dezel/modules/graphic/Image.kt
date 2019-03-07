package ca.logaritm.dezel.modules.graphic

import android.graphics.Bitmap
import ca.logaritm.dezel.core.*
import ca.logaritm.dezel.extension.Delegates
import android.content.Context as AndroidContext

/**
 * An image image manager.
 * @class Image
 * @since 0.1.0
 */
open class Image(context: JavaScriptContext) : JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	companion object {

		/**
		 * Convenience method to create an Image instance within the specified context.
		 * @method with
		 * @since 0.4.0
		 */
		public fun with(input: Bitmap, context: JavaScriptContext): Image {

			val image = context.createObject("dezel.graphic.Image", null, Image::class.java)
			if (image == null) {
				throw Exception("Unable to create Image.")
			}

			image.set(input)

			return image
		}
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The image's source.
	 * @property source
	 * @since 0.1.0
	 */
	open var source: Property by Delegates.OnSet(Property()) { value ->
		this.load(value.string)
	}

	/**
	 * Whether the image is loading.
	 * @property loading
	 * @since 0.1.0
	 */
	open var loading: Property = Property(false)

	/**
	 * Whether the image is completely loaded.
	 * @property complete
	 * @since 0.1.0
	 */
	open var complete: Property = Property(false)

	/**
	 * The image's image.
	 * @property data
	 * @since 0.1.0
	 */
	open var data: Bitmap? = null

	/**
	 * @property loader
	 * @since 0.1.0
	 * @hidden
	 */
	private var loader: ImageLoader = ImageLoader(context.application)

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Loads the image from the specified source.
	 * @method load
	 * @since 0.1.0
	 */
	open fun load(source: String) {

		this.data = null
		this.loading = Property(false)
		this.complete = Property(false)

		this.protect()

		this.loader.load(source) { image ->
			this.set(image)
			this.unprotect()
		}
	}

	/**
	 * Sets the image's data.
	 * @method set
	 * @since 0.1.0
	 */
	open fun set(image: Bitmap?) {

		if (image != null) {
			this.data = image
			this.loading = Property(false)
			this.complete = Property(true)
			this.holder.callMethod("nativeLoad")
			return
		}

		this.data = null
		this.loading = Property(false)
		this.complete = Property(false)
		this.holder.callMethod("nativeError")
	}

	//--------------------------------------------------------------------------
	// JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_width
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_width(callback: JavaScriptGetterCallback) {
		callback.returns(this.data?.width?.toDouble() ?: 0.0)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_height
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_height(callback: JavaScriptGetterCallback) {
		callback.returns(this.data?.height?.toDouble() ?: 0.0)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_loading
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_loading(callback: JavaScriptGetterCallback) {
		callback.returns(this.loading)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_complete
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_complete(callback: JavaScriptGetterCallback) {
		callback.returns(this.complete)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_source
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_source(callback: JavaScriptGetterCallback) {
		callback.returns(this.source)
	}

	/**
	 * @method jsSet_source
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_source(callback: JavaScriptSetterCallback) {
		this.source = Property(callback.value)
	}
}
