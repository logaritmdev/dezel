package ca.logaritm.dezel.view

/**
 * TODO
 * @interface TextViewListener
 * @since 0.7.0
 */
public interface TextViewListener {

	/**
	 * Called when a link is pressed.
	 * @method onPressLink
	 * @since 0.7.0
	 */
	fun onPressLink(textView: TextView, url: String)

}
