package ca.logaritm.dezel.modules.view

import android.graphics.Bitmap
import android.graphics.RectF
import android.util.Log
import android.util.SizeF
import android.view.animation.PathInterpolator
import ca.logaritm.dezel.application.application
import ca.logaritm.dezel.core.*
import ca.logaritm.dezel.extension.*
import ca.logaritm.dezel.extension.type.*
import ca.logaritm.dezel.extension.type.max
import ca.logaritm.dezel.extension.type.min
import ca.logaritm.dezel.extension.type.until
import ca.logaritm.dezel.extension.view.addView
import ca.logaritm.dezel.extension.view.removeFromParent
import ca.logaritm.dezel.layout.LayoutNode
import ca.logaritm.dezel.layout.LayoutNodeListener
import ca.logaritm.dezel.modules.graphic.ImageLoader
import ca.logaritm.dezel.modules.graphic.JavaScriptCanvas
import ca.logaritm.dezel.style.StylerNode
import ca.logaritm.dezel.style.StylerNodeListener
import ca.logaritm.dezel.view.*
import ca.logaritm.dezel.view.animation.Transition
import ca.logaritm.dezel.view.geom.Point3D
import ca.logaritm.dezel.view.geom.Transform3D
import ca.logaritm.dezel.view.graphic.*
import ca.logaritm.dezel.view.type.Overscroll
import ca.logaritm.dezel.view.type.Scrollbars
import kotlin.math.PI
import android.graphics.Canvas as AndroidCanvas
import android.view.View as AndroidView
import android.view.ViewGroup as AndroidViewGroup

/**
 * The base class for view types.
 * @class JavaScriptView
 * @since 0.7.0
 */
open class JavaScriptView(context: JavaScriptContext) : JavaScriptClass(context), LayoutNodeListener, StylerNodeListener, ScrollableListener, SynchronizerCallback {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The view's listener.
	 * @property listener
	 * @since 0.7.0
	 */
	open var listener: Listener? = null

	/**
	 * The view's JavaScript class name.
	 * @property className
	 * @since 0.7.0
	 */
	public var className: String = "View"

	/**
	 * The view's JavaScript class list.
	 * @property classList
	 * @since 0.7.0
	 */
	public var classList: String by Delegates.OnSet("View") { value ->
		this.stylerNode.type = value
	}

	/**
	 * The view's content wrapper view.
	 * @property wrapper
	 * @since 0.7.0
	 */
	public lateinit var wrapper: WrapperView
		private set

	/**
	 * The view that displays this view's content.
	 * @property content
	 * @since 0.7.0
	 */
	public lateinit var content: AndroidView
		private set

	/**
	 * The view's JavaScript root.
	 * @property window
	 * @since 0.7.0
	 */
	public var window: JavaScriptWindow? = null

	/**
	 * The view's JavaScript parent.
	 * @property parent
	 * @since 0.7.0
	 */
	public var parent: JavaScriptView? = null
		private set

	/**
	 * The view's children.
	 * @property children
	 * @since 0.7.0
	 */
	public var children: MutableList<JavaScriptView> = mutableListOf()
		private set

	/**
	 * The view's shadowed views.
	 * @property shadowed
	 * @since 0.7.0
	 */
	public var shadowed: MutableList<JavaScriptView> = mutableListOf()
		private set

	/**
	 * The view's shadow shadowRoot.
	 * @property shadowRoot
	 * @since 0.7.0
	 */
	public var shadowRoot: JavaScriptView? by Delegates.OnChangeOptional<JavaScriptView>(null) { newValue, oldValue ->
		oldValue?.removeShadowedView(this)
		newValue?.appendShadowedView(this)
	}

	/**
	 * Whether this view the root of a isShadowRoot element.
	 * @property isShadowRoot
	 * @since 0.7.0
	 */
	public var isShadowRoot: Boolean = false
		private set

	/**
	 * @property resolvedTop
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedTop: Double = 0.0
		private set

	/**
	 * @property resolvedLeft
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedLeft: Double = 0.0
		private set

	/**
	 * @property resolvedWidth
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedWidth: Double = 0.0
		private set

	/**
	 * @property resolvedHeight
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedHeight: Double = 0.0
		private set

	/**
	 * @property resolvedInnerWidth
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedInnerWidth: Double = 0.0
		private set

	/**
	 * @property resolvedInnerHeight
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedInnerHeight: Double = 0.0
		private set

	/**
	 * @property resolvedContentWidth
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedContentWidth: Double = 0.0
		private set

	/**
	 * @property resolvedContentHeight
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedContentHeight: Double = 0.0
		private set

	/**
	 * @property resolvedMarginTop
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedMarginTop: Double = 0.0
		private set

	/**
	 * @property resolvedMarginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedMarginLeft: Double = 0.0
		private set

	/**
	 * @property resolvedMarginRight
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedMarginRight: Double = 0.0
		private set

	/**
	 * @property resolvedMarginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedMarginBottom: Double = 0.0
		private set

	/**
	 * @property resolvedBorderTopWidth
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedBorderTopWidth: Double = 0.0
		private set

	/**
	 * @property resolvedBorderLeftWidth
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedBorderLeftWidth: Double = 0.0
		private set

	/**
	 * @property resolvedBorderRightWidth
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedBorderRightWidth: Double = 0.0
		private set

	/**
	 * @property resolvedBorderBottomWidth
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedBorderBottomWidth: Double = 0.0
		private set

	/**
	 * @property resolvedPaddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedPaddingTop: Double = 0.0
		private set

	/**
	 * @property resolvedPaddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedPaddingLeft: Double = 0.0
		private set

	/**
	 * @property resolvedPaddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedPaddingRight: Double = 0.0
		private set

	/**
	 * @property resolvedPaddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedPaddingBottom: Double = 0.0
		private set

	/**
	 * @property resolvedTranslationX
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedTranslationX: Double = 0.0
		private set

	/**
	 * @property resolvedTranslationY
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedTranslationY: Double = 0.0
		private set

	/**
	 * @property resolvedTranslationZ
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedTranslationZ: Double = 0.0
		private set

	/**
	 * @property resolvedRotationX
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedRotationX: Double = 0.0
		private set

	/**
	 * @property resolvedRotationY
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedRotationY: Double = 0.0
		private set

	/**
	 * @property resolvedRotationZ
	 * @since 0.7.0
	 * @hidden
	 */
	public var resolvedRotationZ: Double = 0.0
		private set

	/**
	 * Whether the view's frame has been resolved.
	 * @property resolvedFrame
	 * @since 0.7.0
	 */
	public var resolvedFrame: Boolean = false
		private set

	/**
	 * @property stylerNode
	 * @since 0.7.0
	 * @hidden
	 */
	public var stylerNode: StylerNode
		private set

	/**
	 * @property layoutNode
	 * @since 0.7.0
	 * @hidden
	 */
	public var layoutNode: LayoutNode
		private set

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	init {

		val application = this.context.application
		if (application == null) {
			throw Exception("Missing context application controller.")
		}

		this.stylerNode = StylerNode(application.styler, this)
		this.layoutNode = LayoutNode(application.layout)
		this.stylerNode.listener = this
		this.layoutNode.listener = this

		this.content = this.createContentView()
		this.wrapper = this.createWrapperView()
		this.wrapper.container = this

		val scrollable = this.content
		if (scrollable is Scrollable) {
			scrollable.scrollableListener = this
		}

		this.wrapper.draw = fun(cnv: AndroidCanvas) {
			// TODO
			// Pass the instance

			if (this.canvas == null) {
				this.canvas = createCanvas()
			}

			val canvas = this.canvas
			if (canvas == null) {
				return
			}

			canvas.use(cnv)
			this.callMethod("nativeOnRedraw", arrayOf(canvas))
			canvas.use(null)
		}

		this.scheduleUpdate()
	}

	/**
	 * @inherited
	 * @method dispose
	 * @since 0.7.0
	 */
	override fun dispose() {

		if (this.disposed) {
			return
		}

		this.disposed = true

		this.canvas = null
		this.wrapper.removeFromParent()
		this.content.removeFromParent()

		super.dispose()
	}

	/**
	 * Creates the wrapper view.
	 * @method createWrapperView
	 * @since 0.7.0
	 */
	open fun createWrapperView(): WrapperView {
		return WrapperView(this.context.application!!, this.content, this)
	}

	/**
	 * Creates the content view.
	 * @method createContentView
	 * @since 0.7.0
	 */
	open fun createContentView(): AndroidView {
		return View(this.context.application)
	}

	/**
	 * Inserts a view.
	 * @method insert
	 * @since 0.7.0
	 */
	open fun insert(view: JavaScriptView, index: Int, notify: Boolean = true) {

		val parent = this
		var window = this.window

		if (window == null && this is JavaScriptWindow) {
			window = this
		}

		view.moveToParent(parent, notify)
		view.moveToWindow(window, notify)

		this.insertChild(view, index)
	}

	/**
	 * Removes a view.
	 * @method remove
	 * @since 0.7.0
	 */
	open fun remove(view: JavaScriptView, notify: Boolean = true) {

		val index = this.children.indexOf(view)
		if (index == -1) {
			return
		}

		view.moveToParent(null, notify)
		view.moveToWindow(null, notify)

		this.removeChild(view)
	}

	/**
	 * Inserts this view into a receiving view.
	 * @method inject
	 * @since 0.7.0
	 */
	open fun inject(view: JavaScriptView, index: Int, notify: Boolean = true) {

		val parent = this
		var window = this.window

		if (window == null && this is JavaScriptWindow) {
			window = this
		}

		view.moveToParent(parent, notify)
		view.moveToWindow(window, notify)

		this.insertChild(view, index)
	}

	/**
	 * Resolves this view styles and layoutNode.
	 * @method resolve
	 * @since 0.7.0
	 */
	open fun resolve() {
		this.stylerNode.resolve()
		this.layoutNode.resolve()
	}

	/**
	 * Measures this view without performing a layout.
	 * @method measure
	 * @since 0.7.0
	 */
	open fun measure() {
		this.stylerNode.resolve()
		this.layoutNode.measure()
	}

	/**
	 * Returns this view within the specified bounds.
	 * @method measure
	 * @since 0.7.0
	 */
	open fun measure(bounds: SizeF, min: SizeF, max: SizeF): SizeF? {
		return null
	}

	/**
	 * Schedules a layout pass on the next update cycle.
	 * @method scheduleLayout
	 * @since 0.7.0
	 */
	open fun scheduleLayout() {
		this.layoutNode.invalidate()
	}

	/**
	 * Schedules a redraw pass on the next update cycle.
	 * @method scheduleRedraw
	 * @since 0.7.0
	 */
	open fun scheduleRedraw() {

		if (this.drawable.boolean == false) {
			this.drawable.reset(true)
			return
		}

		this.wrapper.scheduleRedraw()
	}

	//--------------------------------------------------------------------------
	// Methods - JavaScriptView updates
	//--------------------------------------------------------------------------

	/**
	 * Schedules an update frame.
	 * @method scheduleUpdate
	 * @since 0.7.0
	 */
	open fun scheduleUpdate() {
		if (this.updateScheduled == false) {
			this.updateScheduled = true
			Synchronizer.main.schedule(this)
		}
	}

	/**
	 * Dispatches the update to the receivers.
	 * @method performUpdate
	 * @since 0.7.0
	 */
	override fun performUpdate() {

		this.update()

		val content = this.content
		if (content is Updatable) {
			content.update()
		}
	}

	/**
	 * Updates the visual aspects of the view.
	 * @method update
	 * @since 0.7.0
	 */
	open fun update() {

		this.resolve()

		if (this.invalidShadow) {
			this.invalidShadow = false
			this.updateShadow()
		}

		if (this.invalidBorder) {
			this.invalidBorder = false
			this.updateBorder()
		}

		if (this.invalidBitmapColor) {
			this.invalidBitmapColor = false
			this.updateBitmapColor()
		}

		if (this.invalidBitmapImage) {
			this.invalidBitmapImage = false
			this.updateBitmapImage()
		}

		if (this.invalidTransform) {
			this.invalidTransform = false
			this.updateTransform()
		}

		if (this.invalidFrame) {
			this.invalidFrame = false
			this.updateFrame()
		}

		this.wrapper.update()

		if (this.invalidContent) {
			this.invalidContent = false
			this.updateContent()
		}

		if (this.invalidOrder) {
			this.invalidOrder = false
			this.updateOrder()
		}

		if (this.wrapper.measured == false && this.resolvedFrame) {
			this.wrapper.measured = true
		}

		this.updateScheduled = false
	}

	/**
	 * Updates the view's frame.
	 * @method updateFrame
	 * @since 0.7.0
	 */
	open fun updateFrame() {

		val t = Convert.toPx(this.resolvedTop)
		val l = Convert.toPx(this.resolvedLeft)
		val w = Convert.toPx(this.resolvedWidth)
		val h = Convert.toPx(this.resolvedHeight)

		this.wrapper.frame = RectF(l, t, l + w, t + h)

		this.resolvedFrame = true
	}

	/**
	 * Updates the view's shadow.
	 * @method updateShadow
	 * @since 0.7.0
	 */
	open fun updateShadow() {
		this.wrapper.shadowColor = this.shadowColor.string.toColor()
		this.wrapper.shadowBlur = Convert.toPx(this.shadowBlur.number)
		this.wrapper.shadowOffsetTop = Convert.toPx(this.shadowOffsetTop.number)
		this.wrapper.shadowOffsetLeft = Convert.toPx(this.shadowOffsetLeft.number)
	}

	/**
	 * Update the view's border.
	 * @method updateBorder
	 * @since 0.7.0
	 */
	open fun updateBorder() {
		this.wrapper.borderTopWidth = Convert.toPx(this.resolvedBorderTopWidth)
		this.wrapper.borderLeftWidth = Convert.toPx(this.resolvedBorderLeftWidth)
		this.wrapper.borderRightWidth = Convert.toPx(this.resolvedBorderRightWidth)
		this.wrapper.borderBottomWidth = Convert.toPx(this.resolvedBorderBottomWidth)
		this.wrapper.borderTopLeftRadius = Convert.toPx(this.borderTopLeftRadius.number)
		this.wrapper.borderTopRightRadius = Convert.toPx(this.borderTopRightRadius.number)
		this.wrapper.borderBottomLeftRadius = Convert.toPx(this.borderBottomLeftRadius.number)
		this.wrapper.borderBottomRightRadius = Convert.toPx(this.borderBottomRightRadius.number)
	}

	/**
	 * Updates the view's background color.
	 * @method updateBitmapColor
	 * @since 0.7.0
	 */
	open fun updateBitmapColor() {

		val isLinearGradient = this.backgroundColor.string.startsWith("linear-gradient")
		val isRadialGradient = this.backgroundColor.string.startsWith("radial-gradient")

		if (isLinearGradient || isRadialGradient) {

			this.wrapper.backgroundKolor = Color.TRANSPARENT

			if (isLinearGradient) {
				this.wrapper.backgroundLinearGradient = LinearGradient(this.backgroundColor.string)
				return
			}

			if (isRadialGradient) {
				this.wrapper.backgroundRadialGradient = RadialGradient(this.backgroundColor.string)
				return
			}

		} else {
			this.wrapper.backgroundKolor = Color.parse(this.backgroundColor.string)
		}
	}

	/**
	 * Updates the view's background image.
	 * @method updateBitmapImage
	 * @since 0.7.0
	 */
	open fun updateBitmapImage() {

		this.wrapper.backgroundImage = null

		val image = this.backgroundImageData
		if (image == null) {
			return
		}

		var autoW = false
		var autoH = false
		var backgroundImageW = 0.0
		var backgroundImageH = 0.0
		var backgroundImageT: Double
		var backgroundImageL: Double

		if (this.backgroundImageWidth.type == JavaScriptPropertyType.STRING &&
			this.backgroundImageWidth.string == "auto") {

			autoW = true

		} else {

			when (this.backgroundImageWidth.unit) {
				JavaScriptPropertyUnit.PC -> backgroundImageW = this.backgroundImageWidth.number / 100 * this.resolvedWidth
				JavaScriptPropertyUnit.VW -> backgroundImageW = this.backgroundImageWidth.number / 100 * this.layoutNode.viewportWidth
				JavaScriptPropertyUnit.VH -> backgroundImageW = this.backgroundImageWidth.number / 100 * this.layoutNode.viewportHeight
				JavaScriptPropertyUnit.PW -> backgroundImageW = this.backgroundImageWidth.number / 100 * this.resolvedInnerWidth
				JavaScriptPropertyUnit.PH -> backgroundImageW = this.backgroundImageWidth.number / 100 * this.resolvedInnerHeight
				JavaScriptPropertyUnit.CW -> backgroundImageW = this.backgroundImageWidth.number / 100 * this.resolvedContentWidth
				JavaScriptPropertyUnit.CH -> backgroundImageW = this.backgroundImageWidth.number / 100 * this.resolvedContentHeight
				else                      -> backgroundImageW = this.backgroundImageWidth.number
			}
		}

		if (this.backgroundImageHeight.type == JavaScriptPropertyType.STRING &&
			this.backgroundImageHeight.string == "auto") {

			autoH = true

		} else {

			when (this.backgroundImageHeight.unit) {
				JavaScriptPropertyUnit.PC -> backgroundImageH = this.backgroundImageHeight.number / 100 * this.resolvedHeight
				JavaScriptPropertyUnit.VW -> backgroundImageH = this.backgroundImageHeight.number / 100 * this.layoutNode.viewportWidth
				JavaScriptPropertyUnit.VH -> backgroundImageH = this.backgroundImageHeight.number / 100 * this.layoutNode.viewportHeight
				JavaScriptPropertyUnit.PW -> backgroundImageH = this.backgroundImageHeight.number / 100 * this.resolvedInnerWidth
				JavaScriptPropertyUnit.PH -> backgroundImageH = this.backgroundImageHeight.number / 100 * this.resolvedInnerHeight
				JavaScriptPropertyUnit.CW -> backgroundImageH = this.backgroundImageHeight.number / 100 * this.resolvedContentWidth
				JavaScriptPropertyUnit.CH -> backgroundImageH = this.backgroundImageHeight.number / 100 * this.resolvedContentHeight
				else                      -> backgroundImageH = this.backgroundImageHeight.number
			}
		}

		when (this.backgroundImageTop.unit) {
			JavaScriptPropertyUnit.PC -> backgroundImageT = this.backgroundImageTop.number / 100 * this.resolvedHeight
			JavaScriptPropertyUnit.VW -> backgroundImageT = this.backgroundImageTop.number / 100 * this.layoutNode.viewportWidth
			JavaScriptPropertyUnit.VH -> backgroundImageT = this.backgroundImageTop.number / 100 * this.layoutNode.viewportHeight
			JavaScriptPropertyUnit.PW -> backgroundImageT = this.backgroundImageTop.number / 100 * this.resolvedInnerWidth
			JavaScriptPropertyUnit.PH -> backgroundImageT = this.backgroundImageTop.number / 100 * this.resolvedInnerHeight
			JavaScriptPropertyUnit.CW -> backgroundImageT = this.backgroundImageTop.number / 100 * this.resolvedContentWidth
			JavaScriptPropertyUnit.CH -> backgroundImageT = this.backgroundImageTop.number / 100 * this.resolvedContentHeight
			else                      -> backgroundImageT = this.backgroundImageTop.number
		}

		when (this.backgroundImageLeft.unit) {
			JavaScriptPropertyUnit.PC -> backgroundImageL = this.backgroundImageLeft.number / 100 * this.resolvedWidth
			JavaScriptPropertyUnit.VW -> backgroundImageL = this.backgroundImageLeft.number / 100 * this.layoutNode.viewportWidth
			JavaScriptPropertyUnit.VH -> backgroundImageL = this.backgroundImageLeft.number / 100 * this.layoutNode.viewportHeight
			JavaScriptPropertyUnit.PW -> backgroundImageL = this.backgroundImageLeft.number / 100 * this.resolvedInnerWidth
			JavaScriptPropertyUnit.PH -> backgroundImageL = this.backgroundImageLeft.number / 100 * this.resolvedInnerHeight
			JavaScriptPropertyUnit.CW -> backgroundImageL = this.backgroundImageLeft.number / 100 * this.resolvedContentWidth
			JavaScriptPropertyUnit.CH -> backgroundImageL = this.backgroundImageLeft.number / 100 * this.resolvedContentHeight
			else                      -> backgroundImageL = this.backgroundImageLeft.number
		}

		val naturalImageW = image.width.toDouble()
		val naturalImageH = image.height.toDouble()

		val frameW = this.resolvedWidth
		val frameH = this.resolvedHeight
		val scaleX = frameW / naturalImageW
		val scaleY = frameH / naturalImageH

		if (autoW && autoH) {

			when (this.backgroundImageFit.string) {

				"none"    -> {
					backgroundImageW = naturalImageW
					backgroundImageH = naturalImageH
				}

				"cover"   -> {
					val scale = Math.max(scaleX, scaleY)
					backgroundImageW = naturalImageW * scale
					backgroundImageH = naturalImageH * scale
				}

				"contain" -> {
					val scale = Math.min(scaleX, scaleY)
					backgroundImageW = naturalImageW * scale
					backgroundImageH = naturalImageH * scale
				}
			}

		} else if (autoW) {
			backgroundImageW = backgroundImageH * (naturalImageW / naturalImageH)
		} else if (autoH) {
			backgroundImageH = backgroundImageW * (naturalImageH / naturalImageW)
		}

		val anchorT = this.getBackgroundImageAnchorTop(this.backgroundImageAnchorTop)
		val anchorL = this.getBackgroundImageAnchorLeft(this.backgroundImageAnchorLeft)

		backgroundImageT = backgroundImageT - (anchorT * backgroundImageH)
		backgroundImageL = backgroundImageL - (anchorL * backgroundImageW)

		this.wrapper.backgroundImage = image
		this.wrapper.backgroundImageTop = Convert.toPx(backgroundImageT)
		this.wrapper.backgroundImageLeft = Convert.toPx(backgroundImageL)
		this.wrapper.backgroundImageWidth = Convert.toPx(backgroundImageW)
		this.wrapper.backgroundImageHeight = Convert.toPx(backgroundImageH)
	}

	/**
	 * Update the view's transform.
	 * @method updateTransform
	 * @since 0.7.0
	 */
	open fun updateTransform() {

		val transform = Transform()

		val viewW = this.resolvedWidth
		val viewH = this.resolvedHeight
		val viewportW = this.layoutNode.viewportWidth
		val viewportH = this.layoutNode.viewportHeight
		val parentW = this.parent?.resolvedInnerWidth ?: 0.0
		val parentH = this.parent?.resolvedInnerHeight ?: 0.0
		val containerW = this.parent?.resolvedContentWidth ?: 0.0
		val containerH = this.parent?.resolvedContentHeight ?: 0.0

		var tx = 0.0
		var ty = 0.0
		val tz = this.translationZ.number

		if (this.translationX.type == JavaScriptPropertyType.NUMBER) {
			when (this.translationX.unit) {
				JavaScriptPropertyUnit.PC -> tx = (this.translationX.number / 100) * viewW
				JavaScriptPropertyUnit.VW -> tx = (this.translationX.number / 100) * viewportW
				JavaScriptPropertyUnit.VH -> tx = (this.translationX.number / 100) * viewportH
				JavaScriptPropertyUnit.PW -> tx = (this.translationX.number / 100) * parentW
				JavaScriptPropertyUnit.PH -> tx = (this.translationX.number / 100) * parentH
				JavaScriptPropertyUnit.CW -> tx = (this.translationX.number / 100) * containerW
				JavaScriptPropertyUnit.CH -> tx = (this.translationX.number / 100) * containerH
				else                      -> tx = this.translationX.number
			}
		}

		if (this.translationY.type == JavaScriptPropertyType.NUMBER) {
			when (this.translationY.unit) {
				JavaScriptPropertyUnit.PC -> ty = (this.translationY.number / 100) * viewH
				JavaScriptPropertyUnit.VW -> ty = (this.translationY.number / 100) * viewportW
				JavaScriptPropertyUnit.VH -> ty = (this.translationY.number / 100) * viewportH
				JavaScriptPropertyUnit.PW -> tx = (this.translationY.number / 100) * parentW
				JavaScriptPropertyUnit.PH -> tx = (this.translationY.number / 100) * parentH
				JavaScriptPropertyUnit.CW -> tx = (this.translationY.number / 100) * containerW
				JavaScriptPropertyUnit.CH -> tx = (this.translationY.number / 100) * containerH
				else                      -> ty = this.translationY.number
			}
		}

		this.resolvedTranslationX = tx
		this.resolvedTranslationY = ty
		this.resolvedTranslationZ = tz

		if (tx != 0.0 || ty != 0.0 || tz != 0.0) {
			transform.translationX = Convert.toPx(tx)
			transform.translationY = Convert.toPx(ty)
			transform.translationZ = Convert.toPx(tz)
		}

		var rx = 0.0
		var ry = 0.0
		var rz = 0.0

		if (this.rotationX.type == JavaScriptPropertyType.NUMBER) {
			when (this.rotationX.unit) {
				JavaScriptPropertyUnit.DEG -> rx = this.rotationX.number * PI / 180
				JavaScriptPropertyUnit.RAD -> rx = this.rotationX.number
				else                       -> rx = this.rotationX.number
			}
		}

		if (this.rotationY.type == JavaScriptPropertyType.NUMBER) {
			when (this.rotationY.unit) {
				JavaScriptPropertyUnit.DEG -> ry = this.rotationY.number * PI / 180
				JavaScriptPropertyUnit.RAD -> ry = this.rotationY.number
				else                       -> ry = this.rotationY.number
			}
		}

		if (this.rotationZ.type == JavaScriptPropertyType.NUMBER) {
			when (this.rotationZ.unit) {
				JavaScriptPropertyUnit.DEG -> rz = this.rotationZ.number * PI / 180
				JavaScriptPropertyUnit.RAD -> rz = this.rotationZ.number
				else                       -> rz = this.rotationZ.number
			}
		}

		this.resolvedTranslationX = tx
		this.resolvedTranslationY = ty
		this.resolvedTranslationZ = tz

		if (rx != 0.0) transform.rotationX = rx.toFloat()
		if (ry != 0.0) transform.rotationY = ry.toFloat()
		if (rz != 0.0) transform.rotationZ = rz.toFloat()

		var sx = 1.0
		var sy = 1.0
		var sz = this.scaleZ.number

		if (this.scaleX.type == JavaScriptPropertyType.NUMBER) sx = this.scaleX.number
		if (this.scaleY.type == JavaScriptPropertyType.NUMBER) sy = this.scaleY.number
		if (this.scaleZ.type == JavaScriptPropertyType.NUMBER) sz = this.scaleZ.number

		if (sx != 1.0 || sy != 1.0 || sz != 1.0) {
			transform.scaleX = sx.toFloat()
			transform.scaleY = sy.toFloat()
			transform.scaleZ = sz.toFloat()
		}

		if (rx != 0.0 || ry != 0.0 || tz != 0.0 || sz != 1.0) {
			// TODO
			// Apply perspective
			//transform.m34 = -1.0 / 500
		}

		this.wrapper.transform = transform
	}

	/**
	 * Update the view's content.
	 * @method updateContent
	 * @since 0.7.0
	 */
	open fun updateContent() {
		this.scrollableView?.scrollWidth = Convert.toPx(this.resolvedContentWidth).toInt()
		this.scrollableView?.scrollHeight = Convert.toPx(this.resolvedContentHeight).toInt()
	}

	/**
	 * Update the view's content order.
	 * @method updateOrder
	 * @since 0.7.0
	 */
	open fun updateOrder() {

		var natural = true
		val ordered = this.children.sortedBy {
			it.zIndex.number
		}

		val map = mutableMapOf<JavaScriptView, Int>()

		for ((index, value) in this.children.withIndex()) {
			map[value] = index
		}

		val ordering = IntArray(ordered.size)

		for (i in 0 until ordered.size) {

			val position = map[ordered[i]]
			if (position == null) {
				continue
			}

			if (position != i) {
				natural = false
			}

			ordering[i] = position
		}

		val content = this.content
		if (content is View) {
			content.ordering = if (natural) null else ordering
		}

		this.naturalOrder = natural
	}

	//--------------------------------------------------------------------------
	// Methods - JavaScriptView Hit Testing
	//--------------------------------------------------------------------------

	/**
	 * Indicates whether the point is contained within this view.
	 * @method isPointInView
	 * @since 0.7.0
	 */
	open fun isPointInView(point: Point3D): Boolean {

		val x = point.x
		val y = point.y

		val w = this.resolvedWidth
		val h = this.resolvedHeight

		val xmin = this.touchOffsetLeft.number
		val ymin = this.touchOffsetTop.number
		val xmax = w + -this.touchOffsetRight.number
		val ymax = h + -this.touchOffsetBottom.number

		return x >= xmin && x <= xmax && y >= ymin && y <= ymax
	}

	/**
	 * Finds the view at the specific point.
	 * @method findViewAt
	 * @since 0.7.0
	 */
	open fun findViewAt(point: Point3D, matrix: Transform3D, visible: Boolean = true, touchable: Boolean = true): JavaScriptView? {

		/*
			Note about overflow:
			Regarding touches, overflow has to be always considered has hidden
			because I'm yet to find an effective solution to handle touches
			outside of the view frame on both iOS and Android.

			Note about decelerating:
			I've noted that on iOS, touches methods are not called when the
			scrollview is decelerating. The side effect is that this view
			in JavaScript may receive a touch start event but no touch cancel
			when a user scrolls. This leads to miss-tap within scroll view.
		*/

		if (this.touchable.boolean == false) {
			return null
		}

		val x = point.x
		val y = point.y

		val a1 = matrix.a1
		val a2 = matrix.a2
		val a3 = matrix.a3
		val a4 = matrix.a4
		val b1 = matrix.b1
		val b2 = matrix.b2
		val b3 = matrix.b3
		val b4 = matrix.b4
		val c1 = matrix.c1
		val c2 = matrix.c2
		val c3 = matrix.c3
		val c4 = matrix.c4
		val d1 = matrix.d1
		val d2 = matrix.d2
		val d3 = matrix.d3
		val d4 = matrix.d4

		if (this.isPointInView(point) == false || (this.scrolling.boolean == true && this.dragging.boolean == false)) {
			return null
		}

		val scrollT = this.scrollTop.number
		val scrollL = this.scrollLeft.number

		val borderWidthT = this.resolvedBorderTopWidth
		val borderWidthL = this.resolvedBorderLeftWidth

		if (this.children.size > 0) {

			val children = this.children.sortedBy {
				it.zIndex.number
			}

			for (i in (0 until children.size).reversed()) {

				val node = children[i]

				if ((node.visible.boolean == false && visible) ||
					(node.touchable.boolean == false && touchable)) {
					continue
				}

				point.x -= node.resolvedLeft + borderWidthL - scrollL
				point.y -= node.resolvedTop + borderWidthT - scrollT

				if (node.isTransformed()) {

					val ox = 0.5
					val oy = 0.5
					val oz = node.originZ.number
					val tx = node.resolvedTranslationX
					val ty = node.resolvedTranslationY
					val tz = node.resolvedTranslationZ
					val rx = node.resolvedRotationX
					val ry = node.resolvedRotationY
					val rz = node.resolvedRotationZ
					val sx = node.scaleX.number
					val sy = node.scaleY.number
					val sz = node.scaleZ.number

					if (ox != 0.0 ||
						oy != 0.0 ||
						oz != 0.0) {
						matrix.translate(
							ox,
							oy,
							oz
						)
					}

					if (rx != 0.0) matrix.rotate(1.0, 0.0, 0.0, -rx)
					if (ry != 0.0) matrix.rotate(0.0, 1.0, 0.0, -ry)
					if (rz != 0.0) matrix.rotate(0.0, 0.0, 1.0, -rz)

					if (sx != 1.0 ||
						sy != 1.0 ||
						sz != 1.0) {
						matrix.scale(
							1 / sx,
							1 / sy,
							1 / sz
						)
					}

					if (ox != 0.0 ||
						oy != 0.0 ||
						oz != 0.0) {
						matrix.translate(
							-ox,
							-oy,
							-oz
						)
					}

					if (tx != 0.0 ||
						ty != 0.0 ||
						tz != 0.0) {
						matrix.translate(
							-tx,
							-ty,
							-tz
						)
					}

					if (tz != 0.0 ||
						rz != 0.0 ||
						sz != 1.0) {
						matrix.perspective(-800.0)
					}

					matrix.transform(point)
				}

				val result = node.findViewAt(point, matrix, visible, touchable)

				matrix.a1 = a1
				matrix.a2 = a2
				matrix.a3 = a3
				matrix.a4 = a4
				matrix.b1 = b1
				matrix.b2 = b2
				matrix.b3 = b3
				matrix.b4 = b4
				matrix.c1 = c1
				matrix.c2 = c2
				matrix.c3 = c3
				matrix.c4 = c4
				matrix.d1 = d1
				matrix.d2 = d2
				matrix.d3 = d3
				matrix.d4 = d4

				point.x = x
				point.y = y

				if (result != null) {
					return result
				}
			}
		}

		return this
	}

	/**
	 * Creates the canvas object used to draw inside this view.
	 * @method createCanvas
	 * @since 0.7.0
	 */
	open fun createCanvas(): JavaScriptCanvas? {
		return null // TODO FIXME
	}

	//--------------------------------------------------------------------------
	// Methods - Layout Node Delegate
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method prepareLayoutNode
	 * @since 0.7.0
	 */
	override fun prepareLayoutNode(node: LayoutNode) {
		this.stylerNode.resolve()
	}

	/**
	 * @inherited
	 * @method measureLayoutNode
	 * @since 0.7.0
	 */
	override fun measureLayoutNode(node: LayoutNode, bounds: SizeF, min: SizeF, max: SizeF): SizeF? {
		return this.measure(bounds, min, max)
	}

	/**
	 * @inherited
	 * @method onResolveSize
	 * @since 0.7.0
	 */
	override fun onResolveSize(node: LayoutNode) {

		if (this.resolvedWidth != this.layoutNode.measuredWidth) {
			this.resolvedWidth = this.layoutNode.measuredWidth
			this.measuredWidth.reset(null)
			this.invalidateFrame()
		}

		if (this.resolvedHeight != this.layoutNode.measuredHeight) {
			this.resolvedHeight = this.layoutNode.measuredHeight
			this.measuredHeight.reset(null)
			this.invalidateFrame()
		}
	}

	/**
	 * @inherited
	 * @method onResolvePosition
	 * @since 0.7.0
	 */
	override fun onResolvePosition(node: LayoutNode) {

		if (this.resolvedTop != this.layoutNode.measuredTop) {
			this.resolvedTop = this.layoutNode.measuredTop
			this.measuredTop.reset(null)
			this.invalidateFrame()
		}

		if (this.resolvedLeft != this.layoutNode.measuredLeft) {
			this.resolvedLeft = this.layoutNode.measuredLeft
			this.measuredLeft.reset(null)
			this.invalidateFrame()
		}
	}

	/**
	 * @inherited
	 * @method onResolveInnerSize
	 * @since 0.7.0
	 */
	override fun onResolveInnerSize(node: LayoutNode) {

		if (this.resolvedInnerWidth != this.layoutNode.measuredInnerWidth) {
			this.resolvedInnerWidth = this.layoutNode.measuredInnerWidth
			this.measuredInnerWidth.reset(null)
			this.invalidateFrame()
		}

		if (this.resolvedInnerHeight != this.layoutNode.measuredInnerHeight) {
			this.resolvedInnerHeight = this.layoutNode.measuredInnerHeight
			this.measuredInnerHeight.reset(null)
			this.invalidateFrame()
		}
	}

	/**
	 * @inherited
	 * @method onResolveContentSize
	 * @since 0.7.0
	 */
	override fun onResolveContentSize(node: LayoutNode) {

		if (this.resolvedContentWidth != this.layoutNode.measuredContentWidth) {
			this.resolvedContentWidth = this.layoutNode.measuredContentWidth
			this.measuredContentWidth.reset(null)
			this.invalidateContent()
		}

		if (this.resolvedContentHeight != this.layoutNode.measuredContentHeight) {
			this.resolvedContentHeight = this.layoutNode.measuredContentHeight
			this.measuredContentHeight.reset(null)
			this.invalidateContent()
		}
	}

	/**
	 * @inherited
	 * @method onResolveMargin
	 * @since 0.7.0
	 */
	override fun onResolveMargin(node: LayoutNode) {

		if (this.resolvedMarginTop != this.layoutNode.measuredMarginTop) {
			this.resolvedMarginTop = this.layoutNode.measuredMarginTop
			this.measuredMarginTop.reset(null)
		}

		if (this.resolvedMarginLeft != this.layoutNode.measuredMarginLeft) {
			this.resolvedMarginLeft = this.layoutNode.measuredMarginLeft
			this.measuredMarginLeft.reset(null)
		}

		if (this.resolvedMarginRight != this.layoutNode.measuredMarginRight) {
			this.resolvedMarginRight = this.layoutNode.measuredMarginRight
			this.measuredMarginRight.reset(null)
		}

		if (this.resolvedMarginBottom != this.layoutNode.measuredMarginBottom) {
			this.resolvedMarginBottom = this.layoutNode.measuredMarginBottom
			this.measuredMarginBottom.reset(null)
		}
	}

	/**
	 * @inherited
	 * @method onResolveBorder
	 * @since 0.7.0
	 */
	override fun onResolveBorder(node: LayoutNode) {

		if (this.resolvedBorderTopWidth != this.layoutNode.measuredBorderTop) {
			this.resolvedBorderTopWidth = this.layoutNode.measuredBorderTop
			this.measuredBorderTopWidth.reset(null)
			this.invalidateBorder()
		}

		if (this.resolvedBorderLeftWidth != this.layoutNode.measuredBorderLeft) {
			this.resolvedBorderLeftWidth = this.layoutNode.measuredBorderLeft
			this.measuredBorderLeftWidth.reset(null)
			this.invalidateBorder()
		}

		if (this.resolvedBorderRightWidth != this.layoutNode.measuredBorderRight) {
			this.resolvedBorderRightWidth = this.layoutNode.measuredBorderRight
			this.measuredBorderRightWidth.reset(null)
			this.invalidateBorder()
		}

		if (this.resolvedBorderBottomWidth != this.layoutNode.measuredBorderBottom) {
			this.resolvedBorderBottomWidth = this.layoutNode.measuredBorderBottom
			this.measuredBorderBottomWidth.reset(null)
			this.invalidateBorder()
		}
	}

	/**
	 * @inherited
	 * @method onResolvePadding
	 * @since 0.7.0
	 */
	override fun onResolvePadding(node: LayoutNode) {

		if (this.resolvedPaddingTop != this.layoutNode.measuredPaddingTop) {
			this.resolvedPaddingTop = this.layoutNode.measuredPaddingTop
			this.measuredPaddingTop.reset(null)
		}

		if (this.resolvedPaddingLeft != this.layoutNode.measuredPaddingLeft) {
			this.resolvedPaddingLeft = this.layoutNode.measuredPaddingLeft
			this.measuredPaddingLeft.reset(null)
		}

		if (this.resolvedPaddingRight != this.layoutNode.measuredPaddingRight) {
			this.resolvedPaddingRight = this.layoutNode.measuredPaddingRight
			this.measuredPaddingRight.reset(null)
		}

		if (this.resolvedPaddingBottom != this.layoutNode.measuredPaddingBottom) {
			this.resolvedPaddingBottom = this.layoutNode.measuredPaddingBottom
			this.measuredPaddingBottom.reset(null)
		}
	}

	/**
	 * @inherited
	 * @method onInvalidateLayout
	 * @since 0.7.0
	 */
	override fun onInvalidateLayout(node: LayoutNode) {
		this.scheduleUpdate()
	}

	/**
	 * @inherited
	 * @method onBeginLayout
	 * @since 0.7.0
	 */
	override fun onBeginLayout(node: LayoutNode) {
		this.listener?.onBeginLayout(this)
		this.callMethod("nativeOnLayoutBegan")
	}

	/**
	 * @inherited
	 * @method onFinishLayout
	 * @since 0.7.0
	 */
	override fun onFinishLayout(node: LayoutNode) {

		if (this.invalidFrame == false) {

			/*
 			 * Its possible the content view itself triggered the layout. In this case the
 			 * frame is most likely not to change. However, the onMeasure and onLayout methods
 			 * will have to be called
			 */

			val t = this.wrapper.top
			val l = this.wrapper.left
			val r = this.wrapper.right
			val b = this.wrapper.bottom

			this.wrapper.layout(l, t, r, b)

			val contentT = this.content.top
			val contentL = this.content.left
			val contentW = this.content.width
			val contentH = this.content.height

			this.content.measure(
				AndroidView.MeasureSpec.makeMeasureSpec(contentW, AndroidView.MeasureSpec.EXACTLY),
				AndroidView.MeasureSpec.makeMeasureSpec(contentH, AndroidView.MeasureSpec.EXACTLY)
			)

			this.content.layout(
				contentL,
				contentT,
				contentL + contentW,
				contentT + contentH
			)
		}

		this.listener?.onFinishLayout(this)
		this.callMethod("nativeOnLayoutFinished")
	}

	//--------------------------------------------------------------------------
	// Methods - Styler Node
	//--------------------------------------------------------------------------

	/**
	 * @method onInvalidateStyleNode
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onInvalidateStyleNode(node: StylerNode) {
		this.scheduleUpdate()
	}

	//--------------------------------------------------------------------------
	// Methods - Content JavaScriptView Observer
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onDragStart
	 * @since 0.7.0
	 */
	override fun onDragStart(scrollable: Scrollable) {
		this.dragging.reset(true)
		this.callMethod("nativeOnDragStart")
	}

	/**
	 * @inherited
	 * @method onDragEnd
	 * @since 0.7.0
	 */
	override fun onDragEnd(scrollable: Scrollable) {
		this.dragging.reset(false)
		this.callMethod("nativeOnDragEnd")
	}

	/**
	 * @method onDrag
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onDrag(scrollable: Scrollable) {
		this.callMethod("nativeOnDrag")
	}

	/**
	 * @method onScrollStart
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onScrollStart(scrollable: Scrollable) {
		this.scrolling.reset(true)
		this.callMethod("nativeOnScrollStart")
	}

	/**
	 * @method onScrollEnd
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onScrollEnd(scrollable: Scrollable) {
		this.scrolling.reset(false)
		this.callMethod("nativeOnScrollEnd")
	}

	/**
	 * @method onScroll
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onScroll(scrollable: Scrollable, top: Int, left: Int) {

		val scrollT = Convert.toDp(top).toDouble()
		val scrollL = Convert.toDp(left).toDouble()

		if (scrollT == this.scrollTop.number &&
			scrollL == this.scrollLeft.number) {
			return
		}

		this.scrollTop.reset(scrollT)
		this.scrollLeft.reset(scrollL)

		this.listener?.onScroll(this)

		this.callMethod("nativeOnScroll")
	}

	/**
	 * @method onZoomStart
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onZoomStart(scrollable: Scrollable) {
		this.callMethod("nativeOnZoomStart")
	}

	/**
	 * @method onZoomEnd
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onZoomEnd(scrollable: Scrollable, scale: Float) {
		this.callMethod("nativeOnZoomEnd", arrayOf(this.context.createNumber(scale)))
	}

	/**
	 * @method onZoom
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onZoom(scrollable: Scrollable) {
		this.callMethod("nativeOnZoom")
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property scrollableView
	 * @since 0.7.0
	 * @hidden
	 */
	private val scrollableView: Scrollable?
		get() = this.content as? Scrollable

	/**
	 * @property backgroundImageData
	 * @since 0.7.0
	 * @hidden
	 */
	private var backgroundImageData: Bitmap? by Delegates.OnSetOptional<Bitmap>(null) {
		this.invalidateBitmapImage()
	}

	/**
	 * @property backgroundImageLoader
	 * @since 0.7.0
	 * @hidden
	 */
	private var backgroundImageLoader: ImageLoader = ImageLoader(context.application) // TODO make image loader using static method

	/**
	 * @property canvas
	 * @since 0.7.0
	 * @hidden
	 */
	private var canvas: JavaScriptCanvas? = null

	/**
	 * @property updateScheduled
	 * @since 0.7.0
	 * @hidden
	 */
	private var updateScheduled: Boolean = false

	/**
	 * @property invalidFrame
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidFrame: Boolean = false

	/**
	 * @property invalidShadow
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidShadow: Boolean = false

	/**
	 * @property invalidBorder
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidBorder: Boolean = false

	/**
	 * @property invalidBitmapColor
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidBitmapColor: Boolean = false

	/**
	 * @property invalidBitmapImage
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidBitmapImage: Boolean = false

	/**
	 * @property invalidTransform
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidTransform: Boolean = false

	/**
	 * @property invalidContent
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidContent: Boolean = false

	/**
	 * @property invalidOrder
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidOrder: Boolean = false

	/**
	 * @property naturalOrder
	 * @since 0.7.0
	 * @hidden
	 */
	private var naturalOrder: Boolean = true

	/**
	 * @property disposed
	 * @since 0.7.0
	 * @hidden
	 */
	private var disposed: Boolean = false

	/**
	 * @property ordered
	 * @since 0.7.0
	 * @hidden
	 */
	private val ordered: Boolean
		get() = this.zIndex.number != 0.0

	/**
	 * @method insertChild
	 * @since 0.7.0
	 * @hidden
	 */
	private fun insertChild(view: JavaScriptView, index: Int) {

		this.children.add(index, view)
		this.stylerNode.insertChild(view.stylerNode, index)
		this.layoutNode.insertChild(view.layoutNode, index)

		this.content.addView(view.wrapper, index)

		if (this.isShadowRoot) {
			view.updateShadowRoot(this)
		} else {
			view.updateShadowRoot(this.shadowRoot)
		}

		this.invalidateOrderIfNeeded(view)
	}

	/**
	 * @method removeChild
	 * @since 0.7.0
	 * @hidden
	 */
	private fun removeChild(view: JavaScriptView) {

		this.children.remove(view)
		this.stylerNode.removeChild(view.stylerNode)
		this.layoutNode.removeChild(view.layoutNode)

		val content = this.content
		if (content is AndroidViewGroup) {
			content.removeView(view.wrapper)
		}

		view.updateShadowRoot(null)

		this.invalidateOrderIfNeeded()
	}

	/**
	 * @method moveToParent
	 * @since 0.7.0
	 * @hidden
	 */
	private fun moveToParent(parent: JavaScriptView?, notify: Boolean = true) {

		this.parent = parent

		if (notify) {
			this.callMethod("nativeOnMoveToParent", arrayOf(parent))
		}
	}

	/**
	 * @method moveToWindow
	 * @since 0.7.0
	 * @hidden
	 */
	private fun moveToWindow(window: JavaScriptWindow?, notify: Boolean = true) {

		this.window = window

		if (notify) {
			this.callMethod("nativeOnMoveToWindow", arrayOf(window))
		}

		this.children.forEach {
			it.moveToWindow(window)
		}
	}

	/**
	 * @method invalidateFrame
	 * @since 0.7.0
	 * @hidden
	 */
	internal open fun invalidateFrame() {

		if (this.invalidFrame == false) {
			this.invalidFrame = true
			this.scheduleUpdate()
		}

		if (this.translationX.unit.isRelativeToParent() ||
			this.translationY.unit.isRelativeToParent()) {
			this.invalidateTransform()
		}

		if (this.backgroundImageTop.unit.isRelativeToParent() ||
			this.backgroundImageLeft.unit.isRelativeToParent() ||
			this.backgroundImageWidth.unit.isRelativeToParent() ||
			this.backgroundImageHeight.unit.isRelativeToParent()) {
			this.invalidateBitmapImage()
		}
	}

	/**
	 * @method invalidateShadow
	 * @since 0.7.0
	 * @hidden
	 */
	internal open fun invalidateShadow() {
		if (this.invalidShadow == false) {
			this.invalidShadow = true
			this.scheduleUpdate()
		}
	}

	/**
	 * @method invalidateBorder
	 * @since 0.7.0
	 * @hidden
	 */
	internal open fun invalidateBorder() {
		if (this.invalidBorder == false) {
			this.invalidBorder = true
			this.scheduleUpdate()
		}
	}

	/**
	 * @method invalidateBitmapColor
	 * @since 0.7.0
	 * @hidden
	 */
	internal open fun invalidateBitmapColor() {
		if (this.invalidBitmapColor == false) {
			this.invalidBitmapColor = true
			this.scheduleUpdate()
		}
	}

	/**
	 * @method invalidateBitmapImage
	 * @since 0.7.0
	 * @hidden
	 */
	internal open fun invalidateBitmapImage() {
		if (this.invalidBitmapImage == false) {
			this.invalidBitmapImage = true
			this.scheduleUpdate()
		}
	}

	/**
	 * @method invalidateTransform
	 * @since 0.7.0
	 * @hidden
	 */
	internal open fun invalidateTransform() {
		if (this.invalidTransform == false) {
			this.invalidTransform = true
			this.scheduleUpdate()
		}
	}

	/**
	 * @method invalidateContent
	 * @since 0.7.0
	 * @hidden
	 */
	internal open fun invalidateContent() {
		if (this.invalidContent == false) {
			this.invalidContent = true
			this.scheduleUpdate()
		}
	}

	/**
	 * @method invalidateOrder
	 * @since 0.7.0
	 * @hidden
	 */
	internal open fun invalidateOrder() {
		if (this.invalidOrder == false) {
			this.invalidOrder = true
			this.naturalOrder = false
			this.scheduleUpdate()
		}
	}

	/**
	 * @method invalidateOrderIfNeeded
	 * @since 0.7.0
	 * @hidden
	 */
	internal open fun invalidateOrderIfNeeded(view: JavaScriptView) {
		if (this.naturalOrder == false || view.ordered) {
			this.invalidateOrder()
		}
	}

	/**
	 * @method invalidateOrderIfNeeded
	 * @since 0.7.0
	 * @hidden
	 */
	internal open fun invalidateOrderIfNeeded() {
		if (this.naturalOrder == false) {
			this.invalidateOrder()
		}
	}

	/**
	 * @method updateShadowRoot
	 * @since 0.7.0
	 * @hidden
	 */
	private fun updateShadowRoot(root: JavaScriptView?) {

		this.shadowRoot = root

		if (this.isShadowRoot == false) {
			this.children.forEach {
				it.updateShadowRoot(root)
			}
		}
	}

	/**
	 * @method appendShadowedView
	 * @since 0.7.0
	 * @hidden
	 */
	private fun appendShadowedView(view: JavaScriptView) {
		this.shadowed.add(view)
		this.stylerNode.appendShadowedNode(view.stylerNode)
	}

	/**
	 * @method removeShadowedView
	 * @since 0.7.0
	 * @hidden
	 */
	private fun removeShadowedView(view: JavaScriptView) {
		this.shadowed.remove(view)
		this.stylerNode.removeShadowedNode(view.stylerNode)
	}

	/**
	 * @method isTransformed
	 * @since 0.7.0
	 * @hidden
	 */
	private fun isTransformed(): Boolean {
		return (
			this.resolvedTranslationX != 0.0 ||
				this.resolvedTranslationY != 0.0 ||
				this.resolvedTranslationZ != 0.0 ||
				this.resolvedRotationX != 0.0 ||
				this.resolvedRotationY != 0.0 ||
				this.resolvedRotationZ != 0.0 ||
				this.scaleX.number != 1.0 ||
				this.scaleY.number != 1.0 ||
				this.scaleZ.number != 1.0
			)
	}

	//--------------------------------------------------------------------------
	// Private API - Conversions
	//--------------------------------------------------------------------------

	/**
	 * @method getBackgroundImageAnchorTop
	 * @since 0.7.0
	 * @hidden
	 */
	private fun getBackgroundImageAnchorTop(prop: JavaScriptProperty): Double {

		if (prop.type == JavaScriptPropertyType.STRING) {

			when (prop.string) {

				"top"    -> return 0.0
				"center" -> return 0.5
				"bottom" -> return 1.0

				else     -> {
					Log.d("Dezel", "Unrecognized toValue for backgroundImageAnchorTop: ${prop.string}")
				}
			}
		}

		return prop.number
	}

	/**
	 * @method getBackgroundImageAnchorLeft
	 * @since 0.7.0
	 * @hidden
	 */
	private fun getBackgroundImageAnchorLeft(prop: JavaScriptProperty): Double {

		if (prop.type == JavaScriptPropertyType.STRING) {

			when (prop.string) {

				"left"   -> return 0.0
				"center" -> return 0.5
				"right"  -> return 1.0

				else     -> {
					Log.d("Dezel", "Unrecognized toValue for getBackgroundImageAnchorLeft: ${prop.string}")
				}
			}
		}

		return prop.number
	}

	//--------------------------------------------------------------------------
	// JS Properties
	//--------------------------------------------------------------------------

	/**
	 * The view's id.
	 * @property id
	 * @since 0.7.0
	 */
	public val id by lazy {
		JavaScriptProperty("")
	}

	/**
	 * The view's background color.
	 * @property backgroundColor
	 * @since 0.7.0
	 */
	public val backgroundColor by lazy {
		JavaScriptProperty("transparent") {
			this.invalidateBitmapColor()
		}
	}

	/**
	 * The view's background image.
	 * @property backgroundImage
	 * @since 0.7.0
	 */
	public val backgroundImage by lazy {
		JavaScriptProperty() { value ->
			this.backgroundImageLoader.load(value) { image ->
				this.backgroundImageData = image
				// TODO FIXME WAT
			}
		}
	}

	/**
	 * The view's background image container fit.
	 * @property backgroundImageFit
	 * @since 0.7.0
	 */
	public val backgroundImageFit by lazy {
		JavaScriptProperty("cover") {
			this.invalidateBitmapImage()
		}
	}

	/**
	 * The view's background image top anchor.
	 * @property backgroundImageAnchorTop
	 * @since 0.7.0
	 */
	public val backgroundImageAnchorTop by lazy {
		JavaScriptProperty(0.5) {
			this.invalidateBitmapImage()
		}
	}

	/**
	 * The view's background image left anchor.
	 * @property backgroundImageAnchorLeft
	 * @since 0.7.0
	 */
	public val backgroundImageAnchorLeft by lazy {
		JavaScriptProperty(0.5) {
			this.invalidateBitmapImage()
		}
	}

	/**
	 * The view's background image top position.
	 * @property backgroundImageTop
	 * @since 0.7.0
	 */
	public val backgroundImageTop by lazy {
		JavaScriptProperty(50.0, JavaScriptPropertyUnit.PC) {
			this.invalidateBitmapImage()
		}
	}

	/**
	 * The view's background image left position.
	 * @property backgroundImageLeft
	 * @since 0.7.0
	 */
	public val backgroundImageLeft by lazy {
		JavaScriptProperty(50.0, JavaScriptPropertyUnit.PC) {
			this.invalidateBitmapImage()
		}
	}

	/**
	 * The view's background image width.
	 * @property backgroundImageWidth
	 * @since 0.7.0
	 */
	public val backgroundImageWidth by lazy {
		JavaScriptProperty("auto") {
			this.invalidateBitmapImage()
		}
	}

	/**
	 * The view's background image height.
	 * @property backgroundImageHeight
	 * @since 0.7.0
	 */
	public val backgroundImageHeight by lazy {
		JavaScriptProperty("auto") {
			this.invalidateBitmapImage()
		}
	}

	/**
	 * The view's background image imageTint.
	 * @property backgroundImageTint
	 * @since 0.7.0
	 */
	public val backgroundImageTint by lazy {
		JavaScriptProperty("auto") { value ->
			this.wrapper.backgroundImageTint = value.string.toColor()
		}
	}

	/**
	 * The view's border.
	 * @property border
	 * @since 0.7.0
	 */
	public val border by lazy {

		JavaScriptProperty("0 #000") { value ->

			val components = value.string.split(spaces)
			if (components.size < 2) {
				return@JavaScriptProperty
			}

			val width = components[0].trim()
			val color = components[1].trim()

			JavaScriptPropertyParser.parse(width).let {
				if (it.isNumber) {
					this.borderTopWidth.reset(it.number, it.unit)
					this.borderLeftWidth.reset(it.number, it.unit)
					this.borderRightWidth.reset(it.number, it.unit)
					this.borderBottomWidth.reset(it.number, it.unit)
				}
			}

			this.borderTopColor.reset(color)
			this.borderLeftColor.reset(color)
			this.borderRightColor.reset(color)
			this.borderBottomColor.reset(color)
		}
	}

	/**
	 * The view's top border.
	 * @property borderTop
	 * @since 0.7.0
	 */
	public val borderTop by lazy {

		JavaScriptProperty("0 #000") { value ->

			val components = value.string.split(spaces)
			if (components.size < 2) {
				return@JavaScriptProperty
			}

			this.borderTopWidth.parse(components[0].trim())
			this.borderTopColor.reset(components[1].trim())
		}
	}

	/**
	 * The view's left border.
	 * @property borderLeft
	 * @since 0.7.0
	 */
	public val borderLeft by lazy {

		JavaScriptProperty("0 #000") { value ->

			val components = value.string.split(spaces)
			if (components.size < 2) {
				return@JavaScriptProperty
			}

			this.borderLeftWidth.parse(components[0].trim())
			this.borderLeftColor.reset(components[1].trim())
		}
	}

	/**
	 * The view's right border.
	 * @property borderRight
	 * @since 0.7.0
	 */
	public val borderRight by lazy {

		JavaScriptProperty("0 #000") { value ->

			val components = value.string.split(spaces)
			if (components.size < 2) {
				return@JavaScriptProperty
			}

			this.borderRightWidth.parse(components[0].trim())
			this.borderRightColor.reset(components[1].trim())
		}
	}

	/**
	 * The view's bottom border.
	 * @property borderBottom
	 * @since 0.7.0
	 */
	public val borderBottom by lazy {

		JavaScriptProperty("0 #000") { value ->

			val components = value.string.split(spaces)
			if (components.size < 2) {
				return@JavaScriptProperty
			}

			this.borderBottomWidth.parse(components[0].trim())
			this.borderBottomColor.reset(components[1].trim())
		}
	}

	/**
	 * The view's border width.
	 * @property borderWidth
	 * @since 0.7.0
	 */
	public val borderWidth by lazy {
		JavaScriptProperty(0.0) { value ->
			this.borderTopWidth.reset(value.number, value.unit)
			this.borderLeftWidth.reset(value.number, value.unit)
			this.borderRightWidth.reset(value.number, value.unit)
			this.borderBottomWidth.reset(value.number, value.unit)
		}
	}

	/**
	 * The view's border color.
	 * @property borderColor
	 * @since 0.7.0
	 */
	public val borderColor by lazy {
		JavaScriptProperty("#000") { value ->
			this.borderTopColor.reset(value.string)
			this.borderLeftColor.reset(value.string)
			this.borderRightColor.reset(value.string)
			this.borderBottomColor.reset(value.string)
		}
	}

	/**
	 * The view's border top color.
	 * @property borderTopColor
	 * @since 0.7.0
	 */
	public val borderTopColor by lazy {
		JavaScriptProperty("#000") { value ->
			this.wrapper.borderTopColor = Color.parse(value.string)
		}
	}

	/**
	 * The view's border left color.
	 * @property borderLeftColor
	 * @since 0.7.0
	 */
	public val borderLeftColor by lazy {
		JavaScriptProperty("#000") { value ->
			this.wrapper.borderLeftColor = Color.parse(value.string)
		}
	}

	/**
	 * The view's border right color.
	 * @property borderRightColor
	 * @since 0.7.0
	 */
	public val borderRightColor by lazy {
		JavaScriptProperty("#000") { value ->
			this.wrapper.borderRightColor = Color.parse(value.string)
		}
	}

	/**
	 * The view's border bottom color.
	 * @property borderBottomColor
	 * @since 0.7.0
	 */
	public val borderBottomColor by lazy {
		JavaScriptProperty("#000") { value ->
			this.wrapper.borderBottomColor = Color.parse(value.string)
		}
	}

	/**
	 * The view's border top width.
	 * @property borderTopWidth
	 * @since 0.7.0
	 */
	public val borderTopWidth by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.borderTop(value)
		}
	}

	/**
	 * The view's border left width.
	 * @property borderLeftWidth
	 * @since 0.7.0
	 */
	public val borderLeftWidth by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.borderLeft(value)
		}
	}

	/**
	 * The view's border right width.
	 * @property borderRightWidth
	 * @since 0.7.0
	 */
	public val borderRightWidth by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.borderRight(value)
		}
	}

	/**
	 * The view's border bottom width.
	 * @property borderBottomWidth
	 * @since 0.7.0
	 */
	public val borderBottomWidth by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.borderBottom(value)
		}
	}

	/**
	 * The view's absolute minimum border top width.
	 * @property minBorderTopWidth
	 * @since 0.7.0
	 */
	public val minBorderTopWidth by lazy {
		JavaScriptProperty(0.0) {
			// TODO
		}
	}

	/**
	 * The view's absolute maximum border top width.
	 * @property maxBorderTopWidth
	 * @since 0.7.0
	 */
	public val maxBorderTopWidth by lazy {
		JavaScriptProperty(Double.max) {
			// TODO
		}
	}

	/**
	 * The view's absolute minimum border left width.
	 * @property minBorderLeftWidth
	 * @since 0.7.0
	 */
	public val minBorderLeftWidth by lazy {
		JavaScriptProperty(0.0) {
			// TODO
		}
	}

	/**
	 * The view's absolute maximum border left width.
	 * @property maxBorderLeftWidth
	 * @since 0.7.0
	 */
	public val maxBorderLeftWidth by lazy {
		JavaScriptProperty(Double.max) {
			// TODO
		}
	}

	/**
	 * The view's absolute minimum border right width.
	 * @property minBorderRightWidth
	 * @since 0.7.0
	 */
	public val minBorderRightWidth by lazy {
		JavaScriptProperty(0.0) {
			// TODO
		}
	}

	/**
	 * The view's absolute maximum border right width.
	 * @property maxBorderRightWidth
	 * @since 0.7.0
	 */
	public val maxBorderRightWidth by lazy {
		JavaScriptProperty(Double.max) {
			// TODO
		}
	}

	/**
	 * The view's absolute minimum border bottom width.
	 * @property minBorderBottomWidth
	 * @since 0.7.0
	 */
	public val minBorderBottomWidth by lazy {
		JavaScriptProperty(0.0) {
			// TODO
		}
	}

	/**
	 * The view's absolute maximum border bottom width.
	 * @property maxBorderBottomWidth
	 * @since 0.7.0
	 */
	public val maxBorderBottomWidth by lazy {
		JavaScriptProperty(Double.max) {
			// TODO
		}
	}

	/**
	 * The view's border radius.
	 * @property borderRadius
	 * @since 0.7.0
	 */
	public val borderRadius by lazy {
		JavaScriptProperty(0.0) { value ->
			this.borderTopLeftRadius.reset(value.number)
			this.borderTopRightRadius.reset(value.number)
			this.borderBottomLeftRadius.reset(value.number)
			this.borderBottomRightRadius.reset(value.number)
		}
	}

	/**
	 * The view's border top left corner radius.
	 * @property borderTopLeftRadius
	 * @since 0.7.0
	 */
	public val borderTopLeftRadius by lazy {
		JavaScriptProperty(0.0) {
			this.invalidateBorder()
		}
	}

	/**
	 * The view's border top right corner radius.
	 * @property borderTopRightRadius
	 * @since 0.7.0
	 */
	public val borderTopRightRadius by lazy {
		JavaScriptProperty(0.0) {
			this.invalidateBorder()
		}
	}

	/**
	 * The view's border bottom left corner radius.
	 * @property borderBottomLeftRadius
	 * @since 0.7.0
	 */
	public val borderBottomLeftRadius by lazy {
		JavaScriptProperty(0.0) {
			this.invalidateBorder()
		}
	}

	/**
	 * The view's border bottom right corner radius.
	 * @property borderBottomRightRadius
	 * @since 0.7.0
	 */
	public val borderBottomRightRadius by lazy {
		JavaScriptProperty(0.0) {
			this.invalidateBorder()
		}
	}

	/**
	 * The view's shadow blur distance.
	 * @property shadowBlur
	 * @since 0.7.0
	 */
	public val shadowBlur by lazy {
		JavaScriptProperty(0.0) {
			this.invalidateShadow()
		}
	}

	/**
	 * The view's shadow color.
	 * @property shadowColor
	 * @since 0.7.0
	 */
	public val shadowColor by lazy {
		JavaScriptProperty("#000") {
			this.invalidateShadow()
		}
	}

	/**
	 * The view's shadow's top offset.
	 * @property shadowOffsetTop
	 * @since 0.7.0
	 */
	public val shadowOffsetTop by lazy {
		JavaScriptProperty(0.0) {
			this.invalidateShadow()
		}
	}

	/**
	 * The view's shadow's left offset.
	 * @property shadowOffsetLeft
	 * @since 0.7.0
	 */
	public val shadowOffsetLeft by lazy {
		JavaScriptProperty(0.0) {
			this.invalidateShadow()
		}
	}

	/**
	 * The view's top position.
	 * @property top
	 * @since 0.7.0
	 */
	public val top by lazy {
		JavaScriptProperty("auto") { value ->
			this.layoutNode.top(value)
		}
	}

	/**
	 * The view's left position.
	 * @property left
	 * @since 0.7.0
	 */
	public val left by lazy {
		JavaScriptProperty("auto") { value ->
			this.layoutNode.left(value)
		}
	}

	/**
	 * The view's right position.
	 * @property right
	 * @since 0.7.0
	 */
	public val right by lazy {
		JavaScriptProperty("auto") { value ->
			this.layoutNode.right(value)
		}
	}

	/**
	 * The view's bottom position.
	 * @property bottom
	 * @since 0.7.0
	 */
	public val bottom by lazy {
		JavaScriptProperty("auto") { value ->
			this.layoutNode.bottom(value)
		}
	}

	/**
	 * The view's absolute minimum top position.
	 * @property minTop
	 * @since 0.7.0
	 */
	public val minTop by lazy {
		JavaScriptProperty(Double.min) { value ->
			this.layoutNode.minTop(value.number)
		}
	}

	/**
	 * The view's absolute maximum top position.
	 * @property maxTop
	 * @since 0.7.0
	 */
	public val maxTop by lazy {
		JavaScriptProperty(Double.max) { value ->
			this.layoutNode.maxTop(value.number)
		}
	}

	/**
	 * The view's absolute minimum left position.
	 * @property minLeft
	 * @since 0.7.0
	 */
	public val minLeft by lazy {
		JavaScriptProperty(Double.min) { value ->
			this.layoutNode.minLeft(value.number)
		}
	}

	/**
	 * The view's absolute maximum left position.
	 * @property maxLeft
	 * @since 0.7.0
	 */
	public val maxLeft by lazy {
		JavaScriptProperty(Double.max) { value ->
			this.layoutNode.maxLeft(value.number)
		}
	}

	/**
	 * The view's absolute minimum right position.
	 * @property minRight
	 * @since 0.7.0
	 */
	public val minRight by lazy {
		JavaScriptProperty(Double.min) { value ->
			this.layoutNode.minRight(value.number)
		}
	}

	/**
	 * The view's absolute maximum right position.
	 * @property maxRight
	 * @since 0.7.0
	 */
	public val maxRight by lazy {
		JavaScriptProperty(Double.max) { value ->
			this.layoutNode.maxRight(value.number)
		}
	}

	/**
	 * The view's absolute minimum bottom position.
	 * @property minBottom
	 * @since 0.7.0
	 */
	public val minBottom by lazy {
		JavaScriptProperty(Double.min) { value ->
			this.layoutNode.minBottom(value.number)
		}
	}

	/**
	 * The view's absolute maximum bottom position.
	 * @property maxBottom
	 * @since 0.7.0
	 */
	public val maxBottom by lazy {
		JavaScriptProperty(Double.max) { value ->
			this.layoutNode.maxBottom(value.number)
		}
	}

	/**
	 * The view's vertical point from with it will be positioned.
	 * @property anchorTop
	 * @since 0.7.0
	 */
	public val anchorTop by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.anchorTop(value)
		}
	}

	/**
	 * The view's horizontal point from with it will be positioned.
	 * @property anchorLeft
	 * @since 0.7.0
	 */
	public val anchorLeft by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.anchorLeft(value)
		}
	}

	/**
	 * The view's width.
	 * @property width
	 * @since 0.7.0
	 */
	public val width by lazy {
		JavaScriptProperty("fill") { value ->
			this.layoutNode.width(value)
		}
	}

	/**
	 * The view's height.
	 * @property height
	 * @since 0.7.0
	 */
	public val height by lazy {
		JavaScriptProperty("fill") { value ->
			this.layoutNode.height(value)
		}
	}

	/**
	 * The view's absolute minimum width.
	 * @property minWidth
	 * @since 0.7.0
	 */
	public val minWidth by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.minWidth(value.number)
		}
	}

	/**b
	 * The view's absolute maximum width.
	 * @property maxWidth
	 * @since 0.7.0
	 */
	public val maxWidth by lazy {
		JavaScriptProperty(Double.max) { value ->
			this.layoutNode.maxWidth(value.number)
		}
	}

	/**
	 * The view's absolute minimum height.
	 * @property minHeight
	 * @since 0.7.0
	 */
	public val minHeight by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.minHeight(value.number)
		}
	}

	/**
	 * The view's absolute maximum height.
	 * @property maxHeight
	 * @since 0.7.0
	 */
	public val maxHeight by lazy {
		JavaScriptProperty(Double.max) { value ->
			this.layoutNode.maxHeight(value.number)
		}
	}

	/**
	 * The view's expandable ratio.
	 * @property expand
	 * @since 0.7.0
	 */
	public val expand by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.expand(value.number)
		}
	}

	/**
	 * The view's shrink ratio.
	 * @property shrink
	 * @since 0.7.0
	 */
	public val shrink by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.shrink(value.number)
		}
	}

	/**
	 * The view's content top.
	 * @property contentTop
	 * @since 0.7.0
	 */
	public val contentTop by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.contentTop(value)
		}
	}

	/**
	 * The view's content left.
	 * @property contentLeft
	 * @since 0.7.0
	 */
	public val contentLeft by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.contentLeft(value)
		}
	}

	/**
	 * The view's content width.
	 * @property contentWidth
	 * @since 0.7.0
	 */
	public val contentWidth by lazy {
		JavaScriptProperty("auto") { value ->
			this.layoutNode.contentWidth(value)
		}
	}

	/**
	 * The view's content height.
	 * @property contentHeight
	 * @since 0.7.0
	 */
	public val contentHeight by lazy {
		JavaScriptProperty("auto") { value ->
			this.layoutNode.contentHeight(value)
		}
	}

	/**
	 * The view's content top inset.
	 * @property contentInsetTop
	 * @since 0.7.0
	 */
	public val contentInsetTop by lazy {
		JavaScriptProperty(0.0) { value ->
			this.scrollableView?.contentInsetTop = Convert.toPx(value.number).toInt()
		}
	}

	/**
	 * The view's content left inset.
	 * @property contentInsetLeft
	 * @since 0.7.0
	 */
	public val contentInsetLeft by lazy {
		JavaScriptProperty(0.0) { value ->
			this.scrollableView?.contentInsetLeft = Convert.toPx(value.number).toInt()
		}
	}

	/**
	 * The view's content right inset.
	 * @property contentInsetRight
	 * @since 0.7.0
	 */
	public val contentInsetRight by lazy {
		JavaScriptProperty(0.0) { value ->
			this.scrollableView?.contentInsetRight = Convert.toPx(value.number).toInt()
		}
	}

	/**
	 * The view's content bottom inset.
	 * @property contentInsetBottom
	 * @since 0.7.0
	 */
	public val contentInsetBottom by lazy {
		JavaScriptProperty(0.0) { value ->
			this.scrollableView?.contentInsetBottom = Convert.toPx(value.number).toInt()
		}
	}

	/**
	 * The view's content orientation.
	 * @property contentDirection
	 * @since 0.7.0
	 */
	public val contentDirection by lazy {
		JavaScriptProperty("vertical") { value ->
			this.layoutNode.contentDirection(value)
		}
	}

	/**
	 * The view's content alignment on the main axis.
	 * @property contentLocation
	 * @since 0.7.0
	 */
	public val contentLocation by lazy {
		JavaScriptProperty("start") { value ->
			this.layoutNode.contentLocation(value)
		}
	}

	/**
	 * The view's content alignment on the cross axis.
	 * @property contentAlignment
	 * @since 0.7.0
	 */
	public val contentAlignment by lazy {
		JavaScriptProperty("start") { value ->
			this.layoutNode.contentAlignment(value)
		}
	}

	/**
	 * Whether this view's content can scroll.
	 * @property scrollable
	 * @since 0.7.0
	 */
	public val scrollable by lazy {
		JavaScriptProperty(false) { value ->
			this.scrollableView?.scrollable = value.boolean
		}
	}

	/**
	 * Whether this view's content displays scrollbars.
	 * @property scrollbars
	 * @since 0.7.0
	 */
	public val scrollbars by lazy {
		JavaScriptProperty(false) { value ->
			this.scrollableView?.scrollbars = Scrollbars.get(value)
		}
	}

	/**
	 * Whether this view's content can overscroll.
	 * @property overscroll
	 * @since 0.7.0
	 */
	public val overscroll by lazy {
		JavaScriptProperty("auto") { value ->
			this.scrollableView?.overscroll = Overscroll.get(value)
		}
	}

	/**
	 * Whether this view's content scrolls with momentum.
	 * @property momentum
	 * @since 0.7.0
	 */
	public val momentum by lazy {
		JavaScriptProperty(true) { value ->
			this.scrollableView?.momentum = value.boolean
		}
	}

	/**
	 * The view's top scroll offset.
	 * @property scrollTop
	 * @since 0.7.0
	 */
	public val scrollTop by lazy {
		JavaScriptProperty(0.0) { value ->
			this.scrollableView?.scrollTop = Convert.toPx(value.number).toInt()
		}
	}

	/**
	 * The view's left scroll offset.
	 * @property scrollLeft
	 * @since 0.7.0
	 */
	public val scrollLeft by lazy {
		JavaScriptProperty(0.0) { value ->
			this.scrollableView?.scrollLeft = Convert.toPx(value.number).toInt()
		}
	}

	/**
	 * Whether this view is scrolling.
	 * @property scrolling
	 * @since 0.7.0
	 */
	public val scrolling by lazy {
		JavaScriptProperty(false)
	}

	/**
	 * Whether this view is dragging.
	 * @property dragging
	 * @since 0.7.0
	 */
	public val dragging by lazy {
		JavaScriptProperty(false)
	}

	/**
	 * The view's margin.
	 * @property margin
	 * @since 0.7.0
	 */
	public val margin by lazy {
		JavaScriptProperty(0.0) { value ->
			this.marginTop.reset(value.number, value.unit)
			this.marginLeft.reset(value.number, value.unit)
			this.marginRight.reset(value.number, value.unit)
			this.marginBottom.reset(value.number, value.unit)
		}
	}

	/**
	 * The view's top margin.
	 * @property marginTop
	 * @since 0.7.0
	 */
	public val marginTop by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.marginTop(value)
		}
	}

	/**
	 * The view's left margin.
	 * @property marginLeft
	 * @since 0.7.0
	 */
	public val marginLeft by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.marginLeft(value)
		}
	}

	/**
	 * The view's right margin.
	 * @property marginRight
	 * @since 0.7.0
	 */
	public val marginRight by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.marginRight(value)
		}
	}

	/**
	 * The view's bottom margin.
	 * @property marginBottom
	 * @since 0.7.0
	 */
	public val marginBottom by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.marginBottom(value)
		}
	}

	/**
	 * The view's absolute minimum top margin.
	 * @property minMarginTop
	 * @since 0.7.0
	 */
	public val minMarginTop by lazy {
		JavaScriptProperty(Double.min) { value ->
			this.layoutNode.minMarginTop(value.number)
		}
	}

	/**
	 * The view's absolute maximum top margin.
	 * @property maxMarginTop
	 * @since 0.7.0
	 */
	public val maxMarginTop by lazy {
		JavaScriptProperty(Double.max) { value ->
			this.layoutNode.maxMarginTop(value.number)
		}
	}

	/**
	 * The view's absolute minimum left margin.
	 * @property minMarginLeft
	 * @since 0.7.0
	 */
	public val minMarginLeft by lazy {
		JavaScriptProperty(Double.min) { value ->
			this.layoutNode.minMarginLeft(value.number)
		}
	}

	/**
	 * The view's absolute maximum left margin.
	 * @property maxMarginLeft
	 * @since 0.7.0
	 */
	public val maxMarginLeft by lazy {
		JavaScriptProperty(Double.max) { value ->
			this.layoutNode.maxMarginLeft(value.number)
		}
	}

	/**
	 * The view's absolute minimum right margin.
	 * @property minMarginRight
	 * @since 0.7.0
	 */
	public val minMarginRight by lazy {
		JavaScriptProperty(Double.min) { value ->
			this.layoutNode.minMarginRight(value.number)
		}
	}

	/**
	 * The view's absolute maximum right margin.
	 * @property maxMarginRight
	 * @since 0.7.0
	 */
	public val maxMarginRight by lazy {
		JavaScriptProperty(Double.max) { value ->
			this.layoutNode.maxMarginRight(value.number)
		}
	}

	/**
	 * The view's absolute minimum bottom margin.
	 * @property minMarginBottom
	 * @since 0.7.0
	 */
	public val minMarginBottom by lazy {
		JavaScriptProperty(Double.min) { value ->
			this.layoutNode.minMarginBottom(value.number)
		}
	}

	/**
	 * The view's absolute maximum bottom margin.
	 * @property maxMarginBottom
	 * @since 0.7.0
	 */
	public val maxMarginBottom by lazy {
		JavaScriptProperty(Double.max) { value ->
			this.layoutNode.maxMarginBottom(value.number)
		}
	}

	/**
	 * The view's padding.
	 * @property padding
	 * @since 0.7.0
	 */
	public val padding by lazy {
		JavaScriptProperty(0.0) { value ->
			this.paddingTop.reset(value.number, value.unit)
			this.paddingLeft.reset(value.number, value.unit)
			this.paddingRight.reset(value.number, value.unit)
			this.paddingBottom.reset(value.number, value.unit)
		}
	}

	/**
	 * The view's top padding.
	 * @property paddingTop
	 * @since 0.7.0
	 */
	public val paddingTop by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.paddingTop(value)
		}
	}

	/**
	 * The view's left padding.
	 * @property paddingLeft
	 * @since 0.7.0
	 */
	public val paddingLeft by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.paddingLeft(value)
		}
	}

	/**
	 * The view's right padding.
	 * @property paddingRight
	 * @since 0.7.0
	 */
	public val paddingRight by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.paddingRight(value)
		}
	}

	/**
	 * The view's bottom padding.
	 * @property paddingBottom
	 * @since 0.7.0
	 */
	public val paddingBottom by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.paddingBottom(value)
		}
	}

	/**
	 * The view's absolute minimum top padding.
	 * @property minPaddingTop
	 * @since 0.7.0
	 */
	public val minPaddingTop by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.minPaddingTop(value.number)
		}
	}

	/**
	 * The view's absolute maximum top padding.
	 * @property maxPaddingTop
	 * @since 0.7.0
	 */
	public val maxPaddingTop by lazy {
		JavaScriptProperty(Double.max) { value ->
			this.layoutNode.maxPaddingTop(value.number)
		}
	}

	/**
	 * The view's absolute minimum left padding.
	 * @property minPaddingLeft
	 * @since 0.7.0
	 */
	public val minPaddingLeft by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.minPaddingLeft(value.number)
		}
	}

	/**
	 * The view's absolute maximum left padding.
	 * @property maxPaddingLeft
	 * @since 0.7.0
	 */
	public val maxPaddingLeft by lazy {
		JavaScriptProperty(Double.max) { value ->
			this.layoutNode.maxPaddingLeft(value.number)
		}
	}

	/**
	 * The view's absolute minimum right padding.
	 * @property minPaddingRight
	 * @since 0.7.0
	 */
	public val minPaddingRight by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.minPaddingRight(value.number)
		}
	}

	/**
	 * The view's absolute maximum right padding.
	 * @property maxPaddingRight
	 * @since 0.7.0
	 */
	public val maxPaddingRight by lazy {
		JavaScriptProperty(Double.max) { value ->
			this.layoutNode.maxPaddingRight(value.number)
		}
	}

	/**
	 * The view's absolute minimum bottom padding.
	 * @property minPaddingBottom
	 * @since 0.7.0
	 */
	public val minPaddingBottom by lazy {
		JavaScriptProperty(0.0) { value ->
			this.layoutNode.minPaddingBottom(value.number)
		}
	}

	/**
	 * The view's absolute maximum bottom padding.
	 * @property maxPaddingBottom
	 * @since 0.7.0
	 */
	public val maxPaddingBottom by lazy {
		JavaScriptProperty(Double.max) { value ->
			this.layoutNode.maxPaddingBottom(value.number)
		}
	}

	/**
	 * The view's transformation origin on the x axis.
	 * @property originX
	 * @since 0.7.0
	 */
	public val originX by lazy {
		JavaScriptProperty(0.5) {
			this.invalidateTransform()
		}
	}

	/**
	 * The view's transformation origin on the y axis.
	 * @property originY
	 * @since 0.7.0
	 */
	public val originY by lazy {
		JavaScriptProperty(0.5) {
			this.invalidateTransform()
		}
	}

	/**
	 * The view's transformation origin on the z axis.
	 * @property originZ
	 * @since 0.7.0
	 */
	public val originZ by lazy {
		JavaScriptProperty(0.0) {
			this.invalidateTransform()
		}
	}

	/**
	 * The view's translation on the x axis.
	 * @property translationX
	 * @since 0.7.0
	 */
	public val translationX by lazy {
		JavaScriptProperty(0.0) {
			this.invalidateTransform()
		}
	}

	/**
	 * The view's translation on the y axis.
	 * @property translationY
	 * @since 0.7.0
	 */
	public val translationY by lazy {
		JavaScriptProperty(0.0) {
			this.invalidateTransform()
		}
	}

	/**
	 * The view's translation on the z axis.
	 * @property translationZ
	 * @since 0.7.0
	 * @hidden
	 */
	public val translationZ by lazy {
		JavaScriptProperty(0.0) {
			this.invalidateTransform()
		}
	}

	/**
	 * The view's rotation on the x axis.
	 * @property rotationX
	 * @since 0.7.0
	 */
	public val rotationX by lazy {
		JavaScriptProperty(0.0) {
			this.invalidateTransform()
		}
	}

	/**
	 * The view's rotation on the y axis.
	 * @property rotationY
	 * @since 0.7.0
	 */
	public val rotationY by lazy {
		JavaScriptProperty(0.0) {
			this.invalidateTransform()
		}
	}

	/**
	 * The view's rotation on the z axis.
	 * @property rotationZ
	 * @since 0.7.0
	 */
	public val rotationZ by lazy {
		JavaScriptProperty(0.0) {
			this.invalidateTransform()
		}
	}

	/**
	 * The view's scale on the x axis.
	 * @property scaleX
	 * @since 0.7.0
	 */
	public val scaleX by lazy {
		JavaScriptProperty(1.0) {
			this.invalidateTransform()
		}
	}

	/**
	 * The view's scale on the y axis.
	 * @property scaleY
	 * @since 0.7.0
	 */
	public val scaleY by lazy {
		JavaScriptProperty(1.0) {
			this.invalidateTransform()
		}
	}

	/**
	 * The view's scale on the z axis.
	 * @property scaleZ
	 * @since 0.7.0
	 */
	public val scaleZ by lazy {
		JavaScriptProperty(1.0) {
			this.invalidateTransform()
		}
	}

	/**
	 * The view's index on the z position relative to its siblings.
	 * @property zIndex
	 * @since 0.7.0
	 */
	public val zIndex by lazy {
		JavaScriptProperty(0.0) {
			val parent = this.parent
			if (parent != null) {
				parent.invalidateOrder()
			}
		}
	}

	/**
	 * Whether the view is zoomable.
	 * @property zoomable
	 * @since 0.7.0
	 */
	public val zoomable by lazy {
		JavaScriptProperty(false) { value ->
			this.scrollableView?.zoomable = value.boolean
		}
	}

	/**
	 * The view's minimum zoom.
	 * @property minZoom
	 * @since 0.7.0
	 */
	public val minZoom by lazy {
		JavaScriptProperty(1.0) { value ->
			this.scrollableView?.minZoom = value.number.toFloat()
		}
	}

	/**
	 * The view's maximum zoom.
	 * @property maxZoom
	 * @since 0.7.0
	 */
	public val maxZoom by lazy {
		JavaScriptProperty(1.0) { value ->
			this.scrollableView?.maxZoom = value.number.toFloat()
		}
	}

	/**
	 * The view that is zoomed.
	 * @property zoomedView
	 * @since 0.7.0
	 */
	open var zoomedView: JavaScriptView? by Delegates.OnSetOptional<JavaScriptView>(null) { value ->
		this.scrollableView?.zoomedView = value?.wrapper
	}

	/**
	 * Whether this view can interact with touches.
	 * @property touchable
	 * @since 0.7.0
	 */
	public val touchable by lazy {
		JavaScriptProperty(true) { value ->
			this.wrapper.touchable = value.boolean
		}
	}

	/**
	 * The top offset for this view touchable area.
	 * @property touchOffsetTop
	 * @since 0.7.0
	 */
	public val touchOffsetTop by lazy {
		JavaScriptProperty(0.0)
	}

	/**
	 * The left offset for this view touchable area.
	 * @property touchOffsetLeft
	 * @since 0.7.0
	 */
	public val touchOffsetLeft by lazy {
		JavaScriptProperty(0.0)
	}

	/**
	 * The right offset for this view touchable area.
	 * @property touchOffsetRight
	 * @since 0.7.0
	 */
	public val touchOffsetRight by lazy {
		JavaScriptProperty(0.0)
	}

	/**
	 * The bottom offset for this view touchable area.
	 * @property touchOffsetBottom
	 * @since 0.7.0
	 */
	public val touchOffsetBottom by lazy {
		JavaScriptProperty(0.0)
	}

	/**
	 * The view's visibility status.
	 * @property visible
	 * @since 0.7.0
	 */
	public val visible by lazy {
		JavaScriptProperty(true) { value ->
			this.stylerNode.visible = value.boolean
			this.layoutNode.visible = value.boolean
			this.wrapper.visible = value.boolean
		}
	}

	/**
	 * The view's opacity.
	 * @property opacity
	 * @since 0.7.0
	 */
	public val opacity by lazy {
		JavaScriptProperty(1.0) { value ->
			this.wrapper.alpha = value.number.toFloat()
		}
	}

	/**
	 * Whether this view can be drawn by user.
	 * @property drawable
	 * @since 0.7.0
	 */
	public val drawable by lazy {
		JavaScriptProperty(false) { value ->
			this.wrapper.drawable = value.boolean
		}
	}

	/**
	 * Whether this view's content is clipped to its bounds.
	 * @property clipped
	 * @since 0.7.0
	 */
	public val clipped by lazy {
		JavaScriptProperty(true) { value ->
			this.wrapper.clipped = value.boolean
		}
	}

	/**
	 * Whether this view's content is paged.
	 * @property paged
	 * @since 0.7.0
	 */
	public val paged by lazy {
		JavaScriptProperty(false) { value ->
			this.scrollableView?.paged = value.boolean
		}
	}

	/**
	 * @property measuredTop
	 * @since 0.7.0
	 * @hidden
	 */
	public val measuredTop by lazy {
		JavaScriptProperty()
	}

	/**
	 * @property measuredLeft
	 * @since 0.7.0
	 * @hidden
	 */
	public val measuredLeft by lazy {
		JavaScriptProperty()
	}

	/**
	 * @property measuredWidth
	 * @since 0.7.0
	 * @hidden
	 */
	public val measuredWidth by lazy {
		JavaScriptProperty()
	}

	/**
	 * @property measuredHeight
	 * @since 0.7.0
	 * @hidden
	 */
	public val measuredHeight by lazy {
		JavaScriptProperty()
	}

	/**
	 * @property measuredInnerWidth
	 * @since 0.7.0
	 * @hidden
	 */
	public val measuredInnerWidth by lazy {
		JavaScriptProperty()
	}

	/**
	 * @property measuredInnerHeight
	 * @since 0.7.0
	 * @hidden
	 */
	public val measuredInnerHeight by lazy {
		JavaScriptProperty()
	}

	/**
	 * @property measuredContentWidth
	 * @since 0.7.0
	 * @hidden
	 */
	public val measuredContentWidth by lazy {
		JavaScriptProperty()
	}

	/**
	 * @property measuredContentHeight
	 * @since 0.7.0
	 * @hidden
	 */
	public val measuredContentHeight by lazy {
		JavaScriptProperty()
	}

	/**
	 * @property measuredMarginTop
	 * @since 0.7.0
	 * @hidden
	 */
	public val measuredMarginTop by lazy {
		JavaScriptProperty()
	}

	/**
	 * @property measuredMarginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	public val measuredMarginLeft by lazy {
		JavaScriptProperty()
	}

	/**
	 * @property measuredMarginRight
	 * @since 0.7.0
	 * @hidden
	 */
	public val measuredMarginRight by lazy {
		JavaScriptProperty()
	}

	/**
	 * @property measuredMarginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	public val measuredMarginBottom by lazy {
		JavaScriptProperty()
	}

	/**
	 * @property measuredBorderTopWidth
	 * @since 0.7.0
	 * @hidden
	 */
	public val measuredBorderTopWidth by lazy {
		JavaScriptProperty()
	}

	/**
	 * @property measuredBorderLeftWidth
	 * @since 0.7.0
	 * @hidden
	 */
	public val measuredBorderLeftWidth by lazy {
		JavaScriptProperty()
	}

	/**
	 * @property measuredBorderRightWidth
	 * @since 0.7.0
	 * @hidden
	 */
	public val measuredBorderRightWidth by lazy {
		JavaScriptProperty()
	}

	/**
	 * @property measuredBorderBottomWidth
	 * @since 0.7.0
	 * @hidden
	 */
	public val measuredBorderBottomWidth by lazy {
		JavaScriptProperty()
	}

	/**
	 * @property measuredPaddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	public val measuredPaddingTop by lazy {
		JavaScriptProperty()
	}

	/**
	 * @property measuredPaddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	public val measuredPaddingLeft by lazy {
		JavaScriptProperty()
	}

	/**
	 * @property measuredPaddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	public val measuredPaddingRight by lazy {
		JavaScriptProperty()
	}

	/**
	 * @property measuredPaddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	public val measuredPaddingBottom by lazy {
		JavaScriptProperty()
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_classList
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_classList(callback: JavaScriptGetterCallback) {
		callback.returns(this.classList)
	}

	/**
	 * @method jsSet_classList
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_classList(callback: JavaScriptSetterCallback) {
		val classList = callback.value.string
		this.className = classList.until('.')
		this.classList = classList
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_window
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_window(callback: JavaScriptGetterCallback) {
		callback.returns(this.window)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_parent
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_parent(callback: JavaScriptGetterCallback) {
		callback.returns(this.parent)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_id
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_id(callback: JavaScriptGetterCallback) {
		callback.returns(this.id)
	}

	/**
	 * @method jsSet_id
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_id(callback: JavaScriptSetterCallback) {
		this.id.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_backgroundColor(callback: JavaScriptGetterCallback) {
		callback.returns(this.backgroundColor)
	}

	/**
	 * @method jsSet_backgroundColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_backgroundColor(callback: JavaScriptSetterCallback) {
		this.backgroundColor.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundImage
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_backgroundImage(callback: JavaScriptGetterCallback) {
		callback.returns(this.backgroundImage)
	}

	/**
	 * @method jsSet_backgroundImage
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_backgroundImage(callback: JavaScriptSetterCallback) {
		this.backgroundImage.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundImageFit
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_backgroundImageFit(callback: JavaScriptGetterCallback) {
		callback.returns(this.backgroundImageFit)
	}

	/**
	 * @method jsSet_backgroundImageFit
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_backgroundImageFit(callback: JavaScriptSetterCallback) {
		this.backgroundImageFit.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundImageAnchorTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_backgroundImageAnchorTop(callback: JavaScriptGetterCallback) {
		callback.returns(this.backgroundImageAnchorTop)
	}

	/**
	 * @method jsSet_backgroundImageAnchorTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_backgroundImageAnchorTop(callback: JavaScriptSetterCallback) {
		this.backgroundImageAnchorTop.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundImageAnchorLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_backgroundImageAnchorLeft(callback: JavaScriptGetterCallback) {
		callback.returns(this.backgroundImageAnchorLeft)
	}

	/**
	 * @method jsSet_backgroundImageAnchorLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_backgroundImageAnchorLeft(callback: JavaScriptSetterCallback) {
		this.backgroundImageAnchorLeft.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundImageTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_backgroundImageTop(callback: JavaScriptGetterCallback) {
		callback.returns(this.backgroundImageTop)
	}

	/**
	 * @method jsSet_backgroundImageTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_backgroundImageTop(callback: JavaScriptSetterCallback) {
		this.backgroundImageTop.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundImageLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_backgroundImageLeft(callback: JavaScriptGetterCallback) {
		callback.returns(this.backgroundImageLeft)
	}

	/**
	 * @method jsSet_backgroundImageLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_backgroundImageLeft(callback: JavaScriptSetterCallback) {
		this.backgroundImageLeft.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundImageWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_backgroundImageWidth(callback: JavaScriptGetterCallback) {
		callback.returns(this.backgroundImageWidth)
	}

	/**
	 * @method jsSet_backgroundImageWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_backgroundImageWidth(callback: JavaScriptSetterCallback) {
		this.backgroundImageWidth.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundImageHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_backgroundImageHeight(callback: JavaScriptGetterCallback) {
		callback.returns(this.backgroundImageHeight)
	}

	/**
	 * @method jsSet_backgroundImageHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_backgroundImageHeight(callback: JavaScriptSetterCallback) {
		this.backgroundImageHeight.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundImageTint
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_backgroundImageTint(callback: JavaScriptGetterCallback) {
		callback.returns(this.backgroundImageTint)
	}

	/**
	 * @method jsSet_backgroundImageTint
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_backgroundImageTint(callback: JavaScriptSetterCallback) {
		this.backgroundImageTint.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_border
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_border(callback: JavaScriptGetterCallback) {

		val width = this.context.createEmptyObject()
		width.property("top", this.borderTopWidth)
		width.property("left", this.borderLeftWidth)
		width.property("right", this.borderRightWidth)
		width.property("bottom", this.borderBottomWidth)

		val color = this.context.createEmptyObject()
		color.property("top", this.borderTopColor)
		color.property("left", this.borderLeftColor)
		color.property("right", this.borderRightColor)
		color.property("bottom", this.borderBottomColor)

		val value = this.context.createEmptyObject()
		value.property("width", width)
		value.property("color", color)

		callback.returns(value)
	}

	/**
	 * @method jsSet_border
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_border(callback: JavaScriptSetterCallback) {
		this.border.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_borderTop(callback: JavaScriptGetterCallback) {
		callback.returns(this.borderTop)
	}

	/**
	 * @method jsSet_borderTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_borderTop(callback: JavaScriptSetterCallback) {
		this.borderTop.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_borderLeft(callback: JavaScriptGetterCallback) {
		callback.returns(this.borderLeft)
	}

	/**
	 * @method jsSet_borderLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_borderLeft(callback: JavaScriptSetterCallback) {
		this.borderLeft.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_borderRight(callback: JavaScriptGetterCallback) {
		callback.returns(this.borderRight)
	}

	/**
	 * @method jsSet_borderRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_borderRight(callback: JavaScriptSetterCallback) {
		this.borderRight.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_borderBottom(callback: JavaScriptGetterCallback) {
		callback.returns(this.borderBottom)
	}

	/**
	 * @method jsSet_borderBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_borderBottom(callback: JavaScriptSetterCallback) {
		this.borderBottom.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_borderWidth(callback: JavaScriptGetterCallback) {

		val value = this.context.createEmptyObject()
		value.property("top", this.borderTopWidth)
		value.property("left", this.borderLeftWidth)
		value.property("right", this.borderRightWidth)
		value.property("bottom", this.borderBottomWidth)

		callback.returns(value)
	}

	/**
	 * @method jsSet_borderWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_borderWidth(callback: JavaScriptSetterCallback) {
		this.borderWidth.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_borderColor(callback: JavaScriptGetterCallback) {

		val value = this.context.createEmptyObject()
		value.property("top", this.borderTopColor)
		value.property("left", this.borderLeftColor)
		value.property("right", this.borderRightColor)
		value.property("bottom", this.borderBottomColor)

		callback.returns(value)
	}

	/**
	 * @method jsSet_borderColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_borderColor(callback: JavaScriptSetterCallback) {
		this.borderColor.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderTopColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_borderTopColor(callback: JavaScriptGetterCallback) {
		callback.returns(this.borderTopColor)
	}

	/**
	 * @method jsSet_borderTopColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_borderTopColor(callback: JavaScriptSetterCallback) {
		this.borderTopColor.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderLeftColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_borderLeftColor(callback: JavaScriptGetterCallback) {
		callback.returns(this.borderLeftColor)
	}

	/**
	 * @method jsSet_borderLeftColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_borderLeftColor(callback: JavaScriptSetterCallback) {
		this.borderLeftColor.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderRightColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_borderRightColor(callback: JavaScriptGetterCallback) {
		callback.returns(this.borderRightColor)
	}

	/**
	 * @method jsSet_borderRightColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_borderRightColor(callback: JavaScriptSetterCallback) {
		this.borderRightColor.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderBottomColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_borderBottomColor(callback: JavaScriptGetterCallback) {
		callback.returns(this.borderBottomColor)
	}

	/**
	 * @method jsSet_borderBottomColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_borderBottomColor(callback: JavaScriptSetterCallback) {
		this.borderBottomColor.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderTopWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_borderTopWidth(callback: JavaScriptGetterCallback) {
		callback.returns(this.borderTopWidth)
	}

	/**
	 * @method jsSet_borderTopWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_borderTopWidth(callback: JavaScriptSetterCallback) {
		this.borderTopWidth.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderLeftWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_borderLeftWidth(callback: JavaScriptGetterCallback) {
		callback.returns(this.borderLeftWidth)
	}

	/**
	 * @method jsSet_borderLeftWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_borderLeftWidth(callback: JavaScriptSetterCallback) {
		this.borderLeftWidth.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderRightWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_borderRightWidth(callback: JavaScriptGetterCallback) {
		callback.returns(this.borderRightWidth)
	}

	/**
	 * @method jsSet_borderRightWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_borderRightWidth(callback: JavaScriptSetterCallback) {
		this.borderRightWidth.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderBottomWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_borderBottomWidth(callback: JavaScriptGetterCallback) {
		callback.returns(this.borderBottomWidth)
	}

	/**
	 * @method jsSet_borderBottomWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_borderBottomWidth(callback: JavaScriptSetterCallback) {
		this.borderBottomWidth.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minBorderTopWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_minBorderTopWidth(callback: JavaScriptGetterCallback) {
		callback.returns(this.minBorderTopWidth)
	}

	/**
	 * @method jsSet_minBorderTopWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_minBorderTopWidth(callback: JavaScriptSetterCallback) {
		this.minBorderTopWidth.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxBorderTopWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_maxBorderTopWidth(callback: JavaScriptGetterCallback) {
		callback.returns(this.maxBorderTopWidth)
	}

	/**
	 * @method jsSet_maxBorderTopWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_maxBorderTopWidth(callback: JavaScriptSetterCallback) {
		this.maxBorderTopWidth.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minBorderLeftWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_minBorderLeftWidth(callback: JavaScriptGetterCallback) {
		callback.returns(this.minBorderLeftWidth)
	}

	/**
	 * @method jsSet_minBorderLeftWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_minBorderLeftWidth(callback: JavaScriptSetterCallback) {
		this.minBorderLeftWidth.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxBorderLeftWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_maxBorderLeftWidth(callback: JavaScriptGetterCallback) {
		callback.returns(this.maxBorderLeftWidth)
	}

	/**
	 * @method jsSet_maxBorderLeftWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_maxBorderLeftWidth(callback: JavaScriptSetterCallback) {
		this.maxBorderLeftWidth.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minBorderRightWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_minBorderRightWidth(callback: JavaScriptGetterCallback) {
		callback.returns(this.minBorderRightWidth)
	}

	/**
	 * @method jsSet_minBorderRightWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_minBorderRightWidth(callback: JavaScriptSetterCallback) {
		this.minBorderRightWidth.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxBorderRightWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_maxBorderRightWidth(callback: JavaScriptGetterCallback) {
		callback.returns(this.maxBorderRightWidth)
	}

	/**
	 * @method jsSet_maxBorderRightWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_maxBorderRightWidth(callback: JavaScriptSetterCallback) {
		this.maxBorderRightWidth.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minBorderBottomWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_minBorderBottomWidth(callback: JavaScriptGetterCallback) {
		callback.returns(this.minBorderBottomWidth)
	}

	/**
	 * @method jsSet_minBorderBottomWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_minBorderBottomWidth(callback: JavaScriptSetterCallback) {
		this.minBorderBottomWidth.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxBorderBottomWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_maxBorderBottomWidth(callback: JavaScriptGetterCallback) {
		callback.returns(this.maxBorderBottomWidth)
	}

	/**
	 * @method jsSet_maxBorderBottomWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_maxBorderBottomWidth(callback: JavaScriptSetterCallback) {
		this.maxBorderBottomWidth.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_borderRadius(callback: JavaScriptGetterCallback) {

		val value = this.context.createEmptyObject()
		value.property("topLeft", this.borderTopLeftRadius)
		value.property("topRight", this.borderTopRightRadius)
		value.property("bottomLeft", this.borderBottomLeftRadius)
		value.property("bottomRight", this.borderBottomRightRadius)

		callback.returns(value)
	}

	/**
	 * @method jsSet_borderRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_borderRadius(callback: JavaScriptSetterCallback) {
		this.borderRadius.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderTopLeftRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_borderTopLeftRadius(callback: JavaScriptGetterCallback) {
		callback.returns(this.borderTopLeftRadius)
	}

	/**
	 * @method jsSet_borderTopLeftRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_borderTopLeftRadius(callback: JavaScriptSetterCallback) {
		this.borderTopLeftRadius.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderTopRightRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_borderTopRightRadius(callback: JavaScriptGetterCallback) {
		callback.returns(this.borderTopRightRadius)
	}

	/**
	 * @method jsSet_borderTopRightRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_borderTopRightRadius(callback: JavaScriptSetterCallback) {
		this.borderTopRightRadius.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderBottomLeftRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_borderBottomLeftRadius(callback: JavaScriptGetterCallback) {
		callback.returns(this.borderBottomLeftRadius)
	}

	/**
	 * @method jsSet_borderBottomLeftRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_borderBottomLeftRadius(callback: JavaScriptSetterCallback) {
		this.borderBottomLeftRadius.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderBottomRightRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_borderBottomRightRadius(callback: JavaScriptGetterCallback) {
		callback.returns(this.borderBottomRightRadius)
	}

	/**
	 * @method jsSet_borderBottomRightRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_borderBottomRightRadius(callback: JavaScriptSetterCallback) {
		this.borderBottomRightRadius.reset(callback.value, this)
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
		this.shadowBlur.reset(callback.value, this)
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
		this.shadowColor.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shadowOffsetTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_shadowOffsetTop(callback: JavaScriptGetterCallback) {
		callback.returns(this.shadowOffsetTop)
	}

	/**
	 * @method jsSet_shadowOffsetTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_shadowOffsetTop(callback: JavaScriptSetterCallback) {
		this.shadowOffsetTop.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shadowOffsetLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_shadowOffsetLeft(callback: JavaScriptGetterCallback) {
		callback.returns(this.shadowOffsetLeft)
	}

	/**
	 * @method jsSet_shadowOffsetLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_shadowOffsetLeft(callback: JavaScriptSetterCallback) {
		this.shadowOffsetLeft.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_top
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_top(callback: JavaScriptGetterCallback) {
		callback.returns(this.top)
	}

	/**
	 * @method jsSet_top
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_top(callback: JavaScriptSetterCallback) {
		this.top.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_left
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_left(callback: JavaScriptGetterCallback) {
		callback.returns(this.left)
	}

	/**
	 * @method jsSet_left
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_left(callback: JavaScriptSetterCallback) {
		this.left.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_right
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_right(callback: JavaScriptGetterCallback) {
		callback.returns(this.right)
	}

	/**
	 * @method jsSet_right
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_right(callback: JavaScriptSetterCallback) {
		this.right.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_bottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_bottom(callback: JavaScriptGetterCallback) {
		callback.returns(this.bottom)
	}

	/**
	 * @method jsSet_bottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_bottom(callback: JavaScriptSetterCallback) {
		this.bottom.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_minTop(callback: JavaScriptGetterCallback) {
		callback.returns(this.minTop)
	}

	/**
	 * @method jsSet_minTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_minTop(callback: JavaScriptSetterCallback) {
		this.minTop.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_maxTop(callback: JavaScriptGetterCallback) {
		callback.returns(this.maxTop)
	}

	/**
	 * @method jsSet_maxTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_maxTop(callback: JavaScriptSetterCallback) {
		this.maxTop.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_minLeft(callback: JavaScriptGetterCallback) {
		callback.returns(this.minLeft)
	}

	/**
	 * @method jsSet_minLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_minLeft(callback: JavaScriptSetterCallback) {
		this.minLeft.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_maxLeft(callback: JavaScriptGetterCallback) {
		callback.returns(this.maxLeft)
	}

	/**
	 * @method jsSet_maxLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_maxLeft(callback: JavaScriptSetterCallback) {
		this.maxLeft.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_minRight(callback: JavaScriptGetterCallback) {
		callback.returns(this.minRight)
	}

	/**
	 * @method jsSet_minRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_minRight(callback: JavaScriptSetterCallback) {
		this.minRight.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_maxRight(callback: JavaScriptGetterCallback) {
		callback.returns(this.maxRight)
	}

	/**
	 * @method jsSet_maxRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_maxRight(callback: JavaScriptSetterCallback) {
		this.maxRight.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_minBottom(callback: JavaScriptGetterCallback) {
		callback.returns(this.minBottom)
	}

	/**
	 * @method jsSet_minBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_minBottom(callback: JavaScriptSetterCallback) {
		this.minBottom.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_maxBottom(callback: JavaScriptGetterCallback) {
		callback.returns(this.maxBottom)
	}

	/**
	 * @method jsSet_maxBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_maxBottom(callback: JavaScriptSetterCallback) {
		this.maxBottom.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_anchorTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_anchorTop(callback: JavaScriptGetterCallback) {
		callback.returns(this.anchorTop)
	}

	/**
	 * @method jsSet_anchorTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_anchorTop(callback: JavaScriptSetterCallback) {
		this.anchorTop.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_anchorLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_anchorLeft(callback: JavaScriptGetterCallback) {
		callback.returns(this.anchorLeft)
	}

	/**
	 * @method jsSet_anchorLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_anchorLeft(callback: JavaScriptSetterCallback) {
		this.anchorLeft.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_width
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_width(callback: JavaScriptGetterCallback) {
		callback.returns(this.width)
	}

	/**
	 * @method jsSet_width
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_width(callback: JavaScriptSetterCallback) {
		this.width.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_height
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_height(callback: JavaScriptGetterCallback) {
		callback.returns(this.height)
	}

	/**
	 * @method jsSet_height
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_height(callback: JavaScriptSetterCallback) {
		this.height.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_minWidth(callback: JavaScriptGetterCallback) {
		callback.returns(this.minWidth)
	}

	/**
	 * @method jsSet_minWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_minWidth(callback: JavaScriptSetterCallback) {
		this.minWidth.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_maxWidth(callback: JavaScriptGetterCallback) {
		callback.returns(this.maxWidth)
	}

	/**
	 * @method jsSet_maxWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_maxWidth(callback: JavaScriptSetterCallback) {
		this.maxWidth.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_minHeight(callback: JavaScriptGetterCallback) {
		callback.returns(this.minHeight)
	}

	/**
	 * @method jsSet_minHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_minHeight(callback: JavaScriptSetterCallback) {
		this.minHeight.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_maxHeight(callback: JavaScriptGetterCallback) {
		callback.returns(this.maxHeight)
	}

	/**
	 * @method jsSet_maxHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_maxHeight(callback: JavaScriptSetterCallback) {
		this.maxHeight.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_expand
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_expand(callback: JavaScriptGetterCallback) {
		callback.returns(this.expand)
	}

	/**
	 * @method jsSet_expand
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_expand(callback: JavaScriptSetterCallback) {
		this.expand.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shrink
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_shrink(callback: JavaScriptGetterCallback) {
		callback.returns(this.shrink)
	}

	/**
	 * @method jsSet_shrink
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_shrink(callback: JavaScriptSetterCallback) {
		this.shrink.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_contentTop(callback: JavaScriptGetterCallback) {
		callback.returns(this.contentTop)
	}

	/**
	 * @method jsSet_contentTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_contentTop(callback: JavaScriptSetterCallback) {
		this.contentTop.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_contentLeft(callback: JavaScriptGetterCallback) {
		callback.returns(this.contentLeft)
	}

	/**
	 * @method jsSet_contentLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_contentLeft(callback: JavaScriptSetterCallback) {
		this.contentLeft.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_contentWidth(callback: JavaScriptGetterCallback) {
		callback.returns(this.contentWidth)
	}

	/**
	 * @method jsSet_contentWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_contentWidth(callback: JavaScriptSetterCallback) {
		this.contentWidth.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_contentHeight(callback: JavaScriptGetterCallback) {
		callback.returns(this.contentHeight)
	}

	/**
	 * @method jsSet_contentHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_contentHeight(callback: JavaScriptSetterCallback) {
		this.contentHeight.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentInsetTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_contentInsetTop(callback: JavaScriptGetterCallback) {
		callback.returns(this.contentInsetTop)
	}

	/**
	 * @method jsSet_contentInsetTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_contentInsetTop(callback: JavaScriptSetterCallback) {
		this.contentInsetTop.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentInsetLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_contentInsetLeft(callback: JavaScriptGetterCallback) {
		callback.returns(this.contentInsetLeft)
	}

	/**
	 * @method jsSet_contentInsetLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_contentInsetLeft(callback: JavaScriptSetterCallback) {
		this.contentInsetLeft.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentInsetRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_contentInsetRight(callback: JavaScriptGetterCallback) {
		callback.returns(this.contentInsetRight)
	}

	/**
	 * @method jsSet_contentInsetRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_contentInsetRight(callback: JavaScriptSetterCallback) {
		this.contentInsetRight.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentInsetBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_contentInsetBottom(callback: JavaScriptGetterCallback) {
		callback.returns(this.contentInsetBottom)
	}

	/**
	 * @method jsSet_contentInsetBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_contentInsetBottom(callback: JavaScriptSetterCallback) {
		this.contentInsetBottom.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentDirection
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_contentDirection(callback: JavaScriptGetterCallback) {
		callback.returns(this.contentDirection)
	}

	/**
	 * @method jsSet_contentDirection
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_contentDirection(callback: JavaScriptSetterCallback) {
		this.contentDirection.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentLocation
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_contentLocation(callback: JavaScriptGetterCallback) {
		callback.returns(this.contentLocation)
	}

	/**
	 * @method jsSet_contentLocation
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_contentLocation(callback: JavaScriptSetterCallback) {
		this.contentLocation.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentAlignment
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_contentAlignment(callback: JavaScriptGetterCallback) {
		callback.returns(this.contentAlignment)
	}

	/**
	 * @method jsSet_contentAlignment
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_contentAlignment(callback: JavaScriptSetterCallback) {
		this.contentAlignment.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scrollable
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_scrollable(callback: JavaScriptGetterCallback) {
		callback.returns(this.scrollable)
	}

	/**
	 * @method jsSet_scrollable
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_scrollable(callback: JavaScriptSetterCallback) {
		this.scrollable.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scrollbars
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_scrollbars(callback: JavaScriptGetterCallback) {
		callback.returns(this.scrollbars)
	}

	/**
	 * @method jsSet_scrollbars
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_scrollbars(callback: JavaScriptSetterCallback) {
		this.scrollbars.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_overscroll
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_overscroll(callback: JavaScriptGetterCallback) {
		callback.returns(this.overscroll)
	}

	/**
	 * @method jsSet_overscroll
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_overscroll(callback: JavaScriptSetterCallback) {
		this.overscroll.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_momentum
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_momentum(callback: JavaScriptGetterCallback) {
		callback.returns(this.momentum)
	}

	/**
	 * @method jsSet_momentum
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_momentum(callback: JavaScriptSetterCallback) {
		this.momentum.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scrollTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_scrollTop(callback: JavaScriptGetterCallback) {
		callback.returns(this.scrollTop)
	}

	/**
	 * @method jsSet_scrollTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_scrollTop(callback: JavaScriptSetterCallback) {
		this.scrollTop.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scrollLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_scrollLeft(callback: JavaScriptGetterCallback) {
		callback.returns(this.scrollLeft)
	}

	/**
	 * @method jsSet_scrollLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_scrollLeft(callback: JavaScriptSetterCallback) {
		this.scrollTop.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scrolling
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_scrolling(callback: JavaScriptGetterCallback) {
		callback.returns(this.scrolling)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_dragging
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_dragging(callback: JavaScriptGetterCallback) {
		callback.returns(this.dragging)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_margin
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_margin(callback: JavaScriptGetterCallback) {

		val value = this.context.createEmptyObject()
		value.property("top", this.marginTop)
		value.property("left", this.marginLeft)
		value.property("right", this.marginRight)
		value.property("bottom", this.marginBottom)

		callback.returns(value)
	}

	/**
	 * @method jsSet_margin
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_margin(callback: JavaScriptSetterCallback) {
		this.margin.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_marginTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_marginTop(callback: JavaScriptGetterCallback) {
		callback.returns(this.marginTop)
	}

	/**
	 * @method jsSet_marginTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_marginTop(callback: JavaScriptSetterCallback) {
		this.marginTop.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_marginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_marginLeft(callback: JavaScriptGetterCallback) {
		callback.returns(this.marginLeft)
	}

	/**
	 * @method jsSet_marginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_marginLeft(callback: JavaScriptSetterCallback) {
		this.marginLeft.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_marginRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_marginRight(callback: JavaScriptGetterCallback) {
		callback.returns(this.marginRight)
	}

	/**
	 * @method jsSet_marginRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_marginRight(callback: JavaScriptSetterCallback) {
		this.marginRight.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_marginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_marginBottom(callback: JavaScriptGetterCallback) {
		callback.returns(this.marginBottom)
	}

	/**
	 * @method jsSet_marginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_marginBottom(callback: JavaScriptSetterCallback) {
		this.marginBottom.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minMarginTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_minMarginTop(callback: JavaScriptGetterCallback) {
		callback.returns(this.minMarginTop)
	}

	/**
	 * @method jsSet_minMarginTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_minMarginTop(callback: JavaScriptSetterCallback) {
		this.minMarginTop.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxMarginTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_maxMarginTop(callback: JavaScriptGetterCallback) {
		callback.returns(this.maxMarginTop)
	}

	/**
	 * @method jsSet_maxMarginTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_maxMarginTop(callback: JavaScriptSetterCallback) {
		this.maxMarginTop.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minMarginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_minMarginLeft(callback: JavaScriptGetterCallback) {
		callback.returns(this.minMarginLeft)
	}

	/**
	 * @method jsSet_minMarginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_minMarginLeft(callback: JavaScriptSetterCallback) {
		this.minMarginLeft.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxMarginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_maxMarginLeft(callback: JavaScriptGetterCallback) {
		callback.returns(this.maxMarginLeft)
	}

	/**
	 * @method jsSet_maxMarginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_maxMarginLeft(callback: JavaScriptSetterCallback) {
		this.maxMarginLeft.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minMarginRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_minMarginRight(callback: JavaScriptGetterCallback) {
		callback.returns(this.minMarginRight)
	}

	/**
	 * @method jsSet_minMarginRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_minMarginRight(callback: JavaScriptSetterCallback) {
		this.minMarginRight.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxMarginRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_maxMarginRight(callback: JavaScriptGetterCallback) {
		callback.returns(this.maxMarginRight)
	}

	/**
	 * @method jsSet_maxMarginRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_maxMarginRight(callback: JavaScriptSetterCallback) {
		this.maxMarginRight.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minMarginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_minMarginBottom(callback: JavaScriptGetterCallback) {
		callback.returns(this.minMarginBottom)
	}

	/**
	 * @method jsSet_minMarginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_minMarginBottom(callback: JavaScriptSetterCallback) {
		this.minMarginBottom.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxMarginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_maxMarginBottom(callback: JavaScriptGetterCallback) {
		callback.returns(this.maxMarginBottom)
	}

	/**
	 * @method jsSet_maxMarginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_maxMarginBottom(callback: JavaScriptSetterCallback) {
		this.maxMarginBottom.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_padding
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_padding(callback: JavaScriptGetterCallback) {

		val value = this.context.createEmptyObject()
		value.property("top", this.paddingTop)
		value.property("left", this.paddingLeft)
		value.property("right", this.paddingRight)
		value.property("bottom", this.paddingBottom)

		callback.returns(value)
	}

	/**
	 * @method jsSet_padding
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_padding(callback: JavaScriptSetterCallback) {
		this.padding.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_paddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_paddingTop(callback: JavaScriptGetterCallback) {
		callback.returns(this.paddingTop)
	}

	/**
	 * @method jsSet_paddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_paddingTop(callback: JavaScriptSetterCallback) {
		this.paddingTop.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_paddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_paddingLeft(callback: JavaScriptGetterCallback) {
		callback.returns(this.paddingLeft)
	}

	/**
	 * @method jsSet_paddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_paddingLeft(callback: JavaScriptSetterCallback) {
		this.paddingLeft.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_paddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_paddingRight(callback: JavaScriptGetterCallback) {
		callback.returns(this.paddingRight)
	}

	/**
	 * @method jsSet_paddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_paddingRight(callback: JavaScriptSetterCallback) {
		this.paddingRight.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_paddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_paddingBottom(callback: JavaScriptGetterCallback) {
		callback.returns(this.paddingBottom)
	}

	/**
	 * @method jsSet_paddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_paddingBottom(callback: JavaScriptSetterCallback) {
		this.paddingBottom.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minPaddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_minPaddingTop(callback: JavaScriptGetterCallback) {
		callback.returns(this.minPaddingTop)
	}

	/**
	 * @method jsSet_minPaddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_minPaddingTop(callback: JavaScriptSetterCallback) {
		this.minPaddingTop.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxPaddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_maxPaddingTop(callback: JavaScriptGetterCallback) {
		callback.returns(this.maxPaddingTop)
	}

	/**
	 * @method jsSet_maxPaddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_maxPaddingTop(callback: JavaScriptSetterCallback) {
		this.maxPaddingTop.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minPaddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_minPaddingLeft(callback: JavaScriptGetterCallback) {
		callback.returns(this.minPaddingLeft)
	}

	/**
	 * @method jsSet_minPaddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_minPaddingLeft(callback: JavaScriptSetterCallback) {
		this.minPaddingLeft.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxPaddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_maxPaddingLeft(callback: JavaScriptGetterCallback) {
		callback.returns(this.maxPaddingLeft)
	}

	/**
	 * @method jsSet_maxPaddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_maxPaddingLeft(callback: JavaScriptSetterCallback) {
		this.maxPaddingLeft.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minPaddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_minPaddingRight(callback: JavaScriptGetterCallback) {
		callback.returns(this.minPaddingRight)
	}

	/**
	 * @method jsSet_minPaddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_minPaddingRight(callback: JavaScriptSetterCallback) {
		this.minPaddingRight.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxPaddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_maxPaddingRight(callback: JavaScriptGetterCallback) {
		callback.returns(this.maxPaddingRight)
	}

	/**
	 * @method jsSet_maxPaddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_maxPaddingRight(callback: JavaScriptSetterCallback) {
		this.maxPaddingRight.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minPaddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_minPaddingBottom(callback: JavaScriptGetterCallback) {
		callback.returns(this.minPaddingBottom)
	}

	/**
	 * @method jsSet_minPaddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_minPaddingBottom(callback: JavaScriptSetterCallback) {
		this.minPaddingBottom.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxPaddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_maxPaddingBottom(callback: JavaScriptGetterCallback) {
		callback.returns(this.maxPaddingBottom)
	}

	/**
	 * @method jsSet_maxPaddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_maxPaddingBottom(callback: JavaScriptSetterCallback) {
		this.maxPaddingBottom.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_originX
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_originX(callback: JavaScriptGetterCallback) {
		callback.returns(this.originX)
	}

	/**
	 * @method jsSet_originX
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_originX(callback: JavaScriptSetterCallback) {
		this.originX.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_originY
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_originY(callback: JavaScriptGetterCallback) {
		callback.returns(this.originY)
	}

	/**
	 * @method jsSet_originY
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_originY(callback: JavaScriptSetterCallback) {
		this.originY.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_originZ
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_originZ(callback: JavaScriptGetterCallback) {
		callback.returns(this.originZ)
	}

	/**
	 * @method jsSet_originZ
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_originZ(callback: JavaScriptSetterCallback) {
		this.originZ.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_translationX
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_translationX(callback: JavaScriptGetterCallback) {
		callback.returns(this.translationX)
	}

	/**
	 * @method jsSet_translationX
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_translationX(callback: JavaScriptSetterCallback) {
		this.translationX.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_translationY
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_translationY(callback: JavaScriptGetterCallback) {
		callback.returns(this.translationY)
	}

	/**
	 * @method jsSet_translationY
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_translationY(callback: JavaScriptSetterCallback) {
		this.translationY.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_translationZ
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_translationZ(callback: JavaScriptGetterCallback) {
		callback.returns(this.translationZ)
	}

	/**
	 * @method jsSet_translationZ
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_translationZ(callback: JavaScriptSetterCallback) {
		this.translationZ.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_rotationX
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_rotationX(callback: JavaScriptGetterCallback) {
		callback.returns(this.rotationX)
	}

	/**
	 * @method jsSet_rotationX
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_rotationX(callback: JavaScriptSetterCallback) {
		this.rotationX.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_rotationY
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_rotationY(callback: JavaScriptGetterCallback) {
		callback.returns(this.rotationY)
	}

	/**
	 * @method jsSet_rotationY
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_rotationY(callback: JavaScriptSetterCallback) {
		this.rotationY.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_rotationZ
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_rotationZ(callback: JavaScriptGetterCallback) {
		callback.returns(this.rotationZ)
	}

	/**
	 * @method jsSet_rotationZ
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_rotationZ(callback: JavaScriptSetterCallback) {
		this.rotationZ.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scaleX
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_scaleX(callback: JavaScriptGetterCallback) {
		callback.returns(this.scaleX)
	}

	/**
	 * @method jsSet_scaleX
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_scaleX(callback: JavaScriptSetterCallback) {
		this.scaleX.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scaleY
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_scaleY(callback: JavaScriptGetterCallback) {
		callback.returns(this.scaleY)
	}

	/**
	 * @method jsSet_scaleY
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_scaleY(callback: JavaScriptSetterCallback) {
		this.scaleY.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scaleZ
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_scaleZ(callback: JavaScriptGetterCallback) {
		callback.returns(this.scaleZ)
	}

	/**
	 * @method jsSet_scaleZ
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_scaleZ(callback: JavaScriptSetterCallback) {
		this.scaleZ.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_zIndex
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_zIndex(callback: JavaScriptGetterCallback) {
		callback.returns(this.zIndex)
	}

	/**
	 * @method jsSet_zIndex
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_zIndex(callback: JavaScriptSetterCallback) {
		this.zIndex.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_zoomable
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_zoomable(callback: JavaScriptGetterCallback) {
		callback.returns(this.zoomable)
	}

	/**
	 * @method jsSet_zoomable
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_zoomable(callback: JavaScriptSetterCallback) {
		this.zoomable.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minZoom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_minZoom(callback: JavaScriptGetterCallback) {
		callback.returns(this.minZoom)
	}

	/**
	 * @method jsSet_minZoom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_minZoom(callback: JavaScriptSetterCallback) {
		this.minZoom.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxZoom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_maxZoom(callback: JavaScriptGetterCallback) {
		callback.returns(this.maxZoom)
	}

	/**
	 * @method jsSet_maxZoom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_maxZoom(callback: JavaScriptSetterCallback) {
		this.maxZoom.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_zoomedView
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_zoomedView(callback: JavaScriptGetterCallback) {
		callback.returns(this.zoomedView)
	}

	/**
	 * @method jsSet_zoomedView
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_zoomedView(callback: JavaScriptSetterCallback) {
		this.zoomedView = if (callback.value.isNull) null else callback.value.cast(JavaScriptView::class.java)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_touchable
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_touchable(callback: JavaScriptGetterCallback) {
		callback.returns(this.touchable)
	}

	/**
	 * @method jsSet_touchable
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_touchable(callback: JavaScriptSetterCallback) {
		this.touchable.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_touchOffsetTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_touchOffsetTop(callback: JavaScriptGetterCallback) {
		callback.returns(this.touchOffsetTop)
	}

	/**
	 * @method jsSet_touchOffsetTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_touchOffsetTop(callback: JavaScriptSetterCallback) {
		this.touchOffsetTop.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_touchOffsetLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_touchOffsetLeft(callback: JavaScriptGetterCallback) {
		callback.returns(this.touchOffsetLeft)
	}

	/**
	 * @method jsSet_touchOffsetLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_touchOffsetLeft(callback: JavaScriptSetterCallback) {
		this.touchOffsetLeft.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_touchOffsetRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_touchOffsetRight(callback: JavaScriptGetterCallback) {
		callback.returns(this.touchOffsetRight)
	}

	/**
	 * @method jsSet_touchOffsetRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_touchOffsetRight(callback: JavaScriptSetterCallback) {
		this.touchOffsetRight.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_touchOffsetBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_touchOffsetBottom(callback: JavaScriptGetterCallback) {
		callback.returns(this.touchOffsetBottom)
	}

	/**
	 * @method jsSet_touchOffsetBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_touchOffsetBottom(callback: JavaScriptSetterCallback) {
		this.touchOffsetBottom.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_visible
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_visible(callback: JavaScriptGetterCallback) {
		callback.returns(this.visible)
	}

	/**
	 * @method jsSet_visible
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_visible(callback: JavaScriptSetterCallback) {
		this.visible.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_opacity
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_opacity(callback: JavaScriptGetterCallback) {
		callback.returns(this.opacity)
	}

	/**
	 * @method jsSet_opacity
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_opacity(callback: JavaScriptSetterCallback) {
		this.opacity.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_drawable
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_drawable(callback: JavaScriptGetterCallback) {
		callback.returns(this.drawable)
	}

	/**
	 * @method jsSet_drawable
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_drawable(callback: JavaScriptSetterCallback) {
		this.drawable.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_clipped
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_clipped(callback: JavaScriptGetterCallback) {
		callback.returns(this.clipped)
	}

	/**
	 * @method jsSet_clipped
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_clipped(callback: JavaScriptSetterCallback) {
		this.clipped.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_paged
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_paged(callback: JavaScriptGetterCallback) {
		callback.returns(this.paged)
	}

	/**
	 * @method jsSet_paged
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_paged(callback: JavaScriptSetterCallback) {
		this.paged.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_measuredTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_measuredTop(callback: JavaScriptGetterCallback) {

		val measuredTop = this.layoutNode.measuredTop

		if (this.resolvedTop != measuredTop) {
			this.resolvedTop = measuredTop
			this.measuredTop.reset(null)
		}

		if (this.measuredTop.isNull) {
			this.measuredTop.reset(this.resolvedTop)
		}

		callback.returns(this.measuredTop)
	}

	/**
	 * @method jsGet_measuredLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_measuredLeft(callback: JavaScriptGetterCallback) {

		val measuredLeft = this.layoutNode.measuredLeft

		if (this.resolvedLeft != measuredLeft) {
			this.resolvedLeft = measuredLeft
			this.measuredLeft.reset(null)
		}

		if (this.measuredLeft.isNull) {
			this.measuredLeft.reset(this.resolvedLeft)
		}

		callback.returns(this.measuredLeft)
	}

	/**
	 * @method jsGet_measuredWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_measuredWidth(callback: JavaScriptGetterCallback) {

		val measuredWidth = this.layoutNode.measuredWidth

		if (this.resolvedWidth != measuredWidth) {
			this.resolvedWidth = measuredWidth
			this.measuredWidth.reset(null)
		}

		if (this.measuredWidth.isNull) {
			this.measuredWidth.reset(this.resolvedWidth)
		}

		callback.returns(this.measuredWidth)
	}

	/**
	 * @method jsGet_measuredHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_measuredHeight(callback: JavaScriptGetterCallback) {

		val measuredHeight = this.layoutNode.measuredHeight

		if (this.resolvedHeight != measuredHeight) {
			this.resolvedHeight = measuredHeight
			this.measuredHeight.reset(null)
		}

		if (this.measuredHeight.isNull) {
			this.measuredHeight.reset(this.resolvedHeight)
		}

		callback.returns(this.measuredHeight)
	}

	/**
	 * @method jsGet_measuredInnerWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_measuredInnerWidth(callback: JavaScriptGetterCallback) {

		val measuredInnerWidth = this.layoutNode.measuredInnerWidth

		if (this.resolvedInnerWidth != measuredInnerWidth) {
			this.resolvedInnerWidth = measuredInnerWidth
			this.measuredInnerWidth.reset(null)
		}

		if (this.measuredInnerWidth.isNull) {
			this.measuredInnerWidth.reset(this.resolvedInnerWidth)
		}

		callback.returns(this.measuredInnerWidth)
	}

	/**
	 * @method jsGet_measuredInnerHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_measuredInnerHeight(callback: JavaScriptGetterCallback) {

		val measuredInnerHeight = this.layoutNode.measuredInnerHeight

		if (this.resolvedInnerHeight != measuredInnerHeight) {
			this.resolvedInnerHeight = measuredInnerHeight
			this.measuredInnerHeight.reset(null)
		}

		if (this.measuredInnerHeight.isNull) {
			this.measuredInnerHeight.reset(this.resolvedInnerHeight)
		}

		callback.returns(this.measuredInnerHeight)
	}

	/**
	 * @method jsGet_measuredContentWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_measuredContentWidth(callback: JavaScriptGetterCallback) {

		val measuredContentWidth = this.layoutNode.measuredContentWidth

		if (this.resolvedContentWidth != measuredContentWidth) {
			this.resolvedContentWidth = measuredContentWidth
			this.measuredContentWidth.reset(null)
		}

		if (this.measuredContentWidth.isNull) {
			this.measuredContentWidth.reset(this.resolvedContentWidth)
		}

		callback.returns(this.measuredContentWidth)
	}

	/**
	 * @method jsGet_measuredContentHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_measuredContentHeight(callback: JavaScriptGetterCallback) {

		val measuredContentHeight = this.layoutNode.measuredContentHeight

		if (this.resolvedContentHeight != measuredContentHeight) {
			this.resolvedContentHeight = measuredContentHeight
			this.measuredContentHeight.reset(null)
		}

		if (this.measuredContentHeight.isNull) {
			this.measuredContentHeight.reset(this.resolvedContentHeight)
		}

		callback.returns(this.measuredContentHeight)
	}

	/**
	 * @method jsGet_measuredMarginTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_measuredMarginTop(callback: JavaScriptGetterCallback) {

		val measuredMarginTop = this.layoutNode.measuredTop

		if (this.resolvedMarginTop != measuredMarginTop) {
			this.resolvedMarginTop = measuredMarginTop
			this.measuredMarginTop.reset(null)
		}

		if (this.measuredMarginTop.isNull) {
			this.measuredMarginTop.reset(this.resolvedMarginTop)
		}

		callback.returns(this.measuredMarginTop)
	}

	/**
	 * @method jsGet_measuredMarginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_measuredMarginLeft(callback: JavaScriptGetterCallback) {

		val measuredMarginLeft = this.layoutNode.measuredMarginLeft

		if (this.resolvedMarginLeft != measuredMarginLeft) {
			this.resolvedMarginLeft = measuredMarginLeft
			this.measuredMarginLeft.reset(null)
		}

		if (this.measuredMarginLeft.isNull) {
			this.measuredMarginLeft.reset(this.resolvedMarginLeft)
		}

		callback.returns(this.measuredMarginLeft)
	}

	/**
	 * @method jsGet_measuredMarginRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_measuredMarginRight(callback: JavaScriptGetterCallback) {

		val measuredMarginRight = this.layoutNode.measuredMarginRight

		if (this.resolvedMarginRight != measuredMarginRight) {
			this.resolvedMarginRight = measuredMarginRight
			this.measuredMarginRight.reset(null)
		}

		if (this.measuredMarginRight.isNull) {
			this.measuredMarginRight.reset(this.resolvedMarginRight)
		}

		callback.returns(this.measuredMarginRight)
	}

	/**
	 * @method jsGet_measuredMarginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_measuredMarginBottom(callback: JavaScriptGetterCallback) {

		val measuredMarginBottom = this.layoutNode.measuredMarginBottom

		if (this.resolvedMarginBottom != measuredMarginBottom) {
			this.resolvedMarginBottom = measuredMarginBottom
			this.measuredMarginBottom.reset(null)
		}

		if (this.measuredMarginBottom.isNull) {
			this.measuredMarginBottom.reset(this.resolvedMarginBottom)
		}

		callback.returns(this.measuredMarginBottom)
	}

	/**
	 * @method jsGet_measuredPaddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_measuredPaddingTop(callback: JavaScriptGetterCallback) {

		val measuredPaddingTop = this.layoutNode.measuredPaddingTop

		if (this.resolvedPaddingTop != measuredPaddingTop) {
			this.resolvedPaddingTop = measuredPaddingTop
			this.measuredPaddingTop.reset(null)
		}

		if (this.measuredPaddingTop.isNull) {
			this.measuredPaddingTop.reset(this.resolvedPaddingTop)
		}

		callback.returns(this.measuredPaddingTop)
	}

	/**
	 * @method jsGet_measuredPaddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_measuredPaddingLeft(callback: JavaScriptGetterCallback) {

		val measuredPaddingLeft = this.layoutNode.measuredPaddingLeft

		if (this.resolvedPaddingLeft != measuredPaddingLeft) {
			this.resolvedPaddingLeft = measuredPaddingLeft
			this.measuredPaddingLeft.reset(null)
		}

		if (this.measuredPaddingLeft.isNull) {
			this.measuredPaddingLeft.reset(this.resolvedPaddingLeft)
		}

		callback.returns(this.measuredPaddingLeft)
	}

	/**
	 * @method jsGet_measuredPaddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_measuredPaddingRight(callback: JavaScriptGetterCallback) {

		val measuredPaddingRight = this.layoutNode.measuredPaddingRight

		if (this.resolvedPaddingRight != measuredPaddingRight) {
			this.resolvedPaddingRight = measuredPaddingRight
			this.measuredPaddingRight.reset(null)
		}

		if (this.measuredPaddingRight.isNull) {
			this.measuredPaddingRight.reset(this.resolvedPaddingRight)
		}

		callback.returns(this.measuredPaddingRight)
	}

	/**
	 * @method jsGet_measuredPaddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_measuredPaddingBottom(callback: JavaScriptGetterCallback) {

		val measuredPaddingBottom = this.layoutNode.measuredPaddingBottom

		if (this.resolvedPaddingBottom != measuredPaddingBottom) {
			this.resolvedPaddingBottom = measuredPaddingBottom
			this.measuredPaddingBottom.reset(null)
		}

		if (this.measuredPaddingBottom.isNull) {
			this.measuredPaddingBottom.reset(this.resolvedPaddingBottom)
		}

		callback.returns(this.measuredPaddingBottom)
	}

	//--------------------------------------------------------------------------
	// JS Funtions
	//--------------------------------------------------------------------------

	companion object {

		/**
		 * @method jsStaticFunction_transition
		 * @since 0.7.0
		 * @hidden
		 */
		@Suppress("unused")
		@JvmStatic
		public fun jsStaticFunction_transition(callback: JavaScriptFunctionCallback) {

			if (callback.arguments < 8) {
				return
			}

			val activity = callback.context.application

			val duration = callback.argument(0).number
			val equation = PathInterpolator(
				callback.argument(1).number.toFloat(),
				callback.argument(2).number.toFloat(),
				callback.argument(3).number.toFloat(),
				callback.argument(4).number.toFloat()
			)

			val delay = callback.argument(5).number

			val complete = callback.argument(6)
			val function = callback.argument(7)

			val animate = {

				Transition.create(
					activity,
					duration,
					equation,
					delay
				)

				function.call()
				complete.protect()

				Transition.commit {
					complete.call()
					complete.unprotect()
				}
			}

			if (callback.context.application.layout.resolving) {
				callback.context.application.layout.requestLayoutEndedCallback(animate)
				return
			}

			animate()
		}
	}

	/**
	 * @method jsFunction_destroy
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_destroy(callback: JavaScriptFunctionCallback) {
		this.dispose()
	}

	/**
	 * @method jsFunction_createShadowRoot
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_createShadowRoot(callback: JavaScriptFunctionCallback) {
		this.isShadowRoot = true
	}

	/**
	 * @method jsFunction_insert
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_insert(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 2) {
			fatalError("Method JavaScriptView.insert() requires 2 arguments.")
		}

		val child = callback.argument(0).cast(JavaScriptView::class.java)
		val index = callback.argument(1).number

		if (child != null) {
			this.insert(child, index.toInt())
		}
	}

	/**
	 * @method jsFunction_remove
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_remove(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptView.remove() requires 1 argument.")
		}

		val child = callback.argument(0).cast(JavaScriptView::class.java)

		if (child != null) {
			this.remove(child)
		}
	}

	/**
	 * @method jsFunction_hasStyle
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_hasStyle(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptView.hasStyle() requires 1 argument.")
		}

		callback.returns(this.stylerNode.hasStyle(callback.argument(0).string))
	}

	/**
	 * @method jsFunction_setStyle
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_setStyle(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 2) {
			fatalError("Method JavaScriptView.setStyle() requires 2 arguments.")
		}

		val style = callback.argument(0).string
		val apply = callback.argument(1).boolean

		this.stylerNode.setStyle(style, apply)
	}

	/**
	 * @method jsFunction_hasState
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_hasState(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptView.hasState() requires 1 argument.")
		}

		callback.returns(this.stylerNode.hasState(callback.argument(0).string))
	}

	/**
	 * @method jsFunction_setState
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_setState(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 2) {
			fatalError("Method JavaScriptView.setState() requires 2 arguments.")
		}

		val state = callback.argument(0).string
		val apply = callback.argument(1).boolean

		this.stylerNode.setState(state, apply)
	}

	/**
	 * @method jsFunction_scheduleRedraw
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_scheduleRedraw(callback: JavaScriptFunctionCallback) {
		this.scheduleRedraw()
	}

	/**
	 * @method jsFunction_scheduleLayout
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_scheduleLayout(callback: JavaScriptFunctionCallback) {
		this.scheduleLayout()
	}

	/**
	 * @method jsFunction_resolve
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_resolve(callback: JavaScriptFunctionCallback) {
		this.resolve()
	}

	/**
	 * @method jsFunction_measure
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_measure(callback: JavaScriptFunctionCallback) {
		this.stylerNode.resolve()
		this.layoutNode.measure()
	}

	/**
	 * @method jsFunction_scrollTo
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_scrollTo(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 2) {
			fatalError("Method JavaScriptView.scrollTo() requires 2 arguments.")
		}

		val y = Convert.toPx(callback.argument(1).number).toInt()
		val x = Convert.toPx(callback.argument(0).number).toInt()

		val scrollable = this.content
		if (scrollable is Scrollable) {
			scrollable.scrollTo(x, y)
		}
	}

	//--------------------------------------------------------------------------
	// Interfaces
	//--------------------------------------------------------------------------

	/**
	 * The view's listener.
	 * @class ViewDelegate
	 * @since 0.7.0
	 */
	public interface Listener {
		fun onBeginLayout(view: JavaScriptView)
		fun onFinishLayout(view: JavaScriptView)
		fun onScroll(view: JavaScriptView)
	}
}