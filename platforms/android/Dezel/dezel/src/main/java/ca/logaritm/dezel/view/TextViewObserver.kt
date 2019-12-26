package ca.logaritm.dezel.view

/**
 * @interface TextViewListener
 * @since 0.7.0
 */
public interface TextViewListener {

	/**
	 * @method onPressLink
	 * @since 0.7.0
	 */
	fun onPressLink(textView: TextView, url: String)

}
