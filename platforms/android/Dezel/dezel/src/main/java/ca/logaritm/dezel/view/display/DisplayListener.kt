package ca.logaritm.dezel.view.display

/**
 * The display's listener.
 * @protocol DisplayDelegate
 * @since 0.7.0
 */
interface DisplayDelegate {

	/**
	 * Called when the display's layout pass began.
	 * @method layoutBegan
	 * @since 0.7.0
	 */
	fun layoutBegan(display: Display)

	/**
	 * Called when the display's layout pass finishes.
	 * @method layoutEnded
	 * @since 0.7.0
	 */
	fun layoutEnded(display: Display)
}
