import UIKit

/**
 * The layer that renders the view's shadow.
 * @class ShadowLayer
 * @super Layer
 * @since 0.1.0
 */
open class ShadowLayer: Layer {

	//--------------------------------------------------------------------------
	// MARK: Class Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method needsDisplay
	 * @since 0.1.0
	 */
	override open class func needsDisplay(forKey key: String) -> Bool {

		if (key == "borderTopLeftRadius" ||
			key == "borderTopRightRadius" ||
			key == "borderBottomLeftRadius" ||
			key == "borderBottomRightRadius" ||
			key == "shadowBlur" ||
			key == "shadowColor") {
			return true
		}

		return super.needsDisplay(forKey: key)
	}

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The shadow layer's blur size.
	 * @property shadowBlur
	 * @since 0.1.0
	 */
	@NSManaged public var shadowBlur: CGFloat

	/**
	 * The shadow layer's shadow top offset.
	 * @property shadowOffsetTop
	 * @since 0.1.0
	 */
	@NSManaged public var shadowOffsetTop: CGFloat

	/**
	 * The shadow layer's shadow left offset.
	 * @property shadowOffsetLeft
	 * @since 0.1.0
	 */
	@NSManaged public var shadowOffsetLeft: CGFloat

	/**
	 * The shadow layer's top left radius.
	 * @property borderTopLeftRadius
	 * @since 0.1.0
	 */
	@NSManaged public var borderTopLeftRadius: CGFloat

	/**
	 * The shadow layer's top right radius.
	 * @property borderTopRightRadius
	 * @since 0.1.0
	 */
	@NSManaged public var borderTopRightRadius: CGFloat

	/**
	 * The shadow layer's bottom left radius.
	 * @property borderBottomLeftRadius
	 * @since 0.1.0
	 */
	@NSManaged public var borderBottomLeftRadius: CGFloat

	/**
	 * The shadow layer's bottom right radius.
	 * @property borderBottomRightRadius
	 * @since 0.1.0
	 */
	@NSManaged public var borderBottomRightRadius: CGFloat

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	required public init() {
		super.init()
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	override init(layer: Any) {

		super.init(layer: layer)

		if let layer = layer as? ShadowLayer {

			self.shadowBlur = layer.shadowBlur
			self.shadowOffsetTop = layer.shadowOffsetTop
			self.shadowOffsetLeft = layer.shadowOffsetLeft

			self.borderTopLeftRadius = layer.borderTopLeftRadius
			self.borderTopRightRadius = layer.borderTopRightRadius
			self.borderBottomLeftRadius = layer.borderBottomLeftRadius
			self.borderBottomRightRadius = layer.borderBottomRightRadius
		}
	}

	/**
	 * @inherited
	 * @method resize
	 * @since 0.1.0
	 */
	override open func resize(_ bounds: CGRect) {

		let shadowBlur: CGFloat
		let shadowOffsetTop: CGFloat
		let shadowOffsetLeft: CGFloat
		let shadowColor: CGColor?

		if let presentationLayer = self.presentation() {

			shadowBlur = ceil(presentationLayer.shadowBlur)
			shadowOffsetTop = presentationLayer.shadowOffsetTop
			shadowOffsetLeft = presentationLayer.shadowOffsetLeft
			shadowColor = presentationLayer.shadowColor

		} else {

			shadowBlur = ceil(self.shadowBlur)
			shadowOffsetTop = self.shadowOffsetTop
			shadowOffsetLeft = self.shadowOffsetLeft
			shadowColor = self.shadowColor
		}

		if (shadowColor == nil ||
			shadowColor?.alpha == 0) {
			super.resize(.zero)
			return
		}

		guard let parent = self.superlayer else {
			return
		}

		var frame = parent.bounds
		frame.origin.x = bounds.origin.x - shadowBlur + shadowOffsetLeft
		frame.origin.y = bounds.origin.y - shadowBlur + shadowOffsetTop
		frame.size.width = frame.size.width + shadowBlur * 2
		frame.size.height = frame.size.height + shadowBlur * 2

		super.resize(frame)
	}

	/**
	 * @inherited
	 * @method update
	 * @since 0.1.0
	 */
	override open func update() {
		self.resize(self.bounds)
	}

	/**
	 * @inherited
	 * @method display
	 * @since 0.1.0
	 */
	override open func display() {

		self.resize(self.bounds)

		let borderRadiusTL: CGFloat
		let borderRadiusTR: CGFloat
		let borderRadiusBL: CGFloat
		let borderRadiusBR: CGFloat

		let shadowBlur: CGFloat
		let shadowColor: CGColor?

		let layerW: CGFloat
		let layerH: CGFloat

		if let presentationLayer = self.presentation() {

			borderRadiusTL = presentationLayer.borderTopLeftRadius
			borderRadiusTR = presentationLayer.borderTopRightRadius
			borderRadiusBL = presentationLayer.borderBottomLeftRadius
			borderRadiusBR = presentationLayer.borderBottomRightRadius

			shadowBlur = ceil(presentationLayer.shadowBlur)
			shadowColor = presentationLayer.shadowColor

			layerW = presentationLayer.bounds.size.width
			layerH = presentationLayer.bounds.size.height

		} else {

			borderRadiusTL = self.borderTopLeftRadius
			borderRadiusTR = self.borderTopRightRadius
			borderRadiusBL = self.borderBottomLeftRadius
			borderRadiusBR = self.borderBottomRightRadius

			shadowBlur = ceil(self.shadowBlur)
			shadowColor = self.shadowColor

			layerW = self.bounds.size.width
			layerH = self.bounds.size.height
		}

		if (layerW == 0 ||
			layerH == 0) {
			return
		}

		if (shadowColor == nil ||
			shadowColor?.alpha == 0) {
			return
		}

		/*
		 * Basically finds the smallest bitmap that contains the pattern that
		 * will be nine-scaled
		 */

		let inner = max(
			borderRadiusTL, borderRadiusTR,
			borderRadiusBR, borderRadiusBL,
			shadowBlur
		)

		let shapeW = inner * 2 + 3
		let shapeH = inner * 2 + 3
		let cacheW = inner * 2 + shadowBlur * 2 + 3
		let cacheH = inner * 2 + shadowBlur * 2 + 3

		let shapeT = cacheH / 2 - shapeH / 2
		let shapeL = cacheW / 2 - shapeW / 2

		UIGraphicsBeginImageContextWithOptions(CGSize(width: cacheW, height: cacheH), false, 0.0)

		if let context = UIGraphicsGetCurrentContext() {

			context.saveGState()

			if (shadowBlur > 0) {

				context.setShadow(offset: CGSize(width: cacheW, height: cacheH), blur: shadowBlur, color: shadowColor)
				context.translateBy(
					x: shapeL - cacheW,
					y: shapeT - cacheH
				)

			} else {

				context.setFillColor(shadowColor!)

			}

			let path = CGOuterRoundedRectPath(
				shapeW,
				shapeH,
				borderRadiusTL,
				borderRadiusTR,
				borderRadiusBL,
				borderRadiusBR
			)

			context.beginPath()
			context.addPath(path)
			context.closePath()
			context.fillPath()

			context.restoreGState()
		}

		if let contents = UIGraphicsGetImageFromCurrentImageContext() {

			self.setContent(contents, center: CGPoint(
				x: shadowBlur + inner + 1,
				y: shadowBlur + inner + 1
			))

		}

		UIGraphicsEndImageContext()
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Animations
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method action
	 * @since 0.1.0
	 */
	override open func action(forKey key: String) -> CAAction? {

		if let transition = Transition.current {

			var current = self.presentation()
			if (current == nil || self.animation(forKey: key) == nil) {
				current = self
			}

			let animation = CABasicAnimation(keyPath: key)

			switch (key) {

				case "shadowBlur":
					animation.fromValue = current!.shadowBlur
				case "shadowColor":
					animation.fromValue = current!.shadowColor
				case "shadowOffsetTop":
					animation.fromValue = current!.shadowOffsetTop
				case "shadowOffsetLeft":
					animation.fromValue = current!.shadowOffsetLeft
				case "borderTopLeftRadius":
					animation.fromValue = current!.borderTopLeftRadius
				case "borderTopRightRadius":
					animation.fromValue = current!.borderTopRightRadius
				case "borderBottomLeftRadius":
					animation.fromValue = current!.borderBottomLeftRadius
				case "borderBottomRightRadius":
					animation.fromValue = current!.borderBottomRightRadius

				default:
					break
			}

			if (animation.fromValue != nil) {

				if (transition.delay > 0) {
					animation.beginTime = CACurrentMediaTime() + transition.delay
					animation.fillMode = CAMediaTimingFillMode.both
				}

				if let listener = self.listener as? TransitionListener {
					if (listener.shouldBeginTransitionAnimation(animation: animation, for: key, of: self)) {
						listener.willBeginTransitionAnimation(animation: animation, for: key, of: self)
						transition.register(listener, animation: animation, for: key)
					} else {
						return NSNull()
					}
				}

				return animation
			}
		}

		return super.action(forKey: key)
	}
}
