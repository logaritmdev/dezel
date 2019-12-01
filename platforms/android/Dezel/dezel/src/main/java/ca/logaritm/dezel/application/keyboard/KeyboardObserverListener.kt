package ca.logaritm.dezel.application.keyboard

/**
 * @interface KeyboardObserverListener
 * @since 0.1.0
 */
interface KeyboardObserverListener {

	/**
	 * @method onKeyboardHeightChanged
	 * @since 0.1.0
	 */
	fun onKeyboardHeightChanged(height: Int, orientation: Int)
}