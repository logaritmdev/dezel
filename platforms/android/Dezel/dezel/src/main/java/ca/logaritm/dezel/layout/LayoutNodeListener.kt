package ca.logaritm.dezel.layout

import android.util.SizeF

/**
 * The layoutNode node's observer.
 * @interface LayoutNodeListener
 * @since 0.1.0
 */
public interface LayoutNodeListener {

	/**
	 * Called when the node is about to begin its layout.
	 * @method prepareLayoutNode
	 * @since 0.1.0
	 */
	fun prepareLayoutNode(node: LayoutNode)

	/**
	 * Called when the node needs to be measured manually.
	 * @method measureLayoutNode
	 * @since 0.1.0
	 */
	fun measureLayoutNode(node: LayoutNode, bounds: SizeF, min: SizeF, max: SizeF): SizeF?

	/**
	 * Called when the node's size is resolved.
	 * @method onResolveSize
	 * @since 0.2.0
	 */
	fun onResolveSize(node: LayoutNode)

	/**
	 * Called when the node's position is resolved.
	 * @method onResolvePosition
	 * @since 0.2.0
	 */
	fun onResolvePosition(node: LayoutNode)

	/**
	 * Called when the node's inner size is resolved.
	 * @method onResolveInnerSize
	 * @since 0.2.0
	 */
	fun onResolveInnerSize(node: LayoutNode)

	/**
	 * Called when the node's content size is resolved.
	 * @method onResolveContentSize
	 * @since 0.2.0
	 */
	fun onResolveContentSize(node: LayoutNode)

	/**
	 * Called when the node's margin is resolved.
	 * @method onResolveMargin
	 * @since 0.1.0
	 */
	fun onResolveMargin(node: LayoutNode)

	/**
	 * Called when the node's border is resolved.
	 * @method onResolveBorder
	 * @since 0.1.0
	 */
	fun onResolveBorder(node: LayoutNode)

	/**
	 * Called when the node's padding is resolved.
	 * @method onResolvePadding
	 * @since 0.1.0
	 */
	fun onResolvePadding(node: LayoutNode)

	/**
	 * Called when the node's layoutNode becomes invalid.
	 * @method onInvalidateLayout
	 * @since 0.1.0
	 */
	fun onInvalidateLayout(node: LayoutNode)

	/**
	 * Called when the node's layoutNode pass began.
	 * @method onBeginLayout
	 * @since 0.1.0
	 */
	fun onBeginLayout(node: LayoutNode)

	/**
	 * Called when the node's layoutNode pass has been completed.
	 * @method onFinishLayout
	 * @since 0.1.0
	 */
	fun onFinishLayout(node: LayoutNode)
}
