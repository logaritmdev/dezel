import Foundation

/**
 * Provides the methods to manage a view that's size must be set manually.
 * @protocol Resizable
 * @since 0.2.0
 */
public protocol Resizable: AnyObject {
	func didResize(frame: CGRect)
}
