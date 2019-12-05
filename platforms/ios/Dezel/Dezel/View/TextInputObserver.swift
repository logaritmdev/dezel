/**
 * @protocol TextInputObserver
 * @since 0.7.0
 */
public protocol TextInputObserver: AnyObject {

	/**
	 * @method didChange
	 * @since 0.7.0
	 */
	func didChange(textInput: TextInput, value: String)

	/**
	 * @method didFocus
	 * @since 0.7.0
	 */
	func didFocus(textInput: TextInput)

	/**
	 * @method didBlur
	 * @since 0.7.0
	 */
	func didBlur(textInput: TextInput)

}
