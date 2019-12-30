package ca.logaritm.dezel.view.text.span

import android.text.Layout
import android.text.style.AlignmentSpan
import ca.logaritm.dezel.view.type.TextAlign

/**
 * Applies text alignment to a text span.
 * @class TextParagraphSpan
 * @since 0.5.0
 */
open class TextParagraphSpan(textAlign: TextAlign): AlignmentSpan {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The text alignment.
	 * @property textAlign
	 * @since 0.5.0
	 */
	public val textAlign: TextAlign = textAlign

	/**
	 * @method getAlignment
	 * @since 0.5.0
	 */
	override fun getAlignment(): Layout.Alignment {

		when (this.textAlign) {

			TextAlign.TOP_LEFT,
			TextAlign.MIDDLE_LEFT,
			TextAlign.BOTTOM_LEFT -> {
				if (this.isLTR) return Layout.Alignment.ALIGN_NORMAL
				if (this.isRTL) return Layout.Alignment.ALIGN_OPPOSITE
			}

			TextAlign.TOP_RIGHT,
			TextAlign.MIDDLE_RIGHT,
			TextAlign.BOTTOM_RIGHT -> {
				if (this.isLTR) return Layout.Alignment.ALIGN_OPPOSITE
				if (this.isRTL) return Layout.Alignment.ALIGN_NORMAL
			}

			TextAlign.TOP_CENTER,
			TextAlign.MIDDLE_CENTER,
			TextAlign.BOTTOM_CENTER -> {
				return Layout.Alignment.ALIGN_CENTER
			}
		}

		if (this.isLTR) {
			return Layout.Alignment.ALIGN_NORMAL
		} else {
			return Layout.Alignment.ALIGN_OPPOSITE
		}
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