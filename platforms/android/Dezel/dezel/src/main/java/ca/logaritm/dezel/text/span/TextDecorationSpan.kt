package ca.logaritm.dezel.text.span

import android.text.TextPaint
import android.text.style.CharacterStyle
import ca.logaritm.dezel.view.type.TextDecoration

/**
 * Applies text decoration to a text span.
 * @class TextDecorationSpantextdsadas
 * @since 0.5.0
 */
open class TextDecorationSpan(textDecoration: TextDecoration): CharacterStyle() {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The text decoration
	 * @property textDecoration
	 * @since 0.5.0
	 */
	public val textDecoration: TextDecoration = textDecoration

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method updateDrawState
	 * @since 0.5.0
	 */
	override fun updateDrawState(paint: TextPaint) {

		when (this.textDecoration) {

			TextDecoration.NONE        -> {
				paint.isUnderlineText = false
				paint.isStrikeThruText = false
			}

			TextDecoration.UNDERLINE   -> {
				paint.isUnderlineText = true
				paint.isStrikeThruText = false
			}

			TextDecoration.LINETHROUGH -> {
				paint.isUnderlineText = false
				paint.isStrikeThruText = true
			}
		}
	}
}