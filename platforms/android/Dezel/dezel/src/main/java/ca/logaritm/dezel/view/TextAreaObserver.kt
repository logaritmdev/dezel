package ca.logaritm.dezel.view

/**
 * @interface TextAreaObserver
 * @since 0.7.0
 */
public interface TextAreaObserver {

	/**
	 * @method onChange
	 * @since 0.7.0
	 */
	fun onChange(textArea: TextArea, value: String)

	/**
	 * @method onFocus
	 * @since 0.7.0
	 */
	fun onFocus(textArea: TextArea)

	/**
	 * @method onBlur
	 * @since 0.7.0
	 */
	fun onBlur(textArea: TextArea)

}
