import UIKit
import QuartzCore

/**
 * @class JavaScriptView
 * @super JavaScriptClass
 * @since 0.7.0
 */
open class JavaScriptView: JavaScriptClass, DisplayNodeDelegate, ScrollableDelegate, SynchronizerCallback {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property delegate
	 * @since 0.7.0
	 */
	open weak var delegate: Delegate?

	/**
	 * @property node
	 * @since 0.7.0
	 */
	private(set) public var node: DisplayNode!

	/**
	 * @property wrapper
	 * @since 0.7.0
	 */
	private(set) public var wrapper: WrapperView!

	/**
	 * @property content
	 * @since 0.7.0
	 */
	private(set) public var content: UIView!

	/**
	 * @property window
	 * @since 0.7.0
	 */
	private(set) public var window: JavaScriptWindow?

	/**
	 * @property parent
	 * @since 0.7.0
	 */
	private(set) public var parent: JavaScriptView?

	/**
	 * @property children
	 * @since 0.7.0
	 */
	private(set) public var children: [JavaScriptView] = []

	/**
	 * @property resolvedTop
	 * @since 0.7.0
	 */
	private(set) public var resolvedTop: Double = 0

	/**
	 * @property resolvedLeft
	 * @since 0.7.0
	 */
	private(set) public var resolvedLeft: Double = 0

	/**
	 * @property resolvedWidth
	 * @since 0.7.0
	 */
	private(set) public var resolvedWidth: Double = 0

	/**
	 * @property resolvedHeight
	 * @since 0.7.0
	 */
	private(set) public var resolvedHeight: Double = 0

	/**
	 * @property resolvedInnerWidth
	 * @since 0.7.0
	 */
	private(set) public var resolvedInnerWidth: Double = 0

	/**
	 * @property resolvedInnerHeight
	 * @since 0.7.0
	 */
	private(set) public var resolvedInnerHeight: Double = 0

	/**
	 * @property resolvedContentWidth
	 * @since 0.7.0
	 */
	private(set) public var resolvedContentWidth: Double = 0

	/**
	 * @property resolvedContentHeight
	 * @since 0.7.0
	 */
	private(set) public var resolvedContentHeight: Double = 0

	/**
	 * @property resolvedMarginTop
	 * @since 0.7.0
	 */
	private(set) public var resolvedMarginTop: Double = 0

	/**
	 * @property resolvedMarginLeft
	 * @since 0.7.0
	 */
	private(set) public var resolvedMarginLeft: Double = 0

	/**
	 * @property resolvedMarginRight
	 * @since 0.7.0
	 */
	private(set) public var resolvedMarginRight: Double = 0

	/**
	 * @property resolvedMarginBottom
	 * @since 0.7.0
	 */
	private(set) public var resolvedMarginBottom: Double = 0

	/**
	 * @property resolvedBorderTopWidth
	 * @since 0.7.0
	 */
	private(set) public var resolvedBorderTopWidth: Double = 0

	/**
	 * @property resolvedBorderLeftWidth
	 * @since 0.7.0
	 */
	private(set) public var resolvedBorderLeftWidth: Double = 0

	/**
	 * @property resolvedBorderRightWidth
	 * @since 0.7.0
	 */
	private(set) public var resolvedBorderRightWidth: Double = 0

	/**
	 * @property resolvedBorderBottomWidth
	 * @since 0.7.0
	 */
	private(set) public var resolvedBorderBottomWidth: Double = 0

	/**
	 * @property resolvedPaddingTop
	 * @since 0.7.0
	 */
	private(set) public var resolvedPaddingTop: Double = 0

	/**
	 * @property resolvedPaddingLeft
	 * @since 0.7.0
	 */
	private(set) public var resolvedPaddingLeft: Double = 0

	/**
	 * @property resolvedPaddingRight
	 * @since 0.7.0
	 */
	private(set) public var resolvedPaddingRight: Double = 0

	/**
	 * @property resolvedPaddingBottom
	 * @since 0.7.0
	 */
	private(set) public var resolvedPaddingBottom: Double = 0

	/**
	 * @property resolvedTranslationX
	 * @since 0.7.0
	 */
	private(set) public var resolvedTranslationX: Double = 0.0

	/**
	 * @property resolvedTranslationY
	 * @since 0.7.0
	 */
	private(set) public var resolvedTranslationY: Double = 0.0

	/**
	 * @property resolvedTranslationZ
	 * @since 0.7.0
	 */
	private(set) public var resolvedTranslationZ: Double = 0.0

	/**
	 * @property resolvedRotationX
	 * @since 0.7.0
	 */
	private(set) public var resolvedRotationX: Double = 0.0

	/**
	 * @property resolvedRotationY
	 * @since 0.7.0
	 */
	private(set) public var resolvedRotationY: Double = 0.0

	/**
	 * @property resolvedRotationZ
	 * @since 0.7.0
	 */
	private(set) public var resolvedRotationZ: Double = 0.0

	/**
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
	 * @property backgroundImageLoader
	 * @since 0.7.0
	 * @hidden
	 */
	private var backgroundImageLoader: ImageLoader = ImageLoader()

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
	 * @property updateScheduled
	 * @since 0.7.0
	 * @hidden
	 */
	private var updateScheduled: Bool = false

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

		self.node = DisplayNode(display: context.controller.display)
		self.node.delegate = self

		self.content = self.createContentView()
		self.wrapper = self.createWrapperView()

		self.scrollableView?.scrollableDelegate = self

		self.scheduleUpdate()
	}

	/**
	 * @method dispose
	 * @since 0.7.0
	 */
	override open func dispose() {

		if (self.disposed) {
			return
		}

		self.disposed = true

		self.wrapper.removeFromSuperview()
		self.content.removeFromSuperview()

		super.dispose()
	}

	/**
	 * @method createWrapperView
	 * @since 0.7.0
	 */
	open func createWrapperView() -> WrapperView {
		return WrapperView(content: self.content)
	}

	/**
	 * @method createContentView
	 * @since 0.7.0
	 */
	open func createContentView() -> UIView {
		return View(frame: .zero)
	}

	/**
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
	 * @method measure
	 * @since 0.7.0
	 */
	open func measure(bounds: CGSize, min: CGSize, max: CGSize) -> CGSize? {
		return nil
	}

	/**
	 * @method measure
	 * @since 0.7.0
	 */
	open func measure() {
		self.node.measure()
	}

	/**
	 * @method resolve
	 * @since 0.7.0
	 */
	open func resolve() {
		self.node.resolve()
	}

	/**
	 * @method scheduleLayout
	 * @since 0.7.0
	 */
	open func scheduleLayout() {
		self.node.invalidateLayout()
	}

	/**
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

		self.content.updateGradient()

		if (self.wrapper.hasFrame == false && self.resolvedFrame) {
			self.wrapper.hasFrame = true
		}

		self.updateScheduled = false
	}

	/**
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
	 * @method updateShadow
	 * @since 0.7.0
	 */
	open func updateShadow() {
		self.wrapper.shadowBlur = CGFloat(self.shadowBlur.number)
		self.wrapper.shadowColor = UIColor(color: self.shadowColor)
		self.wrapper.shadowOffsetTop = CGFloat(self.shadowOffsetTop.number)
		self.wrapper.shadowOffsetLeft = CGFloat(self.shadowOffsetLeft.number)
	}

	/**
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
	 * @method createCanvas
	 * @since 0.7.0
	 */
	open func createCanvas() -> JavaScriptCanvas? {
		return nil // TODO FIX THIS
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Display Node Delegate
	//--------------------------------------------------------------------------

	/**
	 * @method didInvalidate
	 * @since 0.7.0
	 */
	open func didInvalidate(node: DisplayNode) {
		self.scheduleUpdate()
	}

	/**
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
	 * @method didPrepareLayout
	 * @since 0.7.0
	 */
	open func didPrepareLayout(node: DisplayNode) {
		self.delegate?.didPrepareLayout(view: self)
	}

	/**
	 * @method didResolveLayout
	 * @since 0.7.0
	 */
	open func didResolveLayout(node: DisplayNode) {
		self.delegate?.didResolveLayout(view: self)
		self.callMethod("nativeOnLayout")
	}

	/**
	 * @method measure
	 * @since 0.7.0
	 */
	open func measure(node: DisplayNode, bounds: CGSize, min: CGSize, max: CGSize) -> CGSize? {
		return self.measure(bounds: bounds, min: min, max: max)
	}

	/**
	 * @method resolve
	 * @since 0.7.0
	 */
	open func resolve(node: DisplayNode, property: String) -> JavaScriptProperty? {
		return self.value(forKey: property) as? JavaScriptProperty
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Scrollable Delegate
	//--------------------------------------------------------------------------

	/**
	 * @method didBeginDragging
	 * @since 0.7.0
	 */
	open func didBeginDragging(scrollable: Scrollable) {
		self.dragging.reset(true)
		self.callMethod("nativeOnDragStart")
	}

	/**
	 * @method didFinishDragging
	 * @since 0.7.0
	 */
	open func didFinishDragging(scrollable: Scrollable) {
		self.dragging.reset(false)
		self.callMethod("nativeOnDragEnd")
	}

	/**
	 * @method didDrag
	 * @since 0.7.0
	 */
	open func didDrag(scrollable: Scrollable) {
		self.callMethod("nativeOnDrag")
	}

	/**
	 * @method didBeginScrolling
	 * @since 0.7.0
	 */
	open func didBeginScrolling(scrollable: Scrollable) {
		self.scrolling.reset(true)
		self.callMethod("nativeOnScrollStart")
	}

	/**
	 * @method didFinishScrolling
	 * @since 0.7.0
	 */
	open func didFinishScrolling(scrollable: Scrollable) {
		self.scrolling.reset(false)
		self.callMethod("nativeOnScrollEnd")
	}

	/**
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
	 * @method didBeginZooming
	 * @since 0.7.0
	 */
	open func didBeginZooming(scrollable: Scrollable) {
		self.callMethod("nativeOnZoomStart")
	}

	/**
	 * @method didFinishZooming
	 * @since 0.7.0
	 */
	open func didFinishZooming(scrollable: Scrollable, scale: CGFloat) {
		self.callMethod("nativeOnZoomEnd", arguments: [self.context.createNumber(scale)])
	}

	/**
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
		self.content.insertSubview(view.wrapper, at: index)
		self.node.insertChild(view.node, at: index)
	}

	/**
	 * @method removeChild
	 * @since 0.7.0
	 * @hidden
	 */
	open func removeChild(_ view: JavaScriptView) {
		self.children.remove(view)
		self.content.removeSubview(view.wrapper)
		self.node.removeChild(view.node)
	}

	/**
	 * @method moveToParent
	 * @since 0.7.0
	 * @hidden
	 */
	private func moveToParent(_ parent: JavaScriptView?, notify: Bool = true) {

		if (self.parent == parent) {
			return
		}

		if (notify) {
			self.callMethod("nativeOnMoveToParent", arguments: [parent, self.parent])
		}

		self.parent = parent
	}

	/**
	 * @method moveToWindow
	 * @since 0.7.0
	 * @hidden
	 */
	private func moveToWindow(_ window: JavaScriptWindow?, notify: Bool = true) {

		if (self.window == window) {
			return
		}

		if (notify) {
			self.callMethod("nativeOnMoveToWindow", arguments: [window, self.window])
		}

		self.window = window

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

	/**
	 * @method getBackgroundImageFit
	 * @since 0.7.0
	 * @hidden
	 */
	private func getBackgroundImageFit(_ value: String) -> ImageFit {

		switch (value) {

			case "cover":
				return .cover
			case "contain":
				return .contain

			default:
				NSLog("Unrecognized value for backgroundImageFit: \(value)")
		}

		return .contain
	}

	/**
	 * @method getBackgroundImagePosition
	 * @since 0.7.0
	 * @hidden
	 */
	private func getBackgroundImagePosition(_ value: String) -> ImagePosition {

		switch (value) {

			case "top left":
				return .topLeft
			case "top right":
				return .topRight
			case "top center":
				return .topCenter

			case "left":
				return .middleLeft
			case "right":
				return .middleRight
			case "center":
				return .middleCenter

			case "bottom left":
				return .bottomLeft
			case "bottom right":
				return .bottomRight
			case "bottom center":
				return .bottomCenter

			default:
				NSLog("Unrecognized value for backgroundImagePosition: \(value)")
		}

		return .middleCenter
	}

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @property id
	 * @since 0.7.0
	 */
	@objc lazy var id = JavaScriptProperty(string: "") { value in
		self.node.setName(value.string)
	}

	/**
	 * @property className
	 * @since 0.7.0
	 */
	@objc lazy var className = JavaScriptProperty(string: "") { value in
		self.node.setType(value.string)
	}

	/**
	 * @property backgroundColor
	 * @since 0.7.0
	 */
	@objc lazy var backgroundColor = JavaScriptProperty(string: "transparent") { value in

		self.content.backgroundColor = nil
		self.content.backgroundLinearGradient = nil
		self.content.backgroundRadialGradient = nil

		if let function = value.function {

			switch (function.name) {

				case "linear-gradient":
					self.content.backgroundLinearGradient = LinearGradient(property: value)
					return

				case "radial-gradient":
					self.content.backgroundRadialGradient = RadialGradient(property: value)
					return

				default:
					break
			}
		}

		/*
		 * At this point, we have a color or a color function. A linear or
		 * radial graidient returned earlier
		 */

		self.content.backgroundColor = UIColor(color: value)
	}

	/**
	 * @property backgroundImage
	 * @since 0.7.0
	 */
	@objc lazy var backgroundImage = JavaScriptProperty() { value in
		self.backgroundImageLoader.load(value) { image in
			self.wrapper.backgroundImage = image
		}
	}

	/**
	 * @property backgroundImageFit
	 * @since 0.7.0
	 */
	@objc lazy var backgroundImageFit = JavaScriptProperty(string: "cover") { value in
		self.wrapper.backgroundImageFit = self.getBackgroundImageFit(value.string)
	}

	/**
	 * @property backgroundImagePosition
	 * @since 0.7.0
	 */
	@objc lazy var backgroundImagePosition = JavaScriptProperty(string: "center") { value in
		self.wrapper.backgroundImagePosition = self.getBackgroundImagePosition(value.string)
	}

	/**
	 * @property border
	 * @since 0.7.0
	 */
	@objc lazy var border = JavaScriptProperty(string: "0 #000") { value in

		guard let composite = value.composite else {
			return
		}

		let values = composite.values
		if (values.count < 2) {
			return
		}

		let width = values[0]
		let color = values[1]

		self.borderTopWidth.reset(width)
		self.borderLeftWidth.reset(width)
		self.borderRightWidth.reset(width)
		self.borderBottomWidth.reset(width)

		self.borderTopColor.reset(color)
		self.borderLeftColor.reset(color)
		self.borderRightColor.reset(color)
		self.borderBottomColor.reset(color)
	}

	/**
	 * @property borderTop
	 * @since 0.7.0
	 */
	@objc lazy var borderTop = JavaScriptProperty(string: "0 #000") { value in

		guard let composite = value.composite else {
			return
		}

		let values = composite.values
		if (values.count < 2) {
			return
		}

		self.borderTopWidth.reset(values[0])
		self.borderTopColor.reset(values[1])
	}

	/**
	 * @property borderTop
	 * @since 0.7.0
	 */
	@objc lazy var borderLeft = JavaScriptProperty(string: "0 #000") { value in

		guard let composite = value.composite else {
			return
		}

		let values = composite.values
		if (values.count < 2) {
			return
		}

		self.borderLeftWidth.reset(values[0])
		self.borderLeftColor.reset(values[1])
	}

	/**
	 * @property borderRight
	 * @since 0.7.0
	 */
	@objc lazy var borderRight = JavaScriptProperty(string: "0 #000") { value in

		guard let composite = value.composite else {
			return
		}

		let values = composite.values
		if (values.count < 2) {
			return
		}

		self.borderRightWidth.reset(values[0])
		self.borderRightColor.reset(values[1])
	}

	/**
	 * @property borderBottom
	 * @since 0.7.0
	 */
	@objc lazy var borderBottom = JavaScriptProperty(string: "0 #000") { value in

		guard let composite = value.composite else {
			return
		}

		let values = composite.values
		if (values.count < 2) {
			return
		}

		self.borderBottomWidth.reset(values[0])
		self.borderBottomColor.reset(values[1])
	}

	/**
	 * @property borderWidth
	 * @since 0.7.0
	 */
	@objc lazy var borderWidth = JavaScriptProperty(number: 0) { value in
		self.borderTopWidth.reset(value)
		self.borderLeftWidth.reset(value)
		self.borderRightWidth.reset(value)
		self.borderBottomWidth.reset(value)
	}

	/**
	 * @property borderColor
	 * @since 0.7.0
	 */
	@objc lazy var borderColor = JavaScriptProperty(string: "#000") { value in
		self.borderTopColor.reset(value)
		self.borderLeftColor.reset(value)
		self.borderRightColor.reset(value)
		self.borderBottomColor.reset(value)
	}

	/**
	 * @property borderTopColor
	 * @since 0.7.0
	 */
	@objc lazy var borderTopColor = JavaScriptProperty(string: "#000") { value in
		self.wrapper.borderTopColor = UIColor(color: value)
	}

	/**
	 * @property borderLeftColor
	 * @since 0.7.0
	 */
	@objc lazy var borderLeftColor = JavaScriptProperty(string: "#000") { value in
		self.wrapper.borderLeftColor = UIColor(color: value)
	}

	/**
	 * @property borderRightColor
	 * @since 0.7.0
	 */
	@objc lazy var borderRightColor = JavaScriptProperty(string: "#000") { value in
		self.wrapper.borderRightColor = UIColor(color: value)
	}

	/**
	 * @property borderBottomColor
	 * @since 0.7.0
	 */
	@objc lazy var borderBottomColor = JavaScriptProperty(string: "#000") { value in
		self.wrapper.borderBottomColor = UIColor(color: value)
	}

	/**
	 * @property borderTopWidth
	 * @since 0.7.0
	 */
	@objc lazy var borderTopWidth = JavaScriptProperty(number: 0) { value in
		self.node.setBorderTop(value)
	}

	/**
	 * @property borderLeftWidth
	 * @since 0.7.0
	 */
	@objc lazy var borderLeftWidth = JavaScriptProperty(number: 0) { value in
		self.node.setBorderLeft(value)
	}

	/**
	 * @property borderRightWidth
	 * @since 0.7.0
	 */
	@objc lazy var borderRightWidth = JavaScriptProperty(number: 0) { value in
		self.node.setBorderRight(value)
	}

	/**
	 * @property borderBottomWidth
	 * @since 0.7.0
	 */
	@objc lazy var borderBottomWidth = JavaScriptProperty(number: 0) { value in
		self.node.setBorderBottom(value)
	}

	/**
	 * @property minBorderTopWidth
	 * @since 0.7.0
	 */
	@objc lazy var minBorderTopWidth = JavaScriptProperty(number: 0) { value in
		self.invalidateBorder()
	}

	/**
	 * @property maxBorderTopWidth
	 * @since 0.7.0
	 */
	@objc lazy var maxBorderTopWidth = JavaScriptProperty(number: Double.max) { value in
		self.invalidateBorder()
	}

	/**
	 * @property minBorderLeftWidth
	 * @since 0.7.0
	 */
	@objc lazy var minBorderLeftWidth = JavaScriptProperty(number: 0) { value in
		self.invalidateBorder()
	}

	/**
	 * @property maxBorderLeftWidth
	 * @since 0.7.0
	 */
	@objc lazy var maxBorderLeftWidth = JavaScriptProperty(number: Double.max) { value in
		self.invalidateBorder()
	}

	/**
	 * @property minBorderRightWidth
	 * @since 0.7.0
	 */
	@objc lazy var minBorderRightWidth = JavaScriptProperty(number: 0) { value in
		self.invalidateBorder()
	}

	/**
	 * @property maxBorderRightWidth
	 * @since 0.7.0
	 */
	@objc lazy var maxBorderRightWidth = JavaScriptProperty(number: Double.max) { value in
		self.invalidateBorder()
	}

	/**
	 * @property minBorderBottomWidth
	 * @since 0.7.0
	 */
	@objc lazy var minBorderBottomWidth = JavaScriptProperty(number: 0) { value in
		self.invalidateBorder()
	}

	/**
	 * @property maxBorderBottomWidth
	 * @since 0.7.0
	 */
	@objc lazy var maxBorderBottomWidth = JavaScriptProperty(number: Double.max) { value in
		self.invalidateBorder()
	}

	/**
	 * @property borderRadius
	 * @since 0.7.0
	 */
	@objc lazy var borderRadius = JavaScriptProperty(number: 0) { value in
		self.borderTopLeftRadius.reset(value)
		self.borderTopRightRadius.reset(value)
		self.borderBottomLeftRadius.reset(value)
		self.borderBottomRightRadius.reset(value)
	}

	/**
	 * @property borderTopLeftRadius
	 * @since 0.7.0
	 */
	@objc lazy var borderTopLeftRadius = JavaScriptProperty(number: 0) { value in
		self.invalidateBorder()
	}

	/**
	 * @property borderTopRightRadius
	 * @since 0.7.0
	 */
	@objc lazy var borderTopRightRadius = JavaScriptProperty(number: 0) { value in
		self.invalidateBorder()
	}

	/**
	 * @property borderBottomLeftRadius
	 * @since 0.7.0
	 */
	@objc lazy var borderBottomLeftRadius = JavaScriptProperty(number: 0) { value in
		self.invalidateBorder()
	}

	/**
	 * @property borderBottomRightRadius
	 * @since 0.7.0
	 */
	@objc lazy var borderBottomRightRadius = JavaScriptProperty(number: 0) { value in
		self.invalidateBorder()
	}

	/**
	 * @property shadowBlur
	 * @since 0.7.0
	 */
	@objc lazy var shadowBlur = JavaScriptProperty(number: 0) { value in
		self.invalidateShadow()
	}

	/**
	 * @property shadowColor
	 * @since 0.7.0
	 */
	@objc lazy var shadowColor = JavaScriptProperty(string: "#000") { value in
		self.invalidateShadow()
	}

	/**
	 * @property shadowOffsetTop
	 * @since 0.7.0
	 */
	@objc lazy var shadowOffsetTop = JavaScriptProperty(number: 0) { value in
		self.invalidateShadow()
	}

	/**
	 * @property shadowOffsetLeft
	 * @since 0.7.0
	 */
	@objc lazy var shadowOffsetLeft = JavaScriptProperty(number: 0) { value in
		self.invalidateShadow()
	}

	/**
	 * @property top
	 * @since 0.7.0
	 */
	@objc lazy var top = JavaScriptProperty(string: "auto") { value in
		self.node.setTop(value)
	}

	/**
	 * @property left
	 * @since 0.7.0
	 */
	@objc lazy var left = JavaScriptProperty(string: "auto") { value in
		self.node.setLeft(value)
	}

	/**
	 * @property right
	 * @since 0.7.0
	 */
	@objc lazy var right = JavaScriptProperty(string: "auto") { value in
		self.node.setRight(value)
	}

	/**
	 * @property bottom
	 * @since 0.7.0
	 */
	@objc lazy var bottom = JavaScriptProperty(string: "auto") { value in
		self.node.setBottom(value)
	}

	/**
	 * @property minTop
	 * @since 0.7.0
	 */
	@objc lazy var minTop = JavaScriptProperty(number: Double.min) { value in
		self.node.setMinTop(value.number)
	}

	/**
	 * @property maxTop
	 * @since 0.7.0
	 */
	@objc lazy var maxTop = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxTop(value.number)
	}

	/**
	 * @property minLeft
	 * @since 0.7.0
	 */
	@objc lazy var minLeft = JavaScriptProperty(number: Double.min) { value in
		self.node.setMinLeft(value.number)
	}

	/**
	 * @property maxLeft
	 * @since 0.7.0
	 */
	@objc lazy var maxLeft = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxLeft(value.number)
	}

	/**
	 * @property minRight
	 * @since 0.7.0
	 */
	@objc lazy var minRight = JavaScriptProperty(number: Double.min) { value in
		self.node.setMinRight(value.number)
	}

	/**
	 * @property maxRight
	 * @since 0.7.0
	 */
	@objc lazy var maxRight = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxRight(value.number)
	}

	/**
	 * @property minBottom
	 * @since 0.7.0
	 */
	@objc lazy var minBottom = JavaScriptProperty(number: Double.min) { value in
		self.node.setMinBottom(value.number)
	}

	/**
	 * @property maxBottom
	 * @since 0.7.0
	 */
	@objc lazy var maxBottom = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxBottom(value.number)
	}

	/**
	 * @property anchorTop
	 * @since 0.7.0
	 */
	@objc lazy var anchorTop = JavaScriptProperty(number: 0) { value in
		self.node.setAnchorTop(value)
	}

	/**
	 * @property anchorLeft
	 * @since 0.7.0
	 */
	@objc lazy var anchorLeft = JavaScriptProperty(number: 0) { value in
		self.node.setAnchorLeft(value)
	}

	/**
	 * @property width
	 * @since 0.7.0
	 */
	@objc lazy var width = JavaScriptProperty(string: "fill") { value in
		self.node.setWidth(value)
	}

	/**
	 * @property height
	 * @since 0.7.0
	 */
	@objc lazy var height = JavaScriptProperty(string: "fill") { value in
		self.node.setHeight(value)
	}

	/**
	 * @property minWidth
	 * @since 0.7.0
	 */
	@objc lazy var minWidth = JavaScriptProperty(number: 0) { value in
		self.node.setMinWidth(value.number)
	}

	/**
	 * @property maxWidth
	 * @since 0.7.0
	 */
	@objc lazy var maxWidth = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxWidth(value.number)
	}

	/**
	 * @property minHeight
	 * @since 0.7.0
	 */
	@objc lazy var minHeight = JavaScriptProperty(number: 0) { value in
		self.node.setMinHeight(value.number)
	}

	/**
	 * @property maxHeight
	 * @since 0.7.0
	 */
	@objc lazy var maxHeight = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxHeight(value.number)
	}

	/**
	 * @property expandFactor
	 * @since 0.7.0
	 */
	@objc lazy var expandFactor = JavaScriptProperty(number: 0) { value in
		self.node.setExpandFactor(value.number)
	}

	/**
	 * @property shrinkFactor
	 * @since 0.7.0
	 */
	@objc lazy var shrinkFactor = JavaScriptProperty(number: 0) { value in
		self.node.setShrinkFactor(value.number)
	}

	/**
	 * @property contentTop
	 * @since 0.7.0
	 */
	@objc lazy var contentTop = JavaScriptProperty(number: 0) { value in
		self.node.setContentTop(value)
	}

	/**
	 * @property contentLeft
	 * @since 0.7.0
	 */
	@objc lazy var contentLeft = JavaScriptProperty(number: 0) { value in
		self.node.setContentLeft(value)
	}

	/**
	 * @property contentWidth
	 * @since 0.7.0
	 */
	@objc lazy var contentWidth = JavaScriptProperty(string: "auto") { value in
		self.node.setContentWidth(value)
	}

	/**
	 * @property contentHeight
	 * @since 0.7.0
	 */
	@objc lazy var contentHeight = JavaScriptProperty(string: "auto") { value in
		self.node.setContentHeight(value)
	}

	/**
	 * @property contentInsetTop
	 * @since 0.7.0
	 */
	@objc lazy var contentInsetTop = JavaScriptProperty(number: 0) { value in
		self.scrollableView?.contentInsetTop = CGFloat(value.number)
	}

	/**
	 * @property contentInsetLeft
	 * @since 0.7.0
	 */
	@objc lazy var contentInsetLeft = JavaScriptProperty(number: 0) { value in
		self.scrollableView?.contentInsetLeft = CGFloat(value.number)
	}

	/**
	 * @property contentInsetRight
	 * @since 0.7.0
	 */
	@objc lazy var contentInsetRight = JavaScriptProperty(number: 0) { value in
		self.scrollableView?.contentInsetRight = CGFloat(value.number)
	}

	/**
	 * @property contentInsetBottom
	 * @since 0.7.0
	 */
	@objc lazy var contentInsetBottom = JavaScriptProperty(number: 0) { value in
		self.scrollableView?.contentInsetBottom = CGFloat(value.number)
	}

	/**
	 * @property contentDirection
	 * @since 0.7.0
	 */
	@objc lazy var contentDirection = JavaScriptProperty(string: "vertical") { value in
		self.node.setContentDirection(value)
	}

	/**
	 * @property contentAlignment
	 * @since 0.7.0
	 */
	@objc lazy var contentAlignment = JavaScriptProperty(string: "start") { value in
		self.node.setContentAlignment(value)
	}

	/**
	 * @property contentDisposition
	 * @since 0.7.0
	 */
	@objc lazy var contentDisposition = JavaScriptProperty(string: "start") { value in
		self.node.setContentDisposition(value)
	}

	/**
	 * @property margin
	 * @since 0.7.0
	 */
	@objc lazy var margin = JavaScriptProperty(number: 0) { value in
		self.marginTop.reset(value)
		self.marginLeft.reset(value)
		self.marginRight.reset(value)
		self.marginBottom.reset(value)
	}

	/**
	 * @property marginTop
	 * @since 0.7.0
	 */
	@objc lazy var marginTop = JavaScriptProperty(number: 0) { value in
		self.node.setMarginTop(value)
	}

	/**
	 * @property marginLeft
	 * @since 0.7.0
	 */
	@objc lazy var marginLeft = JavaScriptProperty(number: 0) { value in
		self.node.setMarginLeft(value)
	}

	/**
	 * @property marginRight
	 * @since 0.7.0
	 */
	@objc lazy var marginRight = JavaScriptProperty(number: 0) { value in
		self.node.setMarginRight(value)
	}

	/**
	 * @property marginBottom
	 * @since 0.7.0
	 */
	@objc lazy var marginBottom = JavaScriptProperty(number: 0) { value in
		self.node.setMarginBottom(value)
	}

	/**
	 * @property minMarginTop
	 * @since 0.7.0
	 */
	@objc lazy var minMarginTop = JavaScriptProperty(number: Double.min) { value in
		self.node.setMinMarginTop(value.number)
	}

	/**
	 * @property maxMarginTop
	 * @since 0.7.0
	 */
	@objc lazy var maxMarginTop = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxMarginTop(value.number)
	}

	/**
	 * @property minMarginLeft
	 * @since 0.7.0
	 */
	@objc lazy var minMarginLeft = JavaScriptProperty(number: Double.min) { value in
		self.node.setMinMarginLeft(value.number)
	}

	/**
	 * @property maxMarginLeft
	 * @since 0.7.0
	 */
	@objc lazy var maxMarginLeft = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxMarginLeft(value.number)
	}

	/**
	 * @property minMarginRight
	 * @since 0.7.0
	 */
	@objc lazy var minMarginRight = JavaScriptProperty(number: Double.min) { value in
		self.node.setMinMarginRight(value.number)
	}

	/**
	 * @property maxMarginRight
	 * @since 0.7.0
	 */
	@objc lazy var maxMarginRight = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxMarginRight(value.number)
	}

	/**
	 * @property minMarginBottom
	 * @since 0.7.0
	 */
	@objc lazy var minMarginBottom = JavaScriptProperty(number: Double.min) { value in
		self.node.setMinMarginBottom(value.number)
	}

	/**
	 * @property maxMarginBottom
	 * @since 0.7.0
	 */
	@objc lazy var maxMarginBottom = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxMarginBottom(value.number)
	}

	/**
	 * @property padding
	 * @since 0.7.0
	 */
	@objc lazy var padding = JavaScriptProperty(number: 0) { value in
		self.paddingTop.reset(value)
		self.paddingLeft.reset(value)
		self.paddingRight.reset(value)
		self.paddingBottom.reset(value)
	}

	/**
	 * @property paddingTop
	 * @since 0.7.0
	 */
	@objc lazy var paddingTop = JavaScriptProperty(number: 0) { value in
		self.node.setPaddingTop(value)
	}

	/**
	 * @property paddingLeft
	 * @since 0.7.0
	 */
	@objc lazy var paddingLeft = JavaScriptProperty(number: 0) { value in
		self.node.setPaddingLeft(value)
	}

	/**
	 * @property paddingRight
	 * @since 0.7.0
	 */
	@objc lazy var paddingRight = JavaScriptProperty(number: 0) { value in
		self.node.setPaddingRight(value)
	}

	/**
	 * @property paddingBottom
	 * @since 0.7.0
	 */
	@objc lazy var paddingBottom = JavaScriptProperty(number: 0) { value in
		self.node.setPaddingBottom(value)
	}

	/**
	 * @property minPaddingTop
	 * @since 0.7.0
	 */
	@objc lazy var minPaddingTop = JavaScriptProperty(number: 0) { value in
		self.node.setMinPaddingTop(value.number)
	}

	/**
	 * @property maxPaddingTop
	 * @since 0.7.0
	 */
	@objc lazy var maxPaddingTop = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxPaddingTop(value.number)
	}

	/**
	 * @property minPaddingLeft
	 * @since 0.7.0
	 */
	@objc lazy var minPaddingLeft = JavaScriptProperty(number: 0) { value in
		self.node.setMinPaddingLeft(value.number)
	}

	/**
	 * @property maxPaddingLeft
	 * @since 0.7.0
	 */
	@objc lazy var maxPaddingLeft = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxPaddingLeft(value.number)
	}

	/**
	 * @property minPaddingRight
	 * @since 0.7.0
	 */
	@objc lazy var minPaddingRight = JavaScriptProperty(number: 0) { value in
		self.node.setMinPaddingRight(value.number)
	}

	/**
	 * @property maxPaddingRight
	 * @since 0.7.0
	 */
	@objc lazy var maxPaddingRight = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxPaddingRight(value.number)
	}

	/**
	 * @property minPaddingBottom
	 * @since 0.7.0
	 */
	@objc lazy var minPaddingBottom = JavaScriptProperty(number: 0) { value in
		self.node.setMinPaddingBottom(value.number)
	}

	/**
	 * @property maxPaddingBottom
	 * @since 0.7.0
	 */
	@objc lazy var maxPaddingBottom = JavaScriptProperty(number: Double.max) { value in
		self.node.setMaxPaddingBottom(value.number)
	}

	/**
	 * @property originX
	 * @since 0.7.0
	 */
	@objc lazy var originX = JavaScriptProperty(number: 0.5) { value in
		self.invalidateTransform()
	}

	/**
	 * @property originY
	 * @since 0.7.0
	 */
	@objc lazy var originY = JavaScriptProperty(number: 0.5) { value in
		self.invalidateTransform()
	}

	/**
	 * @property originZ
	 * @since 0.7.0
	 */
	@objc lazy var originZ = JavaScriptProperty(number: 0) { value in
		self.invalidateTransform()
	}

	/**
	 * @property translationX
	 * @since 0.7.0
	 */
	@objc lazy var translationX = JavaScriptProperty(number: 0) { value in
		self.invalidateTransform()
	}

	/**
	 * @property translationY
	 * @since 0.7.0
	 */
	@objc lazy var translationY = JavaScriptProperty(number: 0) { value in
		self.invalidateTransform()
	}

	/**
	 * @property translationZ
	 * @since 0.7.0
	 */
	@objc lazy var translationZ = JavaScriptProperty(number: 0) { value in
		self.invalidateTransform()
	}

	/**
	 * @property rotationX
	 * @since 0.7.0
	 */
	@objc lazy var rotationX = JavaScriptProperty(number: 0) { value in
		self.invalidateTransform()
	}

	/**
	 * @property rotationY
	 * @since 0.7.0
	 */
	@objc lazy var rotationY = JavaScriptProperty(number: 0) { value in
		self.invalidateTransform()
	}

	/**
	 * @property rotationZ
	 * @since 0.7.0
	 */
	@objc lazy var rotationZ = JavaScriptProperty(number: 0) { value in
		self.invalidateTransform()
	}

	/**
	 * @property scaleX
	 * @since 0.7.0
	 */
	@objc lazy var scaleX = JavaScriptProperty(number: 1) { value in
		self.invalidateTransform()
	}

	/**
	 * @property scaleY
	 * @since 0.7.0
	 */
	@objc lazy var scaleY = JavaScriptProperty(number: 1) { value in
		self.invalidateTransform()
	}

	/**
	 * @property scaleZ
	 * @since 0.7.0
	 */
	@objc lazy var scaleZ = JavaScriptProperty(number: 1) { value in
		self.invalidateTransform()
	}

	/**
	 * @property zIndex
	 * @since 0.7.0
	 */
	@objc lazy var zIndex = JavaScriptProperty(number: 0) { value in
		self.wrapper.layer.zPosition = CGFloat(value.number)
	}

	/**
	 * @property scrollable
	 * @since 0.7.0
	 */
	@objc lazy var scrollable = JavaScriptProperty(boolean: false) { value in
		self.scrollableView?.scrollable = value.boolean
	}

	/**
	 * @property overscroll
	 * @since 0.7.0
	 */
	@objc lazy var overscroll = JavaScriptProperty(string: "auto") { value in
		self.scrollableView?.overscroll = Overscroll.get(value)
	}

	/**
	 * @property scrollbars
	 * @since 0.7.0
	 */
	@objc lazy var scrollbars = JavaScriptProperty(boolean: false) { value in
		self.scrollableView?.scrollbars = Scrollbars.get(value)
	}

	/**
	 * @property scrollTop
	 * @since 0.7.0
	 */
	@objc lazy var scrollTop = JavaScriptProperty(number: 0) { value in
		self.scrollableView?.scrollTop = CGFloat(value.number)
	}

	/**
	 * @property scrollLeft
	 * @since 0.7.0
	 */
	@objc lazy var scrollLeft = JavaScriptProperty(number: 0) { value in
		self.scrollableView?.scrollLeft = CGFloat(value.number)
	}

	/**
	 * @property scrollInertia
	 * @since 0.7.0
	 */
	@objc lazy var scrollInertia = JavaScriptProperty(boolean: true) { value in
		self.scrollableView?.scrollInertia = value.boolean
	}

	/**
	 * @property scrolling
	 * @since 0.7.0
	 */
	@objc lazy var scrolling = JavaScriptProperty(boolean: false)

	/**
	 * @property dragging
	 * @since 0.7.0
	 */
	@objc lazy var dragging = JavaScriptProperty(boolean: false)

	/**
	 * @property paged
	 * @since 0.7.0
	 */
	@objc lazy var paged = JavaScriptProperty(boolean: false) { value in
		self.scrollableView?.paged = value.boolean
	}

	/**
	 * @property zoomable
	 * @since 0.7.0
	 */
	@objc lazy var zoomable = JavaScriptProperty(boolean: false) { value in
		self.scrollableView?.zoomable = value.boolean
	}

	/**
	 * @property minZoom
	 * @since 0.7.0
	 */
	@objc lazy var minZoom = JavaScriptProperty(number: 1.0) { value in
		self.scrollableView?.minZoom = CGFloat(value.number)
	}

	/**
	 * @property maxZoom
	 * @since 0.7.0
	 */
	@objc lazy var maxZoom = JavaScriptProperty(number: 1.0) { value in
		self.scrollableView?.maxZoom = CGFloat(value.number)
	}

	/**
	 * @property touchable
	 * @since 0.7.0
	 */
	@objc lazy var touchable = JavaScriptProperty(boolean: true) { value in
		self.wrapper.isUserInteractionEnabled = value.boolean
	}

	/**
	 * @property touchOffsetTop
	 * @since 0.7.0
	 */
	@objc lazy var touchOffsetTop = JavaScriptProperty(number: 0.0)

	/**
	 * @property touchOffsetLeft
	 * @since 0.7.0
	 */
	@objc lazy var touchOffsetLeft = JavaScriptProperty(number: 0.0)

	/**
	 * @property touchOffsetRight
	 * @since 0.7.0
	 */
	@objc lazy var touchOffsetRight = JavaScriptProperty(number: 0.0)

	/**
	 * @property touchOffsetBottom
	 * @since 0.7.0
	 */
	@objc lazy var touchOffsetBottom = JavaScriptProperty(number: 0.0)

	/**
	 * @property clipped
	 * @since 0.7.0
	 */
	@objc lazy var clipped = JavaScriptProperty(boolean: true) { value in
		self.content.clipped = value.boolean
	}

	/**
	 * @property visible
	 * @since 0.7.0
	 */
	@objc lazy var visible = JavaScriptProperty(boolean: true) { value in
		self.node.setVisible(value.boolean)
		self.wrapper.visible = value.boolean
		self.content.visible = value.boolean
	}

	/**
	 * @property opacity
	 * @since 0.7.0
	 * @hidden
	 */
	@objc lazy var opacity = JavaScriptProperty(number: 1) { value in
		self.wrapper.opacity = CGFloat(value.number)
	}

	/**
	 * @property drawable
	 * @since 0.7.0
	 */
	@objc lazy var drawable = JavaScriptProperty(boolean: false) { value in
		self.wrapper.drawable = value.boolean
	}

	/**
	 * @property measuredTop
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredTop = JavaScriptProperty(lock: self)

	/**
	 * @property measuredLeft
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredLeft = JavaScriptProperty(lock: self)

	/**
	 * @property measuredWidth
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredWidth = JavaScriptProperty(lock: self)

	/**
	 * @property measuredHeight
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredHeight = JavaScriptProperty(lock: self)

	/**
	 * @property measuredInnerWidth
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredInnerWidth = JavaScriptProperty(lock: self)

	/**
	 * @property measuredInnerHeight
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredInnerHeight = JavaScriptProperty(lock: self)

	/**
	 * @property measuredContentWidth
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredContentWidth = JavaScriptProperty(lock: self)

	/**
	 * @property measuredContentHeight
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredContentHeight = JavaScriptProperty(lock: self)

	/**
	 * @property measuredMarginTop
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredMarginTop = JavaScriptProperty(lock: self)

	/**
	 * @property measuredMarginLeft
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredMarginLeft = JavaScriptProperty(lock: self)

	/**
	 * @property measuredMarginRight
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredMarginRight = JavaScriptProperty(lock: self)

	/**
	 * @property measuredMarginBottom
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredMarginBottom = JavaScriptProperty(lock: self)

	/**
	 * @property measuredBorderTopWidth
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredBorderTopWidth = JavaScriptProperty(lock: self)

	/**
	 * @property measuredBorderLeftWidth
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredBorderLeftWidth = JavaScriptProperty(lock: self)

	/**
	 * @property measuredBorderRightWidth
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredBorderRightWidth = JavaScriptProperty(lock: self)

	/**
	 * @property measuredBorderBottomWidth
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredBorderBottomWidth = JavaScriptProperty(lock: self)

	/**
	 * @property measuredPaddingTop
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredPaddingTop = JavaScriptProperty(lock: self)

	/**
	 * @property measuredPaddingLeft
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredPaddingLeft = JavaScriptProperty(lock: self)

	/**
	 * @property measuredPaddingRight
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredPaddingRight = JavaScriptProperty(lock: self)

	/**
	 * @property measuredPaddingBottom
	 * @since 0.7.0
	 */
	private(set) public lazy var measuredPaddingBottom = JavaScriptProperty(lock: self)

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_id
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_id(callback: JavaScriptGetterCallback) {
		callback.returns(self.id)
	}

	/**
	 * @method jsSet_id
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_id(callback: JavaScriptSetterCallback) {
		self.id.reset(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_className
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_className(callback: JavaScriptGetterCallback) {
		callback.returns(self.className)
	}

	/**
	 * @method jsSet_id
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_className(callback: JavaScriptSetterCallback) {
		self.className.reset(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_window
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_window(callback: JavaScriptGetterCallback) {
		callback.returns(self.window)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_parent
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_parent(callback: JavaScriptGetterCallback) {
		callback.returns(self.parent)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_backgroundColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.backgroundColor)
	}

	/**
	 * @method jsSet_backgroundColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_backgroundColor(callback: JavaScriptSetterCallback) {
		self.backgroundColor.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundImage
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_backgroundImage(callback: JavaScriptGetterCallback) {
		callback.returns(self.backgroundImage)
	}

	/**
	 * @method jsSet_backgroundImage
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_backgroundImage(callback: JavaScriptSetterCallback) {
		self.backgroundImage.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundImageFit
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_backgroundImageFit(callback: JavaScriptGetterCallback) {
		callback.returns(self.backgroundImageFit)
	}

	/**
	 * @method jsSet_backgroundImageFit
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_backgroundImageFit(callback: JavaScriptSetterCallback) {
		self.backgroundImageFit.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_backgroundImagePosition
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_backgroundImagePosition(callback: JavaScriptGetterCallback) {
		callback.returns(self.backgroundImagePosition)
	}

	/**
	 * @method jsSet_backgroundImagePosition
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_backgroundImagePosition(callback: JavaScriptSetterCallback) {
		self.backgroundImagePosition.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_border
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_border(callback: JavaScriptGetterCallback) {

		let width = self.context.createEmptyObject()
		let color = self.context.createEmptyObject()
		let value = self.context.createEmptyObject()

		width.property("top", property: self.borderTopWidth)
		width.property("left", property: self.borderLeftWidth)
		width.property("right", property: self.borderRightWidth)
		width.property("bottom", property: self.borderBottomWidth)

		color.property("top", property: self.borderTopColor)
		color.property("left", property: self.borderLeftColor)
		color.property("right", property: self.borderRightColor)
		color.property("bottom", property: self.borderBottomColor)

		value.property("width", value: width)
		value.property("color", value: color)

		callback.returns(value)
	}

	/**
	 * @method jsSet_border
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_border(callback: JavaScriptSetterCallback) {
		self.border.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_borderTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderTop)
	}

	/**
	 * @method jsSet_borderTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_borderTop(callback: JavaScriptSetterCallback) {
		self.borderTop.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_borderLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderLeft)
	}

	/**
	 * @method jsSet_borderLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_borderLeft(callback: JavaScriptSetterCallback) {
		self.borderLeft.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_borderRight(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderRight)
	}

	/**
	 * @method jsSet_borderRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_borderRight(callback: JavaScriptSetterCallback) {
		self.borderRight.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_borderBottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderBottom)
	}

	/**
	 * @method jsSet_borderBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_borderBottom(callback: JavaScriptSetterCallback) {
		self.borderBottom.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_borderWidth(callback: JavaScriptGetterCallback) {

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
	@objc func jsSet_borderWidth(callback: JavaScriptSetterCallback) {
		self.borderWidth.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_borderColor(callback: JavaScriptGetterCallback) {

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
	@objc func jsSet_borderColor(callback: JavaScriptSetterCallback) {
		self.borderWidth.reset(callback.value, lock: self, parse: true)
	}

	//-------------------------------------------------------------------------

	/**
	 * @method jsGet_borderTopColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_borderTopColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderTopColor)
	}

	/**
	 * @method jsSet_borderTopColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_borderTopColor(callback: JavaScriptSetterCallback) {
		self.borderTopColor.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderLeftColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_borderLeftColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderLeftColor)
	}

	/**
	 * @method jsSet_borderLeftColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_borderLeftColor(callback: JavaScriptSetterCallback) {
		self.borderLeftColor.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderRightColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_borderRightColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderRightColor)
	}

	/**
	 * @method jsSet_borderRightColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_borderRightColor(callback: JavaScriptSetterCallback) {
		self.borderRightColor.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderBottomColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_borderBottomColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderBottomColor)
	}

	/**
	 * @method jsSet_borderBottomColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_borderBottomColor(callback: JavaScriptSetterCallback) {
		self.borderBottomColor.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderTopWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_borderTopWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderTopWidth)
	}

	/**
	 * @method jsSet_borderTopWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_borderTopWidth(callback: JavaScriptSetterCallback) {
		self.borderTopWidth.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderLeftWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_borderLeftWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderLeftWidth)
	}

	/**
	 * @method jsSet_borderLeftWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_borderLeftWidth(callback: JavaScriptSetterCallback) {
		self.borderLeftWidth.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderRightWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_borderRightWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderRightWidth)
	}

	/**
	 * @method jsSet_borderRightWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_borderRightWidth(callback: JavaScriptSetterCallback) {
		self.borderRightWidth.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderBottomWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_borderBottomWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderBottomWidth)
	}

	/**
	 * @method jsSet_borderBottomWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_borderBottomWidth(callback: JavaScriptSetterCallback) {
		self.borderBottomWidth.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minBorderTopWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_minBorderTopWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.minBorderTopWidth)
	}

	/**
	 * @method jsSet_minBorderTopWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_minBorderTopWidth(callback: JavaScriptSetterCallback) {
		self.minBorderTopWidth.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxBorderTopWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_maxBorderTopWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxBorderTopWidth)
	}

	/**
	 * @method jsSet_maxBorderTopWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_maxBorderTopWidth(callback: JavaScriptSetterCallback) {
		self.maxBorderTopWidth.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minBorderLeftWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_minBorderLeftWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.minBorderLeftWidth)
	}

	/**
	 * @method jsSet_minBorderLeftWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_minBorderLeftWidth(callback: JavaScriptSetterCallback) {
		self.minBorderLeftWidth.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxBorderLeftWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_maxBorderLeftWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxBorderLeftWidth)
	}

	/**
	 * @method jsSet_maxBorderLeftWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_maxBorderLeftWidth(callback: JavaScriptSetterCallback) {
		self.maxBorderLeftWidth.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minBorderRightWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_minBorderRightWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.minBorderRightWidth)
	}

	/**
	 * @method jsSet_minBorderRightWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_minBorderRightWidth(callback: JavaScriptSetterCallback) {
		self.minBorderRightWidth.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxBorderRightWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_maxBorderRightWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxBorderRightWidth)
	}

	/**
	 * @method jsSet_maxBorderRightWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_maxBorderRightWidth(callback: JavaScriptSetterCallback) {
		self.maxBorderRightWidth.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minBorderBottomWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_minBorderBottomWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.minBorderBottomWidth)
	}

	/**
	 * @method jsSet_minBorderBottomWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_minBorderBottomWidth(callback: JavaScriptSetterCallback) {
		self.minBorderBottomWidth.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxBorderBottomWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_maxBorderBottomWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxBorderBottomWidth)
	}

	/**
	 * @method jsSet_maxBorderBottomWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_maxBorderBottomWidth(callback: JavaScriptSetterCallback) {
		self.maxBorderBottomWidth.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_borderRadius(callback: JavaScriptGetterCallback) {

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
	@objc func jsSet_borderRadius(callback: JavaScriptSetterCallback) {
		self.borderRadius.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderTopLeftRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_borderTopLeftRadius(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderTopLeftRadius)
	}

	/**
	 * @method jsSet_borderTopLeftRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_borderTopLeftRadius(callback: JavaScriptSetterCallback) {
		self.borderTopLeftRadius.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderTopRightRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_borderTopRightRadius(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderTopRightRadius)
	}

	/**
	 * @method jsSet_borderTopRightRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_borderTopRightRadius(callback: JavaScriptSetterCallback) {
		self.borderTopRightRadius.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderBottomLeftRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_borderBottomLeftRadius(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderBottomLeftRadius)
	}

	/**
	 * @method jsSet_borderBottomLeftRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_borderBottomLeftRadius(callback: JavaScriptSetterCallback) {
		self.borderBottomLeftRadius.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_borderBottomRightRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_borderBottomRightRadius(callback: JavaScriptGetterCallback) {
		callback.returns(self.borderBottomRightRadius)
	}

	/**
	 * @method jsSet_borderBottomRightRadius
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_borderBottomRightRadius(callback: JavaScriptSetterCallback) {
		self.borderBottomRightRadius.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shadowBlur
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_shadowBlur(callback: JavaScriptGetterCallback) {
		callback.returns(self.shadowBlur)
	}

	/**
	 * @method jsSet_shadowBlur
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_shadowBlur(callback: JavaScriptSetterCallback) {
		self.shadowBlur.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shadowColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_shadowColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.shadowColor)
	}

	/**
	 * @method jsSet_shadowColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_shadowColor(callback: JavaScriptSetterCallback) {
		self.shadowColor.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shadowOffsetTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_shadowOffsetTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.shadowOffsetTop)
	}

	/**
	 * @method jsSet_shadowOffsetTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_shadowOffsetTop(callback: JavaScriptSetterCallback) {
		self.shadowOffsetTop.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shadowOffsetLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_shadowOffsetLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.shadowOffsetLeft)
	}

	/**
	 * @method jsSet_shadowOffsetLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_shadowOffsetLeft(callback: JavaScriptSetterCallback) {
		self.shadowOffsetLeft.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_top
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_top(callback: JavaScriptGetterCallback) {
		callback.returns(self.top)
	}

	/**
	 * @method jsSet_top
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_top(callback: JavaScriptSetterCallback) {
		self.top.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_left
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_left(callback: JavaScriptGetterCallback) {
		callback.returns(self.left)
	}

	/**
	 * @method jsSet_left
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_left(callback: JavaScriptSetterCallback) {
		self.left.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_right
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_right(callback: JavaScriptGetterCallback) {
		callback.returns(self.right)
	}

	/**
	 * @method jsSet_right
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_right(callback: JavaScriptSetterCallback) {
		self.right.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_bottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_bottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.bottom)
	}

	/**
	 * @method jsSet_bottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_bottom(callback: JavaScriptSetterCallback) {
		self.bottom.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_minTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.minTop)
	}

	/**
	 * @method jsSet_minTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_minTop(callback: JavaScriptSetterCallback) {
		self.minTop.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_maxTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxTop)
	}

	/**
	 * @method jsSet_maxTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_maxTop(callback: JavaScriptSetterCallback) {
		self.maxTop.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_minLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.minLeft)
	}

	/**
	 * @method jsSet_minLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_minLeft(callback: JavaScriptSetterCallback) {
		self.minLeft.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_maxLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxLeft)
	}

	/**
	 * @method jsSet_maxLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_maxLeft(callback: JavaScriptSetterCallback) {
		self.maxLeft.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_minRight(callback: JavaScriptGetterCallback) {
		callback.returns(self.minRight)
	}

	/**
	 * @method jsSet_minRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_minRight(callback: JavaScriptSetterCallback) {
		self.minRight.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_maxRight(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxRight)
	}

	/**
	 * @method jsSet_maxRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_maxRight(callback: JavaScriptSetterCallback) {
		self.maxRight.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_minBottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.minBottom)
	}

	/**
	 * @method jsSet_minBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_minBottom(callback: JavaScriptSetterCallback) {
		self.minBottom.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_maxBottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxBottom)
	}

	/**
	 * @method jsSet_maxBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_maxBottom(callback: JavaScriptSetterCallback) {
		self.maxBottom.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_anchorTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_anchorTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.anchorTop)
	}

	/**
	 * @method jsSet_anchorTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_anchorTop(callback: JavaScriptSetterCallback) {
		self.anchorTop.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_anchorLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_anchorLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.anchorLeft)
	}

	/**
	 * @method jsSet_anchorLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_anchorLeft(callback: JavaScriptSetterCallback) {
		self.anchorLeft.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_width
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_width(callback: JavaScriptGetterCallback) {
		callback.returns(self.width)
	}

	/**
	 * @method jsSet_width
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_width(callback: JavaScriptSetterCallback) {
		self.width.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_height
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_height(callback: JavaScriptGetterCallback) {
		callback.returns(self.height)
	}

	/**
	 * @method jsSet_height
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_height(callback: JavaScriptSetterCallback) {
		self.height.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_minWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.minWidth)
	}

	/**
	 * @method jsSet_minWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_minWidth(callback: JavaScriptSetterCallback) {
		self.minWidth.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_maxWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxWidth)
	}

	/**
	 * @method jsSet_maxWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_maxWidth(callback: JavaScriptSetterCallback) {
		self.maxWidth.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_minHeight(callback: JavaScriptGetterCallback) {
		callback.returns(self.minHeight)
	}

	/**
	 * @method jsSet_minHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_minHeight(callback: JavaScriptSetterCallback) {
		self.minHeight.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_maxHeight(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxHeight)
	}

	/**
	 * @method jsSet_maxHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_maxHeight(callback: JavaScriptSetterCallback) {
		self.maxHeight.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_expandFactor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_expandFactor(callback: JavaScriptGetterCallback) {
		callback.returns(self.expandFactor)
	}

	/**
	 * @method jsSet_expandFactor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_expandFactor(callback: JavaScriptSetterCallback) {
		self.expandFactor.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_shrinkFactor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_shrinkFactor(callback: JavaScriptGetterCallback) {
		callback.returns(self.shrinkFactor)
	}

	/**
	 * @method shrinkFactor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_shrinkFactor(callback: JavaScriptSetterCallback) {
		self.shrinkFactor.reset(callback.value, lock: self)
	}
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_contentTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.contentTop)
	}

	/**
	 * @method jsSet_contentTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_contentTop(callback: JavaScriptSetterCallback) {
		self.contentTop.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_contentLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.contentLeft)
	}

	/**
	 * @method jsSet_contentLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_contentLeft(callback: JavaScriptSetterCallback) {
		self.contentLeft.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_contentWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.contentWidth)
	}

	/**
	 * @method jsSet_contentWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_contentWidth(callback: JavaScriptSetterCallback) {
		self.contentWidth.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_contentHeight(callback: JavaScriptGetterCallback) {
		callback.returns(self.contentHeight)
	}

	/**
	 * @method jsSet_contentHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_contentHeight(callback: JavaScriptSetterCallback) {
		self.contentHeight.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentInsetTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_contentInsetTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.contentInsetTop)
	}

	/**
	 * @method jsSet_contentInsetTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_contentInsetTop(callback: JavaScriptSetterCallback) {
		self.contentInsetTop.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentInsetLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_contentInsetLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.contentInsetLeft)
	}

	/**
	 * @method jsSet_contentInsetLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_contentInsetLeft(callback: JavaScriptSetterCallback) {
		self.contentInsetLeft.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentInsetRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_contentInsetRight(callback: JavaScriptGetterCallback) {
		callback.returns(self.contentInsetRight)
	}

	/**
	 * @method jsSet_contentInsetRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_contentInsetRight(callback: JavaScriptSetterCallback) {
		self.contentInsetRight.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentInsetBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_contentInsetBottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.contentInsetBottom)
	}

	/**
	 * @method jsSet_contentInsetBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_contentInsetBottom(callback: JavaScriptSetterCallback) {
		self.contentInsetBottom.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentDirection
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_contentDirection(callback: JavaScriptGetterCallback) {
		callback.returns(self.contentDirection)
	}

	/**
	 * @method jsSet_contentDirection
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_contentDirection(callback: JavaScriptSetterCallback) {
		self.contentDirection.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentAlignment
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_contentAlignment(callback: JavaScriptGetterCallback) {
		callback.returns(self.contentAlignment)
	}

	/**
	 * @method jsSet_contentAlignment
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_contentAlignment(callback: JavaScriptSetterCallback) {
		self.contentAlignment.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_contentDisposition
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_contentDisposition(callback: JavaScriptGetterCallback) {
		callback.returns(self.contentDisposition)
	}

	/**
	 * @method jsSet_contentDisposition
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_contentDisposition(callback: JavaScriptSetterCallback) {
		self.contentDisposition.reset(callback.value, lock: self)
	}

	/**
	 * @method jsGet_margin
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_margin(callback: JavaScriptGetterCallback) {

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
	@objc func jsSet_margin(callback: JavaScriptSetterCallback) {
		self.margin.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_marginTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_marginTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.marginTop)
	}

	/**
	 * @method jsSet_marginTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_marginTop(callback: JavaScriptSetterCallback) {
		self.marginTop.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_marginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_marginLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.marginLeft)
	}

	/**
	 * @method jsSet_marginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_marginLeft(callback: JavaScriptSetterCallback) {
		self.marginLeft.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_marginRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_marginRight(callback: JavaScriptGetterCallback) {
		callback.returns(self.marginRight)
	}

	/**
	 * @method jsSet_marginRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_marginRight(callback: JavaScriptSetterCallback) {
		self.marginRight.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_marginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_marginBottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.marginBottom)
	}

	/**
	 * @method jsSet_marginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_marginBottom(callback: JavaScriptSetterCallback) {
		self.marginBottom.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minMarginTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_minMarginTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.minMarginTop)
	}

	/**
	 * @method jsSet_minMarginTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_minMarginTop(callback: JavaScriptSetterCallback) {
		self.minMarginTop.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxMarginTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_maxMarginTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxMarginTop)
	}

	/**
	 * @method jsSet_maxMarginTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_maxMarginTop(callback: JavaScriptSetterCallback) {
		self.maxMarginTop.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minMarginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_minMarginLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.minMarginLeft)
	}

	/**
	 * @method jsSet_minMarginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_minMarginLeft(callback: JavaScriptSetterCallback) {
		self.minMarginLeft.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxMarginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_maxMarginLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxMarginLeft)
	}

	/**
	 * @method jsSet_maxMarginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_maxMarginLeft(callback: JavaScriptSetterCallback) {
		self.maxMarginLeft.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minMarginRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_minMarginRight(callback: JavaScriptGetterCallback) {
		callback.returns(self.minMarginRight)
	}

	/**
	 * @method jsSet_minMarginRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_minMarginRight(callback: JavaScriptSetterCallback) {
		self.minMarginRight.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxMarginRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_maxMarginRight(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxMarginRight)
	}

	/**
	 * @method jsSet_maxMarginRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_maxMarginRight(callback: JavaScriptSetterCallback) {
		self.maxMarginRight.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minMarginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_minMarginBottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.minMarginBottom)
	}

	/**
	 * @method jsSet_minMarginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_minMarginBottom(callback: JavaScriptSetterCallback) {
		self.minMarginBottom.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxMarginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_maxMarginBottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxMarginBottom)
	}

	/**
	 * @method jsSet_maxMarginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_maxMarginBottom(callback: JavaScriptSetterCallback) {
		self.maxMarginBottom.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_padding
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_padding(callback: JavaScriptGetterCallback) {

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
	@objc func jsSet_padding(callback: JavaScriptSetterCallback) {
		self.padding.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_paddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_paddingTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.paddingTop)
	}

	/**
	 * @method jsSet_paddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_paddingTop(callback: JavaScriptSetterCallback) {
		self.paddingTop.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_paddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_paddingLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.paddingLeft)
	}

	/**
	 * @method jsSet_paddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_paddingLeft(callback: JavaScriptSetterCallback) {
		self.paddingLeft.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_paddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_paddingRight(callback: JavaScriptGetterCallback) {
		callback.returns(self.paddingRight)
	}

	/**
	 * @method jsSet_paddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_paddingRight(callback: JavaScriptSetterCallback) {
		self.paddingRight.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_paddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_paddingBottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.paddingBottom)
	}

	/**
	 * @method jsSet_paddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_paddingBottom(callback: JavaScriptSetterCallback) {
		self.paddingBottom.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minPaddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_minPaddingTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.minPaddingTop)
	}

	/**
	 * @method jsSet_minPaddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_minPaddingTop(callback: JavaScriptSetterCallback) {
		self.minPaddingTop.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxPaddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_maxPaddingTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxPaddingTop)
	}

	/**
	 * @method jsSet_maxPaddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_maxPaddingTop(callback: JavaScriptSetterCallback) {
		self.maxPaddingTop.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minPaddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_minPaddingLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.minPaddingLeft)
	}

	/**
	 * @method jsSet_minPaddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_minPaddingLeft(callback: JavaScriptSetterCallback) {
		self.minPaddingLeft.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxPaddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_maxPaddingLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxPaddingLeft)
	}

	/**
	 * @method jsSet_maxPaddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_maxPaddingLeft(callback: JavaScriptSetterCallback) {
		self.maxPaddingLeft.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minPaddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_minPaddingRight(callback: JavaScriptGetterCallback) {
		callback.returns(self.minPaddingRight)
	}

	/**
	 * @method jsSet_minPaddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_minPaddingRight(callback: JavaScriptSetterCallback) {
		self.minPaddingRight.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxPaddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_maxPaddingRight(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxPaddingRight)
	}

	/**
	 * @method jsSet_maxPaddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_maxPaddingRight(callback: JavaScriptSetterCallback) {
		self.maxPaddingRight.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minPaddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_minPaddingBottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.minPaddingBottom)
	}

	/**
	 * @method jsSet_minPaddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_minPaddingBottom(callback: JavaScriptSetterCallback) {
		self.minPaddingBottom.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxPaddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_maxPaddingBottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxPaddingBottom)
	}

	/**
	 * @method jsSet_maxPaddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_maxPaddingBottom(callback: JavaScriptSetterCallback) {
		self.maxPaddingBottom.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_visible
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_visible(callback: JavaScriptGetterCallback) {
		callback.returns(self.visible)
	}

	/**
	 * @method jsSet_visible
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_visible(callback: JavaScriptSetterCallback) {
		self.visible.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_opacity
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_opacity(callback: JavaScriptGetterCallback) {
		callback.returns(self.opacity)
	}

	/**
	 * @method jsSet_opacity
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_opacity(callback: JavaScriptSetterCallback) {
		self.opacity.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_originX
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_originX(callback: JavaScriptGetterCallback) {
		callback.returns(self.originX)
	}

	/**
	 * @method jsSet_originX
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_originX(callback: JavaScriptSetterCallback) {
		self.originX.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_originY
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_originY(callback: JavaScriptGetterCallback) {
		callback.returns(self.originY)
	}

	/**
	 * @method jsSet_originY
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_originY(callback: JavaScriptSetterCallback) {
		self.originY.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_originZ
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_originZ(callback: JavaScriptGetterCallback) {
		callback.returns(self.originZ)
	}

	/**
	 * @method jsSet_originZ
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_originZ(callback: JavaScriptSetterCallback) {
		self.originZ.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_translationX
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_translationX(callback: JavaScriptGetterCallback) {
		callback.returns(self.translationX)
	}

	/**
	 * @method jsSet_translationX
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_translationX(callback: JavaScriptSetterCallback) {
		self.translationX.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_translationY
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_translationY(callback: JavaScriptGetterCallback) {
		callback.returns(self.translationY)
	}

	/**
	 * @method jsSet_translationY
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_translationY(callback: JavaScriptSetterCallback) {
		self.translationY.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_translationZ
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_translationZ(callback: JavaScriptGetterCallback) {
		callback.returns(self.translationZ)
	}

	/**
	 * @method jsSet_translationZ
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_translationZ(callback: JavaScriptSetterCallback) {
		self.translationZ.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_rotationX
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_rotationX(callback: JavaScriptGetterCallback) {
		callback.returns(self.rotationX)
	}

	/**
	 * @method jsSet_rotationX
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_rotationX(callback: JavaScriptSetterCallback) {
		self.rotationX.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_rotationY
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_rotationY(callback: JavaScriptGetterCallback) {
		callback.returns(self.rotationY)
	}

	/**
	 * @method jsSet_rotationY
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_rotationY(callback: JavaScriptSetterCallback) {
		self.rotationY.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_rotationZ
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_rotationZ(callback: JavaScriptGetterCallback) {
		callback.returns(self.rotationZ)
	}

	/**
	 * @method jsSet_rotationZ
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_rotationZ(callback: JavaScriptSetterCallback) {
		self.rotationZ.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scaleX
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_scaleX(callback: JavaScriptGetterCallback) {
		callback.returns(self.scaleX)
	}

	/**
	 * @method jsSet_scaleX
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_scaleX(callback: JavaScriptSetterCallback) {
		self.scaleX.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scaleY
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_scaleY(callback: JavaScriptGetterCallback) {
		callback.returns(self.scaleY)
	}

	/**
	 * @method jsSet_scaleY
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_scaleY(callback: JavaScriptSetterCallback) {
		self.scaleY.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scaleZ
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_scaleZ(callback: JavaScriptGetterCallback) {
		callback.returns(self.scaleZ)
	}

	/**
	 * @method jsSet_scaleZ
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_scaleZ(callback: JavaScriptSetterCallback) {
		self.scaleZ.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_zIndex
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_zIndex(callback: JavaScriptGetterCallback) {
		callback.returns(self.zIndex)
	}

	/**
	 * @method jsSet_zIndex
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_zIndex(callback: JavaScriptSetterCallback) {
		self.zIndex.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scrollable
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_scrollable(callback: JavaScriptGetterCallback) {
		callback.returns(self.scrollable)
	}

	/**
	 * @method jsSet_scrollable
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_scrollable(callback: JavaScriptSetterCallback) {
		self.scrollable.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_overscroll
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_overscroll(callback: JavaScriptGetterCallback) {
		callback.returns(self.overscroll)
	}

	/**
	 * @method jsSet_overscroll
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_overscroll(callback: JavaScriptSetterCallback) {
		self.overscroll.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scrollbars
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_scrollbars(callback: JavaScriptGetterCallback) {
		callback.returns(self.scrollbars)
	}

	/**
	 * @method jsSet_scrollbars
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_scrollbars(callback: JavaScriptSetterCallback) {
		self.scrollbars.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scrollTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_scrollTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.scrollTop)
	}

	/**
	 * @method jsSet_scrollTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_scrollTop(callback: JavaScriptSetterCallback) {
		self.scrollTop.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scrollLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_scrollLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.scrollLeft)
	}

	/**
	 * @method jsSet_scrollLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_scrollLeft(callback: JavaScriptSetterCallback) {
		self.scrollTop.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
     * @method jsGet_scrollInertia
     * @since 0.7.0
     * @hidden
     */
	@objc func jsGet_scrollInertia(callback: JavaScriptGetterCallback) {
		callback.returns(self.scrollInertia)
	}

	/**
     * @method jsSet_scrollInertia
     * @since 0.7.0
     * @hidden
     */
	@objc func jsSet_scrollInertia(callback: JavaScriptSetterCallback) {
		self.scrollInertia.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_scrolling
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_scrolling(callback: JavaScriptGetterCallback) {
		callback.returns(self.scrolling)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_dragging
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_dragging(callback: JavaScriptGetterCallback) {
		callback.returns(self.dragging)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_paged
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_paged(callback: JavaScriptGetterCallback) {
		callback.returns(self.paged)
	}

	/**
	 * @method jsSet_paged
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_paged(callback: JavaScriptSetterCallback) {
		self.paged.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_clipped
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_clipped(callback: JavaScriptGetterCallback) {
		callback.returns(self.clipped)
	}

	/**
	 * @method jsSet_clipped
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_clipped(callback: JavaScriptSetterCallback) {
		self.clipped.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_zoomable
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_zoomable(callback: JavaScriptGetterCallback) {
		callback.returns(self.zoomable)
	}

	/**
	 * @method jsSet_zoomable
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_zoomable(callback: JavaScriptSetterCallback) {
		self.zoomable.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minZoom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_minZoom(callback: JavaScriptGetterCallback) {
		callback.returns(self.minZoom)
	}

	/**
	 * @method jsSet_minZoom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_minZoom(callback: JavaScriptSetterCallback) {
		self.minZoom.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxZoom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_maxZoom(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxZoom)
	}

	/**
	 * @method jsSet_maxZoom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_maxZoom(callback: JavaScriptSetterCallback) {
		self.maxZoom.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_zoomedView
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_zoomedView(callback: JavaScriptGetterCallback) {
		callback.returns(self.zoomedView)
	}

	/**
	 * @method jsSet_zoomedView
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_zoomedView(callback: JavaScriptSetterCallback) {
		self.zoomedView = callback.value.isNull ? nil : callback.value.cast(JavaScriptView.self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_drawable
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_drawable(callback: JavaScriptGetterCallback) {
		callback.returns(self.drawable)
	}

	/**
	 * @method jsSet_drawable
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_drawable(callback: JavaScriptSetterCallback) {
		self.drawable.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_touchable
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_touchable(callback: JavaScriptGetterCallback) {
		callback.returns(self.touchable)
	}

	/**
	 * @method jsSet_touchable
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_touchable(callback: JavaScriptSetterCallback) {
		self.touchable.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_touchOffsetTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_touchOffsetTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.touchOffsetTop)
	}

	/**
	 * @method jsSet_touchOffsetTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_touchOffsetTop(callback: JavaScriptSetterCallback) {
		self.touchOffsetTop.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_touchOffsetLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_touchOffsetLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.touchOffsetLeft)
	}

	/**
	 * @method jsSet_touchOffsetLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_touchOffsetLeft(callback: JavaScriptSetterCallback) {
		self.touchOffsetLeft.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_touchOffsetRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_touchOffsetRight(callback: JavaScriptGetterCallback) {
		callback.returns(self.touchOffsetRight)
	}

	/**
	 * @method jsSet_touchOffsetRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_touchOffsetRight(callback: JavaScriptSetterCallback) {
		self.touchOffsetRight.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_touchOffsetBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_touchOffsetBottom(callback: JavaScriptGetterCallback) {
		callback.returns(self.touchOffsetBottom)
	}

	/**
	 * @method jsSet_touchOffsetBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_touchOffsetBottom(callback: JavaScriptSetterCallback) {
		self.touchOffsetBottom.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_measuredTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_measuredTop(callback: JavaScriptGetterCallback) {

		let measuredTop = self.node.measuredTop

		if (self.resolvedTop != measuredTop) {
			self.resolvedTop = measuredTop
			self.measuredTop.reset(lock: self)
		}

		if (self.measuredTop.isNull) {
			self.measuredTop.reset(self.resolvedTop, lock: self)
		}

		callback.returns(self.measuredTop)
	}

	/**
	 * @method jsGet_measuredLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_measuredLeft(callback: JavaScriptGetterCallback) {

		let measuredLeft = self.node.measuredLeft

		if (self.resolvedLeft != measuredLeft) {
			self.resolvedLeft = measuredLeft
			self.measuredLeft.reset(lock: self)
		}

		if (self.measuredLeft.isNull) {
			self.measuredLeft.reset(self.resolvedLeft, lock: self)
		}

		callback.returns(self.measuredLeft)
	}

	/**
	 * @method jsGet_measuredWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_measuredWidth(callback: JavaScriptGetterCallback) {

		let measuredWidth = self.node.measuredWidth

		if (self.resolvedWidth != measuredWidth) {
			self.resolvedWidth = measuredWidth
			self.measuredWidth.reset(lock: self)
		}

		if (self.measuredWidth.isNull) {
			self.measuredWidth.reset(self.resolvedWidth, lock: self)
		}

		callback.returns(self.measuredWidth)
	}

	/**
	 * @method jsGet_measuredHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_measuredHeight(callback: JavaScriptGetterCallback) {

		let measuredHeight = self.node.measuredHeight

		if (self.resolvedHeight != measuredHeight) {
			self.resolvedHeight = measuredHeight
			self.measuredHeight.reset(lock: self)
		}

		if (self.measuredHeight.isNull) {
			self.measuredHeight.reset(self.resolvedHeight, lock: self)
		}

		callback.returns(self.measuredHeight)
	}

	/**
	 * @method jsGet_measuredInnerWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_measuredInnerWidth(callback: JavaScriptGetterCallback) {

		let measuredInnerWidth = self.node.measuredInnerWidth

		if (self.resolvedInnerWidth != measuredInnerWidth) {
			self.resolvedInnerWidth = measuredInnerWidth
			self.measuredInnerWidth.reset(lock: self)
		}

		if (self.measuredInnerWidth.isNull) {
			self.measuredInnerWidth.reset(self.resolvedInnerWidth, lock: self)
		}

		callback.returns(self.measuredInnerWidth)
	}

	/**
	 * @method jsGet_measuredInnerHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_measuredInnerHeight(callback: JavaScriptGetterCallback) {

		let measuredInnerHeight = self.node.measuredInnerHeight

		if (self.resolvedInnerHeight != measuredInnerHeight) {
			self.resolvedInnerHeight = measuredInnerHeight
			self.measuredInnerHeight.reset(lock: self)
		}

		if (self.measuredInnerHeight.isNull) {
			self.measuredInnerHeight.reset(self.resolvedInnerHeight, lock: self)
		}

		callback.returns(self.measuredInnerHeight)
	}

	/**
	 * @method jsGet_measuredContentWidth
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_measuredContentWidth(callback: JavaScriptGetterCallback) {

		let measuredContentWidth = self.node.measuredContentWidth

		if (self.resolvedContentWidth != measuredContentWidth) {
			self.resolvedContentWidth = measuredContentWidth
			self.measuredContentWidth.reset(lock: self)
		}

		if (self.measuredContentWidth.isNull) {
			self.measuredContentWidth.reset(self.resolvedContentWidth, lock: self)
		}

		callback.returns(self.measuredContentWidth)
	}

	/**
	 * @method jsGet_measuredContentHeight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_measuredContentHeight(callback: JavaScriptGetterCallback) {

		let measuredContentHeight = self.node.measuredContentHeight

		if (self.resolvedContentHeight != measuredContentHeight) {
			self.resolvedContentHeight = measuredContentHeight
			self.measuredContentHeight.reset(lock: self)
		}

		if (self.measuredContentHeight.isNull) {
			self.measuredContentHeight.reset(self.resolvedContentHeight, lock: self)
		}

		callback.returns(self.measuredContentHeight)
	}

	/**
	 * @method jsGet_measuredMarginTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_measuredMarginTop(callback: JavaScriptGetterCallback) {

		let measuredMarginTop = self.node.measuredTop

		if (self.resolvedMarginTop != measuredMarginTop) {
			self.resolvedMarginTop = measuredMarginTop
			self.measuredMarginTop.reset(lock: self)
		}

		if (self.measuredMarginTop.isNull) {
			self.measuredMarginTop.reset(self.resolvedMarginTop, lock: self)
		}

		callback.returns(self.measuredMarginTop)
	}

	/**
	 * @method jsGet_measuredMarginLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_measuredMarginLeft(callback: JavaScriptGetterCallback) {

		let measuredMarginLeft = self.node.measuredMarginLeft

		if (self.resolvedMarginLeft != measuredMarginLeft) {
			self.resolvedMarginLeft = measuredMarginLeft
			self.measuredMarginLeft.reset(lock: self)
		}

		if (self.measuredMarginLeft.isNull) {
			self.measuredMarginLeft.reset(self.resolvedMarginLeft, lock: self)
		}

		callback.returns(self.measuredMarginLeft)
	}

	/**
	 * @method jsGet_measuredMarginRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_measuredMarginRight(callback: JavaScriptGetterCallback) {

		let measuredMarginRight = self.node.measuredMarginRight

		if (self.resolvedMarginRight != measuredMarginRight) {
			self.resolvedMarginRight = measuredMarginRight
			self.measuredMarginRight.reset(lock: self)
		}

		if (self.measuredMarginRight.isNull) {
			self.measuredMarginRight.reset(self.resolvedMarginRight, lock: self)
		}

		callback.returns(self.measuredMarginRight)
	}

	/**
	 * @method jsGet_measuredMarginBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_measuredMarginBottom(callback: JavaScriptGetterCallback) {

		let measuredMarginBottom = self.node.measuredMarginBottom

		if (self.resolvedMarginBottom != measuredMarginBottom) {
			self.resolvedMarginBottom = measuredMarginBottom
			self.measuredMarginBottom.reset(lock: self)
		}

		if (self.measuredMarginBottom.isNull) {
			self.measuredMarginBottom.reset(self.resolvedMarginBottom, lock: self)
		}

		callback.returns(self.measuredMarginBottom)
	}

	/**
	 * @method jsGet_measuredPaddingTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_measuredPaddingTop(callback: JavaScriptGetterCallback) {

		let measuredPaddingTop = self.node.measuredPaddingTop

		if (self.resolvedPaddingTop != measuredPaddingTop) {
			self.resolvedPaddingTop = measuredPaddingTop
			self.measuredPaddingTop.reset(lock: self)
		}

		if (self.measuredPaddingTop.isNull) {
			self.measuredPaddingTop.reset(self.resolvedPaddingTop, lock: self)
		}

		callback.returns(self.measuredPaddingTop)
	}

	/**
	 * @method jsGet_measuredPaddingLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_measuredPaddingLeft(callback: JavaScriptGetterCallback) {

		let measuredPaddingLeft = self.node.measuredPaddingLeft

		if (self.resolvedPaddingLeft != measuredPaddingLeft) {
			self.resolvedPaddingLeft = measuredPaddingLeft
			self.measuredPaddingLeft.reset(lock: self)
		}

		if (self.measuredPaddingLeft.isNull) {
			self.measuredPaddingLeft.reset(self.resolvedPaddingLeft, lock: self)
		}

		callback.returns(self.measuredPaddingLeft)
	}

	/**
	 * @method jsGet_measuredPaddingRight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_measuredPaddingRight(callback: JavaScriptGetterCallback) {

		let measuredPaddingRight = self.node.measuredPaddingRight

		if (self.resolvedPaddingRight != measuredPaddingRight) {
			self.resolvedPaddingRight = measuredPaddingRight
			self.measuredPaddingRight.reset(lock: self)
		}

		if (self.measuredPaddingRight.isNull) {
			self.measuredPaddingRight.reset(self.resolvedPaddingRight, lock: self)
		}

		callback.returns(self.measuredPaddingRight)
	}

	/**
	 * @method jsGet_measuredPaddingBottom
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_measuredPaddingBottom(callback: JavaScriptGetterCallback) {

		let measuredPaddingBottom = self.node.measuredPaddingBottom

		if (self.resolvedPaddingBottom != measuredPaddingBottom) {
			self.resolvedPaddingBottom = measuredPaddingBottom
			self.measuredPaddingBottom.reset(lock: self)
		}

		if (self.measuredPaddingBottom.isNull) {
			self.measuredPaddingBottom.reset(self.resolvedPaddingBottom, lock: self)
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

		if (callback.context.controller.display.resolving) {
			callback.context.controller.display.registerResolveCallback(animate)
			return
		}

		animate()
	}

	/**
	 * @method jsFunction_setOpaque
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsFunction_setOpaque(callback: JavaScriptFunctionCallback) {
		self.node.setOpaque()
	}

	/**
	 * @method jsFunction_destroy
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsFunction_destroy(callback: JavaScriptFunctionCallback) {
		self.dispose()
	}

	/**
	 * @method jsFunction_insert
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsFunction_insert(callback: JavaScriptFunctionCallback) {

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
	@objc func jsFunction_remove(callback: JavaScriptFunctionCallback) {

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
	@objc func jsFunction_appendStyle(callback: JavaScriptFunctionCallback) {

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
	@objc func jsFunction_removeStyle(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptView.removeStyle() requires 1 argument.")
		}

		self.node.removeStyle(callback.argument(0).string)
	}

	/**
	 * @method jsFunction_hasStyle
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsFunction_hasStyle(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptView.hasStyle() requires 1 argument.")
		}

		callback.returns(self.node.hasStyle(callback.argument(0).string))
	}

	/**
	 * @method jsFunction_appendState
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsFunction_appendState(callback: JavaScriptFunctionCallback) {

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
	@objc func jsFunction_removeState(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptView.removeState() requires 1 argument.")
		}

		self.node.removeState(callback.argument(0).string)
	}

	/**
	 * @method jsFunction_hasState
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsFunction_hasState(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptView.hasState() requires 1 argument.")
		}

		callback.returns(self.node.hasState(callback.argument(0).string))
	}

	/**
	 * @method jsFunction_scheduleRedraw
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsFunction_scheduleRedraw(callback: JavaScriptFunctionCallback) {
		self.scheduleRedraw()
	}

	/**
	 * @method jsFunction_scheduleLayout
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsFunction_scheduleLayout(callback: JavaScriptFunctionCallback) {
		self.scheduleLayout()
	}

	/**
	 * @method jsFunction_measure
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsFunction_measure(callback: JavaScriptFunctionCallback) {
		self.measure()
	}

	/**
	 * @method jsFunction_resolve
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsFunction_resolve(callback: JavaScriptFunctionCallback) {
		self.resolve()
	}

	/**
	 * @method jsFunction_scrollTo
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsFunction_scrollTo(callback: JavaScriptFunctionCallback) {

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
	 * @type ViewDelegate
	 * @since 0.7.0
	 */
	public typealias Delegate = JavaScriptViewDelegate
}

/**
 * @type JavaScriptViewDelegate
 * @since 0.7.0
 * @hidden
 */
public protocol JavaScriptViewDelegate: class {
	func didPrepareLayout(view: JavaScriptView)
	func didResolveLayout(view: JavaScriptView)
	func didScroll(view: JavaScriptView)
}
