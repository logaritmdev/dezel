package ca.logaritm.dezel.view.display

/**
 * @protocol DisplayListener
 * @since 0.7.0
 */
interface DisplayListener {

	/**
	 * @method layoutBegan
	 * @since 0.7.0
	 */
	fun layoutBegan(display: Display)

	/**
	 * @method layoutEnded
	 * @since 0.7.0
	 */
	fun layoutEnded(display: Display)
}
