import Foundation

/**
 * The display's delegate.
 * @protocol DisplayDelegate
 * @since 0.7.0
 */
public protocol DisplayDelegate: AnyObject {

	/**
	 * Called when the display's layout pass began.
	 * @method layoutBegan
	 * @since 0.7.0
	 */
	func layoutBegan(display: Display)

	/**
	 * Called when the display's layout pass finishes.
	 * @method layoutEnded
	 * @since 0.7.0
	 */
	func layoutEnded(display: Display)
}
