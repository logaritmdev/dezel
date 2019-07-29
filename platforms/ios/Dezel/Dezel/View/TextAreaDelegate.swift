/**
 * TODO
 * @protocol ContentTextAreaObserver
 * @since 0.7.0
 */
public protocol TextAreaDelegate: AnyObject {

	/**
	 * Called when the text input's receives a new input.
	 * @method didChange
	 * @since 0.7.0
	 */
	func didChange(textInput: TextArea, value: String)

	/**
	 * Called when te text input's is focused.
	 * @method didFocus
	 * @since 0.7.0
	 */
	func didFocus(textInput: TextArea)

	/**
	 * Called when te text input's is blured.
	 * @method didBlur
	 * @since 0.7.0
	 */
	func didBlur(textInput: TextArea)

}
