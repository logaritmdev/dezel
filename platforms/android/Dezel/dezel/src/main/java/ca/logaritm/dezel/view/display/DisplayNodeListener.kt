package ca.logaritm.dezel.view.display

import android.util.SizeF

/**
 * @protocol DisplayNodeListener
 * @since 0.7.0
 */
public interface DisplayNodeListener {

	/**
	 * @method measure
	 * @since 0.7.0
	 */
	fun measure(node: DisplayNode, bounds: SizeF, min: SizeF, max: SizeF): SizeF?

	/**
	 * @method onInvalidate
	 * @since 0.7.0
	 */
	fun onInvalidate(node: DisplayNode)

	/**
	 * @method onResolveSize
	 * @since 0.7.0
	 */
	fun onResolveSize(node: DisplayNode)

	/**
	 * @method onResolveOrigin
	 * @since 0.7.0
	 */
	fun onResolveOrigin(node: DisplayNode)

	/**
	 * @method onResolveInnerSize
	 * @since 0.7.0
	 */
	fun onResolveInnerSize(node: DisplayNode)

	/**
	 * @method onResolveContentSize
	 * @since 0.7.0
	 */
	fun onResolveContentSize(node: DisplayNode)

	/**
	 * @method onResolveMargin
	 * @since 0.7.0
	 */
	fun onResolveMargin(node: DisplayNode)

	/**
	 * @method onResolveBorder
	 * @since 0.7.0
	 */
	fun onResolveBorder(node: DisplayNode)

	/**
	 * @method onResolvePadding
	 * @since 0.7.0
	 */
	fun onResolvePadding(node: DisplayNode)

	/**
	 * @method layoutBegan
	 * @since 0.7.0
	 */
	fun layoutBegan(node: DisplayNode)

	/**
	 * @method layoutEnded
	 * @since 0.7.0
	 */
	fun layoutEnded(node: DisplayNode)
}