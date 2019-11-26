/**
 * @protocol TextAreaDelegate
 * @since 0.7.0
 */
public protocol TextAreaDelegate: AnyObject {

	/**
	 * @method didChange
	 * @since 0.7.0
	 */
	func didChange(textInput: TextArea, value: String)

	/**
	 * @method didFocus
	 * @since 0.7.0
	 */
	func didFocus(textInput: TextArea)

	/**
	 * @method didBlur
	 * @since 0.7.0
	 */
	func didBlur(textInput: TextArea)

}
