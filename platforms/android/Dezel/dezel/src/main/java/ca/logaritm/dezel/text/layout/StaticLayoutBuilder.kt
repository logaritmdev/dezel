package ca.logaritm.dezel.text.layout

import android.os.Build
import android.text.Spanned
import android.text.StaticLayout
import android.text.TextPaint
import android.text.TextUtils
import ca.logaritm.dezel.geom.Size
import ca.logaritm.dezel.view.type.TextOverflow

/**
 * Convenience class to create static layout.
 * @class StaticLayoutBuilder
 * @since 0.5.0
 */
public object StaticLayoutBuilder {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Creates a layout for the specified bounds.
	 * @method build
	 * @since 0.5.0
	 */
	public fun build(paint: TextPaint, bounds: Size, limits: Size, text: Spanned, textLeading: Float, textKerning: Float, textOverflow: TextOverflow, lines: Int): StaticLayout {

		var layout = this.create(
			text,
			paint,
			limits.width,
			textLeading,
			textOverflow == TextOverflow.ELLIPSIS,
			lines
		)

		if (textOverflow == TextOverflow.ELLIPSIS) {

			/*
 			 * Since the static layout doesn't support a max height, a second layout will be
			 * required with a max line set to the last line that fits the bounds. This is only
			 * done if an height is specified and that hight is smaller than current layout's
			 * height.
			 */

			if (bounds.height > 0 &&
				bounds.height < layout.height) {

				for (line in 0 until layout.lineCount) if (layout.getLineBottom(line) > bounds.height) {

					/*
					 * This line goes beyond the available size, lets create a new layout
					 * limited to the amount of lines that fit in this bounds
					 */

					layout = this.create(
						text,
						paint,
						limits.width,
						textLeading,
						textOverflow == TextOverflow.ELLIPSIS,
						line
					)

					break
				}
			}
		}

		return layout
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method create
	 * @since 0.5.0
	 * @hidden
	 */
	private fun create(text: CharSequence, paint: TextPaint, width: Float, sa: Float, ellipsize: Boolean, lines: Int): StaticLayout {
		return this.create(text, 0, text.length, paint, width, 1f, sa, if (ellipsize) TextUtils.TruncateAt.END else null, lines)
	}

	/**
	 * @method create
	 * @since 0.5.0
	 * @hidden
	 */
	private fun create(text: CharSequence, bs: Int, be: Int, paint: TextPaint, width: Float, sm: Float, sa: Float, ellipsize: TextUtils.TruncateAt?, lines: Int): StaticLayout {

		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {

			return StaticLayout.Builder.obtain(text, bs, be, paint, width.toInt())
				.setLineSpacing(sa, sm)
				.setEllipsize(ellipsize)
				.setMaxLines(lines)
				.build()

		} else {
			return StaticLayoutBuilderCompat.create(text, bs, be, paint, width.toInt(), sm, sa, ellipsize, lines)
		}
	}
}
