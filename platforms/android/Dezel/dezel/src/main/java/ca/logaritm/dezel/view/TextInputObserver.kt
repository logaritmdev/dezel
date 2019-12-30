package ca.logaritm.dezel.view

/**
 * @interface TextInputObserver
 * @since 0.7.0
 */
public interface TextInputObserver {

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
