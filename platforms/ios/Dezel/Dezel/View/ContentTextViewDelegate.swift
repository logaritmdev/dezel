/**
 * TODO
 * @interface ContentTextViewDelegate
 * @since 0.5.0
 */
public protocol ContentTextViewDelegate: class {

	/**
	 * Called when a link is pressed.
	 * @method onPressLink
	 * @since 0.5.0
	 */
	func didPressLink(textView: ContentTextView, url: String)

}
