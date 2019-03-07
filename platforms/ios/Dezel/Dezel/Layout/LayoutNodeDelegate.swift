import Foundation

/**
 * The layout node's delegate.
 * @protocol LayoutNodeDelegate
 * @since 0.1.0
 */
public protocol LayoutNodeDelegate: AnyObject {

	/**
	 * Called when the node is about to begin its layout.
	 * @method prepareLayoutNode
	 * @since 0.1.0
	 */
	func prepareLayoutNode(node: LayoutNode)

	/**
	 * Called when the node needs to be measured manually.
	 * @method measureLayoutNode
	 * @since 0.1.0
	 */
	func measureLayoutNode(node: LayoutNode, in: CGSize, min: CGSize, max: CGSize) -> CGSize?

	/**
	 * Called when the node's bounds is resolved.
	 * @method didResolveSize
	 * @since 0.2.0
	 */
	func didResolveSize(node: LayoutNode)

	/**
	 * Called when the node's offset is resolved.
	 * @method didResolvePosition
	 * @since 0.1.0
	 */
	func didResolvePosition(node: LayoutNode)

	/**
	 * Called when the node's margin is resolved.
	 * @method didResolveMargin
	 * @since 0.1.0
	 */
	func didResolveMargin(node: LayoutNode)

	/**
	 * Called when the node's border is resolved.
	 * @method didResolveBorder
	 * @since 0.1.0
	 */
	func didResolveBorder(node: LayoutNode)

	/**
	 * Called when the node's padding is resolved.
	 * @method didResolvePadding
	 * @since 0.1.0
	 */
	func didResolvePadding(node: LayoutNode)

	/**
	 * Called when the node's inner size is resolved.
	 * @method didResolveInnerSize
	 * @since 0.2.0
	 */
	func didResolveInnerSize(node: LayoutNode)

	/**
	 * Called when the node's content size is resolved.
	 * @method didResolveContentSize
	 * @since 0.2.0
	 */
	func didResolveContentSize(node: LayoutNode)

	/**
	 * Called when the node's layout becomes invalid.
	 * @method didInvalidateLayout
	 * @since 0.1.0
	 */
	func didInvalidateLayout(node: LayoutNode)

	/**
	 * Called when the node's layout pass began.
	 * @method didBeginLayout
	 * @since 0.1.0
	 */
	func didBeginLayout(node: LayoutNode)

	/**
	 * Called when the node's layout pass has been finished.
	 * @method didFinishLayout
	 * @since 0.1.0
	 */
	func didFinishLayout(node: LayoutNode)
}
