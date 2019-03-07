package ca.logaritm.dezel.application.keyboard

/**
 * The observer that receives informations about the keyboard state.
 * @interface KeyboardObserverListener
 * @since 0.1.0
 */
interface KeyboardObserverListener {

	/**
	 * Called when the keyboard height changes.
	 * @method onKeyboardHeightChanged
	 * @since 0.1.0
	 */
	fun onKeyboardHeightChanged(height: Int, orientation: Int)
}