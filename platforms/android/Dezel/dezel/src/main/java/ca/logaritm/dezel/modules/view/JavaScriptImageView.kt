package ca.logaritm.dezel.modules.view

import android.util.Log
import android.util.SizeF
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptGetterCallback
import ca.logaritm.dezel.core.JavaScriptProperty
import ca.logaritm.dezel.core.JavaScriptSetterCallback
import ca.logaritm.dezel.extension.core.activity
import ca.logaritm.dezel.extension.util.ceiled
import ca.logaritm.dezel.modules.graphic.ImageLoader
import ca.logaritm.dezel.view.ImageView
import ca.logaritm.dezel.view.display.DisplayNode
import ca.logaritm.dezel.view.graphic.Color
import ca.logaritm.dezel.view.graphic.Convert
import ca.logaritm.dezel.view.type.ImageFit
import ca.logaritm.dezel.view.type.ImagePosition

/**
 * @class JavaScriptImageView
 * @super JavaScriptView
 * @since 0.7.0
 */
open class JavaScriptImageView(context: JavaScriptContext) : JavaScriptView(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property loader
	 * @since 0.7.0
	 * @hidden
	 */
	private var loader: ImageLoader = ImageLoader(context.activity)

	/**
	 * @property view
	 * @since 0.7.0
	 * @hidden
	 */
	private val view: ImageView
		get() = this.content as ImageView

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method createContentView
	 * @since 0.7.0
	 */
	override fun createContentView(): ImageView {
		return ImageView(this.context.activity)
	}

	//--------------------------------------------------------------------------
	// Layout Node Delegate
	//--------------------------------------------------------------------------

	/**
	 * @method measure
	 * @since 0.7.0
	 */
	override fun measure(bounds: SizeF, min: SizeF, max: SizeF): SizeF {

		val size = this.view.measure(
			Convert.toPx(bounds),
			Convert.toPx(min),
			Convert.toPx(max)
		)

		return Convert.toDp(size).ceiled()
	}

	//--------------------------------------------------------------------------
	// Display Node Delegate
	//--------------------------------------------------------------------------

	/**
	 * @method onResolvePadding
	 * @since 0.7.0
	 */
	override fun onResolvePadding(node: DisplayNode) {
		super.onResolvePadding(node)
		this.view.paddingTop = Convert.toPx(this.resolvedPaddingTop)
		this.view.paddingLeft = Convert.toPx(this.resolvedPaddingLeft)
		this.view.paddingRight = Convert.toPx(this.resolvedPaddingRight)
		this.view.paddingBottom = Convert.toPx(this.resolvedPaddingBottom)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method getImageFit
	 * @since 0.7.0
	 * @hidden
	 */
	private fun getImageFit(value: String): ImageFit {

		when (value) {

			 "cover"  ->  return ImageFit.COVER
			 "contain" -> return ImageFit.CONTAIN

			else -> {
				Log.e("Dezel", "Unrecognized value for imageFit: $value")
			}
		}

		return ImageFit.CONTAIN
	}

	/**
	 * @method getImagePosition
	 * @since 0.7.0
	 * @hidden
	 */
	private fun getImagePosition(value: String): ImagePosition {

		when (value) {
			"top left"      -> return ImagePosition.TOP_LEFT
			"top right"     -> return ImagePosition.TOP_RIGHT
			"top center"    -> return ImagePosition.TOP_CENTER
			"left"          -> return ImagePosition.MIDDLE_LEFT
			"right"         -> return ImagePosition.MIDDLE_RIGHT
			"center"        -> return ImagePosition.MIDDLE_CENTER
			"bottom left"   -> return ImagePosition.BOTTOM_LEFT
			"bottom right"  -> return ImagePosition.BOTTOM_RIGHT
			"bottom center" -> return ImagePosition.BOTTOM_CENTER

			else -> {
				Log.e("Dezel", "Unrecognized value for imagePosition: $value")
			}
		}

		return ImagePosition.MIDDLE_CENTER
	}

	//--------------------------------------------------------------------------
	// JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @property source
	 * @since 0.7.0
	 */
	val source by lazy {

		JavaScriptProperty { value ->

			this.loader.load(value) { image ->

				this.view.image = image

				if (this.node.isWrappingContentWidth ||
					this.node.isWrappingContentHeight) {
					this.node.invalidateSize()
				}
			}
		}
	}

	/**
	 * @property imageFit
	 * @since 0.7.0
	 */
	val imageFit by lazy {
		JavaScriptProperty("contain") { value ->
			this.view.imageFit = this.getImageFit(value.string)
		}
	}

	/**
	 * @property imagePosition
	 * @since 0.7.0
	 */
	val imagePosition by lazy {
		JavaScriptProperty("center") { value ->
			this.view.imagePosition = this.getImagePosition(value.string)
		}
	}

	/**
	 * @property tint
	 * @since 0.7.0
	 */
	val tint by lazy {
		JavaScriptProperty("transparent") { value ->
			this.view.tint = Color.parse(value.string)
		}
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_source
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	fun jsGet_source(callback: JavaScriptGetterCallback) {
		callback.returns(this.source)
	}

	/**
	 * @method jsSet_source
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	fun jsSet_source(callback: JavaScriptSetterCallback) {
		this.source.reset(callback.value, lock = this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_imageFit
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	fun jsGet_imageFit(callback: JavaScriptGetterCallback) {
		callback.returns(this.imageFit)
	}

	/**
	 * @method jsSet_imageFit
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	fun jsSet_imageFit(callback: JavaScriptSetterCallback) {
		this.imageFit.reset(callback.value, lock = this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_imagePosition
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	fun jsGet_imagePosition(callback: JavaScriptGetterCallback) {
		callback.returns(this.imagePosition)
	}

	/**
	 * @method jsSet_imageFit
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	fun jsSet_imagePosition(callback: JavaScriptSetterCallback) {
		this.imagePosition.reset(callback.value, lock = this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_tint
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	fun jsGet_tint(callback: JavaScriptGetterCallback) {
		callback.returns(this.tint)
	}

	/**
	 * @method jsSet_tint
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	fun jsSet_tint(callback: JavaScriptSetterCallback) {
		this.tint.reset(callback.value, lock = this, parse = true)
	}
}