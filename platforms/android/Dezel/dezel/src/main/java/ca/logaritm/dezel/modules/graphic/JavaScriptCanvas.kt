package ca.logaritm.dezel.modules.graphic

import android.graphics.*
import ca.logaritm.dezel.core.*
import ca.logaritm.dezel.extension.Delegates
import ca.logaritm.dezel.extension.addArcTo
import ca.logaritm.dezel.extension.pop
import ca.logaritm.dezel.view.graphic.Color
import ca.logaritm.dezel.view.graphic.Convert
import android.graphics.Canvas as AndroidCanvas

/**
 * @class CanvasClass
 * @since 0.7.0
 */
open class JavaScriptCanvas(context: JavaScriptContext) : JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The canvas fill style.
	 * @property fillStyle
	 * @since 0.7.0
	 */	
	open var fillStyle: Property by Delegates.OnSet(Property("black")) { value ->
		this.fillPaint.color = Color.parse(value.string)
	}

	/**
	 * The canvas stroke style.
	 * @property strokeStyle
	 * @since 0.7.0
	 */
	open var strokeStyle: Property by Delegates.OnSet(Property("black")) { value ->
		this.strokePaint.color = Color.parse(value.string)
	}

	/**
	 * The canvas line cap mode.
	 * @property lineCap
	 * @since 0.7.0
	 */
	open var lineCap: Property by Delegates.OnSet(Property("butt")) { value ->
		 when (value.string) {
			"butt"   -> this.strokePaint.strokeCap = Paint.Cap.BUTT
			"round"  -> this.strokePaint.strokeCap = Paint.Cap.ROUND
			"square" -> this.strokePaint.strokeCap = Paint.Cap.SQUARE
		}
	}

	/**
	 * The canvas line join mode.
	 * @property lineJoin
	 * @since 0.7.0
	 */
	open var lineJoin: Property by Delegates.OnSet(Property("miter")) { value ->
		when (value.string) {
			"miter" -> this.strokePaint.strokeJoin = Paint.Join.MITER
			"round" -> this.strokePaint.strokeJoin = Paint.Join.ROUND
			"bevel" -> this.strokePaint.strokeJoin = Paint.Join.BEVEL
		}
	}

	/**
	 * The canvas line width.
	 * @property lineWidth
	 * @since 0.7.0
	 */
	open var lineWidth: Property by Delegates.OnSet(Property(1.0)) { value ->
		this.strokePaint.strokeWidth = Convert.toPx(value.number)
	}

	/**
	 * The canvas horizontal shadow offset.
	 * @property shadowOffsetX
	 * @since 0.7.0
	 */
	open var shadowOffsetX: Property by Delegates.OnSet(Property(0.0)) { value ->
		this.measuredShadowOffsetX = Convert.toPx(value.number)
		this.fillPaint.setShadowLayer(this.measuredShadowBlur, this.measuredShadowOffsetX, this.measuredShadowOffsetY, this.computedShadowColor)
		this.strokePaint.setShadowLayer(this.measuredShadowBlur, this.measuredShadowOffsetX, this.measuredShadowOffsetY, this.computedShadowColor)
	}

	/**
	 * The canvas vertical shadow offset.
	 * @property shadowOffsetY
	 * @since 0.7.0
	 */
	open var shadowOffsetY: Property by Delegates.OnSet(Property(0.0)) { value ->
		this.measuredShadowOffsetY = Convert.toPx(value.number)
		this.fillPaint.setShadowLayer(this.measuredShadowBlur, this.measuredShadowOffsetX, this.measuredShadowOffsetY, this.computedShadowColor)
		this.strokePaint.setShadowLayer(this.measuredShadowBlur, this.measuredShadowOffsetX, this.measuredShadowOffsetY, this.computedShadowColor)
	}

	/**
	 * The canvas shadow blur.
	 * @property shadowBlur
	 * @since 0.7.0
	 */
	open var shadowBlur: Property by Delegates.OnSet(Property(0.0)) { value ->
		this.measuredShadowBlur = Convert.toPx(value.number)
		this.fillPaint.setShadowLayer(this.measuredShadowBlur, this.measuredShadowOffsetX, this.measuredShadowOffsetY, this.computedShadowColor)
		this.strokePaint.setShadowLayer(this.measuredShadowBlur, this.measuredShadowOffsetX, this.measuredShadowOffsetY, this.computedShadowColor)
	}

	/**
	 * The canvas shadow color.
	 * @property shadowBlur
	 * @since 0.7.0
	 */
	open var shadowColor: Property by Delegates.OnSet(Property(0.0)) { value ->
		this.computedShadowColor = Color.parse(value.string)
		this.fillPaint.setShadowLayer(this.measuredShadowBlur, this.measuredShadowOffsetX, this.measuredShadowOffsetY, this.computedShadowColor)
		this.strokePaint.setShadowLayer(this.measuredShadowBlur, this.measuredShadowOffsetX, this.measuredShadowOffsetY, this.computedShadowColor)
	}

	/**
	 * The canvas global alpha.
	 * @property globalAlpha
	 * @since 0.7.0
	 */
	open var globalAlpha: Property by Delegates.OnSet(Property(1.0)) { value ->
		val alpha = value.number.toInt() * 255
		this.fillPaint.alpha = alpha
		this.strokePaint.alpha = alpha
	}

	/**
	 * The canvas global alpha.
	 * @property globalAlpha
	 * @since 0.7.0
	 */
	open var globalCompositeOperation: Property by Delegates.OnSet(Property("source-over")) {
		// TODO
//		when (value.string) {
//			"source-over" ->
//			"source-in"   ->
//			"source-out"  ->
//			"source-atop" ->
//			"destination-over" ->
//			"destination-in"
//			"destination-out"
//			"destination-atop"
//			"lighter" ->
//			"darker"  ->
//			"copy"    ->
//		}
	}

	/**
	 * @since 0.7.0
	 * @hidden
	 * @hidden
	 */
	private var canvas: AndroidCanvas? = null

	/**
	 * @property fillPaint
	 * @since 0.7.0
	 * @hidden
	 */
	private var fillPaint: Paint = Paint()

	/**
	 * @property fillPaintStack
	 * @since 0.7.0
	 * @hidden
	 */
	private var fillPaintStack: MutableList<Paint> = mutableListOf()

	/**
	 * @property strokePaint
	 * @since 0.7.0
	 * @hidden
	 */
	private var strokePaint: Paint = Paint()

	/**
	 * @property strokePaintStack
	 * @since 0.7.0
	 * @hidden
	 */
	private var strokePaintStack: MutableList<Paint> = mutableListOf()

	/**
	 * @property clearPaint
	 * @since 0.7.0
	 * @hidden
	 */
	private var clearPaint: Paint = Paint()

	/**
	 * @property path
	 * @since 0.7.0
	 * @hidden
	 */
	private var path: Path = Path()

	/**
	 * @property pathMeasure
	 * @since 0.7.0
	 * @hidden
	 */
	private var pathMeasure: PathMeasure = PathMeasure()

	/**
	 * @property rectForArc
	 * @since 0.7.0
	 * @hidden
	 */
	private var rectForArc: RectF = RectF()

	/**
	 * @property rectForArcTo
	 * @since 0.7.0
	 * @hidden
	 */
	private var rectForArcTo: RectF = RectF()

	/**
	 * @property shadowColor
	 * @since 0.7.0
	 * @hidden
	 */
	private var computedShadowColor: Int = Color.BLACK

	/**
	 * @property measuredShadowBlur
	 * @since 0.7.0
	 * @hidden
	 */
	private var measuredShadowBlur: Float = 0f

	/**
	 * @property measuredShadowOffsetX
	 * @since 0.7.0
	 * @hidden
	 */
	private var measuredShadowOffsetX: Float = 0f

	/**
	 * @property measuredShadowOffsetY
	 * @since 0.7.0
	 * @hidden
	 */
	private var measuredShadowOffsetY: Float = 0f

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	init {
		this.fillPaint.style = Paint.Style.FILL
		this.strokePaint.style = Paint.Style.STROKE
		this.clearPaint.xfermode = PorterDuffXfermode(PorterDuff.Mode.CLEAR)
	}

	/**
	 * Assigns the context to be used.
	 * @method use
	 * @since 0.7.0
	 */
	open fun use(canvas: AndroidCanvas?) {
		this.canvas = canvas
	}

	/**
	 * @method closePathIfNeeded
	 * @since 0.7.0
	 * @hidden
	 */
	private fun closePathIfNeeded() {

		this.pathMeasure.setPath(this.path, false)

		if (this.pathMeasure.isClosed == false) {
			this.path.close()
		}
	}

	//--------------------------------------------------------------------------
	// JS Property
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_fillStyle
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_fillStyle(callback: JavaScriptGetterCallback) {
		callback.returns(this.fillStyle)
	}
	
	/**
	 * @method jsSet_fillStyle
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_fillStyle(callback: JavaScriptSetterCallback) {
		this.fillStyle = Property(callback.value)
	}
	
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_strokeStyle
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_strokeStyle(callback: JavaScriptGetterCallback) {
		callback.returns(this.strokeStyle)
	}
	
	/**
	 * @method jsSet_strokeStyle
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_strokeStyle(callback: JavaScriptSetterCallback) {
		this.strokeStyle = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_lineCap
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_lineCap(callback: JavaScriptGetterCallback) {
		callback.returns(this.lineCap)
	}
	
	/**
	 * @method jsSet_lineCap
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_lineCap(callback: JavaScriptSetterCallback) {
		this.lineCap = Property(callback.value)		
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_lineJoin
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_lineJoin(callback: JavaScriptGetterCallback) {
		callback.returns(this.lineJoin)
	}
	
	/**
	 * @method jsSet_lineJoin
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_lineJoin(callback: JavaScriptSetterCallback) {
		this.lineJoin = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_lineWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_lineWidth(callback: JavaScriptGetterCallback) {
		callback.returns(this.lineWidth)
	}
	
	/**
	 * @method jsSet_lineWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_lineWidth(callback: JavaScriptSetterCallback) {
		this.lineWidth = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shadowOffsetX
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_shadowOffsetX(callback: JavaScriptGetterCallback) {
		callback.returns(this.shadowOffsetX)
	}

	/**
	 * @method jsSet_shadowOffsetX
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_shadowOffsetX(callback: JavaScriptSetterCallback) {
		this.shadowOffsetX = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shadowOffGetY
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_shadowOffGetY(callback: JavaScriptGetterCallback) {
		callback.returns(this.shadowOffsetY)
	}

	/**
	 * @method jsSet_shadowOffsetY
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_shadowOffsetY(callback: JavaScriptSetterCallback) {
		this.shadowOffsetY = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shadowBlur
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_shadowBlur(callback: JavaScriptGetterCallback) {
		callback.returns(this.shadowBlur)
	}

	/**
	 * @method jsSet_shadowBlur
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_shadowBlur(callback: JavaScriptSetterCallback) {
		this.shadowBlur = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shadowColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_shadowColor(callback: JavaScriptGetterCallback) {
		callback.returns(this.shadowColor)
	}

	/**
	 * @method jsSet_shadowColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_shadowColor(callback: JavaScriptSetterCallback) {
		this.shadowColor = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_globalAlpha
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_globalAlpha(callback: JavaScriptGetterCallback) {
		callback.returns(this.globalAlpha)
	}

	/**
	 * @method jsSet_globalAlpha
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_globalAlpha(callback: JavaScriptSetterCallback) {
		this.globalAlpha = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_globalCompositeOperation
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_globalCompositeOperation(callback: JavaScriptGetterCallback) {
		callback.returns(this.globalCompositeOperation)
	}	
	
	/**
	 * @method jsSet_globalCompositeOperation
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_globalCompositeOperation(callback: JavaScriptSetterCallback) {
		this.globalCompositeOperation = Property(callback.value)
	}

	//--------------------------------------------------------------------------
	// JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_rect
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_rect(callback: JavaScriptFunctionCallback) {

		val x = Convert.toPx(callback.argument(0).number)
		val y = Convert.toPx(callback.argument(1).number)
		val w = Convert.toPx(callback.argument(2).number)
		val h = Convert.toPx(callback.argument(3).number)

		this.path.addRect(
			x,
			y,
			x + w,
			y + h,
			Path.Direction.CW
		)
	}

	/**
	 * @method jsFunction_fillRect
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_fillRect(callback: JavaScriptFunctionCallback) {

		val x = Convert.toPx(callback.argument(0).number)
		val y = Convert.toPx(callback.argument(1).number)
		val w = Convert.toPx(callback.argument(2).number)
		val h = Convert.toPx(callback.argument(3).number)

		this.canvas?.drawRect(
			x,
			y,
			x + w,
			y + h,
			this.fillPaint
		)
	}

	/**
	 * @method jsFunction_strokeRect
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_strokeRect(callback: JavaScriptFunctionCallback) {

		val x = Convert.toPx(callback.argument(0).number)
		val y = Convert.toPx(callback.argument(1).number)
		val w = Convert.toPx(callback.argument(2).number)
		val h = Convert.toPx(callback.argument(3).number)

		this.canvas?.drawRect(
			x,
			y,
			x + w,
			y + h,
			this.strokePaint
		)
	}

	/**
	 * @method jsFunction_clearRect
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_clearRect(callback: JavaScriptFunctionCallback) {

		val x = Convert.toPx(callback.argument(0).number)
		val y = Convert.toPx(callback.argument(1).number)
		val w = Convert.toPx(callback.argument(2).number)
		val h = Convert.toPx(callback.argument(3).number)

		this.canvas?.drawRect(
			x,
			y,
			x + w,
			y + h,
			this.clearPaint
		)
	}

	/**
	 * @method jsFunction_fill
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_fill(callback: JavaScriptFunctionCallback) {
		this.closePathIfNeeded()
		this.canvas?.drawPath(this.path, this.fillPaint)
	}

	/**
	 * @method jsFunction_stroke
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_stroke(callback: JavaScriptFunctionCallback) {
		this.closePathIfNeeded()
		this.canvas?.drawPath(this.path, this.strokePaint)
	}

	/**
	 * @method jsFunction_beginPath
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_beginPath(callback: JavaScriptFunctionCallback) {
		this.path.reset()
	}

	/**
	 * @method jsFunction_closePath
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_closePath(callback: JavaScriptFunctionCallback) {
		this.path.close()
	}

	/**
	 * @method jsFunction_moveTo
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_moveTo(callback: JavaScriptFunctionCallback) {
		val x = Convert.toPx(callback.argument(0).number)
		val y = Convert.toPx(callback.argument(1).number)
		this.path.moveTo(x, y)
	}

	/**
	 * @method jsFunction_lineTo
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_lineTo(callback: JavaScriptFunctionCallback) {
		val x = Convert.toPx(callback.argument(0).number)
		val y = Convert.toPx(callback.argument(1).number)
		this.path.lineTo(x, y)
	}

	/**
	 * @method jsFunction_clip
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_clip(callback: JavaScriptFunctionCallback) {
		this.canvas?.clipPath(this.path)
	}

	/**
	 * @method jsFunction_quadraticCurveTo
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_quadraticCurveTo(callback: JavaScriptFunctionCallback) {
		val cx = Convert.toPx(callback.argument(0).number)
		val cy = Convert.toPx(callback.argument(1).number)
		val x = Convert.toPx(callback.argument(2).number)
		val y = Convert.toPx(callback.argument(3).number)
		this.path.quadTo(cx, cy, x, y)
	}

	/**
	 * @method jsFunction_bezierCurveTo
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_bezierCurveTo(callback: JavaScriptFunctionCallback) {
		val c1x = Convert.toPx(callback.argument(0).number)
		val c1y = Convert.toPx(callback.argument(1).number)
		val c2x = Convert.toPx(callback.argument(2).number)
		val c2y = Convert.toPx(callback.argument(3).number)
		val x = Convert.toPx(callback.argument(4).number)
		val y = Convert.toPx(callback.argument(5).number)
		this.path.cubicTo(c1x, c1y, c2x, c2y, x, y)
	}

	/**
	 * @method jsFunction_arc
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_arc(callback: JavaScriptFunctionCallback) {

		val x = Convert.toPx(callback.argument(0).number)
		val y = Convert.toPx(callback.argument(1).number)
		val r = Convert.toPx(callback.argument(2).number)

		val sa = Math.toDegrees(callback.argument(3).number).toFloat()
		val ea = Math.toDegrees(callback.argument(4).number).toFloat()
		var sweep: Float

		var ccw = false

		if (callback.arguments >= 6) {
			ccw = callback.argument(5).boolean
		}

		val x1 = x - r
		val y1 = y - r
		val x2 = x + r
		val y2 = y + r

		this.rectForArc.set(x1, y1, x2, y2)

		sweep = if (ccw == false) ea - sa else sa - ea

		if (sweep >= 360) {
			sweep = 360f
		} else {

			if (sweep < 0) {
				sweep = sweep + 360
			}

			if (ccw) {
				sweep = -sweep
			}
		}

		this.path.addArc(this.rectForArc, sa, sweep)

		if (sweep == 360f) {
			this.path.moveTo(
				x + r * Math.cos(sa.toDouble()).toFloat(),
				y + r * Math.sin(sa.toDouble()).toFloat()
			)
		}
	}

	/**
	 * @method jsFunction_arcTo
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_arcTo(callback: JavaScriptFunctionCallback) {

		val x1 = Convert.toPx(callback.argument(0).number)
		val y1 = Convert.toPx(callback.argument(1).number)
		val x2 = Convert.toPx(callback.argument(2).number)
		val y2 = Convert.toPx(callback.argument(3).number)
		val r = callback.argument(4).number.toFloat()
		this.path.addArcTo(PointF(x1, y1), PointF(x2, y2), r)
	}

	/**
	 * @method jsFunction_isPointInPath
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_isPointInPath(callback: JavaScriptFunctionCallback) {
		// TODO
	}

	/**
	 * @method jsFunction_scale
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_scale(callback: JavaScriptFunctionCallback) {
		val x = Convert.toPx(callback.argument(0).number)
		val y = Convert.toPx(callback.argument(1).number)
		this.canvas?.scale(x, y)
	}

	/**
	 * @method jsFunction_rotate
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_rotate(callback: JavaScriptFunctionCallback) {
		this.canvas?.rotate(Math.toDegrees(callback.argument(0).number).toFloat())
	}

	/**
	 * @method jsFunction_translate
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_translate(callback: JavaScriptFunctionCallback) {
		val x = Convert.toPx(callback.argument(0).number)
		val y = Convert.toPx(callback.argument(1).number)
		this.canvas?.translate(x, y)
	}

	/**
	 * @method jsFunction_transform
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_transform(callback: JavaScriptFunctionCallback) {

		val a = callback.argument(0).number.toFloat()
		val b = callback.argument(1).number.toFloat()
		val c = callback.argument(2).number.toFloat()
		val d = callback.argument(3).number.toFloat()
		val e = Convert.toPx(callback.argument(4).number)
		val f = Convert.toPx(callback.argument(5).number)

		val values = FloatArray(6)
		values[Matrix.MSCALE_X] = a
		values[Matrix.MSCALE_Y] = d
		values[Matrix.MSKEW_X] = b
		values[Matrix.MSKEW_Y] = c
		values[Matrix.MTRANS_X] = e
		values[Matrix.MTRANS_Y] = f

		val matrix = Matrix()
		matrix.setValues(values)
		this.canvas?.concat(matrix)
	}

	/**
	 * @method jsFunction_setTransform
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_setTransform(callback: JavaScriptFunctionCallback) {

		val a = callback.argument(0).number.toFloat()
		val b = callback.argument(1).number.toFloat()
		val c = callback.argument(2).number.toFloat()
		val d = callback.argument(3).number.toFloat()
		val e = Convert.toPx(callback.argument(4).number)
		val f = Convert.toPx(callback.argument(5).number)

		val m1 = Matrix()
		val m2 = Matrix()

		m1.setValues(floatArrayOf(0f, 0f, 0f, 0f, 0f, 0f))
		m2.setValues(floatArrayOf(1f, 0f, 0f, 1f, 0f, 0f))

		this.canvas?.concat(m1)
		this.canvas?.concat(m2)

		val values = FloatArray(6)
		values[Matrix.MSCALE_X] = a
		values[Matrix.MSCALE_Y] = d
		values[Matrix.MSKEW_X] = b
		values[Matrix.MSKEW_Y] = c
		values[Matrix.MTRANS_X] = e
		values[Matrix.MTRANS_Y] = f

		val matrix = Matrix()
		matrix.setValues(values)
		this.canvas?.concat(matrix)
	}

	/**
	 * @method jsFunction_drawImage
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_drawImage(callback: JavaScriptFunctionCallback) {
		// TODO
	}

	/**
	 * @method jsFunction_save
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_save(callback: JavaScriptFunctionCallback) {
		this.canvas?.save()
		this.fillPaintStack.add(Paint(this.fillPaint))
		this.strokePaintStack.add(Paint(this.strokePaint))
	}

	/**
	 * @method jsFunction_restore
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_restore(callback: JavaScriptFunctionCallback) {
		this.canvas?.restore()
		this.fillPaint = this.fillPaintStack.last()
		this.strokePaint = this.strokePaintStack.last()
		this.fillPaintStack.pop()
		this.strokePaintStack.pop()
	}
}