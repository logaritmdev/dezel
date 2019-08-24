package ca.logaritm.dezel.modules.view

import android.graphics.Bitmap
import android.util.Log
import android.util.SizeF
import ca.logaritm.dezel.application.application
import ca.logaritm.dezel.core.*
import ca.logaritm.dezel.extension.Delegates
import ca.logaritm.dezel.extension.ceiled
import ca.logaritm.dezel.modules.graphic.ImageLoader
import ca.logaritm.dezel.view.ImageView
import ca.logaritm.dezel.view.graphic.Color
import ca.logaritm.dezel.view.graphic.Convert
import ca.logaritm.dezel.view.type.ImageFilter

/**
 * @class JavaScriptImageView
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptImageView(context: JavaScriptContext) : JavaScriptView(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The image view's source.
	 * @property source
	 * @since 0.7.0
	 */
	open val source: JavaScriptProperty by lazy {

		JavaScriptProperty(context) { value ->

			this.imageLoader.load(value) { image ->

				this.imageData = image

				if (this.layoutNode.wrapsContentWidth ||
					this.layoutNode.wrapsContentHeight) {
					this.layoutNode.invalidateSize()
				}
			}
		}
	}

	/**
	 * The image view's image container fit.
	 * @property imageFit
	 * @since 0.7.0
	 */
	open val imageFit: JavaScriptProperty by lazy {
		JavaScriptProperty(context, "contain") {
			this.invalidateImage()
		}
	}

	/**
	 * The image view's image top anchor.
	 * @property imageAnchorTop
	 * @since 0.7.0
	 */
	open val imageAnchorTop: JavaScriptProperty by lazy {
		JavaScriptProperty(context, 0.5) {
			this.invalidateImage()
		}
	}

	/**
	 * The image view's image left anchor.
	 * @property imageAnchorLeft
	 * @since 0.7.0
	 */
	open val imageAnchorLeft: JavaScriptProperty by lazy {
		JavaScriptProperty(context, 0.5) {
			this.invalidateImage()
		}
	}

	/**
	 * The image view's image top position.
	 * @property imageTop
	 * @since 0.7.0
	 */
	open val imageTop: JavaScriptProperty by lazy {
		JavaScriptProperty(context, 50.0, JavaScriptPropertyUnit.PC) {
			this.invalidateImage()
		}
	}

	/**
	 * The image view's image left position.
	 * @property imageLeft
	 * @since 0.7.0
	 */
	open val imageLeft: JavaScriptProperty by lazy {
		JavaScriptProperty(context, 50.0, JavaScriptPropertyUnit.PC) {
			this.invalidateImage()
		}
	}

	/**
	 * The image view's image width.
	 * @property imageWidth
	 * @since 0.7.0
	 */
	open val imageWidth: JavaScriptProperty by lazy {
		JavaScriptProperty(context, "auto") {
			this.invalidateImage()
		}
	}

	/**
	 * The image view's image height.
	 * @property imageHeight
	 * @since 0.7.0
	 */
	open val imageHeight: JavaScriptProperty by lazy {
		JavaScriptProperty(context, "auto") {
			this.invalidageImage()
		}
	}

	/**
	 * The image view's image filter.
	 * @property imageFilter
	 * @since 0.7.0
	 */
	open val imageFilter: JavaScriptProperty by lazy {
		JavaScriptProperty(context, "none") { value ->
			this.view.imageFilter = this.getImageFilter(value.string)
		}
	}

	/**
	 * The image view's image imageTint color.
	 * @property imageTint
	 * @since 0.7.0
	 */
	open val imageTint: JavaScriptProperty by lazy {
		JavaScriptProperty(context, "transparent") { value ->
			this.view.imageTint = Color.parse(value.string)
		}
	}

	/**
	 * @property imageData
	 * @since 0.7.0
	 * @hidden
	 */
	private var imageData: Bitmap? by Delegates.OnSetOptional<Bitmap>(null) {
		this.invalidateImage()
	}

	/**
	 * @property imageLoader
	 * @since 0.7.0
	 * @hidden
	 */
	private var imageLoader: ImageLoader = ImageLoader(context.application)

	/**
	 * @property invalidImage
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidImage: Boolean = false

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
	 * @inherited
	 * @method createContentView
	 * @since 0.7.0
	 */
	override fun createContentView(): ImageView {
		return ImageView(this.context.application)
	}

	/**
	 * @inherited
	 * @method dispose
	 * @since 0.7.0
	 */
	override fun dispose() {
		this.imageData = null
		super.dispose()
	}

	/**
	 * @inherited
	 * @method update
	 * @since 0.7.0
	 */
	override fun update() {

		super.update()

		if (this.invalidImage) {
			this.invalidImage = false
			this.updateImage()
		}
	}

	/**
	 * Updates the image.
	 * @method updateImage
	 * @since 0.7.0
	 */
	open fun updateImage() {

		this.view.image = null

		val image = this.imageData
		if (image == null) {
			return
		}

		var autoW = false
		var autoH = false
		var imageW = 0.0
		var imageH = 0.0
		var imageT = 0.0
		var imageL = 0.0

		if (this.imageWidth.type == JavaScriptPropertyType.STRING &&
			this.imageWidth.string == "auto") {

			autoW = true

		} else {

			when (this.imageWidth.unit) {
				JavaScriptPropertyUnit.PC -> imageW = this.imageWidth.number / 100 * this.resolvedWidth
				JavaScriptPropertyUnit.VW -> imageW = this.imageWidth.number / 100 * this.layoutNode.viewportWidth
				JavaScriptPropertyUnit.VH -> imageW = this.imageWidth.number / 100 * this.layoutNode.viewportHeight
				JavaScriptPropertyUnit.PW -> imageW = this.imageWidth.number / 100 * this.resolvedInnerWidth
				JavaScriptPropertyUnit.PH -> imageW = this.imageWidth.number / 100 * this.resolvedInnerHeight
				JavaScriptPropertyUnit.CW -> imageW = this.imageWidth.number / 100 * this.resolvedContentWidth
				JavaScriptPropertyUnit.CH -> imageW = this.imageWidth.number / 100 * this.resolvedContentHeight
				else                      -> imageW = this.imageWidth.number
			}
		}

		if (this.imageHeight.type == JavaScriptPropertyType.STRING &&
			this.imageHeight.string == "auto") {

			autoH = true

		} else {

			when (this.imageHeight.unit) {
				JavaScriptPropertyUnit.PC -> imageH = this.imageHeight.number / 100 * this.resolvedHeight
				JavaScriptPropertyUnit.VW -> imageH = this.imageHeight.number / 100 * this.layoutNode.viewportWidth
				JavaScriptPropertyUnit.VH -> imageH = this.imageHeight.number / 100 * this.layoutNode.viewportHeight
				JavaScriptPropertyUnit.PW -> imageH = this.imageHeight.number / 100 * this.resolvedInnerWidth
				JavaScriptPropertyUnit.PH -> imageH = this.imageHeight.number / 100 * this.resolvedInnerHeight
				JavaScriptPropertyUnit.CW -> imageH = this.imageHeight.number / 100 * this.resolvedContentWidth
				JavaScriptPropertyUnit.CH -> imageH = this.imageHeight.number / 100 * this.resolvedContentHeight
				else                      -> imageH = this.imageHeight.number
			}
		}

		when (this.imageTop.unit) {
			JavaScriptPropertyUnit.PC -> imageT = this.imageTop.number / 100 * this.resolvedInnerHeight
			JavaScriptPropertyUnit.VW -> imageT = this.imageTop.number / 100 * this.layoutNode.viewportWidth
			JavaScriptPropertyUnit.VH -> imageT = this.imageTop.number / 100 * this.layoutNode.viewportHeight
			JavaScriptPropertyUnit.PW -> imageT = this.imageTop.number / 100 * this.resolvedInnerWidth
			JavaScriptPropertyUnit.PH -> imageT = this.imageTop.number / 100 * this.resolvedInnerHeight
			JavaScriptPropertyUnit.CW -> imageT = this.imageTop.number / 100 * this.resolvedContentWidth
			JavaScriptPropertyUnit.CH -> imageT = this.imageTop.number / 100 * this.resolvedContentHeight
			else                      -> imageT = this.imageTop.number
		}

		when (this.imageLeft.unit) {
			JavaScriptPropertyUnit.PC -> imageL = this.imageLeft.number / 100 * this.resolvedInnerWidth
			JavaScriptPropertyUnit.VW -> imageL = this.imageLeft.number / 100 * this.layoutNode.viewportWidth
			JavaScriptPropertyUnit.VH -> imageL = this.imageLeft.number / 100 * this.layoutNode.viewportHeight
			JavaScriptPropertyUnit.PW -> imageL = this.imageLeft.number / 100 * this.resolvedInnerWidth
			JavaScriptPropertyUnit.PH -> imageL = this.imageLeft.number / 100 * this.resolvedInnerHeight
			JavaScriptPropertyUnit.CW -> imageL = this.imageLeft.number / 100 * this.resolvedContentWidth
			JavaScriptPropertyUnit.CH -> imageL = this.imageLeft.number / 100 * this.resolvedContentHeight
			else                      -> imageL = this.imageLeft.number
		}

		val naturalImageW = image.width.toDouble()
		val naturalImageH = image.height.toDouble()

		val frameW = this.resolvedInnerWidth
		val frameH = this.resolvedInnerHeight
		val scaleX = frameW / naturalImageW
		val scaleY = frameH / naturalImageH

		if (autoW && autoH) {

			when (this.imageFit.string) {

				"none"    -> {
					imageW = naturalImageW
					imageH = naturalImageH
				}

				"cover"   -> {
					val scale = Math.max(scaleX, scaleY)
					imageW = naturalImageW * scale
					imageH = naturalImageH * scale
				}

				"contain" -> {
					val scale = Math.min(scaleX, scaleY)
					imageW = naturalImageW * scale
					imageH = naturalImageH * scale
				}

			}

		} else if (autoW) {
			imageW = imageH * (naturalImageW / naturalImageH)
		} else if (autoH) {
			imageH = imageW * (naturalImageH / naturalImageW)
		}

		val anchorT = this.getImageAnchorTop(this.imageAnchorTop)
		val anchorL = this.getImageAnchorLeft(this.imageAnchorLeft)

		imageT = imageT - (anchorT * imageH)
		imageL = imageL - (anchorL * imageW)

		this.view.image = image
		this.view.imageTop = Convert.toPx(imageT)
		this.view.imageLeft = Convert.toPx(imageL)
		this.view.imageWidth = Convert.toPx(imageW)
		this.view.imageHeight = Convert.toPx(imageH)
	}

	/**
	 * @method invalidageImage
	 * @since 0.7.0
	 * @hidden
	 */
	open fun invalidageImage() {
		if (this.invalidImage == false) {
			this.invalidImage = true
			this.scheduleUpdate()
		}
	}

	//--------------------------------------------------------------------------
	// Methods - Layout Node Delegate
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method measure
	 * @since 0.7.0
	 */
	override fun measure(bounds: SizeF, min: SizeF, max: SizeF): SizeF {

		if (this.invalidImage) {
			this.invalidImage = false
			this.updateImage()
		}

		val size = this.view.measure(
			Convert.toPx(bounds),
			Convert.toPx(min),
			Convert.toPx(max)
		)

		return Convert.toDp(size).ceiled()
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method invalidateFrame
	 * @since 0.7.0
	 * @hidden
	 */
	override fun invalidateFrame() {

		super.invalidateFrame()

		if (this.imageTop.unit == JavaScriptPropertyUnit.PC ||
			this.imageLeft.unit == JavaScriptPropertyUnit.PC ||
			this.imageWidth.unit == JavaScriptPropertyUnit.PC ||
			this.imageHeight.unit == JavaScriptPropertyUnit.PC) {
			this.invalidateImage()
		}
	}

	/**
	 * @method invalidateImage
	 * @since 0.7.0
	 * @hidden
	 */
	internal open fun invalidateImage() {
		if (this.invalidImage == false) {
			this.invalidImage = true
			this.scheduleUpdate()
		}
	}

	//--------------------------------------------------------------------------
	// Private API - Conversions
	//--------------------------------------------------------------------------

	/**
	 * @method getImageAnchorTop
	 * @since 0.7.0
	 * @hidden
	 */
	private fun getImageAnchorTop(prop: JavaScriptProperty): Double {

		if (prop.type == JavaScriptPropertyType.STRING) {

			when (prop.string) {

				"top"    -> return 0.0
				"center" -> return 0.5
				"bottom" -> return 1.0

				else     -> {
					Log.d("Dezel", "Unrecognized value for imageAnchorTop: ${prop.string}")
				}
			}
		}

		return prop.number
	}

	/**
	 * @method getImageAnchorLeft
	 * @since 0.7.0
	 * @hidden
	 */
	private fun getImageAnchorLeft(prop: JavaScriptProperty): Double {

		if (prop.type == JavaScriptPropertyType.STRING) {

			when (prop.string) {

				"left"   -> return 0.0
				"center" -> return 0.5
				"right"  -> return 1.0

				else     -> {
					Log.d("Dezel", "Unrecognized value for imageAnchorLeft: ${prop.string}")
				}
			}
		}

		return prop.number
	}

	/**
	 * @method getImageFilter
	 * @since 0.7.0
	 * @hidden
	 */
	private fun getImageFilter(value: String): ImageFilter {

		when (value) {

			"none"      -> return ImageFilter.NONE
			"grayscale" -> return ImageFilter.GRAYSCALE

			else        -> {
				Log.d("Dezel", "Unrecognized value for imageFilter: $value")
			}
		}

		return ImageFilter.NONE
	}

	//--------------------------------------------------------------------------
	// JS Properties
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
		this.source.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_imageFit
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_imageFit(callback: JavaScriptGetterCallback) {
		callback.returns(this.imageFit)
	}

	/**
	 * @method jsSet_imageFit
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_imageFit(callback: JavaScriptSetterCallback) {
		this.imageFit.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_imageAnchorTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_imageAnchorTop(callback: JavaScriptGetterCallback) {
		callback.returns(this.imageAnchorTop)
	}

	/**
	 * @method jsSet_imageAnchorTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_imageAnchorTop(callback: JavaScriptSetterCallback) {
		this.imageAnchorTop.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_imageAnchorLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_imageAnchorLeft(callback: JavaScriptGetterCallback) {
		callback.returns(this.imageAnchorLeft)
	}

	/**
	 * @method jsSet_imageAnchorLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_imageAnchorLeft(callback: JavaScriptSetterCallback) {
		this.imageAnchorLeft.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_imageTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_imageTop(callback: JavaScriptGetterCallback) {
		callback.returns(this.imageTop)
	}

	/**
	 * @method jsSet_imageTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_imageTop(callback: JavaScriptSetterCallback) {
		this.imageTop.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_imageLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_imageLeft(callback: JavaScriptGetterCallback) {
		callback.returns(this.imageLeft)
	}

	/**
	 * @method jsSet_imageLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_imageLeft(callback: JavaScriptSetterCallback) {
		this.imageLeft.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_imageWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_imageWidth(callback: JavaScriptGetterCallback) {
		callback.returns(this.imageWidth)
	}

	/**
	 * @method jsSet_imageWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_imageWidth(callback: JavaScriptSetterCallback) {
		this.imageWidth.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_imageHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_imageHeight(callback: JavaScriptGetterCallback) {
		callback.returns(this.imageHeight)
	}

	/**
	 * @method jsSet_imageHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_imageHeight(callback: JavaScriptSetterCallback) {
		this.imageHeight.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_imageFilter
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_imageFilter(callback: JavaScriptGetterCallback) {
		callback.returns(this.imageFilter)
	}

	/**
	 * @method jsSet_imageFilter
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_imageFilter(callback: JavaScriptSetterCallback) {
		this.imageFilter.set(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_imageTint
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_imageTint(callback: JavaScriptGetterCallback) {
		callback.returns(this.imageTint)
	}

	/**
	 * @method jsSet_imageTint
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_imageTint(callback: JavaScriptSetterCallback) {
		this.imageTint.set(callback.value, this)
	}
}