package ca.logaritm.dezel.view

/**
 * @interface TextInputListener
 * @since 0.7.0
 */
public interface TextInputListener {

	/**
	 * @method onChange
	 * @since 0.7.0
	 */
	fun onChange(textInput: TextInput, value: String)

	/**
	 * @method onFocus
	 * @since 0.7.0
	 */
	fun onFocus(textInput: TextInput)

	/**
	 * @method onBlur
	 * @since 0.7.0
	 */
	fun onBlur(textInput: TextInput)

}
