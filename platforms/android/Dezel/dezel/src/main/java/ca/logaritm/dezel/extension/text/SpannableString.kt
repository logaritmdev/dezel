package ca.logaritm.dezel.extension.text

import android.text.SpannableString

/**
 * @method SpannableString
 * @since 0.5.0
 * @hidden
 */
internal fun SpannableString(string: StringBuilder, spans: List<Any> = listOf()): SpannableString  {
	return SpannableString(string.toString(), spans)
}

/**
 * @method SpannableString
 * @since 0.5.0
 * @hidden
 */
internal fun SpannableString(string: String, spans: List<Any> = listOf()): SpannableString  {
	return SpannableString(string).apply {
		spans.forEach {
			this.setSpan(it, 0, this.length, SpannableString.SPAN_INCLUSIVE_INCLUSIVE)
		}
	}
}

