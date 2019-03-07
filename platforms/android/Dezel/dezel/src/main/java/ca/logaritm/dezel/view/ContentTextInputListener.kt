package ca.logaritm.dezel.view

/**
 * TODO
 * @interface ContentTextInputListener
 * @since 0.2.0
 */
public interface ContentTextInputListener {

	/**
	 * Called when the text input's receives a new input.
	 * @method onChange
	 * @since 0.2.0
	 */
	fun onChange(textInput: ContentTextInput, value: String)

	/**
	 * Called when te text input's is focused.
	 * @method onFocus
	 * @since 0.2.0
	 */
	fun onFocus(textInput: ContentTextInput)

	/**
	 * Called when te text input's is blured.
	 * @method onBlur
	 * @since 0.2.0
	 */
	fun onBlur(textInput: ContentTextInput)

}
