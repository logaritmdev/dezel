/**
 * TODO
 * @protocol ContentTextInputDelegate
 * @since 0.2.0
 */
public protocol ContentTextInputDelegate: AnyObject {

	/**
	 * Called when the text input's receives a new input.
	 * @method didChange
	 * @since 0.2.0
	 */
	func didChange(textInput: ContentTextInput, value: String)

	/**
	 * Called when te text input's is focused.
	 * @method didFocus
	 * @since 0.2.0
	 */
	func didFocus(textInput: ContentTextInput)

	/**
	 * Called when te text input's is blured.
	 * @method didBlur
	 * @since 0.2.0
	 */
	func didBlur(textInput: ContentTextInput)

}
