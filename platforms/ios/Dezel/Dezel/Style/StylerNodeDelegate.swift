import Foundation

/**
 * @protocol StylerNodeDelegate
 * @since 0.1.0
 */
public protocol StylerNodeDelegate : AnyObject {

	/**
	 * Called when a style is ready to be applied.
	 * @method applyStyleProperty
	 * @since 0.3.0
	 */
	func applyStyleProperty(node: StylerNode, property: String, value: Property)

	/**
	 * Called when a style needs to be returned to the node.
	 * @method fetchStyleProperty
	 * @since 0.1.0
	 */
	func fetchStyleProperty(node: StylerNode, property: String) -> Property?

	/**
	 * Called when a style node is invalidated.
	 * @method didInvalidateStylerNode
	 * @since 0.1.0
	 */
	func didInvalidateStylerNode(node: StylerNode)
}
