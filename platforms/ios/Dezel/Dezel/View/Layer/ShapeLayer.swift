import UIKit

/**
 * @class ShapeLayer
 * @super CAShapeLayer
 * @since 0.1.0
 */
open class ShapeLayer: CAShapeLayer, CALayerDelegate, CAAnimationDelegate {

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

		self.actions = nil
		self.contentsScale = UIScreen.main.scale
		self.rasterizationScale = UIScreen.main.scale
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	public convenience init(path: CGPath) {
		self.init()
		self.path = path
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

				case "path":
					animation.fromValue = current!.path
					animation.delegate = self

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

		return Transition.action(for: self, key: key)
	}

	//--------------------------------------------------------------------------
	// MARK: Animation Delegate
	//--------------------------------------------------------------------------

	/**
	 * @method animationDidStart
	 * @since 0.1.0
	 */
    open func animationDidStart(_ anim: CAAnimation) {
		//self.observer?.didBeginShapeAnimation()
	}

	/**
	 * @method animationDidStop
	 * @since 0.1.0
	 */
    open func animationDidStop(_ anim: CAAnimation, finished: Bool) {
//		if (finished) {
//			self.observer?.didFinishShapeAnimation()
//		}
	}
}
