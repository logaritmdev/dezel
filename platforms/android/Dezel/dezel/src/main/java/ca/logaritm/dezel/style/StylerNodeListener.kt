package ca.logaritm.dezel.style

/**
 * @interface StylerNodeListener
 * @since 0.1.0
 */
public interface StylerNodeListener {

	/**
	 * Called when a stylerNode node is invalidated.
	 * @method onInvalidateStyleNode
	 * @since 0.1.0
	 */
	fun onInvalidateStyleNode(node: StylerNode)
}
