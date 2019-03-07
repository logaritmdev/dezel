package ca.logaritm.dezel.view

/**
 * TODO
 * @interface ContentTextViewListener
 * @since 0.5.0
 */
public interface ContentTextViewListener {

	/**
	 * Called when a link is pressed.
	 * @method onPressLink
	 * @since 0.5.0
	 */
	fun onPressLink(textView: ContentTextView, url: String)

}
