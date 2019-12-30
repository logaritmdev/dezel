package ca.logaritm.dezel.view.drawable

import android.graphics.*
import android.graphics.drawable.Drawable
import ca.logaritm.dezel.view.type.ImageFit
import ca.logaritm.dezel.view.type.ImagePosition
import kotlin.math.max
import kotlin.math.min

/**
 * @class BackgroundImageDrawable
 * @super Drawable
 * @since 0.7.0
 */
open class BackgroundImageDrawable() : Drawable() {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property image
	 * @since 0.7.0
	 */
	open var image: Bitmap? = null

	/**
	 * @property imageFit
	 * @since 0.7.0
	 */
	open var imageFit: ImageFit = ImageFit.CONTAIN

	/**
	 * @property imagePosition
	 * @since 0.7.0
	 */
	open var imagePosition: ImagePosition = ImagePosition.MIDDLE_CENTER

	/**
	 * @property paint
	 * @since 0.7.0
	 * @hidden
	 */
	private val paint: Paint = Paint()

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

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @method setAlpha
	 * @since 0.7.0
	 */
	override fun setAlpha(alpha: Int) {

	}

	/**
	 * @method setColorFilter
	 * @since 0.7.0
	 */
	override fun setColorFilter(cf: ColorFilter?) {

	}

	/**
	 * @method getOpacity
	 * @since 0.7.0
	 */
	override fun getOpacity() : Int {
		return PixelFormat.TRANSLUCENT
	}

	/**
	 * @method draw
	 * @since 0.7.0
	 */
	override fun draw(canvas: Canvas) {
		this.draw(canvas, null)
	}

	/**
	 * @method draw
	 * @since 0.7.0
	 */
	open fun draw(canvas: Canvas, xfermode: Xfermode?) {

		val image = this.image
		if (image == null) {
			return
		}

		var imageW = 0f
		var imageH = 0f
		var imageT = 0f
		var imageL = 0f

		val naturalImageW = image.width.toFloat()
		val naturalImageH = image.height.toFloat()

		val frameW = this.bounds.width()
		val frameH = this.bounds.height()
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

		this.srcRect.set(0, 0, image.width, image.height)
		this.dstRect.set(
			imageL.toInt(),
			imageT.toInt(),
			imageL.toInt() + imageW.toInt(),
			imageT.toInt() + imageH.toInt()
		)

		canvas.save()
		canvas.clipRect(0, 0, this.bounds.width(), this.bounds.height())

		canvas.drawBitmap(
			image,
			this.srcRect,
			this.dstRect,
			this.paint
		)

		canvas.restore()
	}
}