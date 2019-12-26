/**
 * @protocol Animatable
 * @since 0.7.0
 */
public protocol Animatable: AnyObject {

	/**
	 * @method willAnimate
	 * @since 0.7.0
	 */
	func willAnimate(property: String)

	/**
	 * @method didBeginTransition
	 * @since 0.7.0
	 */
	func didBeginTransition()

	/**
	 * @method didCommitTransition
	 * @since 0.7.0
	 */
	func didCommitTransition()

	/**
	 * @method didFinishTransition
	 * @since 0.7.0
	 */
	func didFinishTransition()
}
