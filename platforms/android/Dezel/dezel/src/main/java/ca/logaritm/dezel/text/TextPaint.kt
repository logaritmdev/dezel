package ca.logaritm.dezel.text

import android.text.Spanned
import android.text.style.MetricAffectingSpan
import ca.logaritm.dezel.geom.Size
import ca.logaritm.dezel.text.span.FontSpan
import ca.logaritm.dezel.text.span.TextLeadingSpan
import android.text.TextPaint as AndroidTextPaint

//--------------------------------------------------------------------------
// Methods
//--------------------------------------------------------------------------

/**
 * @class TextPaint
 * @since 0.1.0
 * @hidden
 */
open class TextPaint : AndroidTextPaint() {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property paint
	 * @since 0.4.0
	 * @hidden
	 */
	private val paint = AndroidTextPaint()

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Measure spanned text range.
	 * @method measure
	 * @since 0.5.0
	 */
	open fun measure(text: Spanned, start: Int, end: Int): Size {

		val size = Size()
		var from = start
		var next = start

		var bot = 0f
		var top = 0f

		var leading = 0f

		while (next < end) {

			this.paint.set(this)

			next = text.nextSpanTransition(
				from,
				end,
				Object::class.java
			)

			val spans = text.getSpans(
				from,
				next,
				Object::class.java
			)

			for (span in spans) {

				if (span is MetricAffectingSpan) {
					span.updateMeasureState(this.paint)
				}

				if (span is FontSpan) {
					val t = this.paint.fontMetrics.top
					val b = this.paint.fontMetrics.bottom
					if (top > t) top = t
					if (bot < b) bot = b
				}

				if (span is TextLeadingSpan) {
					if (leading < span.textLeading) {
						leading = span.textLeading
					}
				}
			}

			size.width += this.paint.measureText(
				text,
				from,
				next
			)

			from = next
		}

		size.height = (bot - top) + leading

		return size
	}
}
