package ca.logaritm.dezel.view

/**
 * @interface TextViewObserver
 * @since 0.7.0
 */
public interface TextViewObserver {

	/**
	 * @method onPressLink
	 * @since 0.7.0
	 */
	fun onPressLink(textView: TextView, url: String)

}
