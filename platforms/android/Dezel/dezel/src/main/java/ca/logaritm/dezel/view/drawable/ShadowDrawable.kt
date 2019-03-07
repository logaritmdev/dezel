package ca.logaritm.dezel.view.drawable

import android.graphics.*
import android.graphics.drawable.Drawable
import ca.logaritm.dezel.extension.Delegates
import ca.logaritm.dezel.extension.addOuterRoundedRect
import ca.logaritm.dezel.extension.ceil

/**
 * @class ShadowDrawable
 * @since 0.1.0
 * @hidden
 */
open class ShadowDrawable : Drawable() {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property shadowColor
	 * @since 0.1.0
	 * @hidden
	 */
	public var shadowColor: Int by Delegates.OnSet(Color.TRANSPARENT) {
		this.invalidateCache()
	}

	/**
	 * @property shadowBlur
	 * @since 0.1.0
	 * @hidden
	 */
	public var shadowBlur: Float by Delegates.OnSet(0f) {
		this.invalidateCache()
	}

	/**
	 * @property shadowOffsetTop
	 * @since 0.1.0
	 * @hidden
	 */
	public var shadowOffsetTop: Float = 0f

	/**
	 * @property shadowOffsetLeft
	 * @since 0.1.0
	 * @hidden
	 */
	public var shadowOffsetLeft: Float = 0f

	/**
	 * @property borderTopLeftRadius
	 * @since 0.1.0
	 * @hidden
	 */
	public var borderTopLeftRadius: Float by Delegates.OnSet(0f) {
		this.invalidateCache()
	}

	/**
	 * @property borderTopRightRadius
	 * @since 0.1.0
	 * @hidden
	 */
	public var borderTopRightRadius: Float by Delegates.OnSet(0f) {
		this.invalidateCache()
	}

	/**
	 * @property borderBottomLeftRadius
	 * @since 0.1.0
	 * @hidden
	 */
	public var borderBottomLeftRadius: Float by Delegates.OnSet(0f) {
		this.invalidateCache()
	}

	/**
	 * @property borderBottomRightRadius
	 * @since 0.1.0
	 * @hidden
	 */
	public var borderBottomRightRadius: Float by Delegates.OnSet(0f) {
		this.invalidateCache()
	}

	/**
	 * @property shadowPaint
	 * @since 0.1.0
	 * @hidden
	 */
	private val shadowPaint: Paint = Paint()

	/**
	 * @property shadowCacheBitmap
	 * @since 0.1.0
	 * @hidden
	 */
	private var shadowCacheBitmap: Bitmap? = null

	/**
	 * @property shadowCacheCanvas
	 * @since 0.1.0
	 * @hidden
	 */
	private var shadowCacheCanvas: Canvas? = null

	/**
	 * @property shadowNineSlice
	 * @since 0.1.0
	 * @hidden
	 */
	private var shadowNineSlice: NineSliceDrawable? = null

	/**
	 * @property invalidShadowCache
	 * @since 0.1.0
	 * @hidden
	 */
	private var invalidShadowCache: Boolean = false

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	init {
		this.shadowPaint.isAntiAlias = true
	}

	/**
	 * @method invalidateCache
	 * @since 0.1.0
	 * @hidden
	 */
	open fun invalidateCache() {
		this.invalidShadowCache = true
	}

	/**
	 * @method setAlpha
	 * @since 0.1.0
	 * @hidden
	 */
	override fun setAlpha(alpha: Int) {

	}

	/**
	 * @method setColorFilter
	 * @since 0.1.0
	 * @hidden
	 */
	override fun setColorFilter(cf: ColorFilter?) {

	}

	/**
	 * @method getOpacity
	 * @since 0.1.0
	 * @hidden
	 */
	override fun getOpacity() : Int {
		return PixelFormat.TRANSLUCENT
	}

	/**
	 * @method draw
	 * @since 0.1.0
	 * @hidden
	 */
	override fun draw(canvas: Canvas) {
		this.draw(canvas, null)
	}

	/**
	 * @method draw
	 * @since 0.1.0
	 * @hidden
	 */
	open fun draw(canvas: Canvas, xfermode: Xfermode ?) {

		if (this.invalidShadowCache) {
			this.invalidShadowCache = false
			this.drawShadowCache()
		}

		val shadowNineSlice = this.shadowNineSlice
		if (shadowNineSlice == null) {
			return
		}

		val shadowBlur = Float.ceil(this.shadowBlur)
		val shadowOffsetT = this.shadowOffsetTop
		val shadowOffsetL = this.shadowOffsetLeft

		canvas.save()
		canvas.translate(shadowOffsetL, shadowOffsetT)

		val bounds = this.bounds
		val drawableW = bounds.width() + (shadowBlur * 2f).toInt()
		val drawableH = bounds.height() + (shadowBlur * 2f).toInt()

		shadowNineSlice.setBounds(0, 0, drawableW, drawableH)
		shadowNineSlice.paint.xfermode = xfermode
		shadowNineSlice.draw(canvas)
		shadowNineSlice.paint.xfermode = null

		canvas.restore()
	}

	/**
	 * @method drawShadowCache
	 * @since 0.1.0
	 * @hidden
	 */
	private fun drawShadowCache() {

		val shadowBlur = Float.ceil(this.shadowBlur)

		if (Color.alpha(this.shadowColor) > 0) {

			/*
			 * Basically finds the smallest bitmap that contains the pattern that
			 * will be nine-scaled
			 */

			val borderRadiusTL = this.borderTopLeftRadius
			val borderRadiusTR = this.borderTopRightRadius
			val borderRadiusBL = this.borderBottomLeftRadius
			val borderRadiusBR = this.borderBottomRightRadius

			val inner = Math.max(
				Math.max(
					Math.max(borderRadiusTL, borderRadiusTR),
					Math.max(borderRadiusBR, borderRadiusBL)
				),
				shadowBlur
			)

			val shapeW = inner * 2f + 3f
			val shapeH = inner * 2f + 3f
			val cacheW = inner * 2f + shadowBlur * 2f + 3f
			val cacheH = inner * 2f + shadowBlur * 2f + 3f

			val shapeT = cacheH / 2 - shapeH / 2
			val shapeL = cacheW / 2 - shapeW / 2

			val shadowCacheBitmap = Bitmap.createBitmap(cacheW.toInt(), cacheH.toInt(), Bitmap.Config.ARGB_8888)
			val shadowCacheCanvas = Canvas(shadowCacheBitmap)

			shadowCacheCanvas.save()

			if (shadowBlur > 0f) {

				this.shadowPaint.color = Color.BLACK
				this.shadowPaint.setShadowLayer(shadowBlur, cacheW, cacheH, this.shadowColor)

				shadowCacheCanvas.translate(
					shapeL - cacheW,
					shapeT - cacheH
				)

			} else {

				this.shadowPaint.color = this.shadowColor
				this.shadowPaint.clearShadowLayer()

			}

			val path = Path()

			path.addOuterRoundedRect(
				shapeW,
				shapeH,
				borderRadiusTL,
				borderRadiusTR,
				borderRadiusBL,
				borderRadiusBR
			)

			shadowCacheCanvas.drawPath(path, this.shadowPaint)
			shadowCacheCanvas.restore()

			val offsetX = shadowBlur + inner + 1f
			val offsetY = shadowBlur + inner + 1f

			this.shadowNineSlice = NineSliceDrawable(
				shadowCacheBitmap,
				offsetY.toInt(),
				offsetX.toInt(),
				offsetX.toInt() + 1,
				offsetX.toInt() + 1
			)

			this.shadowCacheBitmap = shadowCacheBitmap
			this.shadowCacheCanvas = shadowCacheCanvas

		} else {
			this.shadowCacheBitmap = null
			this.shadowCacheCanvas = null
		}
	}
}
