package ca.logaritm.dezel.view.text.span

import android.text.TextPaint
import android.text.style.MetricAffectingSpan
import ca.logaritm.dezel.view.graphic.Convert

/**
 * Applies text kerning to a text span.
 * @class TextKerningSpan
 * @since 0.5.0
 */
open class TextKerningSpan(textKerning: Float): MetricAffectingSpan() {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The text kerning.
	 * @property textKerning
	 * @since 0.5.0
	 */
	public val textKerning: Float = textKerning

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method updateMeasureState
	 * @since 0.5.0
	 */
	override fun updateMeasureState(paint: TextPaint) {
		if (this.textKerning != 0f) {
			paint.letterSpacing = this.textKerning / Convert.toPx(16f)
		}
	}

	/**
	 * @method updateDrawState
	 * @since 0.5.0
	 */
	override fun updateDrawState(paint: TextPaint) {
		if (this.textKerning != 0f) {
			paint.letterSpacing = this.textKerning / Convert.toPx(16f)
		}
	}
}