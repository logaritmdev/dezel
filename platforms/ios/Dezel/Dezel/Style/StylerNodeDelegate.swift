import Foundation

/**
 * @protocol StylerNodeDelegate
 * @since 0.1.0
 */
public protocol StylerNodeDelegate : AnyObject {

	/**
	 * Called when a style node is invalidated.
	 * @method didInvalidateStylerNode
	 * @since 0.1.0
	 */
	func didInvalidateStylerNode(node: StylerNode)
}
