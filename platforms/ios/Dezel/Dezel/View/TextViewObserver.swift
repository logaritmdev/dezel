/**
 * @protocol TextViewObserver
 * @since 0.7.0
 */
public protocol TextViewObserver: class {

	/**
	 * @method onPressLink
	 * @since 0.7.0
	 */
	func didPressLink(textView: TextView, url: String)

}
