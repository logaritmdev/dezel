/**
 * The interface for transitionable elements.
 * @protocol Transitionable
 * @since 0.2.0
 */
public protocol TransitionListener: AnyObject {

	/**
	 * Called when a transition animation must be allowed or rejected.
	 * @method shouldBeginTransitionAnimation
	 * @since 0.2.0
	 */
	func shouldBeginTransitionAnimation(animation: CABasicAnimation, for property: String, of layer: CALayer) -> Bool

	/**
	 * Called when a transition animation is created for the specified property.
	 * @method willBeginTransitionAnimation
	 * @since 0.2.0
	 */
	func willBeginTransitionAnimation(animation: CABasicAnimation, for property: String, of layer: CALayer)

	/**
	 * Called when the transition animation begins.
	 * @method didBeginTransition
	 * @since 0.2.0
	 */
	func didBeginTransition()

	/**
	 * Called when the transition animation finishes.
	 * @method didFinishTransition
	 * @since 0.2.0
	 */
	func didFinishTransition()
}

