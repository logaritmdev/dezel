package ca.logaritm.dezel.style

import ca.logaritm.dezel.core.Property

/**
 * @interface StylerNodeListener
 * @since 0.1.0
 */
public interface StylerNodeListener {

	/**
	 * Called when a style is ready to be applied.
	 * @method applyStyleProperty
	 * @since 0.3.0
	 */
	fun applyStyleProperty(node: StylerNode, property: String, value: Property)

	/**
	 * Called when a style needs to be returned to the node.
	 * @method fetchStyleProperty
	 * @since 0.1.0
	 */
	fun fetchStyleProperty(node: StylerNode, property: String): Property?

	/**
	 * Called when a stylerNode node is invalidated.
	 * @method onInvalidateStyleNode
	 * @since 0.1.0
	 */
	fun onInvalidateStyleNode(node: StylerNode)
}
