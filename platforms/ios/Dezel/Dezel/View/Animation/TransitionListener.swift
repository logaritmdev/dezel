/**
 * @protocol Transitionable
 * @since 0.2.0
 */
public protocol TransitionListener: AnyObject {

	/**
	 * @method shouldBeginTransitionAnimation
	 * @since 0.2.0
	 */
	func shouldBeginTransitionAnimation(animation: CABasicAnimation, for property: String, of layer: CALayer) -> Bool

	/**
	 * @method willBeginTransitionAnimation
	 * @since 0.2.0
	 */
	func willBeginTransitionAnimation(animation: CABasicAnimation, for property: String, of layer: CALayer)

	/**
	 * @method didCommitTransition
	 * @since 0.6.0
	 */
	func didCommitTransition()

	/**
	 * @method didFinishTransition
	 * @since 0.2.0
	 */
	func didFinishTransition()
}

