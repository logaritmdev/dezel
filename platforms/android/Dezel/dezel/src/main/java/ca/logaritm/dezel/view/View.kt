package ca.logaritm.dezel.view

import android.animation.ValueAnimator
import android.content.Context
import android.os.Handler
import android.view.MotionEvent
import android.view.ScaleGestureDetector
import android.view.ViewConfiguration
import android.view.ViewGroup
import android.view.animation.Transformation
import android.widget.HorizontalScrollView
import android.widget.ScrollView
import ca.logaritm.dezel.application.ApplicationActivity
import ca.logaritm.dezel.extension.Delegates
import ca.logaritm.dezel.extension.view.removeFromParent
import ca.logaritm.dezel.extension.view.setMeasuredFrame
import ca.logaritm.dezel.view.graphic.Convert
import ca.logaritm.dezel.view.animation.Animatable
import ca.logaritm.dezel.view.trait.Resizable
import ca.logaritm.dezel.view.trait.Scrollable
import ca.logaritm.dezel.view.trait.ScrollableListener
import ca.logaritm.dezel.view.trait.Updatable
import ca.logaritm.dezel.view.type.Overscroll
import ca.logaritm.dezel.view.type.Scrollbars
import kotlin.math.ceil
import kotlin.math.floor
import kotlin.math.max
import android.view.View as AndroidView

/**
 * @class View
 * @super ViewGroup
 * @since 0.7.0
 */
open class View(context: Context) : ViewGroup(context), Scrollable, Resizable, Updatable, Animatable, ScaleGestureDetector.OnScaleGestureListener {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property ordering
	 * @since 0.7.0
	 */
	open var ordering: IntArray? by Delegates.OnSetOptional<IntArray>(null) { value ->
		this.isChildrenDrawingOrderEnabled = value != null
	}

	/**
	 * @property scrollableListener
	 * @since 0.7.0
	 */
	override var scrollableListener: ScrollableListener? = null

	/**
	 * @property scrollable
	 * @since 0.7.0
	 */
	override var scrollable: Boolean = false

	/**
	 * @property scrollbars
	 * @since 0.7.0
	 */
	override var scrollbars: Scrollbars by Delegates.OnSet(Scrollbars.NONE) { value ->

		when (value) {

			Scrollbars.NONE       -> {
				this.scrollbarY = false
				this.scrollbarX = false
			}

			Scrollbars.BOTH       -> {
				this.scrollbarY = true
				this.scrollbarX = true
			}

			Scrollbars.VERTICAL   -> {
				this.scrollbarY = true
				this.scrollbarX = false
			}

			Scrollbars.HORIZONTAL -> {
				this.scrollbarY = true
				this.scrollbarX = false
			}
		}
	}

	/**
	 * @property overscroll
	 * @since 0.7.0
	 */
	override var overscroll: Overscroll by Delegates.OnSet(Overscroll.AUTO) { value ->

		when (value) {

			Overscroll.AUTO     -> {
				this.overscrollY = true
				this.overscrollX = true
				this.overscrollYAlways = false
				this.overscrollXAlways = false
			}

			Overscroll.NEVER    -> {
				this.overscrollY = false
				this.overscrollX = false
				this.overscrollYAlways = false
				this.overscrollXAlways = false
			}

			Overscroll.ALWAYS   -> {
				this.overscrollY = true
				this.overscrollX = true
				this.overscrollYAlways = true
				this.overscrollXAlways = true
			}

			Overscroll.ALWAYS_X -> {
				this.overscrollY = false
				this.overscrollX = true
				this.overscrollYAlways = false
				this.overscrollXAlways = true
			}

			Overscroll.ALWAYS_Y -> {
				this.overscrollY = true
				this.overscrollX = false
				this.overscrollYAlways = true
				this.overscrollXAlways = false
			}
		}
	}

	/**
	 * @property scrollTop
	 * @since 0.7.0
	 */
	override var scrollTop: Int
		get() = this.vScrollView.scrollY - this.contentInsetTop
		set(value) {
			this.vScrollView.scrollY = value + this.contentInsetTop
		}

	/**
	 * @property scrollLeft
	 * @since 0.7.0
	 */
	override var scrollLeft: Int
		get() = this.hScrollView.scrollX - this.contentInsetTop
		set(value) {
			this.hScrollView.scrollX = value + this.contentInsetTop
		}

	/**
	 * @property scrollWidth
	 * @since 0.7.0
	 */
	override var scrollWidth: Int by Delegates.OnSet(0) {
		this.invalidFrame = true
	}

	/**
	 * @property scrollHeight
	 * @since 0.7.0
	 */
	override var scrollHeight: Int by Delegates.OnSet(0) {
		this.invalidFrame = true
	}

	/**
	 * @property scrollInertia
	 * @since 0.7.0
	 */
	override var scrollInertia: Boolean = true

	/**
	 * @property contentInsetTop
	 * @since 0.7.0
	 */
	override var contentInsetTop: Int by Delegates.OnSet(0) {
		this.invalidFrame = true
		this.invalidInset = true
		this.update()
	}

	/**
	 * @property contentInsetLeft
	 * @since 0.7.0
	 */
	override var contentInsetLeft: Int by Delegates.OnSet(0) {
		this.invalidFrame = true
		this.invalidInset = true
		this.update()
	}

	/**
	 * @property contentInsetRight
	 * @since 0.7.0
	 */
	override var contentInsetRight: Int by Delegates.OnSet(0) {
		this.invalidFrame = true
		this.invalidInset = true
		this.update()
	}

	/**
	 * @property contentInsetBottom
	 * @since 0.7.0
	 */
	override var contentInsetBottom:  Int by Delegates.OnSet(0) {
		this.invalidFrame = true
		this.invalidInset = true
		this.update()
	}

	/**
	 * @property paged
	 * @since 0.7.0
	 */
	override var paged: Boolean by Delegates.OnSet(false) { value ->
		this.hScrollView.paged = value
		this.vScrollView.paged = value
	}

	/**
	 * @property zoomable
	 * @since 0.7.0
	 */
	override var zoomable: Boolean by Delegates.OnSet(false) { value ->
		this.applyZoom()
		this.setStaticTransformationsEnabled(value)
	}

	/**
	 * @property minZoom
	 * @since 0.7.0
	 */
	override var minZoom: Float by Delegates.OnSet(1.0f) {
		this.applyZoom()
	}

	/**
	 * @property maxZoom
	 * @since 0.7.0
	 */
	override var maxZoom: Float by Delegates.OnSet(1.0f) {
		this.applyZoom()
	}

	/**
	 * @property zoomedView
	 * @since 0.7.0
	 */
	override var zoomedView: android.view.View? by Delegates.OnSetOptional<android.view.View>(null) {
		this.applyZoom()
	}

	/**
	 * @property zooming
	 * @since 0.7.0
	 */
	open val zooming: Boolean
		get() = this.scaleGestureDetector.isInProgress

	/**
	 * @property pageX
	 * @since 0.7.0
	 */
	open val pageX: Int
		get() = floor(max(this.scrollLeft.toDouble(), 0.0) / this.frameWidth.toDouble()).toInt()

	/**
	 * @property pageY
	 * @since 0.7.0
	 */
	open val pageY: Int
		get() = floor(max(this.scrollLeft.toDouble(), 0.0) / this.frameWidth.toDouble()).toInt()

	/**
	 * @property pageXCount
	 * @since 0.7.0
	 */
	open val pageXCount: Int
		get() = ceil(this.scrollWidth.toDouble() / this.frameWidth.toDouble()).toInt()

	/**
	 * @property pageYCount
	 * @since 0.7.0
	 */
	open val pageYCount: Int
		get() = ceil(this.scrollHeight.toDouble() / this.frameHeight.toDouble()).toInt()

	/**
	 * @property pageXOffset
	 * @since 0.7.0
	 */
	open val pageXOffset: Float
		get() = (this.scrollLeft.toFloat() - (this.frameWidth.toFloat() * this.pageX.toFloat())) / this.frameWidth.toFloat()

	/**
	 * @property pageYOffset
	 * @since 0.7.0
	 */
	open val pageYOffset: Float
		get() = (this.scrollTop.toFloat() - (this.frameHeight.toFloat() * this.pageY.toFloat())) / this.frameHeight.toFloat()

	/**
	 * @property realScrollY
	 * @since 0.7.0
	 */
	public var realScrollY: Int
		get() = this.vScrollView.scrollY
		set(value) {
			this.vScrollView.scrollY = value
		}

	/**
	 * @property realScrollX
	 * @since 0.7.0
	 */
	public var realScrollX: Int
		get() = this.hScrollView.scrollX
		set(value) {
			this.hScrollView.scrollX = value
		}

	/**
	 * @property scrollableY
	 * @since 0.7.0
	 * @hidden
	 */
	private val scrollableY: Boolean
		get() = this.scrollHeight > this.frameHeight

	/**
	 * @property scrollableX
	 * @since 0.7.0
	 * @hidden
	 */
	private val scrollableX: Boolean
		get() = this.scrollWidth > this.frameWidth

	/**
	 * @property scrollbarX
	 * @since 0.7.0
	 * @hidden
	 */
	private var scrollbarX: Boolean by Delegates.OnSet(false) { value ->
		this.isHorizontalScrollBarEnabled = value
	}

	/**
	 * @property scrollbarY
	 * @since 0.7.0
	 * @hidden
	 */
	private var scrollbarY: Boolean by Delegates.OnSet(false) { value ->
		this.vScrollView.isVerticalScrollBarEnabled = value
	}

	/**
	 * @property overscrollX
	 * @since 0.7.0
	 * @hidden
	 */
	private var overscrollX: Boolean by Delegates.OnSet(true) {
		this.applyOverscrollX()
	}

	/**
	 * @property overscrollXAlways
	 * @since 0.7.0
	 * @hidden
	 */
	private var overscrollXAlways: Boolean by Delegates.OnSet(true) {
		this.applyOverscrollX()
	}

	/**
	 * @property overscrollY
	 * @since 0.7.0
	 * @hidden
	 */
	private var overscrollY: Boolean by Delegates.OnSet(true) {
		this.applyOverscrollY()
	}

	/**
	 * @property overscrollYAlways
	 * @since 0.7.0
	 * @hidden
	 */
	private var overscrollYAlways: Boolean by Delegates.OnSet(false) {
		this.applyOverscrollY()
	}

	/**
	 * @property vScrollView
	 * @since 0.7.0
	 * @hidden
	 */
	private val vScrollView: VScrollView

	/**
	 * @property vScrollViewActive
	 * @since 0.7.0
	 * @hidden
	 */
	private var vScrollViewActive: Boolean = false

	/**
	 * @property hScrollView
	 * @since 0.7.0
	 * @hidden
	 */
	private val hScrollView: HScrollView

	/**
	 * @property hScrollViewActive
	 * @since 0.7.0
	 * @hidden
	 */
	private var hScrollViewActive: Boolean = false

	/**
	 * @property frameTop
	 * @since 0.7.0
	 * @hidden
	 */
	private var frameTop: Int = 0

	/**
	 * @property frameLeft
	 * @since 0.7.0
	 * @hidden
	 */
	private var frameLeft: Int = 0

	/**
	 * @property frameWidth
	 * @since 0.7.0
	 * @hidden
	 */
	private var frameWidth: Int = 0

	/**
	 * @property frameHeight
	 * @since 0.7.0
	 * @hidden
	 */
	private var frameHeight: Int = 0

	/**
	 * @property invalidFrame
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidFrame: Boolean = false

	/**
	 * @property invalidInset
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidInset: Boolean = false

	/**
	 * @property minDistance
	 * @since 0.7.0
	 * @hidden
	 */
	private val minDistance: Int

	/**
	 * @property minVelocity
	 * @since 0.7.0
	 * @hidden
	 */
	private val minVelocity: Int

	/**
	 * @property maxVelocity
	 * @since 0.7.0
	 * @hidden
	 */
	private val maxVelocity: Int

	/**
	 * @property scale
	 * @since 0.7.0
	 * @hidden
	 */
	private var scale: Float = 1f

	/**
	 * @property scaleOriginX
	 * @since 0.7.0
	 * @hidden
	 */
	private var scaleOriginX: Float = 0f

	/**
	 * @property scaleOriginY
	 * @since 0.7.0
	 * @hidden
	 */
	private var scaleOriginY: Float = 0f

	/**
	 * @property scaleGestureDetector
	 * @since 0.7.0
	 * @hidden
	 */
	private val scaleGestureDetector: ScaleGestureDetector = ScaleGestureDetector(context, this)

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	init {

		this.vScrollView = VScrollView(context)
		this.hScrollView = HScrollView(context)
		this.clipChildren = false
		this.clipToPadding = false
		this.clipToOutline = false

		val config = ViewConfiguration.get(this.context)
		this.minVelocity = config.scaledMinimumFlingVelocity
		this.maxVelocity = config.scaledMaximumFlingVelocity
		this.minDistance = (25f * Convert.density).toInt()
	}

	/**
	 * @method getChildDrawingOrder
	 * @since 0.7.0
	 */
	override fun getChildDrawingOrder(count: Int, i: Int): Int {
		return this.ordering?.get(i) ?: i
	}

	/**
	 * @method getChildStaticTransformation
	 * @since 0.7.0
	 */
	override fun getChildStaticTransformation(child: android.view.View, transform: Transformation): Boolean {

		if (this.zoomable == false) {
			return false
		}

		val view = this.zoomedView
		if (view == null) {
			return false
		}

		if (view == child) {

			transform.matrix.reset()
			transform.matrix.postTranslate(this.scaleOriginX, this.scaleOriginY)
			transform.matrix.postScale(
				this.scale,
				this.scale,
				this.scaleOriginX,
				this.scaleOriginY
			)

			return true
		}

		return false
	}

	/**
	 * @method onResize
	 * @since 0.7.0
	 */
	override fun onResize(t: Int, l: Int, w: Int, h: Int) {

		this.frameTop = t
		this.frameLeft = l
		this.frameWidth = w
		this.frameHeight = h

		if (this.scrollable == false) {
			this.setMeasuredFrame(t, l, w, h)
		} else {
			this.invalidFrame = true
		}
	}

	/**
	 * @method onMeasure
	 * @since 0.7.0
	 */
	override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
		this.setMeasuredDimension(
			MeasureSpec.getSize(widthMeasureSpec),
			MeasureSpec.getSize(heightMeasureSpec)
		)
	}

	/**
	 * @method onLayout
	 * @since 0.7.0
	 */
	override fun onLayout(changed: Boolean, l: Int, t: Int, r: Int, b: Int) {

	}

	/**
	 * @method onTouchEvent
	 * @since 0.7.0
	 */
	override fun onTouchEvent(event: MotionEvent): Boolean {

		if (this.zoomable) {

			if (this.zooming) {
				this.parent?.requestDisallowInterceptTouchEvent(true)
			}

			this.scaleGestureDetector.onTouchEvent(event)

			return true
		}

		return super.onTouchEvent(event)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 */
	override fun update() {

		if (this.scrollable == false) {

			this.removeScrollableContainers(
				this.hScrollViewActive,
				this.vScrollViewActive
			)

		} else {

			if (this.invalidFrame) {
				this.invalidFrame = false

				val scrollW = this.scrollWidth + this.contentInsetLeft + this.contentInsetRight
				val scrollH = this.scrollHeight + this.contentInsetTop + this.contentInsetBottom

				var frameT = this.frameTop
				var frameL = this.frameLeft
				val frameW = this.frameWidth
				val frameH = this.frameHeight

				this.insertScrollableContainers(
					scrollW > frameW,
					scrollH > frameH
				)

				val contentViewW = max(frameW, scrollW)
				val contentViewH = max(frameH, scrollH)

				if (this.hScrollViewActive) {

					val sx = this.hScrollView.scrollX
					val sy = this.hScrollView.scrollY

					this.hScrollView.setMeasuredFrame(frameT, frameL, frameW, frameH)
					this.hScrollView.scrollX = sx
					this.hScrollView.scrollY = sy

					frameT = 0
					frameL = 0
				}

				if (this.vScrollViewActive) {

					val sx = this.vScrollView.scrollX
					val sy = this.vScrollView.scrollY

					this.vScrollView.setMeasuredFrame(frameT, frameL, max(frameW, scrollW), frameH)
					this.vScrollView.scrollX = sx
					this.vScrollView.scrollY = sy

					frameT = 0
					frameL = 0
				}

				this.setMeasuredFrame(frameT, frameL, contentViewW, contentViewH)

				if (this.scrollTop > 0 && contentViewH == frameH) {
					this.scrollTop = 0
				}

				if (this.scrollLeft > 0 && contentViewW == frameW) {
					this.scrollLeft = 0
				}
			}

			if (this.invalidInset) {
				this.invalidInset = false

				this.translationX = this.contentInsetLeft.toFloat()
				this.translationY = this.contentInsetTop.toFloat()

				val newScrollX = this.realScrollX + this.contentInsetLeft
				val newScrollY = this.realScrollY + this.contentInsetTop

				if (this.hScrollView.scrollX != newScrollX) this.hScrollView.scrollX = newScrollX
				if (this.vScrollView.scrollY != newScrollY) this.vScrollView.scrollY = newScrollY

				this.onScroll(newScrollY, newScrollX)
			}
		}
	}

	/**
	 * @method scrollTo
	 * @since 0.7.0
	 */
	override fun scrollTo(x: Int, y: Int) {
		val sx = x - this.contentInsetLeft
		val sy = y - this.contentInsetTop
		if (sx != this.hScrollView.scrollX) this.hScrollView.smoothScrollTo(sx, 0)
		if (sy != this.vScrollView.scrollY) this.vScrollView.smoothScrollTo(0, sy)
	}

	/**
	 * @method scrollToPage
	 * @since 0.7.0
	 */
	open fun scrollToPage(x: Int, y: Int) {
		val pageW = this.frameWidth
		val pageH = this.frameHeight
		this.scrollTo(x * pageW, y * pageH)
	}

	/**
	 * @method dispatchTouchCancel
	 * @since 0.7.0
	 */
	open fun dispatchTouchCancel(event: MotionEvent) {
		val application = this.context
		if (application is ApplicationActivity) {
			application.dispatchTouchCancel(event)
		}
	}

	//--------------------------------------------------------------------------
	// Animations
	//--------------------------------------------------------------------------

	/**
	 * @property animatable
	 * @since 0.7.0
	 */
	override val animatable: List<String> = listOf()

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

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method applyZoom
	 * @since 0.7.0
	 * @hidden
	 */
	private fun applyZoom() {

		val view = this.zoomedView
		if (view == null) {
			return
		}

		if (this.scale < this.minZoom) this.scale = this.minZoom
		if (this.scale > this.maxZoom) this.scale = this.maxZoom

		view.invalidate()
	}

	/**
	 * @method applyOverscrollY
	 * @since 0.7.0
	 * @hidden
	 */
	private fun applyOverscrollY() {

		if (this.overscrollY &&
			this.overscrollYAlways) {
			this.vScrollView.overScrollMode = AndroidView.OVER_SCROLL_ALWAYS
			return
		}

		if (this.overscrollY == false) {
			this.vScrollView.overScrollMode = AndroidView.OVER_SCROLL_NEVER
			return
		}

		this.vScrollView.overScrollMode = AndroidView.OVER_SCROLL_IF_CONTENT_SCROLLS
	}

	/**
	 * @method applyOverscrollX
	 * @since 0.7.0
	 * @hidden
	 */
	private fun applyOverscrollX() {

		if (this.overscrollX &&
			this.overscrollXAlways) {
			this.hScrollView.overScrollMode = AndroidView.OVER_SCROLL_ALWAYS
			return
		}

		if (this.overscrollX == false) {
			this.hScrollView.overScrollMode = AndroidView.OVER_SCROLL_NEVER
			return
		}

		this.hScrollView.overScrollMode = AndroidView.OVER_SCROLL_IF_CONTENT_SCROLLS
	}

	/**
	 * @method removeScrollableContainers
	 * @since 0.7.0
	 * @hidden
	 */
	private fun removeScrollableContainers(hScrollView: Boolean, vScrollView: Boolean) {

		if (hScrollView) {

			if (this.hScrollViewActive) {
				this.hScrollViewActive = false

				val parent = this.hScrollView.parent
				if (parent is ViewGroup) {
					this.moveToParent(parent)
				}

				this.hScrollView.removeFromParent()
			}
		}

		if (vScrollView) {

			if (this.vScrollViewActive) {
				this.vScrollViewActive = false

				val parent = this.vScrollView.parent
				if (parent is ViewGroup) {
					this.moveToParent(parent)
				}

				this.vScrollView.removeFromParent()
			}
		}
	}

	/**
	 * @method insertScrollableContainers
	 * @since 0.7.0
	 * @hidden
	 */
	private fun insertScrollableContainers(hScrollView: Boolean, vScrollView: Boolean) {

		var content: ViewGroup = this

		if (this.vScrollViewActive == false && vScrollView) {
			this.vScrollViewActive = true

			val parent = content.parent
			if (parent is ViewGroup) {
				parent.addView(this.vScrollView)
			}

			this.removeFromParent()
			this.vScrollView.addView(this)
			content = this.vScrollView
		}

		if (this.hScrollViewActive == false && hScrollView) {
			this.hScrollViewActive = true

			val parent = content.parent
			if (parent is ViewGroup) {
				parent.addView(this.hScrollView)
			}

			this.removeFromParent()
			this.hScrollView.addView(this)
			content = this.hScrollView
		}
	}

	/**
	 * @method moveToParent
	 * @since 0.7.0
	 * @hidden
	 */
	private fun moveToParent(parent: ViewGroup) {

		if (this.hScrollViewActive) {
			this.hScrollView.removeFromParent()
			parent.addView(this.hScrollView)
			return
		}

		if (this.vScrollViewActive) {
			this.vScrollView.removeFromParent()
			parent.addView(this.vScrollView)
			return
		}

		this.removeFromParent()

		parent.addView(this)
	}

	/**
	 * @method onDragStart
	 * @since 0.7.0
	 * @hidden
	 */
	private fun onDragStart() {
		this.scrollableListener?.onDragStart(this)
	}

	/**
	 * @method onDragEnd
	 * @since 0.7.0
	 * @hidden
	 */
	private fun onDragEnd() {
		this.scrollableListener?.onDragEnd(this)
	}

	/**
	 * @method onDrag
	 * @since 0.7.0
	 * @hidden
	 */
	private fun onDrag() {
		this.scrollableListener?.onDrag(this)
	}

	/**
	 * @method onScrollStart
	 * @since 0.7.0
	 * @hidden
	 */
	private fun onScrollStart() {
		this.scrollableListener?.onScrollStart(this)
	}

	/**
	 * @method onScrollEnd
	 * @since 0.7.0
	 * @hidden
	 */
	private fun onScrollEnd() {
		this.scrollableListener?.onScrollEnd(this)
	}

	/**
	 * @method onScroll
	 * @since 0.7.0
	 * @hidden
	 */
	private fun onScroll(t: Int, l: Int) {
		this.scrollableListener?.onScroll(
			this,
			t - this.contentInsetTop,
			l - this.contentInsetLeft
		)
	}

	/**
	 * @method onScaleBegin
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onScaleBegin(detector: ScaleGestureDetector): Boolean {
		this.scrollableListener?.onZoomStart(this)
		return true
	}

	/**
	 * @method onScaleBegin
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onScaleEnd(detector: ScaleGestureDetector) {
		this.scrollableListener?.onZoomEnd(this, this.scale)
	}

	/**
	 * @method onScale
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onScale(detector: ScaleGestureDetector): Boolean {

		this.scale = this.scale * detector.scaleFactor
		this.scaleOriginX = detector.focusX
		this.scaleOriginY = detector.focusY

		this.applyZoom()

		this.scrollableListener?.onZoom(this)

		return true
	}

	//--------------------------------------------------------------------------
	// Classes
	//--------------------------------------------------------------------------

	/**
	 * @class HScrollView
	 * @since 0.7.0
	 * @hidden
	 */
	private inner class HScrollView(context: Context): HorizontalScrollView(context) {

		//--------------------------------------------------------------------------
		// Properties
		//--------------------------------------------------------------------------

		/**
		 * @property velocity
		 * @since 0.7.0
		 * @hidden
		 */
		public var velocity: Int = 0

		/**
		 * @property paged
		 * @since 0.7.0
		 * @hidden
		 */
		public var paged: Boolean = false

		/**
		 * @property scrolling
		 * @since 0.7.0
		 * @hidden
		 */
		public var scrolling: Boolean = false

		/**
		 * @property dragBegan
		 * @since 0.7.0
		 * @hidden
		 */
		private var dragBegan: Boolean = false

		/**
		 * @property dragMoved
		 * @since 0.7.0
		 * @hidden
		 */
		private var dragMoved: Boolean = false

		/**
		 * @property scrollEndHandler
		 * @since 0.7.0
		 * @hidden
		 */
		private val scrollEndHandler: Handler = Handler()

		/**
		 * @property scrollEndRunnable
		 * @since 0.7.0
		 * @hidden
		 */
		private val scrollEndRunnable: Runnable = Runnable {
			if (this.scrolling) {
				this.scrolling = false
				this.velocity = 0
				this@View.onScrollEnd()
			}
		}

		/**
		 * @property touches
		 * @since 0.7.0
		 * @hidden
		 */
		private var touches: Int = 0

		/**
		 * @property touchesCancelled
		 * @since 0.7.0
		 * @hidden
		 */
		private var touchesCancelled: Boolean = false

		/**
		 * @property dragX1
		 * @since 0.7.0
		 * @hidden
		 */
		private var dragX1: Float = 0f

		/**
		 * @property dragX2
		 * @since 0.7.0
		 * @hidden
		 */
		private var dragX2: Float = 0f

		/**
		 * @property snapped
		 * @since 0.7.0
		 * @hidden
		 */
		private var snapped: Boolean = false

		//--------------------------------------------------------------------------
		// Methods
		//--------------------------------------------------------------------------

		/**
		 * @constructor
		 * @since 0.7.0
		 * @hidden
		 */
		init {

			this.clipChildren = false
			this.clipToPadding = false
			this.clipToOutline = false

			this.isVerticalScrollBarEnabled = false
			this.isHorizontalScrollBarEnabled = false

			this.overScrollMode = AndroidView.OVER_SCROLL_IF_CONTENT_SCROLLS
		}

		//--------------------------------------------------------------------------
		// Touch Events
		//--------------------------------------------------------------------------

		/**
		 * @method dispatchTouchEvent
		 * @since 0.7.0
		 */
		override fun dispatchTouchEvent(event: MotionEvent): Boolean {

			when (event.action) {
				MotionEvent.ACTION_CANCEL -> this.onTouchCancel(event)
				MotionEvent.ACTION_DOWN   -> this.onTouchStart(event)
				MotionEvent.ACTION_MOVE   -> this.onTouchMove(event)
				MotionEvent.ACTION_UP     -> this.onTouchEnd(event)
			}

			return super.dispatchTouchEvent(event)
		}

		/**
		 * @method onInterceptTouchEvent
		 * @since 0.7.0
		 */
		override fun onInterceptTouchEvent(event: MotionEvent): Boolean {

			if (this@View.scrollable == false ||
				this@View.scrollableX == false) {
				return false
			}

			return super.onInterceptTouchEvent(event)
		}

		/**
		 * @method onTouchEvent
		 * @since 0.7.0
		 */
		override fun onTouchEvent(event: MotionEvent): Boolean {

			if (this@View.scrollable == false ||
				this@View.scrollableX == false) {
				return false
			}

			if (this.canScrollHorizontally(+1) == false &&
				this.canScrollHorizontally(-1) == false) {
				return false
			}

			if (this.paged) {
				when (event.action) {
					MotionEvent.ACTION_DOWN   -> this.dragX1 = event.x
					MotionEvent.ACTION_UP     -> this.dragX2 = event.x
					MotionEvent.ACTION_CANCEL -> {
						this@View.scrollToPage(
							this@View.pageX,
							this@View.pageY
						)
					}
				}
			}

			val handled = super.onTouchEvent(event)

			if (this.paged && event.action == MotionEvent.ACTION_UP) {

				if (this.snapped) {
					this.snapped = false
				} else {
					this.snap(0)
				}

			}

			return handled
		}

		/**
		 * @method onTouchCancel
		 * @since 0.7.0
		 */
		public fun onTouchCancel(event: MotionEvent) {

			this.touches -= event.pointerCount

			if (this.touchesCancelled == false) {
				this.touchesCancelled = true
				this@View.dispatchTouchCancel(event)
			}
		}

		/**
		 * @method onTouchStart
		 * @since 0.7.0
		 */
		public fun onTouchStart(event: MotionEvent) {

			if (this.touches == 0) {
				this.dragBegan = true
				this.dragMoved = false
			}

			this.touches += event.pointerCount
		}

		/**
		 * @method onTouchMove
		 * @since 0.7.0
		 */
		public fun onTouchMove(event: MotionEvent) {

			/*
			 * For reasons that I do not yet understand, the ACTION_CANCEL is not called under
			 * certain conditions. This is a hack made to execute the event when the scroll
			 * view starts dragging.
			 */

			if (this.dragBegan &&
				this.dragMoved &&
				this.touchesCancelled == false) {
				this.touchesCancelled = true
				this@View.dispatchTouchCancel(event)
			}
		}

		/**
		 * @method onTouchEnd
		 * @since 0.7.0
		 */
		public fun onTouchEnd(event: MotionEvent) {

			this.touches -= event.pointerCount

			if (this.touches == 0) {

				this.dragBegan = false

				if (this.dragMoved) {
					this.dragMoved = false
					this@View.onDragEnd()
				}

				this.touchesCancelled = false
				this.scrollEndHandler.removeCallbacks(this.scrollEndRunnable)
				this.scrollEndHandler.postDelayed(this.scrollEndRunnable, 32)
			}
		}

		//--------------------------------------------------------------------------
		// Scrolling
		//--------------------------------------------------------------------------

		/**
		 * @method onScrollChanged
		 * @since 0.7.0
		 * @hidden
		 */
		override fun onScrollChanged(l: Int, t: Int, oldl: Int, oldt: Int) {

			super.onScrollChanged(l, t, oldl, oldt)

			if (this.scrolling == false) {
				this.scrolling = true
				this@View.onScrollStart()
			}

			if (this.dragBegan) {
				if (this.dragMoved == false) {
					this.dragMoved = true
					this@View.onDragStart()
				}
			}

			this@View.onScroll(this@View.realScrollY, l)

			if (this.dragMoved) {
				this@View.onDrag()
			}

			this.scrollEndHandler.removeCallbacks(this.scrollEndRunnable)

			if (this.touches == 0) {
				this.scrollEndHandler.postDelayed(this.scrollEndRunnable, 32)
			}

			/*
			 * The onScrollChanged event seems to be a bit off sync with the current choreographer
			 * which make views incorrectly positioned for milliseconds. By forcing a layout a display
			 * refresh the effect is minimized.
			 */

			Synchronizer.main.execute()
		}

		/**
		 * @method fling
		 * @since 0.7.0
		 */
		override fun fling(velocity: Int) {

			if (this.paged) {

				if (this.snapped == false) {
					this.snapped = true
					this.snap(velocity)
				}

				return
			}

			if (this@View.scrollInertia) {

				if (this.velocity == 0) {
					this.velocity = velocity
				}

				super.fling(velocity)
			}
		}

		/**
		 * @method snap
		 * @since 0.7.0
		 * @hidden
		 */
		private fun snap(velocity: Int) {

			val pageY = this@View.pageY
			var pageX = this@View.pageX

			val distance = this.dragX1 - this.dragX2

			if (Math.abs(distance) > this@View.minDistance &&
				Math.abs(velocity) > this@View.minVelocity) {
				pageX = if (velocity > 0) pageX + 1 else pageX
			} else {
				pageX = (pageX.toFloat() + this@View.pageXOffset + 0.5).toInt()
			}

			if (pageX < 0) {
				pageX = 0
			} else if (pageX > this@View.pageXCount - 1) {
				pageX = this@View.pageXCount - 1
			}

			this@View.scrollToPage(pageX, pageY)
		}
	}

	//--------------------------------------------------------------------------
	// Classes
	//--------------------------------------------------------------------------

	/**
	 * @class VScrollView
	 * @since 0.7.0
	 * @hidden
	 */
	private inner class VScrollView(context: Context): ScrollView(context) {

		/**
		 * @property velocity
		 * @since 0.7.0
		 * @hidden
		 */
		public var velocity: Int = 0

		/**
		 * @property paged
		 * @since 0.7.0
		 * @hidden
		 */
		public var paged: Boolean = false

		/**
		 * @property scrolling
		 * @since 0.7.0
		 * @hidden
		 */
		public var scrolling: Boolean = false

		/**
		 * @property dragBegan
		 * @since 0.7.0
		 * @hidden
		 */
		private var dragBegan: Boolean = false

		/**
		 * @property dragMoved
		 * @since 0.7.0
		 * @hidden
		 */
		private var dragMoved: Boolean = false

		/**
		 * @property scrollEndHandler
		 * @since 0.7.0
		 * @hidden
		 */
		private val scrollEndHandler: Handler = Handler()

		/**
		 * @property scrollEndRunnable
		 * @since 0.7.0
		 * @hidden
		 */
		private val scrollEndRunnable: Runnable = Runnable {
			if (this.scrolling) {
				this.scrolling = false
				this.velocity = 0
				this@View.onScrollEnd()
			}
		}

		/**
		 * @property touches
		 * @since 0.7.0
		 * @hidden
		 */
		private var touches: Int = 0

		/**
		 * @property touchesCancelled
		 * @since 0.7.0
		 * @hidden
		 */
		private var touchesCancelled: Boolean = false

		/**
		 * @property dragY1
		 * @since 0.7.0
		 * @hidden
		 */
		private var dragY1: Float = 0f

		/**
		 * @property dragY2
		 * @since 0.7.0
		 * @hidden
		 */
		private var dragY2: Float = 0f

		/**
		 * @property snapped
		 * @since 0.7.0
		 * @hidden
		 */
		private var snapped: Boolean = false

		/**
		 * @constructor
		 * @since 0.7.0
		 * @hidden
		 */
		init {

			this.clipChildren = false
			this.clipToPadding = false
			this.clipToOutline = false

			this.isVerticalScrollBarEnabled = false
			this.isHorizontalScrollBarEnabled = false

			this.overScrollMode = AndroidView.OVER_SCROLL_IF_CONTENT_SCROLLS
		}

		/**
		 * @method onMeasure
		 * @since 0.7.0
		 */
		override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
			this.setMeasuredDimension(
				MeasureSpec.getSize(widthMeasureSpec),
				MeasureSpec.getSize(heightMeasureSpec)
			)
		}

		/**
		 * @method onLayout
		 * @since 0.7.0
		 */
		override fun onLayout(changed: Boolean, l: Int, t: Int, r: Int, b: Int) {

		}

		/**
		 * @method dispatchTouchEvent
		 * @since 0.7.0
		 */
		override fun dispatchTouchEvent(event: MotionEvent): Boolean {

			when (event.action) {
				MotionEvent.ACTION_CANCEL -> this.onTouchCancel(event)
				MotionEvent.ACTION_DOWN   -> this.onTouchStart(event)
				MotionEvent.ACTION_MOVE   -> this.onTouchMove(event)
				MotionEvent.ACTION_UP     -> this.onTouchEnd(event)
			}

			return super.dispatchTouchEvent(event)
		}

		/**
		 * @method onInterceptTouchEvent
		 * @since 0.7.0
		 */
		override fun onInterceptTouchEvent(event: MotionEvent): Boolean {

			if (this@View.scrollable == false ||
				this@View.scrollableY == false) {
				return false
			}

			return super.onInterceptTouchEvent(event)
		}

		/**
		 * @method onTouchEvent
		 * @since 0.7.0
		 */
		override fun onTouchEvent(event: MotionEvent): Boolean {

			if (this@View.scrollable == false ||
				this@View.scrollableY == false) {
				return false
			}

			if (this.canScrollVertically(+1) == false &&
				this.canScrollVertically(-1) == false) {
				return false
			}

			if (this.paged) {
				when (event.action) {
					MotionEvent.ACTION_DOWN   -> this.dragY1 = event.y
					MotionEvent.ACTION_UP     -> this.dragY2 = event.y
					MotionEvent.ACTION_CANCEL -> {
						this@View.scrollToPage(
							this@View.pageX,
							this@View.pageY
						)
					}
				}
			}

			val handled = super.onTouchEvent(event)

			if (this.paged && event.action == MotionEvent.ACTION_UP) {

				if (this.snapped) {
					this.snapped = false
				} else {
					this.snap(0)
				}

			}

			return handled
		}

		/**
		 * @method onTouchCancel
		 * @since 0.7.0
		 */
		public fun onTouchCancel(event: MotionEvent) {

			this.touches -= event.pointerCount

			if (this.touchesCancelled == false) {
				this.touchesCancelled = true
				this@View.dispatchTouchCancel(event)
			}
		}

		/**
		 * @method onTouchStart
		 * @since 0.7.0
		 */
		public fun onTouchStart(event: MotionEvent) {

			if (this.touches == 0) {
				this.dragBegan = true
				this.dragMoved = false
			}

			this.touches += event.pointerCount
		}

		/**
		 * @method onTouchMove
		 * @since 0.7.0
		 */
		public fun onTouchMove(event: MotionEvent) {

			/*
			 * For reasons that I do not yet understand, the ACTION_CANCEL is not called under
			 * certain conditions. This is a hack made to execute the event when the scroll
			 * view starts dragging.
			 */

			if (this.dragBegan &&
				this.dragMoved &&
				this.touchesCancelled == false) {
				this.touchesCancelled = true
				this@View.dispatchTouchCancel(event)
			}
		}

		/**
		 * @method onTouchEnd
		 * @since 0.7.0
		 */
		public fun onTouchEnd(event: MotionEvent) {

			this.touches -= event.pointerCount

			if (this.touches == 0) {

				this.dragBegan = false

				if (this.dragMoved) {
					this.dragMoved = false
					this@View.onDragEnd()
				}

				this.touchesCancelled = false
				this.scrollEndHandler.removeCallbacks(this.scrollEndRunnable)
				this.scrollEndHandler.postDelayed(this.scrollEndRunnable, 32)
			}
		}

		/**
		 * @method onScrollChanged
		 * @since 0.7.0
		 */
		override fun onScrollChanged(l: Int, t: Int, oldl: Int, oldt: Int) {

			super.onScrollChanged(l, t, oldl, oldt)

			if (this.scrolling == false) {
				this.scrolling = true
				this@View.onScrollStart()
			}

			if (this.dragBegan) {
				if (this.dragMoved == false) {
					this.dragMoved = true
					this@View.onDragStart()
				}
			}

			this@View.onScroll(t, this@View.realScrollX)

			if (this.dragMoved) {
				this@View.onDrag()
			}

			this.scrollEndHandler.removeCallbacks(this.scrollEndRunnable)

			if (this.touches == 0) {
				this.scrollEndHandler.postDelayed(this.scrollEndRunnable, 16)
			}

			/*
			 * The onScrollChanged event seems to be a bit off sync with the current choreographer
			 * which make views incorrectly positioned for milliseconds. By forcing a layout a display
			 * refresh the effect is minimized.
			 */

			Synchronizer.main.execute()
		}

		/**
		 * @method fling
		 * @since 0.7.0
		 */
		override fun fling(velocity: Int) {

			if (this.paged) {

				if (this.snapped == false) {
					this.snapped = true
					this.snap(velocity)
				}

				return
			}

			if (this@View.scrollInertia) {

				if (this.velocity == 0) {
					this.velocity = velocity
				}

				super.fling(velocity)
			}
		}

		/**
		 * @method snap
		 * @since 0.7.0
		 * @hidden
		 */
		private fun snap(velocity: Int) {

			var pageY = this@View.pageY
			val pageX = this@View.pageX

			val distance = this.dragY1 - this.dragY2

			if (Math.abs(distance) > this@View.minDistance &&
				Math.abs(velocity) > this@View.minVelocity) {
				pageY = if (velocity > 0) pageY + 1 else pageY
			} else {
				pageY = (pageY.toFloat() + this@View.pageYOffset + 0.5).toInt()
			}

			if (pageY < 0) {
				pageY = 0
			} else if (pageY > this@View.pageYCount - 1) {
				pageY = this@View.pageYCount - 1
			}

			this@View.scrollToPage(pageX, pageY)
		}
	}
}