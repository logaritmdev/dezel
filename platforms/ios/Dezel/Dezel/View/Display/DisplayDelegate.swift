/**
 * @protocol DisplayDelegate
 * @since 0.7.0
 */
public protocol DisplayDelegate: AnyObject {

	/**
	 * @method layoutBegan
	 * @since 0.7.0
	 */
	func layoutBegan(display: Display)

	/**
	 * @method layoutEnded
	 * @since 0.7.0
	 */
	func layoutEnded(display: Display)
}
