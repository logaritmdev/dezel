/**
 * @protocol Transitionable
 * @since 0.2.0
 */
public protocol TransitionListener: AnyObject {

	/**
	 * @method willAnimate
	 * @since 0.7.0
	 */
	func willAnimate(layer: CALayer, property: String)

	/**
	 * @method didBeginTransition
	 * @since 0.7.0
	 */
	func didBeginTransition(layer: CALayer)

	/**
	 * @method didCommitTransition
	 * @since 0.7.0
	 */
	func didCommitTransition(layer: CALayer)

	/**
	 * @method didFinishTransition
	 * @since 0.7.0
	 */
	func didFinishTransition(layer: CALayer)
}

