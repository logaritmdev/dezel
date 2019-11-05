import UIKit
import QuartzCore

/**
 * The base class for view types.
 * @class JavaScriptView
 * @since 0.7.0
 */
open class JavaScriptView: JavaScriptClass, DisplayNodeDelegate, ScrollableDelegate, SynchronizerCallback {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The view's delegate.
	 * @property delegate
	 * @since 0.7.0
	 */
	open weak var delegate: Delegate?

	/**
	 * The view's display node.
	 * @property displayNode
	 * @since 0.7.0
	 */
	private(set) public var node: DisplayNode!

	/**
	 * The view's content wrapper view.
	 * @property wrapper
	 * @since 0.7.0
	 */
	private(set) public var wrapper: WrapperView!

	/**
	 * The view that displays this view's content.
	 * @property content
	 * @since 0.7.0
	 */
	private(set) public var content: UIView!

	/**
	 * The view's JavaScript window.
	 * @property window
	 * @since 0.7.0
	 */
	private(set) public var window: JavaScriptWindow?

	/**
	 * The view's JavaScript parent.
	 * @property parent
	 * @since 0.7.0
	 */
	private(set) public var parent: JavaScriptView?

	/**
	 * The view's children.
	 * @property children
	 * @since 0.7.0
	 */
	private(set) public var children: [JavaScriptView] = []

	/**
	 * The view's resolved top.
	 * @property resolvedTop
	 * @since 0.7.0
	 */
	private(set) public var resolvedTop: Double = 0

	/**
	 * The view's resolved left.
	 * @property resolvedLeft
	 * @since 0.7.0
	 */
	private(set) public var resolvedLeft: Double = 0

	/**
	 * The view's resolved width.
	 * @property resolvedWidth
	 * @since 0.7.0
	 */
	private(set) public var resolvedWidth: Double = 0

	/**
	 * The view's resolved height.
	 * @property resolvedHeight
	 * @since 0.7.0
	 */
	private(set) public var resolvedHeight: Double = 0

	/**
	 * The view's resolved inner width.
	 * @property resolvedInnerWidth
	 * @since 0.7.0
	 */
	private(set) public var resolvedInnerWidth: Double = 0

	/**
	 * The view's resolved inner height.
	 * @property resolvedInnerHeight
	 * @since 0.7.0
	 */
	private(set) public var resolvedInnerHeight: Double = 0

	/**
	 * The view's resolved content width.
	 * @property resolvedContentWidth
	 * @since 0.7.0
	 */
	private(set) public var resolvedContentWidth: Double = 0

	/**
	 * The view's resolved content height.
	 * @property resolvedContentHeight
	 * @since 0.7.0
	 */
	private(set) public var resolvedContentHeight: Double = 0

	/**
	 * The view's resolved margin top.
	 * @property resolvedMarginTop
	 * @since 0.7.0
	 */
	private(set) public var resolvedMarginTop: Double = 0

	/**
	 * The view's resolved margin left.
	 * @property resolvedMarginLeft
	 * @since 0.7.0
	 */
	private(set) public var resolvedMarginLeft: Double = 0

	/**
	 * The view's resolved margin right.
	 * @property resolvedMarginRight
	 * @since 0.7.0
	 */
	private(set) public var resolvedMarginRight: Double = 0

	/**
	 * The view's resolved margin bottom.
	 * @property resolvedMarginBottom
	 * @since 0.7.0
	 */
	private(set) public var resolvedMarginBottom: Double = 0

	/**
	 * The view's resolved border top width.
	 * @property resolvedBorderTopWidth
	 * @since 0.7.0
	 */
	private(set) public var resolvedBorderTopWidth: Double = 0

	/**
	 * The view's resolved border left width.
	 * @property resolvedBorderLeftWidth
	 * @since 0.7.0
	 */
	private(set) public var resolvedBorderLeftWidth: Double = 0

	/**
	 * The view's resolved border right width.
	 * @property resolvedBorderRightWidth
	 * @since 0.7.0
	 */
	private(set) public var resolvedBorderRightWidth: Double = 0

	/**
	 * The view's resolved border bottom width.
	 * @property resolvedBorderBottomWidth
	 * @since 0.7.0
	 */
	private(set) public var resolvedBorderBottomWidth: Double = 0

	/**
	 * The view's resolved padding top.
	 * @property resolvedPaddingTop
	 * @since 0.7.0
	 */
	private(set) public var resolvedPaddingTop: Double = 0

	/**
	 * The view's resolved padding left.
	 * @property resolvedPaddingLeft
	 * @since 0.7.0
	 */
	private(set) public var resolvedPaddingLeft: Double = 0

	/**
	 * The view's resolved padding right.
	 * @property resolvedPaddingRight
	 * @since 0.7.0
	 */
	private(set) public var resolvedPaddingRight: Double = 0

	/**
	 * The view's resolved padding bottom.
	 * @property resolvedPaddingBottom
	 * @since 0.7.0
	 */
	private(set) public var resolvedPaddingBottom: Double = 0

	/**
	 * @property resolvedTranslationX
	 * @since 0.7.0
	 * @hidden
	 */
	private(set) public var resolvedTranslationX: Double = 0.0

	/**
	 * @property resolvedTranslationY
	 * @since 0.7.0
	 * @hidden
	 */
	private(set) public var resolvedTranslationY: Double = 0.0

	/**
	 * @property resolvedTranslationZ
	 * @since 0.7.0
	 * @hidden
	 */
	private(set) public var resolvedTranslationZ: Double = 0.0

	/**
	 * @property resolvedRotationX
	 * @since 0.7.0
	 * @hidden
	 */
	private(set) public var resolvedRotationX: Double = 0.0

	/**
	 * @property resolvedRotationY
	 * @since 0.7.0
	 * @hidden
	 */
	private(set) public var resolvedRotationY: Double = 0.0

	/**
	 * @property resolvedRotationZ
	 * @since 0.7.0
	 * @hidden
	 */
	private(set) public var resolvedRotationZ: Double = 0.0

	/**
	 * Whether the view's frame has been resolved.
	 * @property resolvedFrame
	 * @since 0.7.0
	 */
	private(set) public var resolvedFrame: Bool = false

	/**
	 * @property zoomedView
	 * @since 0.7.0
	 * @hidden
	 */
	private var zoomedView: JavaScriptView? {
		willSet {
			self.scrollableView?.zoomedView = newValue?.wrapper
		}
	}

	/**
	 * @property scrollableView
	 * @since 0.7.0
	 * @hidden
	 */
	private var scrollableView: Scrollable? {
		return self.content as? Scrollable
	}

	/**
	 * @property backgroundImageData
	 * @since 0.7.0
	 * @hidden
	 */
	private var backgroundImageData: UIImage? {
		willSet {
			self.invalidateBitmapImage()
		}
	}

	/**
	 * @property backgroundImageLoader
	 * @since 0.7.0
	 * @hidden
	 */
	private var backgroundImageLoader: ImageLoader = ImageLoader()

	/**
	 * @property canvas
	 * @since 0.7.0
	 * @hidden
	 */
	private var canvas: JavaScriptCanvas?

	/**
	 * @property updateScheduled
	 * @since 0.7.0
	 * @hidden
	 */
	private var updateScheduled: Bool = false

	/**
	 * @property invalidFrame
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidFrame: Bool = false

	/**
	 * @property invalidShadow
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidShadow: Bool = false

	/**
	 * @property invalidBorder
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidBorder: Bool = false

	/**
	 * @property invalidBitmapColor
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidBitmapColor: Bool = false

	/**
	 * @property invalidBitmapImage
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidBitmapImage: Bool = false

	/**
	 * @property invalidTransform
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidTransform: Bool = false

	/**
	 * @property invalidContent
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidContent: Bool = false

	/**
	 * @property disposed
	 * @since 0.7.0
	 * @hidden
	 */
	private var disposed: Bool = false

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public required init(context: JavaScriptContext) {

		super.init(context: context)

		self.node = DisplayNode(display: context.application.display)
		self.node.delegate = self

		self.content = self.createContentView()
		self.wrapper = self.createWrapperView()

		if let scrollable = self.content as? Scrollable {
			scrollable.scrollableDelegate = self
		}

		self.wrapper.draw = { [weak self] ctx in
			// TODO
			// Pass the instance
			guard let view = self else {
				return
			}

			if (view.canvas == nil) {
				view.canvas = view.createCanvas()
			}

			let canvas = view.canvas!

			canvas.use(ctx)
			view.callMethod("nativeOnRedraw", arguments: [canvas])
			canvas.use(nil)
		}

		self.scheduleUpdate()
	}

	/**
	 * @inherited
	 * @method dispose
	 * @since 0.7.0
	 */
	override open func dispose() {

		if (self.disposed) {
			return
		}

		self.disposed = true

		self.canvas = nil
		self.wrapper.removeFromSuperview()
		self.content.removeFromSuperview()

		super.dispose()
	}

	/**
	 * Creates the wrapper view.
	 * @method createWrapperView
	 * @since 0.7.0
	 */
	open func createWrapperView() -> WrapperView {
		return WrapperView(content: self.content)
	}

	/**
	 * Creates the content view.
	 * @method createContentView
	 * @since 0.7.0
	 */
	open func createContentView() -> UIView {
		return View(frame: .zero)
	}

	/**
	 * Inserts a view into this view's content.
	 * @method insert
	 * @since 0.7.0
	 */
	open func insert(_ view: JavaScriptView, at index: Int, notify: Bool = true) {

		let parent = self
		var window = self.window

		if (window == nil && self is JavaScriptWindow) {
			window = self as? JavaScriptWindow
		}

		view.moveToParent(parent, notify: notify)
		view.moveToWindow(window, notify: notify)

		self.insertChild(view, at: index)
	}

	/**
	 * Removes a view from this view's content.
	 * @method remove
	 * @since 0.7.0
	 */
	open func remove(_ view: JavaScriptView, notify: Bool = true) {

		guard let _ = self.children.firstIndex(of: view) else {
			return
		}

		view.moveToParent(nil, notify: notify)
		view.moveToWindow(nil, notify: notify)

		self.removeChild(view)
	}

	/**
	 * Inserts this view into a receiving view.
	 * @method inject
	 * @since 0.7.0
	 */
	open func inject(_ view: JavaScriptView, at index: Int, notify: Bool = true) {

		let parent = self
		var window = self.window

		if (window == nil && self is JavaScriptWindow) {
			window = self as? JavaScriptWindow
		}

		view.moveToParent(parent, notify: notify)
		view.moveToWindow(window, notify: notify)

		self.insertChild(view, at: index)
	}

	/**
	 * Returns this view within the specified bounds.
	 * @method measure
	 * @since 0.7.0
	 */
	open func measure(in bounds: CGSize, min: CGSize, max: CGSize) -> CGSize? {
		return nil
	}

	/**
	 * Measures this view without performing a layout.
	 * @method measure
	 * @since 0.7.0
	 */
	open func measure() {
		self.node.measure()
	}

	/**
	 * Resolves this view styles and layout.
	 * @method resolve
	 * @since 0.7.0
	 */
	open func resolve() {
		self.node.resolve()
	}

	/**
	 * Schedules a layout pass on the next update cycle.
	 * @method scheduleLayout
	 * @since 0.7.0
	 */
	open func scheduleLayout() {
		self.node.invalidateLayout()
	}

	/**
	 * Schedules a redraw pass on the next update cycle.
	 * @method scheduleRedraw
	 * @since 0.7.0
	 */
	open func scheduleRedraw() {

		if (self.drawable.boolean == false) {
			self.drawable.reset(true)
			return
		}

		self.wrapper.scheduleRedraw()
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - View updates
	//--------------------------------------------------------------------------

	/**
	 * Schedules a update on the next cycle.
	 * @method scheduleUpdate
	 * @since 0.7.0
	 */
	open func scheduleUpdate() {
		if (self.updateScheduled == false) {
			self.updateScheduled = true
			Synchronizer.main.schedule(self)
		}
	}

	/**
	 * Dispatches the update to the receivers.
	 * @method performUpdate
	 * @since 0.7.0
	 */
	open func performUpdate() {

		self.update()

		if let content = self.content as? Updatable {
			content.update()
		}
	}

	/**
	 * Updates the visual aspects of the view.
	 * @method update
	 * @since 0.7.0
	 */
	open func update() {

		self.resolve()

		if (self.invalidShadow) {
			self.invalidShadow = false
			self.updateShadow()
		}

		if (self.invalidBorder) {
			self.invalidBorder = false
			self.updateBorder()
		}

		if (self.invalidBitmapColor) {
			self.invalidBitmapColor = false
			self.updateBitmapColor()
		}

		if (self.invalidBitmapImage) {
			self.invalidBitmapImage = false
			self.updateBitmapImage()
		}

		if (self.invalidTransform) {
			self.invalidTransform = false
			self.updateTransform()
		}

		if (self.invalidFrame) {
			self.invalidFrame = false
			self.updateFrame()
		}

		self.wrapper.update()

		if (self.invalidContent) {
			self.invalidContent = false
			self.updateContent()
		}

		if (self.wrapper.hasFrame == false && self.resolvedFrame) {
			self.wrapper.hasFrame = true
		}

		self.updateScheduled = false
	}

	/**
	 * Updates the view's frame.
	 * @method updateFrame
	 * @since 0.7.0
	 */
	open func updateFrame() {

		var originX = 0.5
		var originY = 0.5

		if (self.originX.type == .number) { originX = self.originX.number }
		if (self.originY.type == .number) { originY = self.originY.number }

		let t = self.resolvedTop
		let l = self.resolvedLeft
		let w = self.resolvedWidth
		let h = self.resolvedHeight

		self.wrapper.layer.anchorPoint = CGPoint(
			x: originX,
			y: originY
		)

		let center = CGPoint(
			x: CGFloat(l) + ((1 + CGFloat(originX)) * CGFloat(w)) - CGFloat(w),
			y: CGFloat(t) + ((1 + CGFloat(originY)) * CGFloat(h)) - CGFloat(h)
		)

		let bounds = CGRect(
			x: 0, y: 0,
			width: CGFloat(w),
			height: CGFloat(h)
		)

		self.wrapper.center = center
		self.wrapper.bounds = bounds

		self.resolvedFrame = true
	}

	/**
	 * Updates the view's shadow.
	 * @method updateShadow
	 * @since 0.7.0
	 */
	open func updateShadow() {
		self.wrapper.shadowBlur = CGFloat(self.shadowBlur.number)
		self.wrapper.shadowColor = CGColorParse(self.shadowColor.string)
		self.wrapper.shadowOffsetTop = CGFloat(self.shadowOffsetTop.number)
		self.wrapper.shadowOffsetLeft = CGFloat(self.shadowOffsetLeft.number)
	}

	/**
	 * Updates the view's border.
	 * @method updateBorder
	 * @since 0.7.0
	 */
	open func updateBorder() {
		self.wrapper.borderTopWidth = CGFloat(self.resolvedBorderTopWidth)
		self.wrapper.borderLeftWidth = CGFloat(self.resolvedBorderLeftWidth)
		self.wrapper.borderRightWidth = CGFloat(self.resolvedBorderRightWidth)
		self.wrapper.borderBottomWidth = CGFloat(self.resolvedBorderBottomWidth)
		self.wrapper.borderTopLeftRadius = CGFloat(self.borderTopLeftRadius.number)
		self.wrapper.borderTopRightRadius = CGFloat(self.borderTopRightRadius.number)
		self.wrapper.borderBottomLeftRadius = CGFloat(self.borderBottomLeftRadius.number)
		self.wrapper.borderBottomRightRadius = CGFloat(self.borderBottomRightRadius.number)
	}

	/**
	 * Updates the view's background color.
	 * @method updateBitmapColor
	 * @since 0.7.0
	 */
	open func updateBitmapColor() {

		let isLinearGradient = self.backgroundColor.string.hasPrefix("linear-gradient")
		let isRadialGradient = self.backgroundColor.string.hasPrefix("radial-gradient")

		self.wrapper.backgroundRadialGradient = nil
		self.wrapper.backgroundLinearGradient = nil

		if (isLinearGradient || isRadialGradient) {

			self.wrapper.backgroundKolor = nil

			if (isLinearGradient) {
				self.wrapper.backgroundLinearGradient = LinearGradient(value: self.backgroundColor.string)
				return
			}

			if (isRadialGradient) {
				self.wrapper.backgroundRadialGradient = RadialGradient(value: self.backgroundColor.string)
				return
			}

		} else {
			self.wrapper.backgroundKolor = CGColorParse(self.backgroundColor.string)
		}
	}

	/**
	 * Updates the view's background image.
	 * @method updateBitmapImage
	 * @since 0.7.0
	 */
	open func updateBitmapImage() {

		self.wrapper.backgroundImage = nil

		guard let image = self.backgroundImageData else {
			return
		}

		var autoW = false
		var autoH = false
		var backgroundImageW = 0.0
		var backgroundImageH = 0.0
		var backgroundImageT = 0.0
		var backgroundImageL = 0.0

		if (self.backgroundImageWidth.type == .string &&
			self.backgroundImageWidth.string == "auto") {

			autoW = true

		} else {

			switch (self.backgroundImageWidth.unit) {

				case .pc: backgroundImageW = self.backgroundImageWidth.number / 100 * self.resolvedWidth
				case .vw: backgroundImageW = self.backgroundImageWidth.number / 100 * self.node.display.viewportWidth;
				case .vh: backgroundImageW = self.backgroundImageWidth.number / 100 * self.node.display.viewportHeight
				case .pw: backgroundImageW = self.backgroundImageWidth.number / 100 * self.resolvedInnerWidth
				case .ph: backgroundImageW = self.backgroundImageWidth.number / 100 * self.resolvedInnerHeight
				case .cw: backgroundImageW = self.backgroundImageWidth.number / 100 * self.resolvedContentWidth
				case .ch: backgroundImageW = self.backgroundImageWidth.number / 100 * self.resolvedContentHeight

				default:
					backgroundImageW = self.backgroundImageWidth.number
					break
			}
		}

		if (self.backgroundImageHeight.type == .string &&
			self.backgroundImageHeight.string == "auto") {

			autoH = true

		} else {

			switch (self.backgroundImageHeight.unit) {

				case .pc: backgroundImageH = self.backgroundImageHeight.number / 100 * self.resolvedHeight
				case .vw: backgroundImageH = self.backgroundImageHeight.number / 100 * self.node.display.viewportWidth
				case .vh: backgroundImageH = self.backgroundImageHeight.number / 100 * self.node.display.viewportHeight
				case .pw: backgroundImageH = self.backgroundImageHeight.number / 100 * self.resolvedInnerWidth
				case .ph: backgroundImageH = self.backgroundImageHeight.number / 100 * self.resolvedInnerHeight
				case .cw: backgroundImageH = self.backgroundImageHeight.number / 100 * self.resolvedContentWidth
				case .ch: backgroundImageH = self.backgroundImageHeight.number / 100 * self.resolvedContentHeight

				default:
					backgroundImageH = self.backgroundImageHeight.number
					break
			}
		}

		switch (self.backgroundImageTop.unit) {

			case .pc: backgroundImageT = self.backgroundImageTop.number / 100 * self.resolvedHeight
			case .vw: backgroundImageT = self.backgroundImageTop.number / 100 * self.node.display.viewportWidth
			case .vh: backgroundImageT = self.backgroundImageTop.number / 100 * self.node.display.viewportHeight
			case .pw: backgroundImageT = self.backgroundImageTop.number / 100 * self.resolvedInnerWidth
			case .ph: backgroundImageT = self.backgroundImageTop.number / 100 * self.resolvedInnerHeight
			case .cw: backgroundImageT = self.backgroundImageTop.number / 100 * self.resolvedContentWidth
			case .ch: backgroundImageT = self.backgroundImageTop.number / 100 * self.resolvedContentHeight

			default:
				backgroundImageT = self.backgroundImageTop.number
				break
		}

		switch (self.backgroundImageLeft.unit) {

			case .pc: backgroundImageL = self.backgroundImageLeft.number / 100 * self.resolvedWidth
			case .vw: backgroundImageL = self.backgroundImageLeft.number / 100 * self.node.display.viewportWidth
			case .vh: backgroundImageL = self.backgroundImageLeft.number / 100 * self.node.display.viewportHeight
			case .pw: backgroundImageL = self.backgroundImageLeft.number / 100 * self.resolvedInnerWidth
			case .ph: backgroundImageL = self.backgroundImageLeft.number / 100 * self.resolvedInnerHeight
			case .cw: backgroundImageL = self.backgroundImageLeft.number / 100 * self.resolvedContentWidth
			case .ch: backgroundImageL = self.backgroundImageLeft.number / 100 * self.resolvedContentHeight

			default:
				backgroundImageL = self.backgroundImageLeft.number
				break
		}

		let naturalImageW = Double(image.size.width)
		let naturalImageH = Double(image.size.height)

		let frameW = self.resolvedWidth
		let frameH = self.resolvedHeight
		let scaleX = frameW / naturalImageW
		let scaleY = frameH / naturalImageH

		if (autoW && autoH) {

			switch (self.backgroundImageFit.string) {

				case "none":
					backgroundImageW = naturalImageW
					backgroundImageH = naturalImageH

				case "cover":
					let scale = max(scaleX, scaleY)
					backgroundImageW = naturalImageW * scale
					backgroundImageH = naturalImageH * scale

				case "contain":
					let scale = min(scaleX, scaleY)
					backgroundImageW = naturalImageW * scale
					backgroundImageH = naturalImageH * scale

				default: break
			}

		} else if (autoW) {
			backgroundImageW = backgroundImageH * (naturalImageW / naturalImageH)
		} else if (autoH) {
			backgroundImageH = backgroundImageW * (naturalImageH / naturalImageW)
		}

		let anchorT = self.getBackgroundImageAnchorTop(self.backgroundImageAnchorTop)
		let anchorL = self.getBackgroundImageAnchorLeft(self.backgroundImageAnchorLeft)

		backgroundImageT = backgroundImageT - (anchorT * backgroundImageH)
		backgroundImageL = backgroundImageL - (anchorL * backgroundImageW)

		self.wrapper.backgroundImage = image
		self.wrapper.backgroundImageTop = CGFloat(backgroundImageT)
		self.wrapper.backgroundImageLeft = CGFloat(backgroundImageL)
		self.wrapper.backgroundImageWidth = CGFloat(backgroundImageW)
		self.wrapper.backgroundImageHeight = CGFloat(backgroundImageH)
	}

	/**
	 * Update the view's transform.
	 * @method updateTransform
	 * @since 0.7.0
	 */
	open func updateTransform() {

		var transform = CATransform3DIdentity

		let viewW = self.resolvedWidth
		let viewH = self.resolvedHeight
		let viewportW = self.node.display.viewportWidth
		let viewportH = self.node.display.viewportHeight
		let parentW = self.parent?.resolvedInnerWidth ?? 0
		let parentH = self.parent?.resolvedInnerHeight ?? 0
		let containerW = self.parent?.resolvedContentWidth ?? 0
		let containerH = self.parent?.resolvedContentHeight ?? 0

		var tx = 0.0
		var ty = 0.0
		let tz = self.translationZ.number

		if (self.translationX.type == .number) {

			switch (self.translationX.unit) {

				case .pc: tx = (self.translationX.number / 100) * viewW
				case .vw: tx = (self.translationX.number / 100) * viewportW
				case .vh: tx = (self.translationX.number / 100) * viewportH
				case .pw: tx = (self.translationX.number / 100) * parentW
				case .ph: tx = (self.translationX.number / 100) * parentH
				case .cw: tx = (self.translationX.number / 100) * containerW
				case .ch: tx = (self.translationX.number / 100) * containerH

				default:
					tx = self.translationX.number
			}
		}

		if (self.translationY.type == .number) {

			switch (self.translationY.unit) {

				case .pc: ty = (self.translationY.number / 100) * viewH
				case .vw: ty = (self.translationY.number / 100) * viewportW
				case .vh: ty = (self.translationY.number / 100) * viewportH
				case .pw: ty = (self.translationY.number / 100) * parentW
				case .ph: ty = (self.translationY.number / 100) * parentH
				case .cw: ty = (self.translationY.number / 100) * containerW
				case .ch: ty = (self.translationY.number / 100) * containerH

				default:
					ty = self.translationY.number
			}
		}

		self.resolvedTranslationX = tx
		self.resolvedTranslationY = ty
		self.resolvedTranslationZ = tz

		if (tx != 0 || ty != 0 || tz != 0) {
			transform = CATransform3DTranslate(transform, CGFloat(tx), CGFloat(ty), CGFloat(tz))
		}

		var rx = 0.0
		var ry = 0.0
		var rz = 0.0

		if (self.rotationX.type == .number) {

			switch (self.rotationX.unit) {

				case .deg: rx = self.rotationX.number * Double.pi / 180
				case .rad: rx = self.rotationX.number

				default:
					rx = self.rotationX.number
			}
		}

		if (self.rotationY.type == .number) {

			switch (self.rotationY.unit) {

				case .deg: ry = self.rotationY.number * Double.pi / 180
				case .rad: ry = self.rotationY.number

				default:
					ry = self.rotationY.number
			}
		}

		if (self.rotationZ.type == .number) {

			switch (self.rotationZ.unit) {

				case .deg: rz = self.rotationZ.number * Double.pi / 180
				case .rad: rz = self.rotationZ.number

				default:
					rz = self.rotationZ.number
			}
		}

		self.resolvedTranslationX = tx
		self.resolvedTranslationY = ty
		self.resolvedTranslationZ = tz

		if (rx != 0) { transform = CATransform3DRotate(transform, CGFloat(rx), 1, 0, 0) }
		if (ry != 0) { transform = CATransform3DRotate(transform, CGFloat(ry), 0, 1, 0) }
		if (rz != 0) { transform = CATransform3DRotate(transform, CGFloat(rz), 0, 0, 1) }

		var sx = 1.0
		var sy = 1.0
		var sz = self.scaleZ.number

		if (self.scaleX.type == .number) { sx = self.scaleX.number }
		if (self.scaleY.type == .number) { sy = self.scaleY.number }
		if (self.scaleZ.type == .number) { sz = self.scaleZ.number }

		if (sx != 1 || sy != 1 || sz != 1) {
			transform = CATransform3DScale(transform, CGFloat(sx), CGFloat(sy), CGFloat(sz))
		}

		if (rx != 0 || ry != 0 || tz != 0 || sz != 1) {
			transform.m34 = -1.0 / 500
		}

		self.wrapper.layer.transform = transform
	}

	/**
	 * Update the view's content.
	 * @method updateContent
	 * @since 0.7.0
	 */
	open func updateContent() {
		self.scrollableView?.scrollWidth = CGFloat(self.resolvedContentWidth)
		self.scrollableView?.scrollHeight = CGFloat(self.resolvedContentHeight)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - View Hit Testing
	//--------------------------------------------------------------------------

	/**
	 * Indicates whether the point is contained within this view.
	 * @method isPointInView
	 * @since 0.7.0
	 */
	open func isPointInView(point: Point3D) -> Bool {

		let x = point.x
		let y = point.y

		let w = self.resolvedWidth
		let h = self.resolvedHeight

		let xmin = self.touchOffsetLeft.number
		let ymin = self.touchOffsetTop.number
		let xmax = w + -self.touchOffsetRight.number
		let ymax = h + -self.touchOffsetBottom.number

		return x >= xmin && x <= xmax && y >= ymin && y <= ymax
	}

	/**
	 * Finds the view at the specific point.
	 * @method findViewAt
	 * @since 0.7.0
	 */
	open func findViewAt(point: Point3D, matrix: Transform3D, visible: Bool = true, touchable: Bool = true) -> JavaScriptView? {

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

		if (self.touchable.boolean == false) {
			return nil
		}

		let x = point.x
		let y = point.y

		let a1 = matrix.a1
		let a2 = matrix.a2
		let a3 = matrix.a3
		let a4 = matrix.a4
		let b1 = matrix.b1
		let b2 = matrix.b2
		let b3 = matrix.b3
		let b4 = matrix.b4
		let c1 = matrix.c1
		let c2 = matrix.c2
		let c3 = matrix.c3
		let c4 = matrix.c4
		let d1 = matrix.d1
		let d2 = matrix.d2
		let d3 = matrix.d3
		let d4 = matrix.d4

		if (self.isPointInView(point: point) == false || (self.scrolling.boolean == true && self.dragging.boolean == false)) {
			return nil
		}

		let scrollT = self.scrollTop.number
		let scrollL = self.scrollLeft.number

		let borderWidthT = self.resolvedBorderTopWidth
		let borderWidthL = self.resolvedBorderLeftWidth

		if (self.children.count > 0) {

			let children = self.children.sorted { a, b in
				return a.zIndex.number < b.zIndex.number
			}

			for i in (0 ..< children.count).reversed() {

				let node = children[i]

				if ((node.visible.boolean == false && visible) ||
					(node.touchable.boolean == false && touchable)) {
					continue
				}

				point.x -= node.resolvedLeft + borderWidthL - scrollL
				point.y -= node.resolvedTop + borderWidthT - scrollT

				if (node.isTransformed()) {

					let ox = 0.5
					let oy = 0.5
					let oz = node.originZ.number
					let tx = node.resolvedTranslationX
					let ty = node.resolvedTranslationY
					let tz = node.resolvedTranslationZ
					let rx = node.resolvedRotationX
					let ry = node.resolvedRotationY
					let rz = node.resolvedRotationZ
					let sx = node.scaleX.number
					let sy = node.scaleY.number
					let sz = node.scaleZ.number

					if (ox != 0.0 ||
						oy != 0.0 ||
						oz != 0.0) {
						matrix.translate(
							x: ox,
							y: oy,
							z: oz
						)
					}

					if (rx != 0.0) { matrix.rotate(x: 1.0, y: 0.0, z: 0.0, angle: -rx) }
					if (ry != 0.0) { matrix.rotate(x: 0.0, y: 1.0, z: 0.0, angle: -ry) }
					if (rz != 0.0) { matrix.rotate(x: 0.0, y: 0.0, z: 1.0, angle: -rz) }

					if (sx != 1.0 ||
						sy != 1.0 ||
						sz != 1.0) {
						matrix.scale(
							x: 1 / sx,
							y: 1 / sy,
							z: 1 / sz
						)
					}

					if (ox != 0.0 ||
						oy != 0.0 ||
						oz != 0.0) {
						matrix.translate(
							x: -ox,
							y: -oy,
							z: -oz
						)
					}

					if (tx != 0.0 ||
						ty != 0.0 ||
						tz != 0.0) {
						matrix.translate(
							x: -tx,
							y: -ty,
							z: -tz
						)
					}

					if (tz != 0.0 ||
						rz != 0.0 ||
						sz != 1.0) {
						matrix.perspective(d: -800.0)
					}

					matrix.transform(point: point)
				}

				let result = node.findViewAt(point: point, matrix: matrix, visible: visible, touchable: touchable)

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

				if (result != nil) {
					return result
				}
			}
		}

		return self
	}

	/**
	 * Creates the canvas object used to draw inside this view.
	 * @method createCanvas
	 * @since 0.7.0
	 */
	open func createCanvas() -> JavaScriptCanvas? {
		return nil // TODO FIX THIS
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Layout Node Delegate
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method measure
	 * @since 0.7.0
	 */
	open func measure(node: DisplayNode, in bounds: CGSize, min: CGSize, max: CGSize) -> CGSize? {
		return self.measure(in: bounds, min: min, max: max)
	}

	/**
	 * @inherited
	 * @method didResolveSize
	 * @since 0.7.0
	 */
	open func didResolveSize(node: DisplayNode) {

		if (self.resolvedWidth != self.node.measuredWidth) {
			self.resolvedWidth = self.node.measuredWidth
			self.measuredWidth.reset()
			self.invalidateFrame()
		}

		if (self.resolvedHeight != self.node.measuredHeight) {
			self.resolvedHeight = self.node.measuredHeight
			self.measuredHeight.reset()
			self.invalidateFrame()
		}
	}

	/**
	 * @inherited
	 * @method didResolveOrigin
	 * @since 0.7.0
	 */
	open func didResolveOrigin(node: DisplayNode) {

		if (self.resolvedTop != self.node.measuredTop) {
			self.resolvedTop = self.node.measuredTop
			self.measuredTop.reset()
			self.invalidateFrame()
		}

		if (self.resolvedLeft != self.node.measuredLeft) {
			self.resolvedLeft = self.node.measuredLeft
			self.measuredLeft.reset()
			self.invalidateFrame()
		}
	}

	/**
	 * @inherited
	 * @method didResolveInnerSize
	 * @since 0.7.0
	 */
	open func didResolveInnerSize(node: DisplayNode) {

		if (self.resolvedInnerWidth != self.node.measuredInnerWidth) {
			self.resolvedInnerWidth = self.node.measuredInnerWidth
			self.measuredInnerWidth.reset()
			self.invalidateFrame()
		}

		if (self.resolvedInnerHeight != self.node.measuredInnerHeight) {
			self.resolvedInnerHeight = self.node.measuredInnerHeight
			self.measuredInnerHeight.reset()
			self.invalidateFrame()
		}
	}

	/**
	 * @inherited
	 * @method didResolveContentSize
	 * @since 0.7.0
	 */
	open func didResolveContentSize(node: DisplayNode) {

		if (self.resolvedContentWidth != self.node.measuredContentWidth) {
			self.resolvedContentWidth = self.node.measuredContentWidth
			self.measuredContentWidth.reset()
			self.invalidateContent()
		}

		if (self.resolvedContentHeight != self.node.measuredContentHeight) {
			self.resolvedContentHeight = self.node.measuredContentHeight
			self.measuredContentHeight.reset()
			self.invalidateContent()
		}
	}

	/**
	 * @inherited
	 * @method didResolveMargin
	 * @since 0.7.0
	 */
	open func didResolveMargin(node: DisplayNode) {

		if (self.resolvedMarginTop != self.node.measuredMarginTop) {
			self.resolvedMarginTop = self.node.measuredMarginTop
			self.measuredMarginTop.reset()
		}

		if (self.resolvedMarginLeft != self.node.measuredMarginLeft) {
			self.resolvedMarginLeft = self.node.measuredMarginLeft
			self.measuredMarginLeft.reset()
		}

		if (self.resolvedMarginRight != self.node.measuredMarginRight) {
			self.resolvedMarginRight = self.node.measuredMarginRight
			self.measuredMarginRight.reset()
		}

		if (self.resolvedMarginBottom != self.node.measuredMarginBottom) {
			self.resolvedMarginBottom = self.node.measuredMarginBottom
			self.measuredMarginBottom.reset()
		}
	}

	/**
	 * @inherited
	 * @method didResolveBorder
	 * @since 0.7.0
	 */
	open func didResolveBorder(node: DisplayNode) {

		if (self.resolvedBorderTopWidth != self.node.measuredBorderTop) {
			self.resolvedBorderTopWidth = self.node.measuredBorderTop
			self.measuredBorderTopWidth.reset()
			self.invalidateBorder()
		}

		if (self.resolvedBorderLeftWidth != self.node.measuredBorderLeft) {
			self.resolvedBorderLeftWidth = self.node.measuredBorderLeft
			self.measuredBorderLeftWidth.reset()
			self.invalidateBorder()
		}

		if (self.resolvedBorderRightWidth != self.node.measuredBorderRight) {
			self.resolvedBorderRightWidth = self.node.measuredBorderRight
			self.measuredBorderRightWidth.reset()
			self.invalidateBorder()
		}

		if (self.resolvedBorderBottomWidth != self.node.measuredBorderBottom) {
			self.resolvedBorderBottomWidth = self.node.measuredBorderBottom
			self.measuredBorderBottomWidth.reset()
			self.invalidateBorder()
		}
	}

	/**
	 * @inherited
	 * @method didResolvePadding
	 * @since 0.7.0
	 */
	open func didResolvePadding(node: DisplayNode) {

		if (self.resolvedPaddingTop != self.node.measuredPaddingTop) {
			self.resolvedPaddingTop = self.node.measuredPaddingTop
			self.measuredPaddingTop.reset()
		}

		if (self.resolvedPaddingLeft != self.node.measuredPaddingLeft) {
			self.resolvedPaddingLeft = self.node.measuredPaddingLeft
			self.measuredPaddingLeft.reset()
		}

		if (self.resolvedPaddingRight != self.node.measuredPaddingRight) {
			self.resolvedPaddingRight = self.node.measuredPaddingRight
			self.measuredPaddingRight.reset()
		}

		if (self.resolvedPaddingBottom != self.node.measuredPaddingBottom) {
			self.resolvedPaddingBottom = self.node.measuredPaddingBottom
			self.measuredPaddingBottom.reset()
		}
	}

	/**
	 * @inherited
	 * @method didInvalidate
	 * @since 0.7.0
	 */
	open func didInvalidate(node: DisplayNode) {
		self.scheduleUpdate()
	}

	/**
	 * @inherited
	 * @method layoutBegan
	 * @since 0.7.0
	 */
	open func layoutBegan(node: DisplayNode) {
		self.delegate?.didBeginLayout(view: self)
		self.callMethod("nativeOnLayoutBegan")
	}

	/**
	 * @inherited
	 * @method layoutEnded
	 * @since 0.7.0
	 */
	open func didResolveLayout(node: DisplayNode) {
		self.delegate?.didFinishLayout(view: self)
		self.callMethod("nativeOnLayoutFinished")
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Scrollable Delegate
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method didBeginDragging
	 * @since 0.7.0
	 */
	open func didBeginDragging(scrollable: Scrollable) {
		self.dragging.reset(true)
		self.callMethod("nativeOnDragStart")
	}

	/**
	 * @inherited
	 * @method didFinishDragging
	 * @since 0.7.0
	 */
	open func didFinishDragging(scrollable: Scrollable) {
		self.dragging.reset(false)
		self.callMethod("nativeOnDragEnd")
	}

	/**
	 * @inherited
	 * @method didDrag
	 * @since 0.7.0
	 */
	open func didDrag(scrollable: Scrollable) {
		self.callMethod("nativeOnDrag")
	}

	/**
	 * @inherited
	 * @method didBeginScrolling
	 * @since 0.7.0
	 */
	open func didBeginScrolling(scrollable: Scrollable) {
		self.scrolling.reset(true)
		self.callMethod("nativeOnScrollStart")
	}

	/**
	 * @inherited
	 * @method didFinishScrolling
	 * @since 0.7.0
	 */
	open func didFinishScrolling(scrollable: Scrollable) {
		self.scrolling.reset(false)
		self.callMethod("nativeOnScrollEnd")
	}

	/**
	 * @inherited
	 * @method didScroll
	 * @since 0.7.0
	 */
	open func didScroll(scrollable: Scrollable, top: CGFloat, left: CGFloat) {

		self.scrollTop.reset(Double(top))
		self.scrollLeft.reset(Double(left))

		self.delegate?.didScroll(view: self)

		self.callMethod("nativeOnScroll")
	}

	/**
	 * @inherited
	 * @method didBeginZooming
	 * @since 0.7.0
	 */
	open func didBeginZooming(scrollable: Scrollable) {
		self.callMethod("nativeOnZoomStart")
	}

	/**
	 * @inherited
	 * @method didFinishZooming
	 * @since 0.7.0
	 */
	open func didFinishZooming(scrollable: Scrollable, scale: CGFloat) {
		self.callMethod("nativeOnZoomEnd", arguments: [self.context.createNumber(scale)])
	}

	/**
	 * @inherited
	 * @method didZoom
	 * @since 0.7.0
	 */
	open func didZoom(scrollable: Scrollable) {
		self.callMethod("nativeOnZoom")
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method insertChild
	 * @since 0.7.0
	 * @hidden
	 */
	private func insertChild(_ view: JavaScriptView, at index: Int) {
		self.children.insert(view, at: index)
		self.node.insertChild(view.node, at: index)
		self.content.insertSubview(view.wrapper, at: index)
	}

	/**
	 * @method removeChild
	 * @since 0.7.0
	 * @hidden
	 */
	open func removeChild(_ view: JavaScriptView) {
		self.children.remove(view)
		self.node.removeChild(view.node)
		self.content.removeSubview(view.wrapper)
	}

	/**
	 * @method moveToParent
	 * @since 0.7.0
	 * @hidden
	 */
	private func moveToParent(_ parent: JavaScriptView?, notify: Bool = true) {

		self.parent = parent

		if (notify) {
			self.callMethod("nativeOnMoveToParent", arguments: [parent])
		}
	}

	/**
	 * @method moveToWindow
	 * @since 0.7.0
	 * @hidden
	 */
	private func moveToWindow(_ window: JavaScriptWindow?, notify: Bool = true) {

		self.window = window

		if (notify) {
			self.callMethod("nativeOnMoveToWindow", arguments: [window])
		}

		for view in self.children {
			view.moveToWindow(window)
		}
	}

	/**
	 * @method invalidateFrame
	 * @since 0.7.0
	 * @hidden
	 */
	internal func invalidateFrame() {

		if (self.invalidFrame == false) {
			self.invalidFrame = true
			self.scheduleUpdate()
		}

		if (self.translationX.unit.isRelativeToParent() ||
			self.translationY.unit.isRelativeToParent()) {
			self.invalidateTransform()
		}

		if (self.backgroundImageTop.unit.isRelativeToParent() ||
			self.backgroundImageLeft.unit.isRelativeToParent() ||
			self.backgroundImageWidth.unit.isRelativeToParent() ||
			self.backgroundImageHeight.unit.isRelativeToParent()) {
			self.invalidateBitmapImage()
		}
	}

	/**
	 * @method invalidateShadow
	 * @since 0.7.0
	 * @hidden
	 */
	internal func invalidateShadow() {
		if (self.invalidShadow == false) {
			self.invalidShadow = true
			self.scheduleUpdate()
		}
	}

	/**
	 * @method invalidateBorder
	 * @since 0.7.0
	 * @hidden
	 */
	internal func invalidateBorder() {
		if (self.invalidBorder == false) {
			self.invalidBorder = true
			self.scheduleUpdate()
		}
	}

	/**
	 * @method invalidateBitmapColor
	 * @since 0.7.0
	 * @hidden
	 */
	internal func invalidateBitmapColor() {
		if (self.invalidBitmapColor == false) {
			self.invalidBitmapColor = true
			self.scheduleUpdate()
		}
	}

	/**
	 * @method invalidateBitmapImage
	 * @since 0.7.0
	 * @hidden
	 */
	internal func invalidateBitmapImage() {
		if (self.invalidBitmapImage == false) {
			self.invalidBitmapImage = true
			self.scheduleUpdate()
		}
	}

	/**
	 * @method invalidateTransform
	 * @since 0.7.0
	 * @hidden
	 */
	internal func invalidateTransform() {
		if (self.invalidTransform == false) {
			self.invalidTransform = true
			self.scheduleUpdate()
		}
	}

	/**
	 * @method invalidateContent
	 * @since 0.7.0
	 * @hidden
	 */
	internal func invalidateContent() {
		if (self.invalidContent == false) {
			self.invalidContent = true
			self.scheduleUpdate()
		}
	}

	/**
	 * @method isTransformed
	 * @since 0.7.0
	 * @hidden
	 */
	private func isTransformed() -> Bool {
		return (
			self.resolvedTranslationX != 0.0 ||
			self.resolvedTranslationY != 0.0 ||
			self.resolvedTranslationZ != 0.0 ||
			self.resolvedRotationX != 0.0 ||
			self.resolvedRotationY != 0.0 ||
			self.resolvedRotationZ != 0.0 ||
			self.scaleX.number != 1.0 ||
			self.scaleY.number != 1.0 ||
			self.scaleZ.number != 1.0
		)
	}

	//--------------------------------------------------------------------------
	// MARK: Private API - Conversions
	//--------------------------------------------------------------------------

	/**
	 * @method getBackgroundImageAnchorTop
	 * @since 0.7.0
	 * @hidden
	 */
	private func getBackgroundImageAnchorTop(_ prop: JavaScriptProperty) -> Double {

		if (prop.type == .string) {

			switch (prop.string) {

				case "top":    return 0.0
				case "center": return 0.5
				case "bottom": return 1.0

				default:
					NSLog("Unrecognized value for backgroundImageAnchorTop: \(prop.string)")
			}
		}

		return prop.number
	}

	/**
	 * @method getBackgroundImageAnchorLeft
	 * @since 0.7.0
	 * @hidden
	 */
	private func getBackgroundImageAnchorLeft(_ prop: JavaScriptProperty) -> Double {

		if (prop.type == .string) {

			switch (prop.string) {

				case "left":   return 0.0
				case "center": return 0.5
				case "right":  return 1.0

				default:
					NSLog("Unrecognized value for getBackgroundImageAnchorLeft: \(prop.string)")
			}
		}

		return prop.number
	}

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * The view's id.
	 * @property id
	 * @since 0.7.0
	 */
	@objc public lazy var id = JavaScriptProperty(string: "") { value in
		self.node.setName(value.string)
	}

	/**
	 * The view's class name.
	 * @property className
	 * @since 0.7.0
	 */
	@objc public lazy var className = JavaScriptProperty(string: "") { value in
		self.node.setType(value.string)
	}

	/**
	 * The view's background color.
	 * @property backgroundColor
	 * @since 0.7.0
	 */
	@objc public lazy var backgroundColor = JavaScriptProperty(string: "transparent") { value in
		self.invalidateBitmapColor()
	}

	/**
	 * The view's background image.
	 * @property backgroundImage
	 * @since 0.7.0
	 */
	@objc public lazy var backgroundImage = JavaScriptProperty() { value in
		self.backgroundImageLoader.load(value) { image in
			self.backgroundImageData = image
		}
	}

	/**
	 * The view's background image container fit.
	 * @property backgroundImageFit
	 * @since 0.7.0
	 */
	@objc public lazy var backgroundImageFit = JavaScriptProperty(string: "cover") { value in
		self.invalidateBitmapImage()
	}

	/**
	 * The view's background image top anchor.
	 * @property backgroundImageAnchorTop
	 * @since 0.7.0
	 */
	@objc public lazy var backgroundImageAnchorTop = JavaScriptProperty(number: 0.5) { value in
		self.invalidateBitmapImage()
	}

	/**
	 * The view's background image left anchor.
	 * @property backgroundImageAnchorLeft
	 * @since 0.7.0
	 */
	@objc public lazy var backgroundImageAnchorLeft = JavaScriptProperty(number: 0.5) { value in
		self.invalidateBitmapImage()
	}

	/**
	 * The view's background image top position.
	 * @property backgroundImageTop
	 * @since 0.7.0
	 */
	@objc public lazy var backgroundImageTop = JavaScriptProperty(number: 50, unit: .pc) { value in
		self.invalidateBitmapImage()
	}

	/**
	 * The view's background image left position.
	 * @property backgroundImageLeft
	 * @since 0.7.0
	 */
	@objc public lazy var backgroundImageLeft = JavaScriptProperty(number: 50, unit: .pc) { value in
		self.invalidateBitmapImage()
	}

	/**
	 * The view's background image width.
	 * @property backgroundImageWidth
	 * @since 0.7.0
	 */
	@objc public lazy var backgroundImageWidth = JavaScriptProperty(string: "auto") { value in
		self.invalidateBitmapImage()
	}

	/**
	 * The view's background image height.
	 * @property backgroundImageHeight
	 * @since 0.7.0
	 */
	@objc public lazy var backgroundImageHeight = JavaScriptProperty(string: "auto") { value in
		self.invalidateBitmapImage()
	}

	/**
	 * The background image tint color.
	 * @property backgroundImageTint
	 * @since 0.7.0
	 */
	@objc public lazy var backgroundImageTint = JavaScriptProperty(string: "none") { value in
		self.wrapper.backgroundImageTint = CGColorParse(value.string)
	}

	/**
	 * The view's border.
	 * @property border
	 * @since 0.7.0
	 */
	@objc public lazy var border = JavaScriptProperty(string: "0 #000") { value in

		let components = value.string.split(separator: " ")
		if (components.count < 2) {
			return
		}

		let width = String(components[0]).trim()
		let color = String(components[1]).trim()

		if let width = JavaScriptPropertyParser.parse(width), width.isNumber {
			self.borderTopWidth.reset(width.number, unit: width.unit)
			self.borderLeftWidth.reset(width.number, unit: width.unit)
			self.borderRightWidth.reset(width.number, unit: width.unit)
			self.borderBottomWidth.reset(width.number, unit: width.unit)
		}

		self.borderTopColor.reset(color)
		self.borderLeftColor.reset(color)
		self.borderRightColor.reset(color)
		self.borderBottomColor.reset(color)
	}

	/**
	 * The view's top border.
	 * @property borderTop
	 * @since 0.7.0
	 */
	@objc public lazy var borderTop = JavaScriptProperty(string: "0 #000") { value in

		let components = value.string.split(separator: " ")
		if (components.count < 2) {
			return
		}

		self.borderTopWidth.parse(String(components[0]).trim())
		self.borderTopColor.reset(String(components[1]).trim())
	}

	/**
	 * The view's left border.
	 * @property borderTop
	 * @since 0.7.0
	 */
	@objc public lazy var borderLeft = JavaScriptProperty(string: "0 #000") { value in

		let components = value.string.split(separator: " ")
		if (components.count < 2) {
			return
		}

		self.borderLeftWidth.parse(String(components[0]).trim())
		self.borderLeftColor.reset(String(components[1]).trim())
	}

	/**
	 * The view's right border.
	 * @property borderRight
	 * @since 0.7.0
	 */
	@objc public lazy var borderRight = JavaScriptProperty(string: "0 #000") { value in

		let components = value.string.split(separator: " ")
		if (components.count < 2) {
			return
		}

		self.borderRightWidth.parse(String(components[0]).trim())
		self.borderRightColor.reset(String(components[1]).trim())
	}

	/**
	 * The view's bottom border.
	 * @property borderBottom
	 * @since 0.7.0
	 */
	@objc public lazy var borderBottom = JavaScriptProperty(string: "0 #000") { value in

		let components = value.string.split(separator: " ")
		if (components.count < 2) {
			return
		}

		self.borderBottomWidth.parse(String(components[0]).trim())
		self.borderBottomColor.reset(String(components[1]).trim())
	}

	/**
	 * The view's border width.
	 * @property borderWidth
	 * @since 0.7.0
	 */
	@objc public lazy var borderWidth = JavaScriptProperty(number: 0) { value in
		self.borderTopWidth.reset(value.number, unit: value.unit)
		self.borderLeftWidth.reset(value.number, unit: value.unit)
		self.borderRightWidth.reset(value.number, unit: value.unit)
		self.borderBottomWidth.reset(value.number, unit: value.unit)
	}

	/**
	 * The view's border color.
	 * @property borderColor
	 * @since 0.7.0
	 */
	@objc public lazy var borderColor = JavaScriptProperty(string: "#000") { value in
		self.borderTopColor.reset(value.string)
		self.borderLeftColor.reset(value.string)
		self.borderRightColor.reset(value.string)
		self.borderBottomColor.reset(value.string)
	}

	/**
	 * The view's border top color.
	 * @property borderTopColor
	 * @since 0.7.0
	 */
	@objc public lazy var borderTopColor = JavaScriptProperty(string: "#000") { value in
		self.wrapper.borderTopColor = CGColorParse(value.string)
	}

	/**
	 * The view's border left color.
	 * @property borderLeftColor
	 * @since 0.7.0
	 */
	@objc public lazy var borderLeftColor = JavaScriptProperty(string: "#000") { value in
		self.wrapper.borderLeftColor = CGColorParse(value.string)
	}

	/**
	 * The view's border right color.
	 * @property borderRightColor
	 * @since 0.7.0
	 */
	@objc public lazy var borderRightColor = JavaScriptProperty(string: "#000") { value in
		self.wrapper.borderRightColor = CGColorParse(value.string)
	}

	/**
	 * The view's border bottom color.
	 * @property borderBottomColor
	 * @since 0.7.0
	 */
	@objc public lazy var borderBottomColor = JavaScriptProperty(string: "#000") { value in
		self.wrapper.borderBottomColor = CGColorParse(value.string)
	}

	/**
	 * The view's border top width.
	 * @property borderTopWidth
	 * @since 0.7.0
	 */
	@objc public lazy var borderTopWidth = JavaScriptProperty(number: 0) { value in
		self.node.setBorderTop(value)
	}

	/**
	 * The view's border left width.
	 * @property borderLeftWidth
	 * @since 0.7.0
	 */
	@objc public lazy var borderLeftWidth = JavaScriptProperty(number: 0) { value in
		self.node.setBorderLeft(value)
	}

	/**
	 * The view's border right width.
	 * @property borderRightWidth
	 * @since 0.7.0
	 */
	@objc public lazy var borderRightWidth = JavaScriptProperty(number: 0) { value in
		self.node.setBorderRight(value)
	}

	/**
	 * The view's border bottom width.
	 * @property borderBottomWidth
	 * @since 0.7.0
	 */
	@objc public lazy var borderBottomWidth = JavaScriptProperty(number: 0) { value in
		self.node.setBorderBottom(value)
	}

	/**
	 * The view's absolute minimum border top width.
	 * @property minBorderTopWidth
	 * @since 0.7.0
	 */
	@objc public lazy var minBorderTopWidth = JavaScriptProperty(number: 0) { value in
		self.invalidateBorder()
	}

	/**
	 * The view's absolute maximum border top width.
	 * @property maxBorderTopWidth
	 * @since 0.7.0
	 */
	@objc public lazy var maxBorderTopWidth = JavaScriptProperty(number: Double.max) { value in
		self.invalidateBorder()
	}

	/**
	 * The view's absolute minimum border left width.
	 * @property minBorderLeftWidth
	 * @since 0.7.0
	 */
	@objc public lazy var minBorderLeftWidth = JavaScriptProperty(number: 0) { value in
		self.invalidateBorder()
	}

	/**
	 * The view's absolute maximum border left width.
	 * @property maxBorderLeftWidth
	 * @since 0.7.0
	 */
	@objc public lazy var maxBorderLeftWidth = JavaScriptProperty(number: Double.max) { value in
		self.invalidateBorder()
	}

	/**
	 * The view's absolute minimum border right width.
	 * @property minBorderRightWidth
	 * @since 0.7.0
	 */
	@objc public lazy var minBorderRightWidth = JavaScriptProperty(number: 0) { value in
		self.invalidateBorder()
	}

	/**
	 * The view's absolute maximum border right width.
	 * @property maxBorderRightWidth
	 * @since 0.7.0
	 */
	@objc public lazy var maxBorderRightWidth = JavaScriptProperty(number: Double.max) { value in
		self.invalidateBorder()
	}

	/**
	 * The view's absolute minimum border bottom width.
	 * @property minBorderBottomWidth
	 * @since 0.7.0
	 */
	@objc public lazy var minBorderBottomWidth = JavaScriptProperty(number: 0) { value in
		self.invalidateBorder()
	}

	/**
	 * The view's absolute maximum border bottom width.
	 * @property maxBorderBottomWidth
	 * @since 0.7.0
	 */
	@objc public lazy var maxBorderBottomWidth = JavaScriptProperty(number: Double.max) { value in
		self.invalidateBorder()
	}

	/**
	 * The view's border radius.
	 * @property borderRadius
	 * @since 0.7.0
	 */
	@objc public lazy var borderRadius = JavaScriptProperty(number: 0) { value in
		self.borderTopLeftRadius.reset(value.number, unit: value.unit)
		self.borderTopRightRadius.reset(value.number, unit: value.unit)
		self.borderBottomLeftRadius.reset(value.number, unit: value.unit)
		self.borderBottomRightRadius.reset(value.number, unit: value.unit)
	}

	/**
	 * The view's border top left corner radius.
	 * @property borderTopLeftRadius
	 * @since 0.7.0
	 */
	@objc public lazy var borderTopLeftRadius = JavaScriptProperty(number: 0) { value in
		self.invalidateBorder()
	}

	/**
	 * The view's border top right corner radius.
	 * @property borderTopRightRadius
	 * @since 0.7.0
	 */
	@objc public lazy var borderTopRightRadius = JavaScriptProperty(number: 0) { value in
		self.invalidateBorder()
	}

	/**
	 * The view's border bottom left corner radius.
	 * @property borderBottomLeftRadius
	 * @since 0.7.0
	 */
	@objc public lazy var borderBottomLeftRadius = JavaScriptProperty(number: 0) { value in
		self.invalidateBorder()
	}

	/**
	 * The view's border bottom right corner radius.
	 * @property borderBottomRightRadius
	 * @since 0.7.0
	 */
	@objc public lazy var borderBottomRightRadius = JavaScriptProperty(number: 0) { value in
		self.invalidateBorder()
	}

	/**
	 * The view's shadow blur distance.
	 * @property shadowBlur
	 * @since 0.7.0
	 */
	@objc public lazy var shadowBlur = JavaScriptProperty(number: 0) { value in
		self.invalidateShadow()
	}

	/**
	 * The view's shadow color.
	 * @property shadowColor
	 * @since 0.7.0
	 */
	@objc public lazy var shadowColor = JavaScriptProperty(string: "#000") { value in
		self.invalidateShadow()
	}

	/**
	 * The view's shadow's top offset.
	 * @property shadowOffsetTop
	 * @since 0.7.0
	 */
	@objc public lazy var shadowOffsetTop = JavaScriptProperty(number: 0) { value in
		self.invalidateShadow()
	}

	/**
	 * The view's shadow's left offset.
	 * @property shadowOffsetLeft
	 * @since 0.7.0
	 */
	@objc public lazy var shadowOffsetLeft = JavaScriptProperty(number: 0) { value in
		self.invalidateShadow()
	}

	/**
	 * The view's top position.
	 * @property top
	 * @since 0.7.0
	 */
	@objc public lazy var top = JavaScriptProperty(string: "auto") { value in
		self.node.setTop(value)
	}

	/**
	 * The view's left position.
	 * @property left
	 * @since 0.7.0
	 */
	@objc public lazy var left = JavaScriptProperty(string: "auto") { value in
		self.node.setLeft(value)
	}

	/**
	 * The view's right position.
	 * @property right
	 * @since 0.7.0
	 */
	@objc public lazy var right = JavaScriptProperty(string: "auto") { value in
		self.node.setRight(value)
	}

	/**
	 * The view's bottom position.
	 * @property bottom
	 * @since 0.7.0
	 */
	@objc public lazy var bottom = JavaScriptProperty(string: "auto") { value in
		self.node.setBottom(value)
	}

	/**
	 * The view's absolute minimum top position.
	 * @property minTop
	 * @since 0.7.0
	 */
	@objc public lazy var minTop = JavaScriptProperty(number: Double.min) { value in
		self.node.setMinTop(value.number)
	}

	/**
	 * The view's absolute maximum top position.
	 * @property maxTop
	 * @since 0.7.0
	 */
	@objc public lazy var maxTop = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxTop(value.number)
	}

	/**
	 * The view's absolute minimum left position.
	 * @property minLeft
	 * @since 0.7.0
	 */
	@objc public lazy var minLeft = JavaScriptProperty(number: Double.min) { value in
		self.node.setMinLeft(value.number)
	}

	/**
	 * The view's absolute maximum left position.
	 * @property maxLeft
	 * @since 0.7.0
	 */
	@objc public lazy var maxLeft = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxLeft(value.number)
	}

	/**
	 * The view's absolute minimum right position.
	 * @property minRight
	 * @since 0.7.0
	 */
	@objc public lazy var minRight = JavaScriptProperty(number: Double.min) { value in
		self.node.setMinRight(value.number)
	}

	/**
	 * The view's absolute maximum right position.
	 * @property maxRight
	 * @since 0.7.0
	 */
	@objc public lazy var maxRight = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxRight(value.number)
	}

	/**
	 * The view's absolute minimum bottom position.
	 * @property minBottom
	 * @since 0.7.0
	 */
	@objc public lazy var minBottom = JavaScriptProperty(number: Double.min) { value in
		self.node.setMinBottom(value.number)
	}

	/**
	 * The view's absolute maximum bottom position.
	 * @property maxBottom
	 * @since 0.7.0
	 */
	@objc public lazy var maxBottom = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxBottom(value.number)
	}

	/**
	 * The view's vertical point from with it will be positioned.
	 * @property anchorTop
	 * @since 0.7.0
	 */
	@objc public lazy var anchorTop = JavaScriptProperty(number: 0) { value in
		self.node.setAnchorTop(value)
	}

	/**
	 * The view's horizontal point from with it will be positioned.
	 * @property anchorLeft
	 * @since 0.7.0
	 */
	@objc public lazy var anchorLeft = JavaScriptProperty(number: 0) { value in
		self.node.setAnchorLeft(value)
	}

	/**
	 * The view's width.
	 * @property width
	 * @since 0.7.0
	 */
	@objc public lazy var width = JavaScriptProperty(string: "fill") { value in
		self.node.setWidth(value)
	}

	/**
	 * The view's height.
	 * @property height
	 * @since 0.7.0
	 */
	@objc public lazy var height = JavaScriptProperty(string: "fill") { value in
		self.node.setHeight(value)
	}

	/**
	 * The view's absolute minimum width.
	 * @property minWidth
	 * @since 0.7.0
	 */
	@objc public lazy var minWidth = JavaScriptProperty(number: 0) { value in
		self.node.setMinWidth(value.number)
	}

	/**
	 * The view's absolute maximum width.
	 * @property maxWidth
	 * @since 0.7.0
	 */
	@objc public lazy var maxWidth = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxWidth(value.number)
	}

	/**
	 * The view's absolute minimum height.
	 * @property minHeight
	 * @since 0.7.0
	 */
	@objc public lazy var minHeight = JavaScriptProperty(number: 0) { value in
		self.node.setMinHeight(value.number)
	}

	/**
	 * The view's absolute maximum height.
	 * @property maxHeight
	 * @since 0.7.0
	 */
	@objc public lazy var maxHeight = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxHeight(value.number)
	}

	/**
	 * The view's expand factor.
	 * @property expandFactor
	 * @since 0.7.0
	 */
	@objc public lazy var expandFactor = JavaScriptProperty(number: 0) { value in
		self.node.setExpandFactor(value.number)
	}

	/**
	 * The view's shrink factor.
	 * @property shrinkFactor
	 * @since 0.7.0
	 */
	@objc public lazy var shrinkFactor = JavaScriptProperty(number: 0) { value in
		self.node.setShrinkFactor(value.number)
	}

	/**
	 * The view's content top.
	 * @property contentTop
	 * @since 0.7.0
	 */
	@objc public lazy var contentTop = JavaScriptProperty(number: 0) { value in
		self.node.setContentTop(value)
	}

	/**
	 * The view's content left.
	 * @property contentLeft
	 * @since 0.7.0
	 */
	@objc public lazy var contentLeft = JavaScriptProperty(number: 0) { value in
		self.node.setContentLeft(value)
	}

	/**
	 * The view's content width.
	 * @property contentWidth
	 * @since 0.7.0
	 */
	@objc public lazy var contentWidth = JavaScriptProperty(string: "auto") { value in
		self.node.setContentWidth(value)
	}

	/**
	 * The view's content height.
	 * @property contentHeight
	 * @since 0.7.0
	 */
	@objc public lazy var contentHeight = JavaScriptProperty(string: "auto") { value in
		self.node.setContentHeight(value)
	}

	/**
	 * The view's content top inset.
	 * @property contentInsetTop
	 * @since 0.7.0
	 */
	@objc public lazy var contentInsetTop = JavaScriptProperty(number: 0) { value in
		self.scrollableView?.contentInsetTop = CGFloat(value.number)
	}

	/**
	 * The view's content left inset.
	 * @property contentInsetLeft
	 * @since 0.7.0
	 */
	@objc public lazy var contentInsetLeft = JavaScriptProperty(number: 0) { value in
		self.scrollableView?.contentInsetLeft = CGFloat(value.number)
	}

	/**
	 * The view's content right inset.
	 * @property contentInsetRight
	 * @since 0.7.0
	 */
	@objc public lazy var contentInsetRight = JavaScriptProperty(number: 0) { value in
		self.scrollableView?.contentInsetRight = CGFloat(value.number)
	}

	/**
	 * The view's content bottom inset.
	 * @property contentInsetBottom
	 * @since 0.7.0
	 */
	@objc public lazy var contentInsetBottom = JavaScriptProperty(number: 0) { value in
		self.scrollableView?.contentInsetBottom = CGFloat(value.number)
	}

	/**
	 * The view's content orientation.
	 * @property contentDirection
	 * @since 0.7.0
	 */
	@objc public lazy var contentDirection = JavaScriptProperty(string: "vertical") { value in
		self.node.setContentDirection(value)
	}

	/**
	 * The view's content alignment on the cross axis.
	 * @property contentAlignment
	 * @since 0.7.0
	 */
	@objc public lazy var contentAlignment = JavaScriptProperty(string: "start") { value in
		self.node.setContentAlignment(value)
	}

	/**
	 * The view's content alignment on the main axis.
	 * @property contentDisposition
	 * @since 0.7.0
	 */
	@objc public lazy var contentDisposition = JavaScriptProperty(string: "start") { value in
		self.node.setContentDisposition(value)
	}

	/**
	 * Whether this view's content can scroll.
	 * @property scrollable
	 * @since 0.7.0
	 */
	@objc public lazy var scrollable = JavaScriptProperty(boolean: false) { value in
		self.scrollableView?.scrollable = value.boolean
	}

	/**
	 * Whether this view's content displays scrollbars.
	 * @property scrollbars
	 * @since 0.7.0
	 */
	@objc public lazy var scrollbars = JavaScriptProperty(boolean: false) { value in
		self.scrollableView?.scrollbars = Scrollbars.get(value)
	}

	/**
	 * Whether this view's content can overscroll.
	 * @property overscroll
	 * @since 0.7.0
	 */
	@objc public lazy var overscroll = JavaScriptProperty(string: "auto") { value in
		self.scrollableView?.overscroll = Overscroll.get(value)
	}

	/**
	 * Whether this view's content scrolls with momentum.
	 * @property momentum
	 * @since 0.7.0
	 */
	@objc public lazy var momentum = JavaScriptProperty(boolean: true) { value in
		self.scrollableView?.momentum = value.boolean
	}

	/**
	 * The view's top scroll offset.
	 * @property scrollTop
	 * @since 0.7.0
	 */
	@objc public lazy var scrollTop = JavaScriptProperty(number: 0) { value in
		self.scrollableView?.scrollTop = CGFloat(value.number)
	}

	/**
	 * The view's left scroll offset.
	 * @property scrollLeft
	 * @since 0.7.0
	 */
	@objc public lazy var scrollLeft = JavaScriptProperty(number: 0) { value in
		self.scrollableView?.scrollLeft = CGFloat(value.number)
	}

	/**
	 * Whether this view is scrolling.
	 * @property scrolling
	 * @since 0.7.0
	 */
	@objc public lazy var scrolling = JavaScriptProperty(boolean: false)

	/**
	 * Whether this view is dragging.
	 * @property dragging
	 * @since 0.7.0
	 */
	@objc public lazy var dragging = JavaScriptProperty(boolean: false)

	/**
	 * The view's margin.
	 * @property margin
	 * @since 0.7.0
	 */
	@objc public lazy var margin = JavaScriptProperty(number: 0) { value in
		self.marginTop.reset(value.number, unit: value.unit)
		self.marginLeft.reset(value.number, unit: value.unit)
		self.marginRight.reset(value.number, unit: value.unit)
		self.marginBottom.reset(value.number, unit: value.unit)
	}

	/**
	 * The view's top margin.
	 * @property marginTop
	 * @since 0.7.0
	 */
	@objc public lazy var marginTop = JavaScriptProperty(number: 0) { value in
		self.node.setMarginTop(value)
	}

	/**
	 * The view's left margin.
	 * @property marginLeft
	 * @since 0.7.0
	 */
	@objc public lazy var marginLeft = JavaScriptProperty(number: 0) { value in
		self.node.setMarginLeft(value)
	}

	/**
	 * The view's right margin.
	 * @property marginRight
	 * @since 0.7.0
	 */
	@objc public lazy var marginRight = JavaScriptProperty(number: 0) { value in
		self.node.setMarginRight(value)
	}

	/**
	 * The view's bottom margin.
	 * @property marginBottom
	 * @since 0.7.0
	 */
	@objc public lazy var marginBottom = JavaScriptProperty(number: 0) { value in
		self.node.setMarginBottom(value)
	}

	/**
	 * The view's absolute minimum top margin.
	 * @property minMarginTop
	 * @since 0.7.0
	 */
	@objc public lazy var minMarginTop = JavaScriptProperty(number: Double.min) { value in
		self.node.setMinMarginTop(value.number)
	}

	/**
	 * The view's absolute maximum top margin.
	 * @property maxMarginTop
	 * @since 0.7.0
	 */
	@objc public lazy var maxMarginTop = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxMarginTop(value.number)
	}

	/**
	 * The view's absolute minimum left margin.
	 * @property minMarginLeft
	 * @since 0.7.0
	 */
	@objc public lazy var minMarginLeft = JavaScriptProperty(number: Double.min) { value in
		self.node.setMinMarginLeft(value.number)
	}

	/**
	 * The view's absolute maximum left margin.
	 * @property maxMarginLeft
	 * @since 0.7.0
	 */
	@objc public lazy var maxMarginLeft = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxMarginLeft(value.number)
	}

	/**
	 * The view's absolute minimum right margin.
	 * @property minMarginRight
	 * @since 0.7.0
	 */
	@objc public lazy var minMarginRight = JavaScriptProperty(number: Double.min) { value in
		self.node.setMinMarginRight(value.number)
	}

	/**
	 * The view's absolute maximum right margin.
	 * @property maxMarginRight
	 * @since 0.7.0
	 */
	@objc public lazy var maxMarginRight = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxMarginRight(value.number)
	}

	/**
	 * The view's absolute minimum bottom margin.
	 * @property minMarginBottom
	 * @since 0.7.0
	 */
	@objc public lazy var minMarginBottom = JavaScriptProperty(number: Double.min) { value in
		self.node.setMinMarginBottom(value.number)
	}

	/**
	 * The view's absolute maximum bottom margin.
	 * @property maxMarginBottom
	 * @since 0.7.0
	 */
	@objc public lazy var maxMarginBottom = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxMarginBottom(value.number)
	}

	/**
	 * The view's padding.
	 * @property padding
	 * @since 0.7.0
	 */
	@objc public lazy var padding = JavaScriptProperty(number: 0) { value in
		self.paddingTop.reset(value.number, unit: value.unit)
		self.paddingLeft.reset(value.number, unit: value.unit)
		self.paddingRight.reset(value.number, unit: value.unit)
		self.paddingBottom.reset(value.number, unit: value.unit)
	}

	/**
	 * The view's top padding.
	 * @property paddingTop
	 * @since 0.7.0
	 */
	@objc public lazy var paddingTop = JavaScriptProperty(number: 0) { value in
		self.node.setPaddingTop(value)
	}

	/**
	 * The view's left padding.
	 * @property paddingLeft
	 * @since 0.7.0
	 */
	@objc public lazy var paddingLeft = JavaScriptProperty(number: 0) { value in
		self.node.setPaddingLeft(value)
	}

	/**
	 * The view's right padding.
	 * @property paddingRight
	 * @since 0.7.0
	 */
	@objc public lazy var paddingRight = JavaScriptProperty(number: 0) { value in
		self.node.setPaddingRight(value)
	}

	/**
	 * The view's bottom padding.
	 * @property paddingBottom
	 * @since 0.7.0
	 */
	@objc public lazy var paddingBottom = JavaScriptProperty(number: 0) { value in
		self.node.setPaddingBottom(value)
	}

	/**
	 * The view's absolute minimum top padding.
	 * @property minPaddingTop
	 * @since 0.7.0
	 */
	@objc public lazy var minPaddingTop = JavaScriptProperty(number: 0) { value in
		self.node.setMinPaddingTop(value.number)
	}

	/**
	 * The view's absolute maximum top padding.
	 * @property maxPaddingTop
	 * @since 0.7.0
	 */
	@objc public lazy var maxPaddingTop = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxPaddingTop(value.number)
	}

	/**
	 * The view's absolute minimum left padding.
	 * @property minPaddingLeft
	 * @since 0.7.0
	 */
	@objc public lazy var minPaddingLeft = JavaScriptProperty(number: 0) { value in
		self.node.setMinPaddingLeft(value.number)
	}

	/**
	 * The view's absolute maximum left padding.
	 * @property maxPaddingLeft
	 * @since 0.7.0
	 */
	@objc public lazy var maxPaddingLeft = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxPaddingLeft(value.number)
	}

	/**
	 * The view's absolute minimum right padding.
	 * @property minPaddingRight
	 * @since 0.7.0
	 */
	@objc public lazy var minPaddingRight = JavaScriptProperty(number: 0) { value in
		self.node.setMinPaddingRight(value.number)
	}

	/**
	 * The view's absolute maximum right padding.
	 * @property maxPaddingRight
	 * @since 0.7.0
	 */
	@objc public lazy var maxPaddingRight = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxPaddingRight(value.number)
	}

	/**
	 * The view's absolute minimum bottom padding.
	 * @property minPaddingBottom
	 * @since 0.7.0
	 */
	@objc public lazy var minPaddingBottom = JavaScriptProperty(number: 0) { value in
		self.node.setMinPaddingBottom(value.number)
	}

	/**
	 * The view's absolute maximum bottom padding.
	 * @property maxPaddingBottom
	 * @since 0.7.0
	 */
	@objc public lazy var maxPaddingBottom = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxPaddingBottom(value.number)
	}

	/**
	 * The view's transformation origin on the x axis.
	 * @property originX
	 * @since 0.7.0
	 */
	@objc public lazy var originX = JavaScriptProperty(number: 0.5) { value in
		self.invalidateTransform()
	}

	/**
	 * The view's transformation origin on the y axis.
	 * @property originY
	 * @since 0.7.0
	 */
	@objc public lazy var originY = JavaScriptProperty(number: 0.5) { value in
		self.invalidateTransform()
	}

	/**
	 * The view's transformation origin on the z axis.
	 * @property originZ
	 * @since 0.7.0
	 */
	@objc public lazy var originZ = JavaScriptProperty(number: 0) { value in
		self.invalidateTransform()
	}

	/**
	 * The view's translation on the x axis.
	 * @property translationX
	 * @since 0.7.0
	 */
	@objc public lazy var translationX = JavaScriptProperty(number: 0) { value in
		self.invalidateTransform()
	}

	/**
	 * The view's translation on the y axis.
	 * @property translationY
	 * @since 0.7.0
	 */
	@objc public lazy var translationY = JavaScriptProperty(number: 0) { value in
		self.invalidateTransform()
	}

	/**
	 * The view's translation on the z axis.
	 * @property translationZ
	 * @since 0.7.0
	 * @hidden
	 */
	@objc public lazy var translationZ = JavaScriptProperty(number: 0) { value in
		self.invalidateTransform()
	}

	/**
	 * The view's rotation on the x axis.
	 * @property rotationX
	 * @since 0.7.0
	 */
	@objc public lazy var rotationX = JavaScriptProperty(number: 0) { value in
		self.invalidateTransform()
	}

	/**
	 * The view's rotation on the y axis.
	 * @property rotationY
	 * @since 0.7.0
	 */
	@objc public lazy var rotationY = JavaScriptProperty(number: 0) { value in
		self.invalidateTransform()
	}

	/**
	 * The view's rotation on the z axis.
	 * @property rotationZ
	 * @since 0.7.0
	 */
	@objc public lazy var rotationZ = JavaScriptProperty(number: 0) { value in
		self.invalidateTransform()
	}

	/**
	 * The view's scale on the x axis.
	 * @property scaleX
	 * @since 0.7.0
	 */
	@objc public lazy var scaleX = JavaScriptProperty(number: 1) { value in
		self.invalidateTransform()
	}

	/**
	 * The view's scale on the y axis.
	 * @property scaleY
	 * @since 0.7.0
	 */
	@objc public lazy var scaleY = JavaScriptProperty(number: 1) { value in
		self.invalidateTransform()
	}

	/**
	 * The view's scale on the z axis.
	 * @property scaleZ
	 * @since 0.7.0
	 */
	@objc public lazy var scaleZ = JavaScriptProperty(number: 1) { value in
		self.invalidateTransform()
	}

	/**
	 * The view's index on the z position relative to its siblings.
	 * @property zIndex
	 * @since 0.7.0
	 */
	@objc public lazy var zIndex = JavaScriptProperty(number: 0) { value in
		self.wrapper.layer.zPosition = CGFloat(value.number)
	}

	/**
	 * Whether the view is zoomable.
	 * @property zoomable
	 * @since 0.7.0
	 */
	@objc public lazy var zoomable = JavaScriptProperty(boolean: false) { value in
		self.scrollableView?.zoomable = value.boolean
	}

	/**
	 * The view's minimum zoom.
	 * @property minZoom
	 * @since 0.7.0
	 */
	@objc public lazy var minZoom = JavaScriptProperty(number: 1.0) { value in
		self.scrollableView?.minZoom = CGFloat(value.number)
	}

	/**
	 * The view's maximum zoom.
	 * @property maxZoom
	 * @since 0.7.0
	 */
	@objc public lazy var maxZoom = JavaScriptProperty(number: 1.0) { value in
		self.scrollableView?.maxZoom = CGFloat(value.number)
	}

	/**
	 * Whether this view can interact with touches.
	 * @property touchable
	 * @since 0.7.0
	 */
	@objc public lazy var touchable = JavaScriptProperty(boolean: true) { value in
		self.wrapper.isUserInteractionEnabled = value.boolean
	}

	/**
	 * The top offset for this view touchable area.
	 * @property touchOffsetTop
	 * @since 0.7.0
	 */
	@objc public lazy var touchOffsetTop = JavaScriptProperty(number: 0.0)

	/**
	 * The left offset for this view touchable area.
	 * @property touchOffsetLeft
	 * @since 0.7.0
	 */
	@objc public lazy var touchOffsetLeft = JavaScriptProperty(number: 0.0)

	/**
	 * The right offset for this view touchable area.
	 * @property touchOffsetRight
	 * @since 0.7.0
	 */
	@objc public lazy var touchOffsetRight = JavaScriptProperty(number: 0.0)

	/**
	 * The bottom offset for this view touchable area.
	 * @property touchOffsetBottom
	 * @since 0.7.0
	 */
	@objc public lazy var touchOffsetBottom = JavaScriptProperty(number: 0.0)

	/**
	 * The view's visibility status.
	 * @property visible
	 * @since 0.7.0
	 */
	@objc public lazy var visible = JavaScriptProperty(boolean: true) { value in
		self.wrapper.visible = value.boolean
		self.node.setVisible(value.boolean)
	}

	/**
	 * The view's opacity.
	 * @property opacity
	 * @since 0.7.0
	 * @hidden
	 */
	@objc public lazy var opacity = JavaScriptProperty(number: 1) { value in
		self.wrapper.alpha = CGFloat(value.number)
	}

	/**
	 * Whether this view can be drawn by user.
	 * @property drawable
	 * @since 0.7.0
	 */
	@objc public lazy var drawable = JavaScriptProperty(boolean: false) { value in
		self.wrapper.drawable = value.boolean
	}

	/**
	 * Whether this view's content is clipped to its bounds.
	 * @property clipped
	 * @since 0.7.0
	 */
	@objc public lazy var clipped = JavaScriptProperty(boolean: true) { value in
		self.content.clipsToBounds = value.boolean
	}

	/**
	 * Whether this view's content is paged.
	 * @property paged
	 * @since 0.7.0
	 */
	@objc public lazy var paged = JavaScriptProperty(boolean: false) { value in
		self.scrollableView?.paged = value.boolean
	}

	/**
	 * The view's measured top.
	 * @property measuredTop
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredTop = JavaScriptProperty()

	/**
	 * The view's measured left.
	 * @property measuredLeft
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredLeft = JavaScriptProperty()

	/**
	 * The view's measured width.
	 * @property measuredWidth
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredWidth = JavaScriptProperty()

	/**
	 * The view's measured height.
	 * @property measuredHeight
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredHeight = JavaScriptProperty()

	/**
	 * The view's measured inner width.
	 * @property measuredInnerWidth
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredInnerWidth = JavaScriptProperty()

	/**
	 * The view's measured inner height.
	 * @property measuredInnerHeight
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredInnerHeight = JavaScriptProperty()

	/**
	 * The view's measured content width.
	 * @property measuredContentWidth
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredContentWidth = JavaScriptProperty()

	/**
	 * The view's measured content height.
	 * @property measuredContentHeight
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredContentHeight = JavaScriptProperty()

	/**
	 * The view's measured margin top.
	 * @property measuredMarginTop
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredMarginTop = JavaScriptProperty()

	/**
	 * The view's measured margin left.
	 * @property measuredMarginLeft
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredMarginLeft = JavaScriptProperty()

	/**
	 * The view's measured margin right.
	 * @property measuredMarginRight
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredMarginRight = JavaScriptProperty()

	/**
	 * The view's measured margin bottom.
	 * @property measuredMarginBottom
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredMarginBottom = JavaScriptProperty()

	/**
	 * The view's measured border top width.
	 * @property measuredBorderTopWidth
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredBorderTopWidth = JavaScriptProperty()

	/**
	 * The view's measured border left width.
	 * @property measuredBorderLeftWidth
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredBorderLeftWidth = JavaScriptProperty()

	/**
	 * The view's measured border right width.
	 * @property measuredBorderRightWidth
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredBorderRightWidth = JavaScriptProperty()

	/**
	 * The view's measured border bottom width.
	 * @property measuredBorderBottomWidth
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredBorderBottomWidth = JavaScriptProperty()

	/**
	 * The view's measured padding top.
	 * @property measuredPaddingTop
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredPaddingTop = JavaScriptProperty()

	/**
	 * The view's measured padding left.
	 * @property measuredPaddingLeft
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredPaddingLeft = JavaScriptProperty()

	/**
	 * The view's measured padding right.
	 * @property measuredPaddingRight
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredPaddingRight = JavaScriptProperty()

	/**
	 * The view's measured padding bottom.
	 * @property measuredPaddingBottom
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredPaddingBottom = JavaScriptProperty()

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_id
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_id(callback: JavaScriptGetterCallback) {
		callback.returns(self.id)
	}

	/**
	 * @method jsSet_id
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_id(callback: JavaScriptSetterCallback) {
		self.id.reset(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_className
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_className(callback: JavaScriptGetterCallback) {
		callback.returns(self.className)
	}

	/**
	 * @method jsSet_id
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_className(callback: JavaScriptSetterCallback) {
		self.className.reset(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_window
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_window(callback: JavaScriptGetterCallback) {
		callback.returns(self.window)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_parent
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_parent(callback: JavaScriptGetterCallback) {
		callback.returns(self.parent)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_backgroundColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.backgroundColor)
	}

	/**
	 * @method jsSet_backgroundColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_backgroundColor(callback: JavaScriptSetterCallback) {
		self.backgroundColor.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundImage
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_backgroundImage(callback: JavaScriptGetterCallback) {
		callback.returns(self.backgroundImage)
	}

	/**
	 * @method jsSet_backgroundImage
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_backgroundImage(callback: JavaScriptSetterCallback) {
		self.backgroundImage.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundImageFit
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_backgroundImageFit(callback: JavaScriptGetterCallback) {
		callback.returns(self.backgroundImageFit)
	}

	/**
	 * @method jsSet_backgroundImageFit
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_backgroundImageFit(callback: JavaScriptSetterCallback) {
		self.backgroundImageFit.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundImageAnchorTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_backgroundImageAnchorTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.backgroundImageAnchorTop)
	}

	/**
	 * @method jsSet_backgroundImageAnchorTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_backgroundImageAnchorTop(callback: JavaScriptSetterCallback) {
		self.backgroundImageAnchorTop.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundImageAnchorLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_backgroundImageAnchorLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.backgroundImageAnchorLeft)
	}

	/**
	 * @method jsSet_backgroundImageAnchorLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_backgroundImageAnchorLeft(callback: JavaScriptSetterCallback) {
		self.backgroundImageAnchorLeft.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundImageTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_backgroundImageTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.backgroundImageTop)
	}

	/**
	 * @method jsSet_backgroundImageTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_backgroundImageTop(callback: JavaScriptSetterCallback) {
		self.backgroundImageTop.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundImageLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_backgroundImageLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.backgroundImageLeft)
	}

	/**
	 * @method jsSet_backgroundImageLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_backgroundImageLeft(callback: JavaScriptSetterCallback) {
		self.backgroundImageLeft.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundImageWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_backgroundImageWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.backgroundImageWidth)
	}

	/**
	 * @method jsSet_backgroundImageWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_backgroundImageWidth(callback: JavaScriptSetterCallback) {
		self.backgroundImageWidth.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundImageHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_backgroundImageHeight(callback: JavaScriptGetterCallback) {
		callback.returns(self.backgroundImageHeight)
	}

	/**
	 * @method jsSet_backgroundImageHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_backgroundImageHeight(callback: JavaScriptSetterCallback) {
		self.backgroundImageHeight.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundImageTint
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_backgroundImageTint(callback: JavaScriptGetterCallback) {
		callback.returns(self.backgroundImageTint)
	}

	/**
	 * @method jsSet_backgroundImageTint
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_backgroundImageTint(callback: JavaScriptSetterCallback) {
		self.backgroundImageTint.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_border
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_border(callback: JavaScriptGetterCallback) {

		let width = self.context.createEmptyObject()
		width.property("top", property: self.borderTopWidth)
		width.property("left", property: self.borderLeftWidth)
		width.property("right", property: self.borderRightWidth)
		width.property("bottom", property: self.borderBottomWidth)

		let color = self.context.createEmptyObject()
		color.property("top", property: self.borderTopColor)
		color.property("left", property: self.borderLeftColor)
		color.property("right", property: self.borderRightColor)
		color.property("bottom", property: self.borderBottomColor)

		let value = self.context.createEmptyObject()
		value.property("width", value: width)
		value.property("color", value: color)

		callback.returns(value)
	}

	/**
	 * @method jsSet_border
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_border(callback: JavaScriptSetterCallback) {
		self.border.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_borderTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderTop)
	}

	/**
	 * @method jsSet_borderTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_borderTop(callback: JavaScriptSetterCallback) {
		self.borderTop.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_borderLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderLeft)
	}

	/**
	 * @method jsSet_borderLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_borderLeft(callback: JavaScriptSetterCallback) {
		self.borderLeft.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_borderRight(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderRight)
	}

	/**
	 * @method jsSet_borderRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_borderRight(callback: JavaScriptSetterCallback) {
		self.borderRight.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_borderBottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderBottom)
	}

	/**
	 * @method jsSet_borderBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_borderBottom(callback: JavaScriptSetterCallback) {
		self.borderBottom.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_borderWidth(callback: JavaScriptGetterCallback) {

		let value = self.context.createEmptyObject()
		value.property("top", property: self.borderTopWidth)
		value.property("left", property: self.borderLeftWidth)
		value.property("right", property: self.borderRightWidth)
		value.property("bottom", property: self.borderBottomWidth)

		callback.returns(value)
	}

	/**
	 * @method jsSet_borderWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_borderWidth(callback: JavaScriptSetterCallback) {
		self.borderWidth.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_borderColor(callback: JavaScriptGetterCallback) {

		let value = self.context.createEmptyObject()
		value.property("top", property: self.borderTopColor)
		value.property("left", property: self.borderLeftColor)
		value.property("right", property: self.borderRightColor)
		value.property("bottom", property: self.borderBottomColor)

		callback.returns(value)
	}

	/**
	 * @method jsSet_borderColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_borderColor(callback: JavaScriptSetterCallback) {
		self.borderWidth.reset(callback.value, lock: self)
	}

	//-------------------------------------------------------------------------

	/**
	 * @method jsGet_borderTopColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_borderTopColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderTopColor)
	}

	/**
	 * @method jsSet_borderTopColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_borderTopColor(callback: JavaScriptSetterCallback) {
		self.borderTopColor.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderLeftColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_borderLeftColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderLeftColor)
	}

	/**
	 * @method jsSet_borderLeftColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_borderLeftColor(callback: JavaScriptSetterCallback) {
		self.borderLeftColor.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderRightColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_borderRightColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderRightColor)
	}

	/**
	 * @method jsSet_borderRightColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_borderRightColor(callback: JavaScriptSetterCallback) {
		self.borderRightColor.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderBottomColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_borderBottomColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderBottomColor)
	}

	/**
	 * @method jsSet_borderBottomColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_borderBottomColor(callback: JavaScriptSetterCallback) {
		self.borderBottomColor.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderTopWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_borderTopWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderTopWidth)
	}

	/**
	 * @method jsSet_borderTopWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_borderTopWidth(callback: JavaScriptSetterCallback) {
		self.borderTopWidth.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderLeftWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_borderLeftWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderLeftWidth)
	}

	/**
	 * @method jsSet_borderLeftWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_borderLeftWidth(callback: JavaScriptSetterCallback) {
		self.borderLeftWidth.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderRightWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_borderRightWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderRightWidth)
	}

	/**
	 * @method jsSet_borderRightWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_borderRightWidth(callback: JavaScriptSetterCallback) {
		self.borderRightWidth.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderBottomWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_borderBottomWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderBottomWidth)
	}

	/**
	 * @method jsSet_borderBottomWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_borderBottomWidth(callback: JavaScriptSetterCallback) {
		self.borderBottomWidth.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minBorderTopWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_minBorderTopWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.minBorderTopWidth)
	}

	/**
	 * @method jsSet_minBorderTopWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_minBorderTopWidth(callback: JavaScriptSetterCallback) {
		self.minBorderTopWidth.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxBorderTopWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_maxBorderTopWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxBorderTopWidth)
	}

	/**
	 * @method jsSet_maxBorderTopWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_maxBorderTopWidth(callback: JavaScriptSetterCallback) {
		self.maxBorderTopWidth.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minBorderLeftWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_minBorderLeftWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.minBorderLeftWidth)
	}

	/**
	 * @method jsSet_minBorderLeftWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_minBorderLeftWidth(callback: JavaScriptSetterCallback) {
		self.minBorderLeftWidth.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxBorderLeftWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_maxBorderLeftWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxBorderLeftWidth)
	}

	/**
	 * @method jsSet_maxBorderLeftWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_maxBorderLeftWidth(callback: JavaScriptSetterCallback) {
		self.maxBorderLeftWidth.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minBorderRightWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_minBorderRightWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.minBorderRightWidth)
	}

	/**
	 * @method jsSet_minBorderRightWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_minBorderRightWidth(callback: JavaScriptSetterCallback) {
		self.minBorderRightWidth.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxBorderRightWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_maxBorderRightWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxBorderRightWidth)
	}

	/**
	 * @method jsSet_maxBorderRightWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_maxBorderRightWidth(callback: JavaScriptSetterCallback) {
		self.maxBorderRightWidth.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minBorderBottomWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_minBorderBottomWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.minBorderBottomWidth)
	}

	/**
	 * @method jsSet_minBorderBottomWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_minBorderBottomWidth(callback: JavaScriptSetterCallback) {
		self.minBorderBottomWidth.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxBorderBottomWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_maxBorderBottomWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxBorderBottomWidth)
	}

	/**
	 * @method jsSet_maxBorderBottomWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_maxBorderBottomWidth(callback: JavaScriptSetterCallback) {
		self.maxBorderBottomWidth.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_borderRadius(callback: JavaScriptGetterCallback) {

		let value = self.context.createEmptyObject()
		value.property("topLeft", property: self.borderTopLeftRadius)
		value.property("topRight", property: self.borderTopRightRadius)
		value.property("bottomLeft", property: self.borderBottomLeftRadius)
		value.property("bottomRight", property: self.borderBottomRightRadius)

		callback.returns(value)
	}

	/**
	 * @method jsSet_borderRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_borderRadius(callback: JavaScriptSetterCallback) {
		self.borderRadius.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderTopLeftRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_borderTopLeftRadius(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderTopLeftRadius)
	}

	/**
	 * @method jsSet_borderTopLeftRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_borderTopLeftRadius(callback: JavaScriptSetterCallback) {
		self.borderTopLeftRadius.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderTopRightRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_borderTopRightRadius(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderTopRightRadius)
	}

	/**
	 * @method jsSet_borderTopRightRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_borderTopRightRadius(callback: JavaScriptSetterCallback) {
		self.borderTopRightRadius.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderBottomLeftRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_borderBottomLeftRadius(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderBottomLeftRadius)
	}

	/**
	 * @method jsSet_borderBottomLeftRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_borderBottomLeftRadius(callback: JavaScriptSetterCallback) {
		self.borderBottomLeftRadius.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderBottomRightRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_borderBottomRightRadius(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderBottomRightRadius)
	}

	/**
	 * @method jsSet_borderBottomRightRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_borderBottomRightRadius(callback: JavaScriptSetterCallback) {
		self.borderBottomRightRadius.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shadowBlur
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_shadowBlur(callback: JavaScriptGetterCallback) {
		callback.returns(self.shadowBlur)
	}

	/**
	 * @method jsSet_shadowBlur
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_shadowBlur(callback: JavaScriptSetterCallback) {
		self.shadowBlur.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shadowColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_shadowColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.shadowColor)
	}

	/**
	 * @method jsSet_shadowColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_shadowColor(callback: JavaScriptSetterCallback) {
		self.shadowColor.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shadowOffsetTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_shadowOffsetTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.shadowOffsetTop)
	}

	/**
	 * @method jsSet_shadowOffsetTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_shadowOffsetTop(callback: JavaScriptSetterCallback) {
		self.shadowOffsetTop.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shadowOffsetLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_shadowOffsetLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.shadowOffsetLeft)
	}

	/**
	 * @method jsSet_shadowOffsetLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_shadowOffsetLeft(callback: JavaScriptSetterCallback) {
		self.shadowOffsetLeft.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_top
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_top(callback: JavaScriptGetterCallback) {
		callback.returns(self.top)
	}

	/**
	 * @method jsSet_top
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_top(callback: JavaScriptSetterCallback) {
		self.top.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_left
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_left(callback: JavaScriptGetterCallback) {
		callback.returns(self.left)
	}

	/**
	 * @method jsSet_left
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_left(callback: JavaScriptSetterCallback) {
		self.left.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_right
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_right(callback: JavaScriptGetterCallback) {
		callback.returns(self.right)
	}

	/**
	 * @method jsSet_right
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_right(callback: JavaScriptSetterCallback) {
		self.right.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_bottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_bottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.bottom)
	}

	/**
	 * @method jsSet_bottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_bottom(callback: JavaScriptSetterCallback) {
		self.bottom.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_minTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.minTop)
	}

	/**
	 * @method jsSet_minTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_minTop(callback: JavaScriptSetterCallback) {
		self.minTop.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_maxTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxTop)
	}

	/**
	 * @method jsSet_maxTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_maxTop(callback: JavaScriptSetterCallback) {
		self.maxTop.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_minLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.minLeft)
	}

	/**
	 * @method jsSet_minLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_minLeft(callback: JavaScriptSetterCallback) {
		self.minLeft.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_maxLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxLeft)
	}

	/**
	 * @method jsSet_maxLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_maxLeft(callback: JavaScriptSetterCallback) {
		self.maxLeft.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_minRight(callback: JavaScriptGetterCallback) {
		callback.returns(self.minRight)
	}

	/**
	 * @method jsSet_minRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_minRight(callback: JavaScriptSetterCallback) {
		self.minRight.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_maxRight(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxRight)
	}

	/**
	 * @method jsSet_maxRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_maxRight(callback: JavaScriptSetterCallback) {
		self.maxRight.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_minBottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.minBottom)
	}

	/**
	 * @method jsSet_minBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_minBottom(callback: JavaScriptSetterCallback) {
		self.minBottom.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_maxBottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxBottom)
	}

	/**
	 * @method jsSet_maxBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_maxBottom(callback: JavaScriptSetterCallback) {
		self.maxBottom.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_anchorTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_anchorTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.anchorTop)
	}

	/**
	 * @method jsSet_anchorTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_anchorTop(callback: JavaScriptSetterCallback) {
		self.anchorTop.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_anchorLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_anchorLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.anchorLeft)
	}

	/**
	 * @method jsSet_anchorLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_anchorLeft(callback: JavaScriptSetterCallback) {
		self.anchorLeft.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_width
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_width(callback: JavaScriptGetterCallback) {
		callback.returns(self.width)
	}

	/**
	 * @method jsSet_width
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_width(callback: JavaScriptSetterCallback) {
		self.width.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_height
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_height(callback: JavaScriptGetterCallback) {
		callback.returns(self.height)
	}

	/**
	 * @method jsSet_height
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_height(callback: JavaScriptSetterCallback) {
		self.height.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_minWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.minWidth)
	}

	/**
	 * @method jsSet_minWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_minWidth(callback: JavaScriptSetterCallback) {
		self.minWidth.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_maxWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxWidth)
	}

	/**
	 * @method jsSet_maxWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_maxWidth(callback: JavaScriptSetterCallback) {
		self.maxWidth.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_minHeight(callback: JavaScriptGetterCallback) {
		callback.returns(self.minHeight)
	}

	/**
	 * @method jsSet_minHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_minHeight(callback: JavaScriptSetterCallback) {
		self.minHeight.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_maxHeight(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxHeight)
	}

	/**
	 * @method jsSet_maxHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_maxHeight(callback: JavaScriptSetterCallback) {
		self.maxHeight.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_expandFactor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_expandFactor(callback: JavaScriptGetterCallback) {
		callback.returns(self.expandFactor)
	}

	/**
	 * @method jsSet_expandFactor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_expandFactor(callback: JavaScriptSetterCallback) {
		self.expandFactor.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shrinkFactor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_shrinkFactor(callback: JavaScriptGetterCallback) {
		callback.returns(self.shrinkFactor)
	}

	/**
	 * @method shrinkFactor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_shrinkFactor(callback: JavaScriptSetterCallback) {
		self.shrinkFactor.reset(callback.value, lock: self)
	}
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_contentTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.contentTop)
	}

	/**
	 * @method jsSet_contentTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_contentTop(callback: JavaScriptSetterCallback) {
		self.contentTop.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_contentLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.contentLeft)
	}

	/**
	 * @method jsSet_contentLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_contentLeft(callback: JavaScriptSetterCallback) {
		self.contentLeft.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_contentWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.contentWidth)
	}

	/**
	 * @method jsSet_contentWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_contentWidth(callback: JavaScriptSetterCallback) {
		self.contentWidth.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_contentHeight(callback: JavaScriptGetterCallback) {
		callback.returns(self.contentHeight)
	}

	/**
	 * @method jsSet_contentHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_contentHeight(callback: JavaScriptSetterCallback) {
		self.contentHeight.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentInsetTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_contentInsetTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.contentInsetTop)
	}

	/**
	 * @method jsSet_contentInsetTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_contentInsetTop(callback: JavaScriptSetterCallback) {
		self.contentInsetTop.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentInsetLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_contentInsetLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.contentInsetLeft)
	}

	/**
	 * @method jsSet_contentInsetLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_contentInsetLeft(callback: JavaScriptSetterCallback) {
		self.contentInsetLeft.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentInsetRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_contentInsetRight(callback: JavaScriptGetterCallback) {
		callback.returns(self.contentInsetRight)
	}

	/**
	 * @method jsSet_contentInsetRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_contentInsetRight(callback: JavaScriptSetterCallback) {
		self.contentInsetRight.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentInsetBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_contentInsetBottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.contentInsetBottom)
	}

	/**
	 * @method jsSet_contentInsetBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_contentInsetBottom(callback: JavaScriptSetterCallback) {
		self.contentInsetBottom.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentDirection
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_contentDirection(callback: JavaScriptGetterCallback) {
		callback.returns(self.contentDirection)
	}

	/**
	 * @method jsSet_contentDirection
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_contentDirection(callback: JavaScriptSetterCallback) {
		self.contentDirection.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentDisposition
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_contentDisposition(callback: JavaScriptGetterCallback) {
		callback.returns(self.contentDisposition)
	}

	/**
	 * @method jsSet_contentDisposition
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_contentDisposition(callback: JavaScriptSetterCallback) {
		self.contentDisposition.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentAlignment
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_contentAlignment(callback: JavaScriptGetterCallback) {
		callback.returns(self.contentAlignment)
	}

	/**
	 * @method jsSet_contentAlignment
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_contentAlignment(callback: JavaScriptSetterCallback) {
		self.contentAlignment.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scrollable
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_scrollable(callback: JavaScriptGetterCallback) {
		callback.returns(self.scrollable)
	}

	/**
	 * @method jsSet_scrollable
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_scrollable(callback: JavaScriptSetterCallback) {
		self.scrollable.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scrollbars
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_scrollbars(callback: JavaScriptGetterCallback) {
		callback.returns(self.scrollbars)
	}

	/**
	 * @method jsSet_scrollbars
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_scrollbars(callback: JavaScriptSetterCallback) {
		self.scrollbars.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_overscroll
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_overscroll(callback: JavaScriptGetterCallback) {
		callback.returns(self.overscroll)
	}

	/**
	 * @method jsSet_overscroll
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_overscroll(callback: JavaScriptSetterCallback) {
		self.overscroll.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
     * @method jsGet_momentum
     * @since 0.7.0
     * @hidden
     */
	@objc open func jsGet_momentum(callback: JavaScriptGetterCallback) {
		callback.returns(self.momentum)
	}

	/**
     * @method jsSet_momentum
     * @since 0.7.0
     * @hidden
     */
	@objc open func jsSet_momentum(callback: JavaScriptSetterCallback) {
		self.momentum.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scrollTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_scrollTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.scrollTop)
	}

	/**
	 * @method jsSet_scrollTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_scrollTop(callback: JavaScriptSetterCallback) {
		self.scrollTop.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scrollLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_scrollLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.scrollLeft)
	}

	/**
	 * @method jsSet_scrollLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_scrollLeft(callback: JavaScriptSetterCallback) {
		self.scrollTop.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scrolling
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_scrolling(callback: JavaScriptGetterCallback) {
		callback.returns(self.scrolling)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_dragging
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_dragging(callback: JavaScriptGetterCallback) {
		callback.returns(self.dragging)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_margin
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_margin(callback: JavaScriptGetterCallback) {

		let value = self.context.createEmptyObject()
		value.property("top", property: self.marginTop)
		value.property("left", property: self.marginLeft)
		value.property("right", property: self.marginRight)
		value.property("bottom", property: self.marginBottom)

		callback.returns(value)
	}

	/**
	 * @method jsSet_margin
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_margin(callback: JavaScriptSetterCallback) {
		self.margin.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_marginTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_marginTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.marginTop)
	}

	/**
	 * @method jsSet_marginTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_marginTop(callback: JavaScriptSetterCallback) {
		self.marginTop.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_marginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_marginLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.marginLeft)
	}

	/**
	 * @method jsSet_marginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_marginLeft(callback: JavaScriptSetterCallback) {
		self.marginLeft.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_marginRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_marginRight(callback: JavaScriptGetterCallback) {
		callback.returns(self.marginRight)
	}

	/**
	 * @method jsSet_marginRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_marginRight(callback: JavaScriptSetterCallback) {
		self.marginRight.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_marginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_marginBottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.marginBottom)
	}

	/**
	 * @method jsSet_marginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_marginBottom(callback: JavaScriptSetterCallback) {
		self.marginBottom.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minMarginTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_minMarginTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.minMarginTop)
	}

	/**
	 * @method jsSet_minMarginTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_minMarginTop(callback: JavaScriptSetterCallback) {
		self.minMarginTop.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxMarginTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_maxMarginTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxMarginTop)
	}

	/**
	 * @method jsSet_maxMarginTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_maxMarginTop(callback: JavaScriptSetterCallback) {
		self.maxMarginTop.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minMarginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_minMarginLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.minMarginLeft)
	}

	/**
	 * @method jsSet_minMarginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_minMarginLeft(callback: JavaScriptSetterCallback) {
		self.minMarginLeft.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxMarginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_maxMarginLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxMarginLeft)
	}

	/**
	 * @method jsSet_maxMarginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_maxMarginLeft(callback: JavaScriptSetterCallback) {
		self.maxMarginLeft.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minMarginRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_minMarginRight(callback: JavaScriptGetterCallback) {
		callback.returns(self.minMarginRight)
	}

	/**
	 * @method jsSet_minMarginRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_minMarginRight(callback: JavaScriptSetterCallback) {
		self.minMarginRight.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxMarginRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_maxMarginRight(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxMarginRight)
	}

	/**
	 * @method jsSet_maxMarginRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_maxMarginRight(callback: JavaScriptSetterCallback) {
		self.maxMarginRight.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minMarginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_minMarginBottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.minMarginBottom)
	}

	/**
	 * @method jsSet_minMarginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_minMarginBottom(callback: JavaScriptSetterCallback) {
		self.minMarginBottom.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxMarginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_maxMarginBottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxMarginBottom)
	}

	/**
	 * @method jsSet_maxMarginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_maxMarginBottom(callback: JavaScriptSetterCallback) {
		self.maxMarginBottom.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_padding
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_padding(callback: JavaScriptGetterCallback) {

		let value = self.context.createEmptyObject()
		value.property("top", property: self.paddingTop)
		value.property("left", property: self.paddingLeft)
		value.property("right", property: self.paddingRight)
		value.property("bottom", property: self.paddingBottom)

		callback.returns(value)
	}

	/**
	 * @method jsSet_padding
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_padding(callback: JavaScriptSetterCallback) {
		self.padding.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_paddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_paddingTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.paddingTop)
	}

	/**
	 * @method jsSet_paddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_paddingTop(callback: JavaScriptSetterCallback) {
		self.paddingTop.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_paddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_paddingLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.paddingLeft)
	}

	/**
	 * @method jsSet_paddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_paddingLeft(callback: JavaScriptSetterCallback) {
		self.paddingLeft.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_paddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_paddingRight(callback: JavaScriptGetterCallback) {
		callback.returns(self.paddingRight)
	}

	/**
	 * @method jsSet_paddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_paddingRight(callback: JavaScriptSetterCallback) {
		self.paddingRight.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_paddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_paddingBottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.paddingBottom)
	}

	/**
	 * @method jsSet_paddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_paddingBottom(callback: JavaScriptSetterCallback) {
		self.paddingBottom.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minPaddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_minPaddingTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.minPaddingTop)
	}

	/**
	 * @method jsSet_minPaddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_minPaddingTop(callback: JavaScriptSetterCallback) {
		self.minPaddingTop.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxPaddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_maxPaddingTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxPaddingTop)
	}

	/**
	 * @method jsSet_maxPaddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_maxPaddingTop(callback: JavaScriptSetterCallback) {
		self.maxPaddingTop.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minPaddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_minPaddingLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.minPaddingLeft)
	}

	/**
	 * @method jsSet_minPaddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_minPaddingLeft(callback: JavaScriptSetterCallback) {
		self.minPaddingLeft.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxPaddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_maxPaddingLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxPaddingLeft)
	}

	/**
	 * @method jsSet_maxPaddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_maxPaddingLeft(callback: JavaScriptSetterCallback) {
		self.maxPaddingLeft.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minPaddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_minPaddingRight(callback: JavaScriptGetterCallback) {
		callback.returns(self.minPaddingRight)
	}

	/**
	 * @method jsSet_minPaddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_minPaddingRight(callback: JavaScriptSetterCallback) {
		self.minPaddingRight.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxPaddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_maxPaddingRight(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxPaddingRight)
	}

	/**
	 * @method jsSet_maxPaddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_maxPaddingRight(callback: JavaScriptSetterCallback) {
		self.maxPaddingRight.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minPaddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_minPaddingBottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.minPaddingBottom)
	}

	/**
	 * @method jsSet_minPaddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_minPaddingBottom(callback: JavaScriptSetterCallback) {
		self.minPaddingBottom.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxPaddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_maxPaddingBottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxPaddingBottom)
	}

	/**
	 * @method jsSet_maxPaddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_maxPaddingBottom(callback: JavaScriptSetterCallback) {
		self.maxPaddingBottom.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_visible
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_visible(callback: JavaScriptGetterCallback) {
		callback.returns(self.visible)
	}

	/**
	 * @method jsSet_visible
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_visible(callback: JavaScriptSetterCallback) {
		self.visible.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_opacity
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_opacity(callback: JavaScriptGetterCallback) {
		callback.returns(self.opacity)
	}

	/**
	 * @method jsSet_opacity
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_opacity(callback: JavaScriptSetterCallback) {
		self.opacity.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_originX
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_originX(callback: JavaScriptGetterCallback) {
		callback.returns(self.originX)
	}

	/**
	 * @method jsSet_originX
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_originX(callback: JavaScriptSetterCallback) {
		self.originX.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_originY
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_originY(callback: JavaScriptGetterCallback) {
		callback.returns(self.originY)
	}

	/**
	 * @method jsSet_originY
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_originY(callback: JavaScriptSetterCallback) {
		self.originY.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_originZ
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_originZ(callback: JavaScriptGetterCallback) {
		callback.returns(self.originZ)
	}

	/**
	 * @method jsSet_originZ
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_originZ(callback: JavaScriptSetterCallback) {
		self.originZ.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_translationX
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_translationX(callback: JavaScriptGetterCallback) {
		callback.returns(self.translationX)
	}

	/**
	 * @method jsSet_translationX
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_translationX(callback: JavaScriptSetterCallback) {
		self.translationX.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_translationY
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_translationY(callback: JavaScriptGetterCallback) {
		callback.returns(self.translationY)
	}

	/**
	 * @method jsSet_translationY
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_translationY(callback: JavaScriptSetterCallback) {
		self.translationY.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_translationZ
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_translationZ(callback: JavaScriptGetterCallback) {
		callback.returns(self.translationZ)
	}

	/**
	 * @method jsSet_translationZ
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_translationZ(callback: JavaScriptSetterCallback) {
		self.translationZ.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_rotationX
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_rotationX(callback: JavaScriptGetterCallback) {
		callback.returns(self.rotationX)
	}

	/**
	 * @method jsSet_rotationX
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_rotationX(callback: JavaScriptSetterCallback) {
		self.rotationX.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_rotationY
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_rotationY(callback: JavaScriptGetterCallback) {
		callback.returns(self.rotationY)
	}

	/**
	 * @method jsSet_rotationY
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_rotationY(callback: JavaScriptSetterCallback) {
		self.rotationY.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_rotationZ
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_rotationZ(callback: JavaScriptGetterCallback) {
		callback.returns(self.rotationZ)
	}

	/**
	 * @method jsSet_rotationZ
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_rotationZ(callback: JavaScriptSetterCallback) {
		self.rotationZ.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scaleX
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_scaleX(callback: JavaScriptGetterCallback) {
		callback.returns(self.scaleX)
	}

	/**
	 * @method jsSet_scaleX
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_scaleX(callback: JavaScriptSetterCallback) {
		self.scaleX.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scaleY
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_scaleY(callback: JavaScriptGetterCallback) {
		callback.returns(self.scaleY)
	}

	/**
	 * @method jsSet_scaleY
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_scaleY(callback: JavaScriptSetterCallback) {
		self.scaleY.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scaleZ
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_scaleZ(callback: JavaScriptGetterCallback) {
		callback.returns(self.scaleZ)
	}

	/**
	 * @method jsSet_scaleZ
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_scaleZ(callback: JavaScriptSetterCallback) {
		self.scaleZ.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_zIndex
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_zIndex(callback: JavaScriptGetterCallback) {
		callback.returns(self.zIndex)
	}

	/**
	 * @method jsSet_zIndex
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_zIndex(callback: JavaScriptSetterCallback) {
		self.zIndex.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_clipped
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_clipped(callback: JavaScriptGetterCallback) {
		callback.returns(self.clipped)
	}

	/**
	 * @method jsSet_clipped
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_clipped(callback: JavaScriptSetterCallback) {
		self.clipped.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_zoomable
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_zoomable(callback: JavaScriptGetterCallback) {
		callback.returns(self.zoomable)
	}

	/**
	 * @method jsSet_zoomable
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_zoomable(callback: JavaScriptSetterCallback) {
		self.zoomable.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minZoom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_minZoom(callback: JavaScriptGetterCallback) {
		callback.returns(self.minZoom)
	}

	/**
	 * @method jsSet_minZoom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_minZoom(callback: JavaScriptSetterCallback) {
		self.minZoom.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxZoom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_maxZoom(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxZoom)
	}

	/**
	 * @method jsSet_maxZoom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_maxZoom(callback: JavaScriptSetterCallback) {
		self.maxZoom.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_zoomedView
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_zoomedView(callback: JavaScriptGetterCallback) {
		callback.returns(self.zoomedView)
	}

	/**
	 * @method jsSet_zoomedView
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_zoomedView(callback: JavaScriptSetterCallback) {
		self.zoomedView = callback.value.isNull ? nil : callback.value.cast(JavaScriptView.self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_drawable
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_drawable(callback: JavaScriptGetterCallback) {
		callback.returns(self.drawable)
	}

	/**
	 * @method jsSet_drawable
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_drawable(callback: JavaScriptSetterCallback) {
		self.drawable.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_touchable
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_touchable(callback: JavaScriptGetterCallback) {
		callback.returns(self.touchable)
	}

	/**
	 * @method jsSet_touchable
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_touchable(callback: JavaScriptSetterCallback) {
		self.touchable.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_touchOffsetTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_touchOffsetTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.touchOffsetTop)
	}

	/**
	 * @method jsSet_touchOffsetTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_touchOffsetTop(callback: JavaScriptSetterCallback) {
		self.touchOffsetTop.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_touchOffsetLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_touchOffsetLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.touchOffsetLeft)
	}

	/**
	 * @method jsSet_touchOffsetLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_touchOffsetLeft(callback: JavaScriptSetterCallback) {
		self.touchOffsetLeft.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_touchOffsetRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_touchOffsetRight(callback: JavaScriptGetterCallback) {
		callback.returns(self.touchOffsetRight)
	}

	/**
	 * @method jsSet_touchOffsetRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_touchOffsetRight(callback: JavaScriptSetterCallback) {
		self.touchOffsetRight.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_touchOffsetBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_touchOffsetBottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.touchOffsetBottom)
	}

	/**
	 * @method jsSet_touchOffsetBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_touchOffsetBottom(callback: JavaScriptSetterCallback) {
		self.touchOffsetBottom.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_paged
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_paged(callback: JavaScriptGetterCallback) {
		callback.returns(self.paged)
	}

	/**
	 * @method jsSet_paged
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_paged(callback: JavaScriptSetterCallback) {
		self.paged.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_measuredTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_measuredTop(callback: JavaScriptGetterCallback) {

		let measuredTop = self.node.measuredTop

		if (self.resolvedTop != measuredTop) {
			self.resolvedTop = measuredTop
			self.measuredTop.reset()
		}

		if (self.measuredTop.isNull) {
			self.measuredTop.reset(self.resolvedTop)
		}

		callback.returns(self.measuredTop)
	}

	/**
	 * @method jsGet_measuredLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_measuredLeft(callback: JavaScriptGetterCallback) {

		let measuredLeft = self.node.measuredLeft

		if (self.resolvedLeft != measuredLeft) {
			self.resolvedLeft = measuredLeft
			self.measuredLeft.reset()
		}

		if (self.measuredLeft.isNull) {
			self.measuredLeft.reset(self.resolvedLeft)
		}

		callback.returns(self.measuredLeft)
	}

	/**
	 * @method jsGet_measuredWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_measuredWidth(callback: JavaScriptGetterCallback) {

		let measuredWidth = self.node.measuredWidth

		if (self.resolvedWidth != measuredWidth) {
			self.resolvedWidth = measuredWidth
			self.measuredWidth.reset()
		}

		if (self.measuredWidth.isNull) {
			self.measuredWidth.reset(self.resolvedWidth)
		}

		callback.returns(self.measuredWidth)
	}

	/**
	 * @method jsGet_measuredHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_measuredHeight(callback: JavaScriptGetterCallback) {

		let measuredHeight = self.node.measuredHeight

		if (self.resolvedHeight != measuredHeight) {
			self.resolvedHeight = measuredHeight
			self.measuredHeight.reset()
		}

		if (self.measuredHeight.isNull) {
			self.measuredHeight.reset(self.resolvedHeight)
		}

		callback.returns(self.measuredHeight)
	}

	/**
	 * @method jsGet_measuredInnerWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_measuredInnerWidth(callback: JavaScriptGetterCallback) {

		let measuredInnerWidth = self.node.measuredInnerWidth

		if (self.resolvedInnerWidth != measuredInnerWidth) {
			self.resolvedInnerWidth = measuredInnerWidth
			self.measuredInnerWidth.reset()
		}

		if (self.measuredInnerWidth.isNull) {
			self.measuredInnerWidth.reset(self.resolvedInnerWidth)
		}

		callback.returns(self.measuredInnerWidth)
	}

	/**
	 * @method jsGet_measuredInnerHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_measuredInnerHeight(callback: JavaScriptGetterCallback) {

		let measuredInnerHeight = self.node.measuredInnerHeight

		if (self.resolvedInnerHeight != measuredInnerHeight) {
			self.resolvedInnerHeight = measuredInnerHeight
			self.measuredInnerHeight.reset()
		}

		if (self.measuredInnerHeight.isNull) {
			self.measuredInnerHeight.reset(self.resolvedInnerHeight)
		}

		callback.returns(self.measuredInnerHeight)
	}

	/**
	 * @method jsGet_measuredContentWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_measuredContentWidth(callback: JavaScriptGetterCallback) {

		let measuredContentWidth = self.node.measuredContentWidth

		if (self.resolvedContentWidth != measuredContentWidth) {
			self.resolvedContentWidth = measuredContentWidth
			self.measuredContentWidth.reset()
		}

		if (self.measuredContentWidth.isNull) {
			self.measuredContentWidth.reset(self.resolvedContentWidth)
		}

		callback.returns(self.measuredContentWidth)
	}

	/**
	 * @method jsGet_measuredContentHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_measuredContentHeight(callback: JavaScriptGetterCallback) {

		let measuredContentHeight = self.node.measuredContentHeight

		if (self.resolvedContentHeight != measuredContentHeight) {
			self.resolvedContentHeight = measuredContentHeight
			self.measuredContentHeight.reset()
		}

		if (self.measuredContentHeight.isNull) {
			self.measuredContentHeight.reset(self.resolvedContentHeight)
		}

		callback.returns(self.measuredContentHeight)
	}

	/**
	 * @method jsGet_measuredMarginTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_measuredMarginTop(callback: JavaScriptGetterCallback) {

		let measuredMarginTop = self.node.measuredTop

		if (self.resolvedMarginTop != measuredMarginTop) {
			self.resolvedMarginTop = measuredMarginTop
			self.measuredMarginTop.reset()
		}

		if (self.measuredMarginTop.isNull) {
			self.measuredMarginTop.reset(self.resolvedMarginTop)
		}

		callback.returns(self.measuredMarginTop)
	}

	/**
	 * @method jsGet_measuredMarginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_measuredMarginLeft(callback: JavaScriptGetterCallback) {

		let measuredMarginLeft = self.node.measuredMarginLeft

		if (self.resolvedMarginLeft != measuredMarginLeft) {
			self.resolvedMarginLeft = measuredMarginLeft
			self.measuredMarginLeft.reset()
		}

		if (self.measuredMarginLeft.isNull) {
			self.measuredMarginLeft.reset(self.resolvedMarginLeft)
		}

		callback.returns(self.measuredMarginLeft)
	}

	/**
	 * @method jsGet_measuredMarginRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_measuredMarginRight(callback: JavaScriptGetterCallback) {

		let measuredMarginRight = self.node.measuredMarginRight

		if (self.resolvedMarginRight != measuredMarginRight) {
			self.resolvedMarginRight = measuredMarginRight
			self.measuredMarginRight.reset()
		}

		if (self.measuredMarginRight.isNull) {
			self.measuredMarginRight.reset(self.resolvedMarginRight)
		}

		callback.returns(self.measuredMarginRight)
	}

	/**
	 * @method jsGet_measuredMarginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_measuredMarginBottom(callback: JavaScriptGetterCallback) {

		let measuredMarginBottom = self.node.measuredMarginBottom

		if (self.resolvedMarginBottom != measuredMarginBottom) {
			self.resolvedMarginBottom = measuredMarginBottom
			self.measuredMarginBottom.reset()
		}

		if (self.measuredMarginBottom.isNull) {
			self.measuredMarginBottom.reset(self.resolvedMarginBottom)
		}

		callback.returns(self.measuredMarginBottom)
	}

	/**
	 * @method jsGet_measuredPaddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_measuredPaddingTop(callback: JavaScriptGetterCallback) {

		let measuredPaddingTop = self.node.measuredPaddingTop

		if (self.resolvedPaddingTop != measuredPaddingTop) {
			self.resolvedPaddingTop = measuredPaddingTop
			self.measuredPaddingTop.reset()
		}

		if (self.measuredPaddingTop.isNull) {
			self.measuredPaddingTop.reset(self.resolvedPaddingTop)
		}

		callback.returns(self.measuredPaddingTop)
	}

	/**
	 * @method jsGet_measuredPaddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_measuredPaddingLeft(callback: JavaScriptGetterCallback) {

		let measuredPaddingLeft = self.node.measuredPaddingLeft

		if (self.resolvedPaddingLeft != measuredPaddingLeft) {
			self.resolvedPaddingLeft = measuredPaddingLeft
			self.measuredPaddingLeft.reset()
		}

		if (self.measuredPaddingLeft.isNull) {
			self.measuredPaddingLeft.reset(self.resolvedPaddingLeft)
		}

		callback.returns(self.measuredPaddingLeft)
	}

	/**
	 * @method jsGet_measuredPaddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_measuredPaddingRight(callback: JavaScriptGetterCallback) {

		let measuredPaddingRight = self.node.measuredPaddingRight

		if (self.resolvedPaddingRight != measuredPaddingRight) {
			self.resolvedPaddingRight = measuredPaddingRight
			self.measuredPaddingRight.reset()
		}

		if (self.measuredPaddingRight.isNull) {
			self.measuredPaddingRight.reset(self.resolvedPaddingRight)
		}

		callback.returns(self.measuredPaddingRight)
	}

	/**
	 * @method jsGet_measuredPaddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_measuredPaddingBottom(callback: JavaScriptGetterCallback) {

		let measuredPaddingBottom = self.node.measuredPaddingBottom

		if (self.resolvedPaddingBottom != measuredPaddingBottom) {
			self.resolvedPaddingBottom = measuredPaddingBottom
			self.measuredPaddingBottom.reset()
		}

		if (self.measuredPaddingBottom.isNull) {
			self.measuredPaddingBottom.reset(self.resolvedPaddingBottom)
		}

		callback.returns(self.measuredPaddingBottom)
	}

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsStaticFunction_transition
	 * @since 0.7.0
	 * @hidden
	 */
	@objc class func jsStaticFunction_transition(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 8) {
			fatalError("Method JavaScriptView.transition() requires 8 arguments.")
		}

		let duration = callback.argument(0).number / 1000
		let equation = CAMediaTimingFunction(controlPoints:
			Float(callback.argument(1).number),
			Float(callback.argument(2).number),
			Float(callback.argument(3).number),
			Float(callback.argument(4).number)
		)

		let delay = callback.argument(5).number / 1000.0

		let complete = callback.argument(6)
		let function = callback.argument(7)

		let animate = {

			Transition.create(
				duration: duration,
				equation: equation,
				delay: delay
			) {
				complete.call()
				complete.unprotect()
			}

			function.call()
			complete.protect()

			Transition.commit()
		}

		if (callback.context.application.display.resolving) {
			callback.context.application.display.requestLayoutEndedCallback(animate)
			return
		}

		animate()
	}

	/**
	 * @method jsFunction_setOpaque
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_setOpaque(callback: JavaScriptFunctionCallback) {
		self.node.setOpaque()
	}

	/**
	 * @method jsFunction_destroy
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_destroy(callback: JavaScriptFunctionCallback) {
		self.dispose()
	}

	/**
	 * @method jsFunction_insert
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_insert(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 2) {
			fatalError("Method JavaScriptView.insert() requires 2 arguments.")
		}

		let child = callback.argument(0)
		let index = callback.argument(1).number

		if let child = child.cast(JavaScriptView.self) {
			self.insert(child, at: index.toInt())
		}
	}

	/**
	 * @method jsFunction_remove
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_remove(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptView.remove() requires 1 argument.")
		}

		let child = callback.argument(0)

		if let child = child.cast(JavaScriptView.self) {
			self.remove(child)
		}
	}

	/**
	 * @method jsFunction_appendStyle
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_appendStyle(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptView.appendStyle() requires 1 argument.")
		}

		self.node.appendStyle(callback.argument(0).string)
	}

	/**
	 * @method jsFunction_removeStyle
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_removeStyle(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptView.removeStyle() requires 1 argument.")
		}

		self.node.removeStyle(callback.argument(0).string)
	}

	/**
	 * @method jsFunction_appendState
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_appendState(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptView.appendState() requires 1 argument.")
		}

		self.node.appendState(callback.argument(0).string)
	}

	/**
	 * @method jsFunction_removeState
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_removeState(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptView.removeState() requires 1 argument.")
		}

		self.node.removeState(callback.argument(0).string)
	}

	/**
	 * @method jsFunction_scheduleRedraw
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_scheduleRedraw(callback: JavaScriptFunctionCallback) {
		self.scheduleRedraw()
	}

	/**
	 * @method jsFunction_scheduleLayout
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_scheduleLayout(callback: JavaScriptFunctionCallback) {
		self.scheduleLayout()
	}

	/**
	 * @method jsFunction_measure
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_measure(callback: JavaScriptFunctionCallback) {
		self.measure()
	}

	/**
	 * @method jsFunction_resolve
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_resolve(callback: JavaScriptFunctionCallback) {
		self.resolve()
	}

	/**
	 * @method jsFunction_scrollTo
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_scrollTo(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 2) {
			fatalError("Method JavaScriptView.scrollTo() requires 2 arguments.")
		}

		let y = callback.argument(0).number
		let x = callback.argument(1).number

		self.scrollableView?.scrollTo(x: CGFloat(x), y: CGFloat(y))
	}

	//--------------------------------------------------------------------------
	// MARK: Types
	//--------------------------------------------------------------------------

	/**
	 * The view's delegate.
	 * @type ViewDelegate
	 * @since 0.7.0
	 */
	public typealias Delegate = ViewDelegate
}

/**
 * @type ViewDelegate
 * @since 0.7.0
 * @hidden
 */
public protocol ViewDelegate: class {
	func didBeginLayout(view: JavaScriptView)
	func didFinishLayout(view: JavaScriptView)
	func didScroll(view: JavaScriptView)
}
