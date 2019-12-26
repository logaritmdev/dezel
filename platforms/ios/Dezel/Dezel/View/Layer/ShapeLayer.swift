import UIKit

/**
 * @class ShapeLayer
 * @super CAShapeLayer
 * @since 0.1.0
 */
open class ShapeLayer: CAShapeLayer, CALayerDelegate, Animatable {

	//--------------------------------------------------------------------------
	// MARK: Class Methods
	//--------------------------------------------------------------------------

	/**
	 * @method defaultAction
	 * @since 0.1.0
	 */
	override open class func defaultAction(forKey event: String) -> CAAction? {
		return nil
	}

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	required public init?(coder:NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	public required override init() {
		super.init()
		self.setup()
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	override init(layer: Any) {
		super.init(layer: layer)
	}

	//--------------------------------------------------------------------------
	// MARK: Animations
	//--------------------------------------------------------------------------

	/**
	 * @method willAnimate
	 * @since 0.7.0
	 */
	open func willAnimate(layer: CALayer, property: String) {
		(self.listener as? Animatable)?.willAnimate(layer: self, property: property)
	}

	/**
	 * @method didBeginTransition
	 * @since 0.7.0
	 */
	open func didBeginTransition(layer: CALayer) {
		(self.listener as? Animatable)?.didBeginTransition(layer: self)
	}

	/**
	 * @method didCommitTransition
	 * @since 0.7.0
	 */
	open func didCommitTransition(layer: CALayer) {
		(self.listener as? Animatable)?.didCommitTransition(layer: self)
	}

	/**
	 * @method didFinishTransition
	 * @since 0.7.0
	 */
	open func didFinishTransition(layer: CALayer) {
		(self.listener as? Animatable)?.didFinishTransition(layer: self)
	}

	/**
	 * @method action
	 * @since 0.1.0
	 */
	override open func action(forKey key: String) -> CAAction? {

		if let transition = TransitionManager.transition {

			var current = self.presentation()
			if (current == nil || self.animation(forKey: key) == nil) {
				current = self
			}

			let animation = CABasicAnimation(key: key, delay: transition.delay)

			switch (key) {

				case "bounds":
					animation.fromValue = NSValue(cgRect: current!.bounds)
				case "position":
					animation.fromValue = NSValue(cgPoint: current!.position)
				case "transform":
					animation.fromValue = NSValue(caTransform3D: current!.transform)
				case "opacity":
					animation.fromValue = current!.opacity
				case "path":
					animation.fromValue = current!.path

				default:
					return NSNull()
			}

			transition.notify(self)

			self.willAnimate(layer: self, property: key)

			return animation
		}

		return NSNull()
	}
}
