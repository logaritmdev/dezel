import UIKit

/**
 * @class BorderLayer
 * @super Layer
 * @since 0.1.0
 */
public class BorderLayer: Layer {

	//--------------------------------------------------------------------------
	// MARK: Class Methods
	//--------------------------------------------------------------------------

	/**
	 * @method needsDisplay
	 * @since 0.1.0
	 */
	override open class func needsDisplay(forKey key: String) -> Bool {

		if (key == "borderTopWidth" ||
			key == "borderLeftWidth" ||
			key == "borderRightWidth" ||
			key == "borderBottomWidth" ||
			key == "borderTopColor" ||
			key == "borderLeftColor" ||
			key == "borderRightColor" ||
			key == "borderBottomColor" ||
			key == "borderTopLeftRadius" ||
			key == "borderTopRightRadius" ||
			key == "borderBottomLeftRadius" ||
			key == "borderBottomRightRadius" ||
			key == "borderTopLeftInnerRadius" ||
			key == "borderTopRightInnerRadius" ||
			key == "borderBottomLeftInnerRadius" ||
			key == "borderBottomRightInnerRadius") {
			return true
		}

		return super.needsDisplay(forKey: key)
	}

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property borderTopWidth
	 * @since 0.1.0
	 */
	@NSManaged public var borderTopWidth: CGFloat

	/**
	 * @property borderLeftWidth
	 * @since 0.1.0
	 */
	@NSManaged public var borderLeftWidth: CGFloat

	/**
	 * @property borderRightWidth
	 * @since 0.1.0
	 */
	@NSManaged public var borderRightWidth: CGFloat

	/**
	 * @property borderBottomWidth
	 * @since 0.1.0
	 */
	@NSManaged public var borderBottomWidth: CGFloat

	/**
	 * @property borderTopColor
	 * @since 0.1.0
	 */
	@NSManaged public var borderTopColor: CGColor

	/**
	 * @property borderLeftColor
	 * @since 0.1.0
	 */
	@NSManaged public var borderLeftColor: CGColor

	/**
	 * @property borderRightColor
	 * @since 0.1.0
	 */
	@NSManaged public var borderRightColor: CGColor

	/**
	 * @property borderBottomColor
	 * @since 0.1.0
	 */
	@NSManaged public var borderBottomColor: CGColor

	/**
	 * @property borderTopLeftRadius
	 * @since 0.1.0
	 */
	@NSManaged public var borderTopLeftRadius: CGFloat

	/**
	 * @property borderTopRightRadius
	 * @since 0.1.0
	 */
	@NSManaged public var borderTopRightRadius: CGFloat

	/**
	 * @property borderBottomLeftRadius
	 * @since 0.1.0
	 */
	@NSManaged public var borderBottomLeftRadius: CGFloat

	/**
	 * @property borderBottomRightRadius
	 * @since 0.1.0
	 */
	@NSManaged public var borderBottomRightRadius: CGFloat

	/**
	 * @property borderTopLeftInnerRadius
	 * @since 0.1.0
	 */
	@NSManaged public var borderTopLeftInnerRadius: CGPoint

	/**
	 * @property borderTopRightInnerRadius
	 * @since 0.1.0
	 */
	@NSManaged public var borderTopRightInnerRadius: CGPoint

	/**
	 * @property borderBottomLeftInnerRadius
	 * @since 0.1.0
	 */
	@NSManaged public var borderBottomLeftInnerRadius: CGPoint

	/**
	 * @property borderBottomRightInnerRadius
	 * @since 0.1.0
	 */
	@NSManaged public var borderBottomRightInnerRadius: CGPoint

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	required public init() {
		super.init()
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	override init(layer: Any) {

		super.init(layer: layer)

		if let layer = layer as? BorderLayer {

			self.borderTopWidth = layer.borderTopWidth
			self.borderLeftWidth = layer.borderLeftWidth
			self.borderRightWidth = layer.borderRightWidth
			self.borderBottomWidth = layer.borderBottomWidth

			self.borderTopColor = layer.borderTopColor
			self.borderLeftColor = layer.borderLeftColor
			self.borderRightColor = layer.borderRightColor
			self.borderBottomColor = layer.borderBottomColor

			self.borderTopLeftRadius = layer.borderTopLeftRadius
			self.borderTopRightRadius = layer.borderTopRightRadius
			self.borderBottomLeftRadius = layer.borderBottomLeftRadius
			self.borderBottomRightRadius = layer.borderBottomRightRadius

			self.borderTopLeftInnerRadius = layer.borderTopLeftInnerRadius
			self.borderTopRightInnerRadius = layer.borderTopRightInnerRadius
			self.borderBottomLeftInnerRadius = layer.borderBottomLeftInnerRadius
			self.borderBottomRightInnerRadius = layer.borderBottomRightInnerRadius
		}
	}

	/**
	 * @method display
	 * @since 0.1.0
	 */
	override open func display() {

		let borderWidthT: CGFloat
		let borderWidthL: CGFloat
		let borderWidthR: CGFloat
		let borderWidthB: CGFloat

		let borderColorT: CGColor
		let borderColorL: CGColor
		let borderColorR: CGColor
		let borderColorB: CGColor

		let innerRadiusTL: CGPoint
		let innerRadiusTR: CGPoint
		let innerRadiusBL: CGPoint
		let innerRadiusBR: CGPoint

		let layerW: CGFloat
		let layerH: CGFloat

		if let presentationLayer = self.presentation() {

			borderWidthT = presentationLayer.borderTopWidth
			borderWidthL = presentationLayer.borderLeftWidth
			borderWidthR = presentationLayer.borderRightWidth
			borderWidthB = presentationLayer.borderBottomWidth

			borderColorT = presentationLayer.borderTopColor
			borderColorL = presentationLayer.borderLeftColor
			borderColorR = presentationLayer.borderRightColor
			borderColorB = presentationLayer.borderBottomColor

			innerRadiusTL = presentationLayer.borderTopLeftInnerRadius
			innerRadiusTR = presentationLayer.borderTopRightInnerRadius
			innerRadiusBL = presentationLayer.borderBottomLeftInnerRadius
			innerRadiusBR = presentationLayer.borderBottomRightInnerRadius

			layerW = presentationLayer.bounds.size.width
			layerH = presentationLayer.bounds.size.height

		} else {

			borderWidthT = self.borderTopWidth
			borderWidthL = self.borderLeftWidth
			borderWidthR = self.borderRightWidth
			borderWidthB = self.borderBottomWidth

			borderColorT = self.borderTopColor
			borderColorL = self.borderLeftColor
			borderColorR = self.borderRightColor
			borderColorB = self.borderBottomColor

			innerRadiusTL = self.borderTopLeftInnerRadius
			innerRadiusTR = self.borderTopRightInnerRadius
			innerRadiusBL = self.borderBottomLeftInnerRadius
			innerRadiusBR = self.borderBottomRightInnerRadius

			layerW = self.bounds.size.width
			layerH = self.bounds.size.height
		}

		if ((borderWidthT == 0 || borderColorT.alpha == 0) &&
			(borderWidthB == 0 || borderColorB.alpha == 0) &&
			(borderWidthL == 0 || borderColorL.alpha == 0) &&
			(borderWidthR == 0 || borderColorR.alpha == 0)) {
			self.contents = nil
			return
		}

		if (layerW == 0 || layerH == 0) {
			self.contents = nil
			return
		}

		/*
		 * Basically finds the smallest bitmap that contains the pattern that
		 * will be nine-scaled
		 */

		let cacheW = borderWidthL + borderWidthR + max(innerRadiusTL.x, innerRadiusBL.x, innerRadiusTR.x, innerRadiusBR.x) * 2 + 3
		let cacheH = borderWidthT + borderWidthB + max(innerRadiusTL.y, innerRadiusBL.y, innerRadiusTR.y, innerRadiusBR.y) * 2 + 3

		UIGraphicsBeginImageContextWithOptions(CGSize(width: cacheW, height: cacheH), false, 0.0)

		if let context = UIGraphicsGetCurrentContext() {

			context.saveGState()
			context.setShouldAntialias(false)
			context.setAllowsAntialiasing(false)
			context.setLineWidth(0)
			context.setMiterLimit(0)

			if (borderWidthT > 0) {
				context.beginPath()
				context.move(to: CGPoint(x: 0, y: 0))
				context.addLine(to: CGPoint(x: cacheW, y: 0))
				context.addLine(to: CGPoint(x: cacheW - borderWidthR - innerRadiusTR.x, y: borderWidthT + innerRadiusTR.y))
				context.addLine(to: CGPoint(x: borderWidthL + innerRadiusTL.x, y: borderWidthT + innerRadiusTL.y))
				context.closePath()
				context.setFillColor(borderColorT)
				context.fillPath()
			}

			if (borderWidthL > 0) {
				context.beginPath()
				context.move(to: CGPoint(x: 0, y: 0))
				context.addLine(to: CGPoint(x: borderWidthL + innerRadiusTL.x, y: borderWidthT + innerRadiusTL.y))
				context.addLine(to: CGPoint(x: borderWidthL + innerRadiusBL.x, y: cacheH - borderWidthB - innerRadiusBL.y))
				context.addLine(to: CGPoint(x: 0, y: cacheH))
				context.closePath()
				context.setFillColor(borderColorL)
				context.fillPath()
			}

			if (borderWidthR > 0) {
				context.beginPath()
				context.move(to: CGPoint(x: cacheW - borderWidthR - innerRadiusTR.x, y: borderWidthT + innerRadiusTR.y))
				context.addLine(to: CGPoint(x: cacheW, y: 0))
				context.addLine(to: CGPoint(x: cacheW, y: cacheH))
				context.addLine(to: CGPoint(x: cacheW - borderWidthR - innerRadiusBR.x, y: cacheH - borderWidthB - innerRadiusBR.y))
				context.closePath()
				context.setFillColor(borderColorR)
				context.fillPath()
			}

			if (borderWidthB > 0) {
				context.beginPath()
				context.move(to: CGPoint(x: borderWidthL + innerRadiusBL.x, y: cacheH - borderWidthB - innerRadiusBL.y))
				context.addLine(to: CGPoint(x: cacheW - borderWidthR - innerRadiusBR.x, y: cacheH - borderWidthB - innerRadiusBR.y))
				context.addLine(to: CGPoint(x: cacheW, y: cacheH))
				context.addLine(to: CGPoint(x: 0, y: cacheH))
				context.closePath()
				context.setFillColor(borderColorB)
				context.fillPath()
			}

			context.restoreGState()

			if (innerRadiusTL != .zero || innerRadiusTR != .zero ||
				innerRadiusBL != .zero || innerRadiusBR != .zero) {

				let path = CGInnerRoundedRectPath(
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

				context.saveGState()
				context.setShouldAntialias(true)
				context.setAllowsAntialiasing(true)
				context.setBlendMode(.clear)
				context.beginPath()
				context.addPath(path)
				context.closePath()
				context.fillPath()
				context.restoreGState()
			}
		}

		if let contents = UIGraphicsGetImageFromCurrentImageContext() {

			self.setContent(contents, center: CGPoint(
				x: ((max(innerRadiusTL.x, innerRadiusBL.x) + borderWidthL) + 1),
				y: ((max(innerRadiusTL.y, innerRadiusTR.y) + borderWidthT) + 1)
			))

		}

		UIGraphicsEndImageContext()
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Animations
	//--------------------------------------------------------------------------

	/**
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

				case "borderTopWidth":
					animation.fromValue = current!.borderTopWidth
				case "borderLeftWidth":
					animation.fromValue = current!.borderLeftWidth
				case "borderRightWidth":
					animation.fromValue = current!.borderRightWidth
				case "borderBottomWidth":
					animation.fromValue = current!.borderBottomWidth
				case "borderTopColor":
					animation.fromValue = current!.borderTopColor
				case "borderLeftColor":
					animation.fromValue = current!.borderLeftColor
				case "borderRightColor":
					animation.fromValue = current!.borderRightColor
				case "borderBottomColor":
					animation.fromValue = current!.borderBottomColor
				case "borderTopLeftRadius":
					animation.fromValue = current!.borderTopLeftRadius
				case "borderTopRightRadius":
					animation.fromValue = current!.borderTopRightRadius
				case "borderBottomLeftRadius":
					animation.fromValue = current!.borderBottomLeftRadius
				case "borderBottomRightRadius":
					animation.fromValue = current!.borderBottomRightRadius
				case "borderTopLeftInnerRadius":
					animation.fromValue = current!.borderTopLeftInnerRadius
				case "borderTopRightInnerRadius":
					animation.fromValue = current!.borderTopRightInnerRadius
				case "borderBottomLeftInnerRadius":
					animation.fromValue = current!.borderBottomLeftInnerRadius
				case "borderBottomRightInnerRadius":
					animation.fromValue = current!.borderBottomRightInnerRadius

				default:
					break
			}

			if (animation.fromValue != nil) {

				if (transition.delay > 0) {
					animation.delay = transition.delay
				}

				if let listener = self.listener as? TransitionListener {
					if (listener.shouldBeginTransitionAnimation(animation: animation, for: key, of: self)) {
						listener.willBeginTransitionAnimation(animation: animation, for: key, of: self)
						transition.register(listener)
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
