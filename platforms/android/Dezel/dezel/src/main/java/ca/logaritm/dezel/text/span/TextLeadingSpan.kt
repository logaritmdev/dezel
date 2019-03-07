package ca.logaritm.dezel.text.span

import android.text.style.ParagraphStyle


/**
 * Applies text leading to a text span.
 * @class TextLeadingSpan
 * @since 0.5.0
 */
open class TextLeadingSpan(textLeading: Float): ParagraphStyle {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The text leading.
	 * @property textLeading
	 * @since 0.5.0
	 */
	public val textLeading: Float = textLeading

}