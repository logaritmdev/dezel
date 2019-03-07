package ca.logaritm.dezel.extension

import android.graphics.Canvas
import android.graphics.Paint
import android.graphics.RectF

/**
 * @method strokeRect
 * @since 0.5.0
 * @hidden
 */
internal fun Canvas.strokeRect(rect: RectF, color: Int) {
	val paint = Paint()
	paint.style = Paint.Style.STROKE
	paint.color = color
	paint.strokeWidth = 10f
	this.drawRect(rect, paint)
}