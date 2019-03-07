package ca.logaritm.dezel.extension

import java.util.regex.Pattern

/**
 * @extension RegularExpression
 * @since 0.5.0
 * @hidden
 */
internal object RegularExpression {

	/**
	 * @method isHTML
	 * @since 0.5.0
	 * @hidden
	 */
	internal fun isHTML(string: String): Boolean {
		return isHTMLPattern.matcher(string).find(0)
	}
}

/**
 * @since 0.5.0
 */
public var isHTMLPattern = Pattern.compile("<[a-z][\\s\\S]*>", Pattern.CASE_INSENSITIVE)