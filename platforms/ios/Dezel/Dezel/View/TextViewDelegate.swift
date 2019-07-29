/**
 * TODO
 * @interface TextViewDelegate
 * @since 0.7.0
 */
public protocol TextViewDelegate: class {

	/**
	 * Called when a link is pressed.
	 * @method onPressLink
	 * @since 0.7.0
	 */
	func didPressLink(textView: TextView, url: String)

}
