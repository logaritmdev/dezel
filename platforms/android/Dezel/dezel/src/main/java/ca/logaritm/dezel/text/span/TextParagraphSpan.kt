package ca.logaritm.dezel.text.span

import android.text.Layout
import android.text.style.AlignmentSpan
import ca.logaritm.dezel.view.type.TextAlignment

/**
 * Applies text alignment to a text span.
 * @class TextParagraphSpan
 * @since 0.5.0
 */
open class TextParagraphSpan(textAlignment: TextAlignment): AlignmentSpan {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The text alignment.
	 * @property textAlignment
	 * @since 0.5.0
	 */
	public val textAlignment: TextAlignment = textAlignment

	/**
	 * @inherited
	 * @method getAlignment
	 * @since 0.5.0
	 */
	override fun getAlignment(): Layout.Alignment {

		when (this.textAlignment) {

			TextAlignment.START  -> return Layout.Alignment.ALIGN_NORMAL
			TextAlignment.END    -> return Layout.Alignment.ALIGN_OPPOSITE

			TextAlignment.LEFT   -> {
				if (this.isLTR) return Layout.Alignment.ALIGN_NORMAL
				if (this.isRTL) return Layout.Alignment.ALIGN_OPPOSITE
			}

			TextAlignment.RIGHT  -> {
				if (this.isLTR) return Layout.Alignment.ALIGN_OPPOSITE
				if (this.isRTL) return Layout.Alignment.ALIGN_NORMAL
			}

			TextAlignment.CENTER -> return Layout.Alignment.ALIGN_CENTER
		}

		return Layout.Alignment.ALIGN_NORMAL
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property isRTL
	 * @since 0.5.0
	 * @hidden
	 */
	private val isRTL: Boolean
		get() = isRTL(java.util.Locale.getDefault())

	/**
	 * @property isLTR
	 * @since 0.5.0
	 * @hidden
	 */
	private val isLTR: Boolean
		get() = isLTR(java.util.Locale.getDefault())

	/**
	 * @method isRTL
	 * @since 0.5.0
	 * @hidden
	 */
	private fun isRTL(locale: java.util.Locale): Boolean {
		return (
			Character.getDirectionality(locale.displayName[0]).toInt() == Character.DIRECTIONALITY_RIGHT_TO_LEFT.toInt() ||
			Character.getDirectionality(locale.displayName[0]).toInt() == Character.DIRECTIONALITY_RIGHT_TO_LEFT_ARABIC.toInt()
		)
	}

	/**
	 * @method isLTR
	 * @since 0.5.0
	 * @hidden
	 */
	private fun isLTR(locale: java.util.Locale): Boolean {
		return Character.getDirectionality(locale.displayName[0]).toInt() == Character.DIRECTIONALITY_LEFT_TO_RIGHT.toInt()
	}
}