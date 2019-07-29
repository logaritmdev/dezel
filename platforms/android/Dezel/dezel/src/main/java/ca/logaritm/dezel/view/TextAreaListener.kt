package ca.logaritm.dezel.view

/**
 * TODO
 * @interface TextAreaListener
 * @since 0.7.0
 */
public interface TextAreaListener {

	/**
	 * Called when the text input's receives a new input.
	 * @method onChange
	 * @since 0.7.0
	 */
	fun onChange(textArea: TextArea, value: String)

	/**
	 * Called when te text input's is focused.
	 * @method onFocus
	 * @since 0.7.0
	 */
	fun onFocus(textArea: TextArea)

	/**
	 * Called when te text input's is blured.
	 * @method onBlur
	 * @since 0.7.0
	 */
	fun onBlur(textArea: TextArea)

}
