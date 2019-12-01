package ca.logaritm.dezel.view.drawable

import android.graphics.*
import android.graphics.drawable.Drawable
import ca.logaritm.dezel.extension.Delegates
import ca.logaritm.dezel.extension.graphics.addInnerRoundedRect
import ca.logaritm.dezel.extension.graphics.addOuterRoundedRect


/**
 * @class BorderDrawable
 * @super Drawable
 * @since 0.1.0
 */
open class BorderDrawable : Drawable() {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property borderTopColor
	 * @since 0.1.0
	 */
	public var borderTopColor: Int by Delegates.OnSet(Color.BLACK) {
		this.invalidateCache()
	}

	/**
	 * @property borderLeftColor
	 * @since 0.1.0
	 */
	public var borderLeftColor: Int by Delegates.OnSet(Color.BLACK) {
		this.invalidateCache()
	}

	/**
	 * @property borderRightColor
	 * @since 0.1.0
	 */
	public var borderRightColor: Int by Delegates.OnSet(Color.BLACK) {
		this.invalidateCache()
	}

	/**
	 * @property borderBottomColor
	 * @since 0.1.0
	 */
	public var borderBottomColor: Int by Delegates.OnSet(Color.BLACK) {
		this.invalidateCache()
	}

	/**
	 * @property borderTopWidth
	 * @since 0.1.0
	 */
	public var borderTopWidth: Float by Delegates.OnSet(0f) {
		this.invalidateCache()
	}

	/**
	 * @property borderLeftWidth
	 * @since 0.1.0
	 */
	public var borderLeftWidth: Float by Delegates.OnSet(0f) {
		this.invalidateCache()
	}

	/**
	 * @property borderRightWidth
	 * @since 0.1.0
	 */
	public var borderRightWidth: Float by Delegates.OnSet(0f) {
		this.invalidateCache()
	}

	/**
	 * @property borderBottomWidth
	 * @since 0.1.0
	 */
	public var borderBottomWidth: Float by Delegates.OnSet(0f) {
		this.invalidateCache()
	}

	/**
	 * @property borderTopLeftRadius
	 * @since 0.1.0
	 */
	public var borderTopLeftRadius: Float by Delegates.OnSet(0f) {
		this.invalidateCache()
	}

	/**
	 * @property borderTopRightRadius
	 * @since 0.1.0
	 */
	public var borderTopRightRadius: Float by Delegates.OnSet(0f) {
		this.invalidateCache()
	}

	/**
	 * @property borderBottomLeftRadius
	 * @since 0.1.0
	 */
	public var borderBottomLeftRadius: Float by Delegates.OnSet(0f) {
		this.invalidateCache()
	}

	/**
	 * @property borderBottomRightRadius
	 * @since 0.1.0
	 */
	public var borderBottomRightRadius: Float by Delegates.OnSet(0f) {
		this.invalidateCache()
	}

	/**
	 * @property borderTopLeftInnerRadius
	 * @since 0.1.0
	 */
	public var borderTopLeftInnerRadius: PointF by Delegates.OnSet(PointF(0f, 0f)) {
		this.invalidateCache()
	}

	/**
	 * @property borderTopRightInnerRadius
	 * @since 0.1.0
	 */
	public var borderTopRightInnerRadius: PointF by Delegates.OnSet(PointF(0f, 0f)) {
		this.invalidateCache()
	}

	/**
	 * @property borderBottomLeftInnerRadius
	 * @since 0.1.0
	 */
	public var borderBottomLeftInnerRadius: PointF by Delegates.OnSet(PointF(0f, 0f)) {
		this.invalidateCache()
	}

	/**
	 * @property borderBottomRightInnerRadius
	 * @since 0.1.0
	 */
	public var borderBottomRightInnerRadius: PointF by Delegates.OnSet(PointF(0f, 0f)) {
		this.invalidateCache()
	}

	/**
	 * @property borderTopPaint
	 * @since 0.1.0
	 * @hidden
	 */
	private val borderTopPaint: Paint = Paint()

	/**
	 * @property borderLeftPaint
	 * @since 0.1.0
	 * @hidden
	 */
	private val borderLeftPaint: Paint = Paint()

	/**
	 * @property borderRightPaint
	 * @since 0.1.0
	 * @hidden
	 */
	private val borderRightPaint: Paint = Paint()

	/**
	 * @property borderBottomPaint
	 * @since 0.1.0
	 * @hidden
	 */
	private val borderBottomPaint: Paint = Paint()

	/**
	 * @property borderTopShape
	 * @since 0.1.0
	 * @hidden
	 */
	private val borderTopShape: Path = Path()

	/**
	 * @property borderLeftShape
	 * @since 0.1.0
	 * @hidden
	 */
	private val borderLeftShape: Path = Path()

	/**
	 * @property borderRightShape
	 * @since 0.1.0
	 * @hidden
	 */
	private val borderRightShape: Path = Path()

	/**
	 * @property borderBottomShape
	 * @since 0.1.0
	 * @hidden
	 */
	private val borderBottomShape: Path = Path()

	/**
	 * @property outerPathPaint
	 * @since 0.1.0
	 * @hidden
	 */
	private val outerPathPaint: Paint = Paint(Paint.ANTI_ALIAS_FLAG)

	/**
	 * @property innerPathPaint
	 * @since 0.1.0
	 * @hidden
	 */
	private val innerPathPaint: Paint = Paint(Paint.ANTI_ALIAS_FLAG)

	/**
	 * @property borderCacheBitmap
	 * @since 0.1.0
	 * @hidden
	 */
	private var borderCacheBitmap: Bitmap? = null

	/**
	 * @property borderCacheCanvas
	 * @since 0.1.0
	 * @hidden
	 */
	private var borderCacheCanvas: Canvas? = null

	/**
	 * @property borderNineSlice
	 * @since 0.1.0
	 * @hidden
	 */
	private var borderNineSlice: NineSliceDrawable? = null

	/**
	 * @property invalidBorderCache
	 * @since 0.1.0
	 * @hidden
	 */
	private var invalidBorderCache: Boolean = true

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	init {

		this.borderTopPaint.isAntiAlias = false
		this.borderLeftPaint.isAntiAlias = false
		this.borderRightPaint.isAntiAlias = false
		this.borderBottomPaint.isAntiAlias = false

		this.innerPathPaint.xfermode = PorterDuffXfermode(PorterDuff.Mode.CLEAR)
	}

	/**
	 * @method invalidateCache
	 * @since 0.1.0
	 */
	open fun invalidateCache() {
		this.invalidBorderCache = true
	}

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
	override fun getOpacity(): Int {
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

		if (this.invalidBorderCache) {
			this.invalidBorderCache = false
			this.drawBorderCache()
		}

		val borderNineSlice = this.borderNineSlice
		if (borderNineSlice == null) {
			return
		}

		val bounds = this.bounds
		val drawableT = bounds.top
		val drawableL = bounds.left
		val drawableW = bounds.width()
		val drawableH = bounds.height()

		borderNineSlice.setBounds(drawableL, drawableT, drawableL + drawableW, drawableT + drawableH)
		borderNineSlice.paint.xfermode = xfermode
		borderNineSlice.draw(canvas)
		borderNineSlice.paint.xfermode = null
	}

	/**
	 * @method drawBorderCache
	 * @since 0.1.0
	 * @hidden
	 */
	private fun drawBorderCache() {

		val borderWidthT = this.borderTopWidth
		val borderWidthL = this.borderLeftWidth
		val borderWidthR = this.borderRightWidth
		val borderWidthB = this.borderBottomWidth

		val borderColorT = this.borderTopColor
		val borderColorL = this.borderLeftColor
		val borderColorR = this.borderRightColor
		val borderColorB = this.borderBottomColor

		if ((borderWidthT == 0f || Color.alpha(borderColorT) == 0) &&
			(borderWidthL == 0f || Color.alpha(borderColorL) == 0) &&
			(borderWidthR == 0f || Color.alpha(borderColorR) == 0) &&
			(borderWidthB == 0f || Color.alpha(borderColorB) == 0)) {
			this.borderNineSlice = null
			this.borderCacheBitmap = null
			this.borderCacheCanvas = null
			return
		}

		val outerRadiusTL = this.borderTopLeftRadius
		val outerRadiusTR = this.borderTopRightRadius
		val outerRadiusBL = this.borderBottomLeftRadius
		val outerRadiusBR = this.borderBottomRightRadius

		val innerRadiusTL = this.borderTopLeftInnerRadius
		val innerRadiusTR = this.borderTopRightInnerRadius
		val innerRadiusBL = this.borderBottomLeftInnerRadius
		val innerRadiusBR = this.borderBottomRightInnerRadius

		val cacheW = (borderWidthL + borderWidthR + Math.max(Math.max(innerRadiusTL.x, innerRadiusBL.x), Math.max(innerRadiusTR.x, innerRadiusBR.x)) * 2 + 3f)
		val cacheH = (borderWidthT + borderWidthB + Math.max(Math.max(innerRadiusTL.y, innerRadiusBL.y), Math.max(innerRadiusTR.y, innerRadiusBR.y)) * 2 + 3f)

		val borderCacheBitmap = Bitmap.createBitmap(cacheW.toInt(), cacheH.toInt(), Bitmap.Config.ARGB_8888)
		val borderCacheCanvas = Canvas(borderCacheBitmap)

		if (outerRadiusTL > 0 || outerRadiusTR > 0 ||
			outerRadiusBL > 0 || outerRadiusBR > 0) {

			val path = Path()

			path.addOuterRoundedRect(
				cacheW,
				cacheH,
				outerRadiusTL,
				outerRadiusTR,
				outerRadiusBL,
				outerRadiusBR
			)

			borderCacheCanvas.drawPath(path, this.outerPathPaint)

			this.borderTopPaint.xfermode = PorterDuffXfermode(PorterDuff.Mode.SRC_IN)
			this.borderLeftPaint.xfermode = PorterDuffXfermode(PorterDuff.Mode.SRC_IN)
			this.borderRightPaint.xfermode = PorterDuffXfermode(PorterDuff.Mode.SRC_IN)
			this.borderBottomPaint.xfermode = PorterDuffXfermode(PorterDuff.Mode.SRC_IN)
		}

		if (borderWidthT > 0f) {
			this.borderTopPaint.color = borderColorT
			this.borderTopShape.reset()
			this.borderTopShape.moveTo(0f, 0f)
			this.borderTopShape.lineTo(cacheW, 0f)
			this.borderTopShape.lineTo(cacheW - borderWidthR - innerRadiusTR.x, borderWidthT + innerRadiusTR.y)
			this.borderTopShape.lineTo(borderWidthL + innerRadiusTL.x, borderWidthT + innerRadiusTL.y)
			this.borderTopShape.close()
			borderCacheCanvas.drawPath(this.borderTopShape, this.borderTopPaint)
		}

		if (borderWidthL > 0) {
			this.borderLeftPaint.color = borderColorL
			this.borderLeftShape.reset()
			this.borderLeftShape.moveTo(0f, 0f)
			this.borderLeftShape.lineTo(borderWidthL + innerRadiusTL.x, borderWidthT + innerRadiusTL.y)
			this.borderLeftShape.lineTo(borderWidthL + innerRadiusBL.x, cacheH - borderWidthB - innerRadiusBL.y)
			this.borderLeftShape.lineTo(0f, cacheH)
			this.borderLeftShape.close()
			borderCacheCanvas.drawPath(this.borderLeftShape, this.borderLeftPaint)
		}

		if (borderWidthR > 0) {
			this.borderRightPaint.color = borderColorR
			this.borderRightShape.reset()
			this.borderRightShape.moveTo(cacheW - borderWidthR - innerRadiusTR.x, borderWidthT + innerRadiusTR.y)
			this.borderRightShape.lineTo(cacheW, 0f)
			this.borderRightShape.lineTo(cacheW, cacheH)
			this.borderRightShape.lineTo(cacheW - borderWidthR - innerRadiusBR.x, cacheH - borderWidthB - innerRadiusBR.y)
			this.borderRightShape.close()
			borderCacheCanvas.drawPath(this.borderRightShape, this.borderRightPaint)
		}

		if (borderWidthB > 0) {
			this.borderBottomPaint.color = borderColorB
			this.borderBottomShape.reset()
			this.borderBottomShape.moveTo(borderWidthL + innerRadiusBL.x, cacheH - borderWidthB - innerRadiusBL.y)
			this.borderBottomShape.lineTo(cacheW - borderWidthR - innerRadiusBR.x, cacheH - borderWidthB - innerRadiusBR.y)
			this.borderBottomShape.lineTo(cacheW, cacheH)
			this.borderBottomShape.lineTo(0f, cacheH)
			this.borderBottomShape.close()
			borderCacheCanvas.drawPath(this.borderBottomShape, this.borderBottomPaint)
		}

		if (innerRadiusTL.equals(0f, 0f) == false ||
			innerRadiusTR.equals(0f, 0f) == false ||
			innerRadiusBL.equals(0f, 0f) == false ||
			innerRadiusBR.equals(0f, 0f) == false) {

			val path = Path()

			path.addInnerRoundedRect(
				cacheW,
				cacheH,
				innerRadiusTL,
				innerRadiusTR,
				innerRadiusBL,
				innerRadiusBR,
				borderWidthT,
				borderWidthL,
				borderWidthR,
				borderWidthB
			)

			borderCacheCanvas.drawPath(path, this.innerPathPaint)
		}

		this.borderTopPaint.xfermode = null
		this.borderLeftPaint.xfermode = null
		this.borderRightPaint.xfermode = null
		this.borderBottomPaint.xfermode = null

		val offsetX = Math.max(innerRadiusTL.x, innerRadiusBL.x) + borderWidthL + 1f
		val offsetY = Math.max(innerRadiusTL.y, innerRadiusTR.y) + borderWidthT + 1f

		this.borderNineSlice = NineSliceDrawable(
			borderCacheBitmap,
			offsetY.toInt(),
			offsetX.toInt(),
			offsetX.toInt() + 1,
			offsetY.toInt() + 1
		)

		this.borderCacheBitmap = borderCacheBitmap
		this.borderCacheCanvas = borderCacheCanvas
	}
}
