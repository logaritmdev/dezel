package ca.logaritm.dezel.view.drawable

import android.graphics.*
import android.graphics.drawable.Drawable
import ca.logaritm.dezel.view.graphic.LinearGradient
import ca.logaritm.dezel.view.graphic.RadialGradient
import android.graphics.LinearGradient as AndroidLinearGradient

/**
 * @class BitmapDrawable
 * @super Drawable
 * @since 0.1.0
 */
open class BitmapDrawable() : Drawable() {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property backgroundColor
	 * @since 0.1.0
	 */
	open var backgroundColor: Int? = null

	/**
	 * @property backgroundImage
	 * @since 0.1.0
	 */
	open var backgroundImage: Bitmap? = null

	/**
	 * @property backgroundImageTop
	 * @since 0.1.0
	 */
	open var backgroundImageTop: Float = 0f

	/**
	 * @property backgroundImageLeft
	 * @since 0.1.0
	 */
	open var backgroundImageLeft: Float = 0f

	/**
	 * @property backgroundImageWidth
	 * @since 0.1.0
	 */
	open var backgroundImageWidth: Float = 0f

	/**
	 * @property backgroundImageHeight
	 * @since 0.1.0
	 */
	open var backgroundImageHeight: Float = 0f

	/**
	 * @property backgroundImageTint
	 * @since 0.1.0
	 */
	open var backgroundImageTint: Int = Color.TRANSPARENT

	/**
	 * @property backgroundLinearGradient
	 * @since 0.1.0
	 */
	open var backgroundLinearGradient: LinearGradient? = null

	/**
	 * @property backgroundRadialGradient
	 * @since 0.1.0
	 */
	open var backgroundRadialGradient: RadialGradient? = null

	/**
	 * @property backgroundColorPaint
	 * @since 0.1.0
	 * @hidden
	 */
	private val backgroundColorPaint: Paint = Paint()

	/**
	 * @property backgroundLinearGradientPaint
	 * @since 0.1.0
	 * @hidden
	 */
	private val backgroundLinearGradientPaint: Paint = Paint()

	/**
	 * @property backgroundRadialGradientPaint
	 * @since 0.1.0
	 * @hidden
	 */
	private val backgroundRadialGradientPaint: Paint = Paint()

	/**
	 * @property backgroundImagePaint
	 * @since 0.1.0
	 * @hidden
	 */
	private val backgroundImagePaint: Paint = Paint()

	/**
	 * @property srcRect
	 * @since 0.1.0
	 * @hidden
	 */
	private var srcRect: Rect = Rect()

	/**
	 * @property dstRect
	 * @since 0.1.0
	 * @hidden
	 */
	private var dstRect: Rect = Rect()

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @method setAlpha
	 * @since 0.1.0
	 */
	override fun setAlpha(alpha: Int) {

	}

	/**
	 * @method setColorFilter
	 * @since 0.1.0
	 */
	override fun setColorFilter(cf: ColorFilter?) {

	}

	/**
	 * @method getOpacity
	 * @since 0.1.0
	 */
	override fun getOpacity() : Int {
		return PixelFormat.TRANSLUCENT
	}

	/**
	 * @method draw
	 * @since 0.1.0
	 */
	override fun draw(canvas: Canvas) {
		this.draw(canvas, null)
	}

	/**
	 * @method draw
	 * @since 0.1.0
	 */
	open fun draw(canvas: Canvas, xfermode: Xfermode?) {

		val linearGradient = this.backgroundLinearGradient
		val radialGradient = this.backgroundRadialGradient

		val backgroundColor = this.backgroundColor
		if (backgroundColor != null &&
			backgroundColor != Color.TRANSPARENT) {
			this.drawBackgroundColor(canvas, xfermode, backgroundColor)
		} else if (linearGradient != null) {
			this.drawBackgroundLinearGradient(canvas, xfermode, linearGradient)
		} else if (radialGradient != null) {

		}

		val backgroundImage = this.backgroundImage
		if (backgroundImage != null) {
			this.drawBackgroundImage(canvas, xfermode, backgroundImage)
		}
	}

	/**
	 * @method drawBackgroundColor
	 * @since 0.1.0
	 */
	open fun drawBackgroundColor(canvas: Canvas, xfermode: Xfermode?, backgroundColor: Int) {
		this.backgroundColorPaint.xfermode = xfermode
		this.backgroundColorPaint.color = backgroundColor
		canvas.drawRect(this.bounds, this.backgroundColorPaint)
		this.backgroundColorPaint.xfermode = null
	}

	/**
	 * @method drawBackgroundImage
	 * @since 0.1.0
	 */
	open fun drawBackgroundImage(canvas: Canvas, xfermode: Xfermode?, backgroundImage: Bitmap) {

		this.srcRect.set(
			0, 0,
			backgroundImage.width,
			backgroundImage.height
		)

		this.dstRect.set(
			this.backgroundImageLeft.toInt(),
			this.backgroundImageTop.toInt(),
			this.backgroundImageLeft.toInt() + this.backgroundImageWidth.toInt(),
			this.backgroundImageTop.toInt() + this.backgroundImageHeight.toInt()
		)

		val backgroundImageTint = this.backgroundImageTint
		if (backgroundImageTint == Color.TRANSPARENT) {
			this.backgroundImagePaint.colorFilter = null
		} else {
			this.backgroundImagePaint.colorFilter = PorterDuffColorFilter(backgroundImageTint, PorterDuff.Mode.SRC_IN)
		}

		canvas.save()
		canvas.clipRect(0, 0, this.bounds.width(), this.bounds.height())
		canvas.drawBitmap(backgroundImage, this.srcRect, this.dstRect, this.backgroundImagePaint)
		canvas.restore()
	}

	/**
	 * @method drawBackgroundLinearGradient
	 * @since 0.1.0
	 */
	open fun drawBackgroundLinearGradient(canvas: Canvas, xfermode: Xfermode?, linearGradient: LinearGradient) {

		val w = this.bounds.width()
		val h = this.bounds.height()

		val x = (linearGradient.angle + Math.PI / 2.0) / (2.0 * Math.PI)

		val a = Math.pow(Math.sin((2.0 * Math.PI * ((x + 0.75) / 2.0))), 2.0).toFloat() * w.toFloat()
		val b = Math.pow(Math.sin((2.0 * Math.PI * ((x + 0.00) / 2.0))), 2.0).toFloat() * h.toFloat()
		val c = Math.pow(Math.sin((2.0 * Math.PI * ((x + 0.25) / 2.0))), 2.0).toFloat() * w.toFloat()
		val d = Math.pow(Math.sin((2.0 * Math.PI * ((x + 0.50) / 2.0))), 2.0).toFloat() * h.toFloat()

		val shader = AndroidLinearGradient(a, b, c, d, linearGradient.colors.toIntArray(), linearGradient.points.toFloatArray(), Shader.TileMode.CLAMP)

		this.backgroundLinearGradientPaint.xfermode = xfermode
		this.backgroundLinearGradientPaint.shader = shader

		canvas.drawRect(this.bounds, this.backgroundLinearGradientPaint)

		this.backgroundLinearGradientPaint.xfermode = null
	}
}