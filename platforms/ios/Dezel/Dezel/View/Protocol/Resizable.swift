import Foundation

/**
 * @protocol Resizable
 * @since 0.2.0
 */
public protocol Resizable: AnyObject {

	/*
	 * @method didResize
	 * @since 0.2.0
	 */
	func didResize(frame: CGRect)
}
