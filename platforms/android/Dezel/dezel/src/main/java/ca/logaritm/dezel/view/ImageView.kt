package ca.logaritm.dezel.view

import android.content.Context
import android.graphics.*
import android.util.SizeF
import android.view.View
import ca.logaritm.dezel.extension.Delegates
import ca.logaritm.dezel.extension.ceiled
import ca.logaritm.dezel.extension.clamp
import ca.logaritm.dezel.view.graphic.Color
import ca.logaritm.dezel.view.type.ImageFilter


/**
 * @class ImageView
 * @since 0.7.0
 * @hidden
 */
open class ImageView(context: Context) : View(context), Clippable {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The image view's image.
	 * @property image
	 * @since 0.7.0
	 */
	open var image: Bitmap? by Delegates.OnSetOptional<Bitmap>(null) {
		this.invalidate()
	}

	/**
	 * The image view's image top position.
	 * @property imageTop
	 * @since 0.7.0
	 */
	open var imageTop: Float by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * The image view's image left position.
	 * @property imageLeft
	 * @since 0.7.0
	 */
	open var imageLeft: Float by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * The image view's image width.
	 * @property imageWidth
	 * @since 0.7.0
	 */
	open var imageWidth: Float by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * The image view's image height.
	 * @property imageHeight
	 * @since 0.7.0
	 */
	open var imageHeight: Float by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * The image view's image filter.
	 * @property imageFilter
	 * @since 0.7.0
	 */
	open var imageFilter: ImageFilter by Delegates.OnSet(ImageFilter.NONE) {
		this.invalidate()
	}

	/**
	 * The image view's image color.
	 * @property imageTint
	 * @since 0.7.0
	 */
	open var imageTint: Int by Delegates.OnSet(Color.TRANSPARENT) {
		this.invalidate()
	}

	/**
	 * @property srcRect
	 * @since 0.7.0
	 * @hidden
	 */
	private var srcRect: Rect = Rect()

	/**
	 * @property dstRect
	 * @since 0.7.0
	 * @hidden
	 */
	private var dstRect: Rect = Rect()

	/**
	 * @property paint
	 * @since 0.7.0
	 * @hidden
	 */
	private var paint: Paint = Paint()

	/**
	 * @property grayscaleColorMatrix
	 * @since 0.7.0
	 * @hidden
	 */
	private val grayscaleColorMatrix: ColorMatrix

	/**
	 * @property grayscaleColorMatrixFilter
	 * @since 0.7.0
	 * @hidden
	 */
	private val grayscaleColorMatrixFilter: ColorMatrixColorFilter

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	init {

		this.setLayerType(LAYER_TYPE_HARDWARE, null)

		this.grayscaleColorMatrix = ColorMatrix()
		this.grayscaleColorMatrix.setSaturation(0f)
		this.grayscaleColorMatrixFilter = ColorMatrixColorFilter(this.grayscaleColorMatrix)
	}

	/**
	 * Measures the natural size of this view.
	 * @method measure
	 * @since 0.7.0
	 */
	open fun measure(bounds: SizeF, min: SizeF, max: SizeF): SizeF {

		val image = this.image
		if (image == null) {
			return SizeF(0f, 0f)
		}

		val frameW = bounds.width
		val frameH = bounds.height
		val imageW = image.width.toFloat()
		val imageH = image.height.toFloat()

		val scaleW = imageW / imageH
		val scaleH = imageH / imageW

		if (frameW == 0f &&
			frameH == 0f) {
			return SizeF(imageW, imageH).clamp(min, max)
		}

		if (frameW == 0f) return SizeF(frameH * scaleW, frameH).clamp(min, max)
		if (frameH == 0f) return SizeF(frameW, frameW * scaleH).clamp(min, max)

		return bounds.ceiled()
	}

	/**
	 * @method onDraw
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onDraw(canvas: Canvas) {

		val image = this.image
		if (image == null) {
			return
		}

		val imageT = this.imageTop.toInt()
		val imageL = this.imageLeft.toInt()
		val imageW = this.imageWidth.toInt()
		val imageH = this.imageHeight.toInt()

		this.srcRect.set(0, 0, image.width, image.height)
		this.dstRect.set(
			imageL,
			imageT,
			imageL + imageW,
			imageT + imageH
		)

		val tint = this.imageTint
		if (tint == Color.TRANSPARENT) {
			this.paint.colorFilter = null
		} else {
			this.paint.colorFilter = PorterDuffColorFilter(tint, PorterDuff.Mode.SRC_IN)
		}

		if (this.imageFilter == ImageFilter.GRAYSCALE) {
			// This is not perfect because it will override the color filter, It would be nice
			// to be able to apply both
			this.paint.colorFilter = this.grayscaleColorMatrixFilter
		}

		canvas.save()
		canvas.clipRect(0, 0, this.width, this.height)

		canvas.drawBitmap(
			image,
			this.srcRect,
			this.dstRect,
			this.paint
		)

		canvas.restore()
	}
}