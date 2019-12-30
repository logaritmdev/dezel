package ca.logaritm.dezel.view

import android.animation.ObjectAnimator
import android.animation.ValueAnimator
import android.content.Context
import android.graphics.*
import android.util.SizeF
import android.view.View
import ca.logaritm.dezel.extension.Delegates
import ca.logaritm.dezel.extension.util.ceiled
import ca.logaritm.dezel.extension.util.clamped
import ca.logaritm.dezel.view.graphic.Color
import ca.logaritm.dezel.view.animation.Animatable
import ca.logaritm.dezel.view.trait.Clippable
import ca.logaritm.dezel.view.type.ImageFit
import ca.logaritm.dezel.view.type.ImagePosition
import kotlin.math.max
import kotlin.math.min


/**
 * @class ImageView
 * @since 0.7.0
 */
open class ImageView(context: Context) : View(context), Clippable, Animatable {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property tint
	 * @since 0.7.0
	 */
	open var tint: Int by Delegates.OnSet(Color.TRANSPARENT) {
		this.invalidate()
	}

	/**
	 * @property image
	 * @since 0.7.0
	 */
	open var image: Bitmap? by Delegates.OnSetOptional<Bitmap>(null) {
		this.invalidate()
	}

	/**
	 * @property imageFit
	 * @since 0.7.0
	 */
	open var imageFit: ImageFit by Delegates.OnSet(ImageFit.CONTAIN) {
		this.invalidate()
	}

	/**
	 * @property imagePosition
	 * @since 0.7.0
	 */
	open var imagePosition: ImagePosition by Delegates.OnSet(ImagePosition.MIDDLE_CENTER) {
		this.invalidate()
	}

	/**
	 * @property paddingTop
	 * @since 0.7.0
	 */
	open var paddingTop: Float by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * @property paddingLeft
	 * @since 0.7.0
	 */
	open var paddingLeft: Float by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * @property paddingRight
	 * @since 0.7.0
	 */
	open var paddingRight: Float by Delegates.OnSet(0f) {
		this.invalidate()
	}

	/**
	 * @property paddingBottom
	 * @since 0.7.0
	 */
	open var paddingBottom: Float by Delegates.OnSet(0f) {
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

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	init {
		this.setLayerType(LAYER_TYPE_HARDWARE, null)
	}

	/**
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
			return SizeF(imageW, imageH).clamped(min, max)
		}

		if (frameW == 0f) return SizeF(frameH * scaleW, frameH).clamped(min, max)
		if (frameH == 0f) return SizeF(frameW, frameW * scaleH).clamped(min, max)

		return bounds.ceiled()
	}

	/**
	 * @method onDraw
	 * @since 0.7.0
	 */
	override fun onDraw(canvas: Canvas) {

		val image = this.image
		if (image == null) {
			return
		}

		val paddingT = this.paddingTop
		val paddingL = this.paddingLeft
		val paddingR = this.paddingRight
		val paddingB = this.paddingBottom
		
		var imageW = 0f
		var imageH = 0f
		var imageT = 0f
		var imageL = 0f

		val naturalImageW = image.width.toFloat()
		val naturalImageH = image.height.toFloat()

		val frameW = this.width
		val frameH = this.height
		val scaleX = frameW / naturalImageW
		val scaleY = frameH / naturalImageH

		when (this.imageFit) {

			ImageFit.COVER   -> {
				val scale = max(scaleX, scaleY)
				imageW = naturalImageW * scale
				imageH = naturalImageH * scale
			}

			ImageFit.CONTAIN -> {
				val scale = min(scaleX, scaleY)
				imageW = naturalImageW * scale
				imageH = naturalImageH * scale
			}
		}

		when (this.imagePosition) {

			ImagePosition.TOP_LEFT -> {
				imageT = 0f
				imageL = 0f
			}

			ImagePosition.TOP_RIGHT -> {
				imageT = 0f
				imageL = frameW - imageW
			}

			ImagePosition.TOP_CENTER -> {
				imageT = 0f
				imageL = frameW / 2 - imageW / 2
			}

			ImagePosition.MIDDLE_LEFT -> {
				imageT = frameH / 2 - imageH / 2
				imageL = 0f
			}

			ImagePosition.MIDDLE_RIGHT -> {
				imageT = frameH / 2 - imageH / 2
				imageL = frameW - imageW
			}

			ImagePosition.MIDDLE_CENTER -> {
				imageT = frameH / 2 - imageH / 2
				imageL = frameW / 2 - imageW / 2
			}

			ImagePosition.BOTTOM_LEFT -> {
				imageT = frameH - imageH
				imageL = 0f
			}

			ImagePosition.BOTTOM_RIGHT -> {
				imageT = frameH - imageH
				imageL = frameW - imageW
			}

			ImagePosition.BOTTOM_CENTER -> {
				imageT = frameH - imageH
				imageL = frameW / 2 - imageW / 2
			}
		}

		imageT += paddingT
		imageL += paddingL
		imageW -= paddingL + paddingR
		imageH -= paddingT + paddingB

		this.srcRect.set(0, 0, image.width, image.height)
		this.dstRect.set(
			imageL.toInt(),
			imageT.toInt(),
			imageL.toInt() + imageW.toInt(),
			imageT.toInt() + imageH.toInt()
		)

		val tint = this.tint
		if (tint == Color.TRANSPARENT) {
			this.paint.colorFilter = null
		} else {
			this.paint.colorFilter = PorterDuffColorFilter(tint, PorterDuff.Mode.SRC_IN)
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

	//--------------------------------------------------------------------------
	// Animations
	//--------------------------------------------------------------------------

	/**
	 * @property animatable
	 * @since 0.7.0
	 */
	override var animatable: List<String> = listOf(
		"imageTint",
		"paddingTop",
		"paddingLeft",
		"paddingRight",
		"paddingBottom"
	)

	/**
	 * @property animations
	 * @since 0.7.0
	 */
	override var animations: MutableMap<String, ValueAnimator> = mutableMapOf()

	/**
	 * @method onBeforeAnimate
	 * @since 0.7.0
	 */
	override fun animate(property: String, initialValue: Any, currentValue: Any): ValueAnimator? {

		when (property) {

			"imageTint" -> {

				if (initialValue is Int &&
					currentValue is Int) {
					return ObjectAnimator.ofArgb(this, property, initialValue, currentValue)
				}

				throw Exception("Unexpected error.")
			}

			"paddingTop",
			"paddingLeft",
			"paddingRight",
			"paddingBottom" -> {

				if (initialValue is Float &&
					currentValue is Float) {
					return ObjectAnimator.ofFloat(this, property, initialValue, currentValue)
				}

				throw Exception("Unexpected error.")
			}
		}

		return null
	}

	/**
	 * @method onBeforeAnimate
	 * @since 0.7.0
	 */
	override fun onBeforeAnimate(property: String) {

	}

	/**
	 * @method onBeginTransition
	 * @since 0.7.0
	 */
	override fun onBeginTransition() {

	}

	/**
	 * @method onCommitTransition
	 * @since 0.7.0
	 */
	override fun onCommitTransition() {

	}

	/**
	 * @method onFinishTransition
	 * @since 0.7.0
	 */
	override fun onFinishTransition() {

	}
}
