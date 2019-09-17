import Foundation

/**
 * The display node's delegate.
 * @protocol DisplayNodeDelegate
 * @since 0.7.0
 */
public protocol DisplayNodeDelegate: AnyObject {

	/**
	 * Called when the node needs to be measured manually.
	 * @method measure
	 * @since 0.7.0
	 */
	func measure(node: DisplayNode, in: CGSize, min: CGSize, max: CGSize) -> CGSize?

	/**
	 * Called when the node's becomes invalid.
	 * @method didInvalidate
	 * @since 0.7.0
	 */
	func didInvalidate(node: DisplayNode)

	/**
	 * Called when the node's size is resolved.
	 * @method didResolveSize
	 * @since 0.7.0
	 */
	func didResolveSize(node: DisplayNode)

	/**
	 * Called when the node's offset is resolved.
	 * @method didResolveOrigin
	 * @since 0.7.0
	 */
	func didResolveOrigin(node: DisplayNode)

	/**
	 * Called when the node's inner size is resolved.
	 * @method didResolveInnerSize
	 * @since 0.7.0
	 */
	func didResolveInnerSize(node: DisplayNode)

	/**
	 * Called when the node's content size is resolved.
	 * @method didResolveContentSize
	 * @since 0.7.0
	 */
	func didResolveContentSize(node: DisplayNode)

	/**
	 * Called when the node's margin is resolved.
	 * @method didResolveMargin
	 * @since 0.7.0
	 */
	func didResolveMargin(node: DisplayNode)

	/**
	 * Called when the node's border is resolved.
	 * @method didResolveBorder
	 * @since 0.7.0
	 */
	func didResolveBorder(node: DisplayNode)

	/**
	 * Called when the node's padding is resolved.
	 * @method didResolvePadding
	 * @since 0.7.0
	 */
	func didResolvePadding(node: DisplayNode)

	/**
	 * Called when the node's layout pass began.
	 * @method layoutBegan
	 * @since 0.7.0
	 */
	func layoutBegan(node: DisplayNode)

	/**
	 * Called when the node's layout pass has been finished.
	 * @method layoutEnded
	 * @since 0.7.0
	 */
	func layoutEnded(node: DisplayNode)
}
