package ca.logaritm.dezel.text.span

import android.text.TextPaint
import android.text.style.CharacterStyle


/**
 * Applies text color to a text span.
 * @class TextColorSpan
 * @since 0.5.0
 */
open class TextColorSpan(textColor: Int): CharacterStyle() {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The text color
	 * @property textColor
	 * @since 0.5.0
	 */
	public val textColor: Int = textColor

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method updateDrawState
	 * @since 0.5.0
	 */
	override fun updateDrawState(paint: TextPaint) {
		paint.color = this.textColor
	}
}