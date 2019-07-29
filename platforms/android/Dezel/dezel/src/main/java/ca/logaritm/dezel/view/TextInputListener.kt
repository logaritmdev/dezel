package ca.logaritm.dezel.view

/**
 * TODO
 * @interface TextInputListener
 * @since 0.7.0
 */
public interface TextInputListener {

	/**
	 * Called when the text input's receives a new input.
	 * @method onChange
	 * @since 0.7.0
	 */
	fun onChange(textInput: TextInput, value: String)

	/**
	 * Called when te text input's is focused.
	 * @method onFocus
	 * @since 0.7.0
	 */
	fun onFocus(textInput: TextInput)

	/**
	 * Called when te text input's is blured.
	 * @method onBlur
	 * @since 0.7.0
	 */
	fun onBlur(textInput: TextInput)

}
