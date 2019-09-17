package ca.logaritm.dezel.view.display

import android.util.SizeF

/**
 * The display node's listener.
 * @protocol DisplayNodeListener
 * @since 0.7.0
 */
public interface DisplayNodeListener {

	/**
	 * Called when the node needs to be measured manually.
	 * @method measure
	 * @since 0.7.0
	 */
	fun measure(node: DisplayNode, bounds: SizeF, min: SizeF, max: SizeF): SizeF?

	/**
	 * Called when the node's becomes invalid.
	 * @method onInvalidate
	 * @since 0.7.0
	 */
	fun onInvalidate(node: DisplayNode)

	/**
	 * Called when the node's size is resolved.
	 * @method onResolveSize
	 * @since 0.7.0
	 */
	fun onResolveSize(node: DisplayNode)

	/**
	 * Called when the node's offset is resolved.
	 * @method onResolveOrigin
	 * @since 0.7.0
	 */
	fun onResolveOrigin(node: DisplayNode)

	/**
	 * Called when the node's inner size is resolved.
	 * @method onResolveInnerSize
	 * @since 0.7.0
	 */
	fun onResolveInnerSize(node: DisplayNode)

	/**
	 * Called when the node's content size is resolved.
	 * @method onResolveContentSize
	 * @since 0.7.0
	 */
	fun onResolveContentSize(node: DisplayNode)

	/**
	 * Called when the node's margin is resolved.
	 * @method onResolveMargin
	 * @since 0.7.0
	 */
	fun onResolveMargin(node: DisplayNode)

	/**
	 * Called when the node's border is resolved.
	 * @method onResolveBorder
	 * @since 0.7.0
	 */
	fun onResolveBorder(node: DisplayNode)

	/**
	 * Called when the node's padding is resolved.
	 * @method onResolvePadding
	 * @since 0.7.0
	 */
	fun onResolvePadding(node: DisplayNode)

	/**
	 * Called when the node's layoutNode pass began.
	 * @method layoutBegan
	 * @since 0.7.0
	 */
	fun layoutBegan(node: DisplayNode)

	/**
	 * Called when the node's layoutNode pass has been completed.
	 * @method layoutEnded
	 * @since 0.7.0
	 */
	fun layoutEnded(node: DisplayNode)
}