package ca.logaritm.dezel.view

import android.animation.ObjectAnimator
import android.animation.ValueAnimator
import android.content.Context
import android.graphics.*
import android.view.MotionEvent
import android.view.View
import android.view.ViewGroup
import ca.logaritm.dezel.extension.Delegates
import ca.logaritm.dezel.extension.graphics.addInnerRoundedRect
import ca.logaritm.dezel.extension.graphics.addOuterRoundedRect
import ca.logaritm.dezel.extension.view.setMeasuredFrame
import ca.logaritm.dezel.modules.view.JavaScriptView
import ca.logaritm.dezel.view.animation.animator.TransformAnimator
import ca.logaritm.dezel.view.animation.Animatable
import ca.logaritm.dezel.view.drawable.BackgroundImageDrawable
import ca.logaritm.dezel.view.drawable.BorderDrawable
import ca.logaritm.dezel.view.drawable.BackgroundColorDrawable
import ca.logaritm.dezel.view.drawable.ShadowDrawable
import ca.logaritm.dezel.view.graphic.Color
import ca.logaritm.dezel.view.graphic.LinearGradient
import ca.logaritm.dezel.view.graphic.RadialGradient
import ca.logaritm.dezel.view.graphic.Transform
import ca.logaritm.dezel.view.trait.Clippable
import ca.logaritm.dezel.view.trait.Resizable
import ca.logaritm.dezel.view.type.ImageFit
import ca.logaritm.dezel.view.type.ImagePosition
import kotlin.math.abs
import kotlin.math.ceil
import kotlin.math.max
import kotlin.math.min

/**
 * @class WrapperView
 * @super ViewGroup
 * @since 0.1.0
 */
open class WrapperView(context: Context, content: View, manager: JavaScriptView) : ViewGroup(context), Animatable {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property manager
	 * @since 0.5.0
	 */
	public var manager: JavaScriptView

	/**
	 * @property content
	 * @since 0.2.0
	 */
	public val content: View

	/**
	 * @property id
	 * @since 0.2.0
	 */
	open var id: String = ""

	/**
	 * @property frame
	 * @since 0.1.0
	 */
	open var frame: RectF by Delegates.OnSet(RectF(0f, 0f, 0f, 0f)) {
		this.invalidate()
		this.invalidateFrame()
		this.invalidateShape()
	}

	/**
	 * @property backgroundColor
	 * @since 0.1.0
	 */
	open var backgroundColor: Int? by Delegates.OnSetOptional<Int>(null) { value ->
		this.backgroundColorDrawable.color = value
		this.invalidate()
	}

	/**
	 * @property backgroundLinearGradient
	 * @since 0.1.0
	 */
	open var backgroundLinearGradient: LinearGradient? by Delegates.OnSetOptional<LinearGradient>(null) { value ->
		this.backgroundColorDrawable.linearGradient = value
		this.invalidate()
	}

	/**
	 * @property backgroundRadialGradient
	 * @since 0.1.0
	 */
	open var backgroundRadialGradient: RadialGradient? by Delegates.OnSetOptional<RadialGradient>(null) { value ->
		this.backgroundColorDrawable.radialGradient = value
		this.invalidate()
	}

	/**
	 * @property backgroundImage
	 * @since 0.1.0
	 */
	open var backgroundImage: Bitmap? by Delegates.OnSetOptional<Bitmap>(null) { value ->
		this.backgroundImageDrawable.image = value
		this.invalidate()
	}

	/**
	 * @property backgroundImageFit
	 * @since 0.7.0
	 */
	open var backgroundImageFit: ImageFit by Delegates.OnSet(ImageFit.COVER) { value ->
		this.backgroundImageDrawable.imageFit = value
		this.invalidate()
	}

	/**
	 * @property backgroundImagePosition
	 * @since 0.7.0
	 */
	open var backgroundImagePosition: ImagePosition by Delegates.OnSet(ImagePosition.MIDDLE_CENTER) { value ->
		this.backgroundImageDrawable.imagePosition = value
		this.invalidate()
	}

	/**
	 * @property borderTopColor
	 * @since 0.1.0
	 */
	open var borderTopColor: Int by Delegates.OnSet(Color.BLACK) { value ->
		this.borderDrawable.borderTopColor = value
		this.invalidate()
	}

	/**
	 * @property borderLeftColor
	 * @since 0.1.0
	 */
	open var borderLeftColor: Int by Delegates.OnSet(Color.BLACK) { value ->
		this.borderDrawable.borderLeftColor = value
		this.invalidate()
	}

	/**
	 * @property borderRightColor
	 * @since 0.1.0
	 */
	open var borderRightColor: Int by Delegates.OnSet(Color.BLACK) { value ->
		this.borderDrawable.borderRightColor = value
		this.invalidate()
	}

	/**
	 * @property borderBottomColor
	 * @since 0.1.0
	 */
	open var borderBottomColor: Int by Delegates.OnSet(Color.BLACK) { value ->
		this.borderDrawable.borderBottomColor = value
		this.invalidate()
	}

	/**
	 * @property borderTopWidth
	 * @since 0.1.0
	 */
	open var borderTopWidth: Float by Delegates.OnSet(0f) { value ->
		this.borderDrawable.borderTopWidth = value
		this.invalidateShape()
		this.invalidateFrame()
	}

	/**
	 * @property borderLeftWidth
	 * @since 0.1.0
	 */
	open var borderLeftWidth: Float by Delegates.OnSet(0f) { value ->
		this.borderDrawable.borderLeftWidth = value
		this.invalidateShape()
		this.invalidateFrame()
	}

	/**
	 * @property borderRightWidth
	 * @since 0.1.0
	 */
	open var borderRightWidth: Float by Delegates.OnSet(0f) { value ->
		this.borderDrawable.borderRightWidth = value
		this.invalidateShape()
		this.invalidateFrame()
	}

	/**
	 * @property borderBottomWidth
	 * @since 0.1.0
	 */
	open var borderBottomWidth: Float by Delegates.OnSet(0f) { value ->
		this.borderDrawable.borderBottomWidth = value
		this.invalidateShape()
		this.invalidateFrame()
	}

	/**
	 * @property borderTopLeftRadius
	 * @since 0.1.0
	 */
	open var borderTopLeftRadius: Float by Delegates.OnSet(0f) {
		this.invalidateShape()
	}

	/**
	 * @property borderTopRightRadius
	 * @since 0.1.0
	 */
	open var borderTopRightRadius: Float by Delegates.OnSet(0f) {
		this.invalidateShape()
	}

	/**
	 * @property borderBottomLeftRadius
	 * @since 0.1.0
	 */
	open var borderBottomLeftRadius: Float by Delegates.OnSet(0f) {
		this.invalidateShape()
	}

	/**
	 * @property borderBottomRightRadius
	 * @since 0.1.0
	 */
	open var borderBottomRightRadius: Float by Delegates.OnSet(0f) {
		this.invalidateShape()
	}

	/**
	 * @property shadowBlur
	 * @since 0.1.0
	 */
	open var shadowBlur: Float by Delegates.OnSet(0f) { value ->
		this.shadowDrawable.shadowBlur = value
		this.invalidate()
	}

	/**
	 * @property shadowColor
	 * @since 0.1.0
	 */
	open var shadowColor: Int by Delegates.OnSet(Color.BLACK) { value ->
		this.shadowDrawable.shadowColor = value
		this.invalidate()
	}

	/**
	 * @property shadowOffsetTop
	 * @since 0.1.0
	 */
	open var shadowOffsetTop: Float by Delegates.OnSet(0f) { value ->
		this.shadowDrawable.shadowOffsetTop = value
		this.invalidate()
	}

	/**
	 * @property shadowOffsetLeft
	 * @since 0.1.0
	 */
	open var shadowOffsetLeft: Float by Delegates.OnSet(0f) { value ->
		this.shadowDrawable.shadowOffsetLeft = value
		this.invalidate()
	}

	/**
	 * @property transform
	 * @since 0.1.0
	 */
	open var transform: Transform by Delegates.OnSet(Transform()) { value ->
		this.translationX = value.translationX
		this.translationY = value.translationY
		this.translationZ = value.translationZ
		this.rotationX = value.rotationX * 180f / Math.PI.toFloat()
		this.rotationY = value.rotationY * 180f / Math.PI.toFloat()
		this.rotation = value.rotationZ * 180f / Math.PI.toFloat()
		this.scaleX = value.scaleX
		this.scaleY = value.scaleY
	}

	/**
	 * @property clipped
	 * @since 0.1.0
	 */
	open var clipped: Boolean by Delegates.OnSet(true) {
		this.invalidate()
	}

	/**
	 * @property drawable
	 * @since 0.4.0
	 */
	open var drawable: Boolean by Delegates.OnSet(false) {
		this.shouldRedraw()
	}

	/**
	 * @property draw
	 * @since 0.4.0
	 */
	open var draw: ((Canvas) -> Unit)? = null

	/**
	 * @property touchable
	 * @since 0.1.0
	 */
	open var touchable: Boolean = true

	/**
	 * @property hasDepth
	 * @since 0.1.0
	 * @hidden
	 */
	private val hasDepth: Boolean
		get() = this.translationZ != 0f || this.rotationX != 0f || this.rotationY != 0f

	/**
	 * @property hasShape
	 * @since 0.1.0
	 * @hidden
	 */
	private val hasShape: Boolean
		get() = this.borderTopLeftRadius > 0f || this.borderTopRightRadius > 0f || this.borderBottomLeftRadius > 0f || this.borderBottomRightRadius > 0f

	/**
	 * @property backgroundColorDrawable
	 * @since 0.7.0
	 * @hidden
	 */
	private var backgroundColorDrawable: BackgroundColorDrawable

	/**
	 * @property backgroundImageDrawable
	 * @since 0.1.0
	 * @hidden
	 */
	private var backgroundImageDrawable: BackgroundImageDrawable

	/**
	 * @property borderDrawable
	 * @since 0.1.0
	 * @hidden
	 */
	private var borderDrawable: BorderDrawable

	/**
	 * @property shadowDrawable
	 * @since 0.1.0
	 * @hidden
	 */
	private var shadowDrawable: ShadowDrawable

	/**
	 * @property hardwareLayerPaint
	 * @since 0.1.0
	 * @hidden
	 */
	private var hardwareLayerPaint: Paint = Paint(Paint.ANTI_ALIAS_FLAG)

	/**
	 * @property hardwareLayerShapePath
	 * @since 0.1.0
	 * @hidden
	 */
	private var hardwareLayerShapePath: Path = Path()

	/**
	 * @property hardwareLayerShapePaint
	 * @since 0.1.0
	 * @hidden
	 */
	private var hardwareLayerShapePaint: Paint = Paint(Paint.ANTI_ALIAS_FLAG)

	/**
	 * @property invalidFrame
	 * @since 0.2.0
	 * @hidden
	 */
	private var invalidFrame: Boolean = false

	/**
	 * @property invalidShape
	 * @since 0.2.0
	 * @hidden
	 */
	private var invalidShape: Boolean = false

	/**
	 * @property innerShapePath
	 * @since 0.1.0
	 * @hidden
	 */
	private var innerShapePath: Path = Path()

	/**
	 * @property innerShapeMatrix
	 * @since 0.1.0
	 * @hidden
	 */
	private var innerShapeMatrix: Matrix = Matrix()

	/**
	 * @property innerShapePaint
	 * @since 0.1.0
	 * @hidden
	 */
	private var innerShapePaint: Paint = Paint()

	/**
	 * @property initialized
	 * @since 0.5.0
	 * @hidden
	 */
	private var initialized: Boolean = false

	/**
	 * @property srcInMode
	 * @since 0.7.0
	 * @hidden
	 */
	private val srcInMode: PorterDuffXfermode = PorterDuffXfermode(PorterDuff.Mode.SRC_IN)

	/**
	 * @property dstOverMode
	 * @since 0.7.0
	 * @hidden
	 */
	private val dstOverMode: PorterDuffXfermode = PorterDuffXfermode(PorterDuff.Mode.DST_OVER)

	/**
	 * @property clearMode
	 * @since 0.7.0
	 * @hidden
	 */
	private val clearMode: PorterDuffXfermode = PorterDuffXfermode(PorterDuff.Mode.CLEAR)

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @hidden
	 */
	init {

		this.content = content
		this.manager = manager

		this.setWillNotDraw(true)

		this.clipChildren = false
		this.clipToPadding = false
		this.backgroundColorDrawable = BackgroundColorDrawable()
		this.backgroundImageDrawable = BackgroundImageDrawable()
		this.borderDrawable = BorderDrawable()
		this.shadowDrawable = ShadowDrawable()

		this.hardwareLayerShapePaint.color = Color.BLACK

		this.addView(content)

		this.initialized = true
	}

	/**
	 * @method requestLayout
	 * @since 0.5.0
	 */
	override fun requestLayout() {

		super.requestLayout()

		/*
		 * The layout might be requested from a content view. In this case we must schedule
		 * our own layout pass for this view
		 */

		if (this.initialized) {
			this.manager.scheduleLayout()
		}
	}

	/**
	 * @method onMeasure
	 * @since 0.2.0
	 */
	override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {

		/*
		 * The frame is used here instead of the parameters because in some
		 * cases such as the window the given width and height will represent
		 * the size given by the activity view and not the size computed by
		 * our own layout engine.
		 */

		this.setMeasuredDimension(
			MeasureSpec.getSize(this.frame.width().toInt()),
			MeasureSpec.getSize(this.frame.height().toInt())
		)
	}

	/**
	 * @method onLayout
	 * @since 0.1.0
	 */
	override fun onLayout(changed: Boolean, l: Int, t: Int, r: Int, b: Int) {

	}

	/**
	 * @method update
	 * @since 0.1.0
	 */
	open fun update() {

		if (this.invalidFrame) {
			this.invalidFrame = false
			this.updateFrame()
		}

		val draw = this.shouldRedraw()

		val hardware = this.hasDepth || this.hasShape
		if (hardware && draw) {
			this.setLayerType(View.LAYER_TYPE_HARDWARE, this.hardwareLayerPaint)
		} else {
			this.setLayerType(View.LAYER_TYPE_NONE, null)
		}
	}

	/**
	 * @method updateFrame
	 * @since 0.2.0
	 */
	open fun updateFrame() {

		val viewT = this.frame.top.toInt()
		val viewL = this.frame.left.toInt()
		val viewW = this.frame.width().toInt()
		val viewH = this.frame.height().toInt()

		val borderWidthT = this.borderTopWidth.toInt()
		val borderWidthL = this.borderLeftWidth.toInt()
		val borderWidthR = this.borderRightWidth.toInt()
		val borderWidthB = this.borderBottomWidth.toInt()

		val shadowBlur = this.shadowBlur.toInt()
		val shadowOffsetL = this.shadowOffsetLeft.toInt()
		val shadowOffsetT = this.shadowOffsetTop.toInt()

		/*
		 * Android does not simply support shadow so it must be drawn inside this view. This is
		 * why we add the shadow to the view viewport.
		 */

		val contentShadowOffsetT = max(shadowBlur - shadowOffsetT, 0)
		val contentShadowOffsetL = max(shadowBlur - shadowOffsetL, 0)

		val adjustedViewW = viewW + (shadowBlur * 2 + abs(shadowOffsetL))
		val adjustedViewH = viewH + (shadowBlur * 2 + abs(shadowOffsetT))
		val adjustedViewT = viewT - contentShadowOffsetT
		val adjustedViewL = viewL - contentShadowOffsetL

		this.setMeasuredFrame(
			adjustedViewT,
			adjustedViewL,
			adjustedViewW,
			adjustedViewH
		)

		val contentT = contentShadowOffsetT + borderWidthT
		val contentL = contentShadowOffsetL + borderWidthL
		val contentW = viewW - borderWidthL - borderWidthR
		val contentH = viewH - borderWidthT - borderWidthB

		val content = this.content

		content.setMeasuredFrame(
			contentT,
			contentL,
			contentW,
			contentH
		)

		if (content is Resizable) {
			content.onResize(
				contentT,
				contentL,
				contentW,
				contentH
			)
		}
	}

	/**
	 * @method updateShape
	 * @since 0.2.0
	 */
	open fun updateShape() {

		val borderWidthT = this.borderTopWidth
		val borderWidthL = this.borderLeftWidth
		val borderWidthR = this.borderRightWidth
		val borderWidthB = this.borderBottomWidth

		val shapeW = this.frame.width()
		val shapeH = this.frame.height()

		val maxRadius = min(shapeW, shapeH) / 2f

		var outerTL = this.borderTopLeftRadius
		var outerTR = this.borderTopRightRadius
		var outerBL = this.borderBottomLeftRadius
		var outerBR = this.borderBottomRightRadius

		if (outerTL > maxRadius) outerTL = maxRadius
		if (outerTR > maxRadius) outerTR = maxRadius
		if (outerBL > maxRadius) outerBL = maxRadius
		if (outerBR > maxRadius) outerBR = maxRadius

		var innerRadiusTLY = max(outerTL - borderWidthT, 0f)
		var innerRadiusTLX = max(outerTL - borderWidthL, 0f)
		var innerRadiusTRY = max(outerTR - borderWidthT, 0f)
		var innerRadiusTRX = max(outerTR - borderWidthR, 0f)
		var innerRadiusBLY = max(outerBL - borderWidthB, 0f)
		var innerRadiusBLX = max(outerBL - borderWidthL, 0f)
		var innerRadiusBRY = max(outerBR - borderWidthB, 0f)
		var innerRadiusBRX = max(outerBR - borderWidthR, 0f)

		if (innerRadiusTLY == 0f || innerRadiusTLX == 0f) {
			innerRadiusTLY = 0f
			innerRadiusTLX = 0f
		}

		if (innerRadiusTRY == 0f || innerRadiusTRX == 0f) {
			innerRadiusTRY = 0f
			innerRadiusTRX = 0f
		}

		if (innerRadiusBLY == 0f || innerRadiusBLX == 0f) {
			innerRadiusBLY = 0f
			innerRadiusBLX = 0f
		}

		if (innerRadiusBRY == 0f || innerRadiusBRX == 0f) {
			innerRadiusBRY = 0f
			innerRadiusBRX = 0f
		}

		var innerTLX = 0f
		var innerTLY = 0f
		var innerTRX = 0f
		var innerTRY = 0f
		var innerBRX = 0f
		var innerBRY = 0f
		var innerBLX = 0f
		var innerBLY = 0f

		if (borderWidthT == 0f) {
			innerTRX = innerRadiusTRX
			innerTLX = innerRadiusTLX
		}

		if (borderWidthL == 0f) {
			innerTLY = innerRadiusTLY
			innerBLY = innerRadiusBLY
		}

		if (borderWidthR == 0f) {
			innerTRY = innerRadiusTRY
			innerBRY = innerRadiusBRY
		}

		if (borderWidthB == 0f) {
			innerBRX = innerRadiusBRX
			innerBLX = innerRadiusBLX
		}

		if (borderWidthT > 0 && borderWidthL > 0) {
			if (borderWidthT > borderWidthL) {
				innerTLX = innerRadiusTLY * (borderWidthL / borderWidthT)
				innerTLY = innerRadiusTLY
			} else {
				innerTLX = innerRadiusTLX
				innerTLY = innerRadiusTLX * (borderWidthT / borderWidthL)
			}
		}

		if (borderWidthT > 0 && borderWidthR > 0) {
			if (borderWidthT > borderWidthR) {
				innerTRX = innerRadiusTRY * (borderWidthR / borderWidthT)
				innerTRY = innerRadiusTRY
			} else {
				innerTRX = innerRadiusTRX
				innerTRY = innerRadiusTRX * (borderWidthT / borderWidthR)
			}
		}

		if (borderWidthB > 0 && borderWidthR > 0) {
			if (borderWidthB > borderWidthR) {
				innerBRX = innerRadiusBRY * (borderWidthR / borderWidthB)
				innerBRY = innerRadiusBRY
			} else {
				innerBRX = innerRadiusBRX
				innerBRY = innerRadiusBRX * (borderWidthB / borderWidthR)
			}
		}

		if (borderWidthB > 0 && borderWidthL > 0) {
			if (borderWidthB > borderWidthL) {
				innerBLX = innerRadiusBLY * (borderWidthL / borderWidthB)
				innerBLY = innerRadiusBLY
			} else {
				innerBLX = innerRadiusBLX
				innerBLY = innerRadiusBLX * (borderWidthB / borderWidthL)
			}
		}

		this.shadowDrawable.borderTopLeftRadius = outerTL
		this.shadowDrawable.borderTopRightRadius = outerTR
		this.shadowDrawable.borderBottomLeftRadius = outerBL
		this.shadowDrawable.borderBottomRightRadius = outerBR

		this.borderDrawable.borderTopLeftRadius = outerTL
		this.borderDrawable.borderTopRightRadius = outerTR
		this.borderDrawable.borderBottomLeftRadius = outerBL
		this.borderDrawable.borderBottomRightRadius = outerBR

		this.borderDrawable.borderTopLeftInnerRadius = PointF(innerTLX, innerTLY)
		this.borderDrawable.borderTopRightInnerRadius = PointF(innerTRX, innerTRY)
		this.borderDrawable.borderBottomLeftInnerRadius = PointF(innerBLX, innerBLY)
		this.borderDrawable.borderBottomRightInnerRadius = PointF(innerBRX, innerBRY)
	}

	/**
	 * @method shouldRedraw
	 * @since 0.4.0
	 */
	open fun shouldRedraw(): Boolean {

		var draw = false
		if (draw == false) draw = this.hasBackgroundColor()
		if (draw == false) draw = this.hasBackgroundImage()
		if (draw == false) draw = this.hasShadow()
		if (draw == false) draw = this.hasBorder()
		if (draw == false) draw = this.drawable

		this.setWillNotDraw(!draw)

		if (draw) {
			this.invalidate()
		}

		return draw
	}

	/**
	 * @method scheduleRedraw
	 * @since 0.4.0
	 */
	open fun scheduleRedraw() {
		this.invalidate()
	}

	//----------------------------------------------------------------------
	// Focus
	//----------------------------------------------------------------------

	/**
	 * @method clearFocus
	 * @since 0.6.0
	 */
	override fun clearFocus() {

		/*
		 * This is empty voluntarily. Clear focus will be called when this
		 * view's frame changes and it will clear the content view's
		 * focus. Conside the following case, upon pressing on a text input
		 * we change the form size using an animation. This will automaticaly
		 * clear the focus from the text input. Hopefully there will be no
		 * side effect of this.
		 */

	}

	//----------------------------------------------------------------------
	// Touch
	//----------------------------------------------------------------------

	/**
	 * @method onInterceptTouchEvent
	 * @since 0.1.0
	 */
	override fun onInterceptTouchEvent(event: MotionEvent): Boolean {
		return if (this.touchable) super.onInterceptTouchEvent(event) else true
	}

	//----------------------------------------------------------------------
	// Drawing
	//----------------------------------------------------------------------

	/**
	 * @method drawCanvasIfNeeded
	 * @since 0.4.0
	 */
	open fun drawCanvasIfNeeded(canvas: Canvas, x: Int, y: Int, w: Int, h: Int) {

		if (this.drawable == false) {
			return
		}

		val c = canvas.saveLayer(
			x.toFloat(),
			y.toFloat(),
			x.toFloat() + w.toFloat(),
			y.toFloat() + h.toFloat(),
			null
		)

		this.draw?.invoke(canvas)

		canvas.restoreToCount(c)
	}

	/**
	 * @method dispatchDraw
	 * @since 0.1.0
	 */
	override fun dispatchDraw(canvas: Canvas) {

		if (this.invalidShape) {
			this.invalidShape = false
			this.updateShape()
		}

		val clipped = this.clipped || this.content is Clippable

		if (clipped) {

			canvas.save()

			val viewW = this.width
			val viewH = this.height

			val shadowBlur = ceil(this.shadowBlur)
			val shadowOffsetL = this.shadowOffsetLeft
			val shadowOffsetT = this.shadowOffsetTop

			val borderWidthT = this.borderTopWidth
			val borderWidthL = this.borderLeftWidth
			val borderWidthR = this.borderRightWidth
			val borderWidthB = this.borderBottomWidth

			val adjustedX = max(shadowBlur - shadowOffsetL, 0f).toInt()
			val adjustedY = max(shadowBlur - shadowOffsetT, 0f).toInt()
			val adjustedW = viewW - (shadowBlur * 2 + abs(shadowOffsetL)).toInt()
			val adjustedH = viewH - (shadowBlur * 2 + abs(shadowOffsetT)).toInt()

			val innerL = adjustedX + borderWidthL
			val innerT = adjustedY + borderWidthT
			val innerW = adjustedW - borderWidthL - borderWidthR
			val innerH = adjustedH - borderWidthT - borderWidthB

			var clipRect = true

			if (this.content is Clippable) {

				val innerTL = this.borderDrawable.borderTopLeftInnerRadius
				val innerTR = this.borderDrawable.borderTopRightInnerRadius
				val innerBL = this.borderDrawable.borderBottomLeftInnerRadius
				val innerBR = this.borderDrawable.borderBottomRightInnerRadius

				if (innerTL.equals(0f, 0f) == false ||
					innerTR.equals(0f, 0f) == false ||
					innerBL.equals(0f, 0f) == false ||
					innerBR.equals(0f, 0f) == false) {

					clipRect = false

					this.innerShapePath.reset()
					this.innerShapePath.addInnerRoundedRect(
						innerW,
						innerH,
						innerTL,
						innerTR,
						innerBL,
						innerBR,
						0f, 0f,
						0f, 0f
					)

					this.innerShapeMatrix.reset()
					this.innerShapeMatrix.postTranslate(innerL, innerT)
					this.innerShapePath.transform(this.innerShapeMatrix)

					canvas.clipPath(this.innerShapePath)
				}
			}

			if (clipRect) {

				canvas.clipRect(
					innerL,
					innerT,
					innerL + innerW,
					innerT + innerH
				)

			}
		}

		super.dispatchDraw(canvas)

		if (clipped) {
			canvas.restore()
		}
	}

	/**
	 * @method onDraw
	 * @since 0.1.0
	 */
	override fun onDraw(canvas: Canvas) {

		if (this.invalidShape) {
			this.invalidShape = false
			this.updateShape()
		}

		val viewW = this.width
		val viewH = this.height

		val shadowBlur = ceil(this.shadowBlur)
		val shadowOffsetL = this.shadowOffsetLeft
		val shadowOffsetT = this.shadowOffsetTop

		val adjustedX = max(shadowBlur - shadowOffsetL, 0f).toInt()
		val adjustedY = max(shadowBlur - shadowOffsetT, 0f).toInt()
		val adjustedW = viewW - (shadowBlur * 2 + abs(shadowOffsetL)).toInt()
		val adjustedH = viewH - (shadowBlur * 2 + abs(shadowOffsetT)).toInt()

		val backgroundColor = this.needsBackgroundColor()
		val backgroundImage = this.needsBackgroundImage()
		val border = this.needsBorderDrawable()
		val shadow = this.needsShadowDrawable()

		val rounded = this.hasShape
		if (rounded) {

			this.hardwareLayerShapePath.reset()
			this.hardwareLayerShapePath.addOuterRoundedRect(
				adjustedW.toFloat(),
				adjustedH.toFloat(),
				this.borderTopLeftRadius,
				this.borderTopRightRadius,
				this.borderBottomLeftRadius,
				this.borderBottomRightRadius
			)

			canvas.save()
			canvas.translate(
				adjustedX.toFloat(),
				adjustedY.toFloat()
			)

			canvas.drawPath(
				this.hardwareLayerShapePath,
				this.hardwareLayerShapePaint
			)

			if (backgroundColor) {
				this.backgroundColorDrawable.setBounds(0, 0, adjustedW, adjustedH)
				this.backgroundColorDrawable.draw(canvas, this.srcInMode)
			}

			if (backgroundImage) {
				this.backgroundImageDrawable.setBounds(0, 0, adjustedW, adjustedH)
				this.backgroundImageDrawable.draw(canvas, this.srcInMode)
			}

			if (border) {
				this.borderDrawable.setBounds(0, 0, adjustedW, adjustedH)
				this.borderDrawable.draw(canvas)
			}

			this.drawCanvasIfNeeded(canvas, 0, 0, adjustedW, adjustedH)

			canvas.restore()

			if (shadow) {
				this.shadowDrawable.setBounds(0, 0, adjustedW, adjustedH)
				this.shadowDrawable.draw(canvas, this.dstOverMode)
			}

			if (backgroundImage == false) {

				val innerL = adjustedX + this.borderLeftWidth
				val innerT = adjustedY + this.borderTopWidth
				val innerW = adjustedW - this.borderLeftWidth - this.borderRightWidth
				val innerH = adjustedH - this.borderTopWidth - this.borderBottomWidth

				val innerTL = this.borderDrawable.borderTopLeftInnerRadius
				val innerTR = this.borderDrawable.borderTopRightInnerRadius
				val innerBL = this.borderDrawable.borderBottomLeftInnerRadius
				val innerBR = this.borderDrawable.borderBottomRightInnerRadius

				this.innerShapePath.reset()
				this.innerShapePath.addInnerRoundedRect(
					innerW,
					innerH,
					innerTL,
					innerTR,
					innerBL,
					innerBR,
					0f, 0f,
					0f, 0f
				)

				this.innerShapeMatrix.reset()
				this.innerShapeMatrix.postTranslate(innerL, innerT)
				this.innerShapePath.transform(this.innerShapeMatrix)

				this.innerShapePaint.xfermode = this.clearMode

				canvas.drawPath(
					this.innerShapePath,
					this.innerShapePaint
				)
			}

		} else {

			if (shadow) {
				this.shadowDrawable.setBounds(0, 0, adjustedW, adjustedH)
				this.shadowDrawable.draw(canvas)
			}

			canvas.save()
			canvas.translate(
				adjustedX.toFloat(),
				adjustedY.toFloat()
			)

			if (backgroundColor) {
				this.backgroundColorDrawable.setBounds(0, 0, adjustedW, adjustedH)
				this.backgroundColorDrawable.draw(canvas)
			}

			if (backgroundImage) {
				this.backgroundImageDrawable.setBounds(0, 0, adjustedW, adjustedH)
				this.backgroundImageDrawable.draw(canvas)
			}

			if (border) {
				this.borderDrawable.setBounds(0, 0, adjustedW, adjustedH)
				this.borderDrawable.draw(canvas)
			}

			this.drawCanvasIfNeeded(canvas, 0, 0, adjustedW, adjustedH)

			canvas.restore()
		}
	}

	//--------------------------------------------------------------------------
	// Animations
	//--------------------------------------------------------------------------

	/**
	 * @property animatable
	 * @since 0.7.0
	 */
	override val animatable: List<String> = listOf(
		"backgroundColor",
		"borderTopWidth",
		"borderLeftWidth",
		"borderRightWidth",
		"borderBottomWidth",
		"borderTopColor",
		"borderLeftColor",
		"borderRightColor",
		"borderBottomColor",
		"borderTopLeftRadius",
		"borderTopRightRadius",
		"borderBottomLeftRadius",
		"borderBottomRightRadius",
		"shadowBlur",
		"shadowColor",
		"shadowOffsetTop",
		"shadowOffsetLeft",
		"alpha",
		"transform"
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

			"borderTopWidth",
			"borderLeftWidth",
			"borderRightWidth",
			"borderBottomWidth",
			"borderTopLeftRadius",
			"borderTopRightRadius",
			"borderBottomLeftRadius",
			"borderBottomRightRadius",
			"shadowBlur",
			"shadowOffsetTop",
			"shadowOffsetLeft",
			"alpha" -> {

				if (initialValue is Float &&
					currentValue is Float) {
					return ObjectAnimator.ofFloat(this, property, initialValue, currentValue)
				}

				throw Exception("Unexpected error.")
			}

			"borderTopColor",
			"borderLeftColor",
			"borderRightColor",
			"borderBottomColor",
			"backgroundColor",
			"shadowColor"-> {

				if (initialValue is Int &&
					currentValue is Int) {
					return ObjectAnimator.ofArgb(this, property, initialValue, currentValue)
				}

				throw Exception("Unexpected error.")
			}

			"transform" -> {

				if (initialValue is Transform &&
					currentValue is Transform) {
					return TransformAnimator(this, initialValue, currentValue)
				}

				throw Exception("Unexpected error.")
			}

			else -> {
			}
		}

		return null
	}

	/**
	 * @method onBeforeAnimate
	 * @since 0.7.0
	 */
	override fun onBeforeAnimate(property: String) {

		if (property == "backgroundColor") {
			this.setWillNotDraw(false)
			return
		}

		if (property == "borderTopWidth" ||
			property == "borderTopColor" ||
			property == "borderLeftWidth" ||
			property == "borderLeftColor" ||
			property == "borderRightWidth" ||
			property == "borderRightColor" ||
			property == "borderBottomWidth" ||
			property == "borderBottomColor") {
			this.setWillNotDraw(false)
			return
		}

		if (property == "shadowBlur" ||
			property == "shadowColor" ||
			property == "shadowOffsetTop" ||
			property == "shadowOffsetLeft") {
			this.setWillNotDraw(false)
			return
		}
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
		this.update()
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method invalidateFrame
	 * @since 0.2.0
	 * @hidden
	 */
	private fun invalidateFrame() {
		this.invalidFrame = true
	}

	/**
	 * @method invalidateShape
	 * @since 0.2.0
	 * @hidden
	 */
	private fun invalidateShape() {
		if (this.invalidShape == false) {
			this.invalidShape = true
			this.invalidate()
		}
	}

	/**
	 * @method needsBackgroundColor
	 * @since 0.7.0
	 * @hidden
	 */
	private fun needsBackgroundColor(): Boolean {
		return this.hasBackgroundColor()
	}

	/**
	 * @method needsBitmapDrawable
	 * @since 0.1.0
	 * @hidden
	 */
	private fun needsBackgroundImage(): Boolean {
		return this.hasBackgroundImage()
	}

	/**
	 * @method needsBorderDrawable
	 * @since 0.1.0
	 * @hidden
	 */
	private fun needsBorderDrawable(): Boolean {
		return this.hasBorder()
	}

	/**
	 * @method needsShadowDrawable
	 * @since 0.1.0
	 * @hidden
	 */
	private fun needsShadowDrawable(): Boolean {
		return this.hasShadow()
	}

	/**
	 * @method hasBackgroundColor
	 * @since 0.1.0
	 * @hidden
	 */
	private fun hasBackgroundColor(): Boolean {
		return (this.backgroundColor != null && this.backgroundColor != Color.TRANSPARENT && Color.alpha(this.backgroundColor!!) > 0) || this.backgroundLinearGradient != null ||this.backgroundRadialGradient != null
	}

	/**
	 * @method hasBackgroundImage
	 * @since 0.1.0
	 * @hidden
	 */
	private fun hasBackgroundImage(): Boolean {
		return this.backgroundImage != null
	}

	/**
	 * @method hasShadow
	 * @since 0.1.0
	 * @hidden
	 */
	private fun hasShadow(): Boolean {
		return Color.alpha(this.shadowColor) > 0 && (this.shadowBlur > 0 || this.shadowOffsetTop > 0 || this.shadowOffsetLeft > 0)
	}

	/**
	 * @method hasBorder
	 * @since 0.1.0
	 * @hidden
	 */
	private fun hasBorder(): Boolean {
		return (
			(Color.alpha(this.borderTopColor) > 0 && this.borderTopWidth > 0) ||
			(Color.alpha(this.borderLeftColor) > 0 && this.borderLeftWidth > 0) ||
			(Color.alpha(this.borderRightColor) > 0 && this.borderRightWidth > 0) ||
			(Color.alpha(this.borderBottomColor) > 0 && this.borderBottomWidth > 0)
		)
	}
}

