package ca.logaritm.dezel.view

/**
 * TODO
 * @interface ContentTextAreaListener
 * @since 0.2.0
 */
public interface ContentTextAreaListener {

	/**
	 * Called when the text input's receives a new input.
	 * @method onChange
	 * @since 0.2.0
	 */
	fun onChange(textArea: ContentTextArea, value: String)

	/**
	 * Called when te text input's is focused.
	 * @method onFocus
	 * @since 0.2.0
	 */
	fun onFocus(textArea: ContentTextArea)

	/**
	 * Called when te text input's is blured.
	 * @method onBlur
	 * @since 0.2.0
	 */
	fun onBlur(textArea: ContentTextArea)

}
