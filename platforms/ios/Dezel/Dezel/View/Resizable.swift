import Foundation

/**
 * @protocol Resizable
 * @since 0.2.0
 */
public protocol Resizable: AnyObject {
	func didResize(frame: CGRect)
}
