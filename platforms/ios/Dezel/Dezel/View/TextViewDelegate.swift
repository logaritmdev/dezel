/**
 * @protocol TextViewDelegate
 * @since 0.7.0
 */
public protocol TextViewDelegate: class {

	/**
	 * @method onPressLink
	 * @since 0.7.0
	 */
	func didPressLink(textView: TextView, url: String)

}
