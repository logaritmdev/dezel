package ca.logaritm.dezel.view.display

import android.util.SizeF
import ca.logaritm.dezel.core.JavaScriptProperty

/**
 * @protocol DisplayNodeListener
 * @since 0.7.0
 */
public interface DisplayNodeListener {

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
	 * @method onPrepareLayout
	 * @since 0.7.0
	 */
	fun onPrepareLayout(node: DisplayNode)

	/**
	 * @method onResolveLayout
	 * @since 0.7.0
	 */
	fun onResolveLayout(node: DisplayNode)

	/**
	 * @method measure
	 * @since 0.7.0
	 */
	fun measure(node: DisplayNode, bounds: SizeF, min: SizeF, max: SizeF): SizeF?

	/**
	 * @method resolve
	 * @since 0.7.0
	 */
	fun resolve(node: DisplayNode, property: String): JavaScriptProperty?
}
