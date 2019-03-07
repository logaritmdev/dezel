package ca.logaritm.dezel.extension

import android.graphics.Path
import android.graphics.PathMeasure
import android.graphics.PointF
import android.graphics.RectF

private val measure: PathMeasure = PathMeasure()

/**
 * @method Path.getLastPoint()
 * @since 0.1.0
 * @hidden
 */
internal fun Path.getLastPoint(): PointF {

	val coordinates = floatArrayOf(0f, 0f)

	measure.setPath(this, false)
	measure.getPosTan(measure.length, coordinates, null)

	return PointF(
		Math.round(coordinates[0] * 100).toFloat() / 100f,
		Math.round(coordinates[1] * 100).toFloat() / 100f
	)
}

/**
 * @method Path.addArcTo
 * @since 0.1.0
 * @hidden
 */
internal fun Path.addArcTo(tangent1End: PointF, tangent2End: PointF, radius: Float) {

	val last = this.getLastPoint()
	val x0 = last.x.toDouble()
	val y0 = last.y.toDouble()
	val x1 = tangent1End.x.toDouble()
	val y1 = tangent1End.y.toDouble()
	val x2 = tangent2End.x.toDouble()
	val y2 = tangent2End.y.toDouble()
	val r = radius.toDouble()

	if (isColinear(x0, y0, x1, y1, x2, y2)) {
		this.lineTo(x1.toFloat(), y1.toFloat())
		return
	}

	val ccw = isCCW(x0, y0, x1, y1, x2, y2)
	val firstAngle = getAngle(x0, y0, x1, y1)
	val medianAngle = getAngle(x0, y0, x1, y1, x2, y2) / 2

	val center = getCenter(firstAngle, x1, y1, r, medianAngle, ccw)
	val contact = getTanContactCoords(x1, y1, firstAngle, medianAngle, r)

	val startAngle = getStartAngle(contact[0], contact[1], center[0], center[1])
	val sweepAngle = getSweepAngle(medianAngle, ccw)

	val rect = RectF(
		(center[0] - r).toFloat(),
		(center[1] - r).toFloat(),
		(center[0] + r).toFloat(),
		(center[1] + r).toFloat()
	)

	this.lineTo(
		contact[0].toFloat(),
		contact[1].toFloat()
	)

	this.addArc(rect, startAngle.toFloat(), sweepAngle.toFloat())
}

/**
 * @method Path.addOuterRoundedRect
 * @since 0.1.0
 * @hidden
 */
internal fun Path.addOuterRoundedRect(w: Float, h: Float, radiusTL: Float, radiusTR: Float, radiusBL: Float, radiusBR: Float) {

	val rect = RectF(0f, 0f, w, h)

	if (radiusTL == 0f && radiusTR == 0f &&
		radiusBL == 0f && radiusBR == 0f) {

		this.addRect(rect, Path.Direction.CW)

	} else {

		this.addRoundRect(rect, floatArrayOf(
			radiusTL, radiusTL,
			radiusTR, radiusTR,
			radiusBR, radiusBR,
			radiusBL, radiusBL
		), Path.Direction.CW)

	}
}

/**
 * @method Path.addInnerRoundedRect
 * @since 0.1.0
 * @hidden
 */
internal fun Path.addInnerRoundedRect(w: Float, h: Float, radiusTL: PointF, radiusTR: PointF, radiusBL: PointF, radiusBR: PointF, borderT: Float, borderL: Float, borderR: Float, borderB: Float) {

	val rect = RectF(
		borderL,
		borderT,
		borderL + w - borderL - borderR,
		borderT + h - borderT - borderB
	)

	if (radiusTL.equals(0f, 0f) && radiusTR.equals(0f, 0f) &&
		radiusBL.equals(0f, 0f) && radiusBR.equals(0f, 0f)) {

		this.addRect(rect, Path.Direction.CW)

	} else {

		this.addRoundRect(rect, floatArrayOf(
			radiusTL.x, radiusTL.y,
			radiusTR.x, radiusTR.y,
			radiusBR.x, radiusBR.y,
			radiusBL.x, radiusBL.y
		), Path.Direction.CW)

	}
}

/**
 * @function getTanContactCoords
 * @since 0.4.0
 * @hidden
 */
internal fun getTanContactCoords(x: Double, y: Double, angle: Double, medianAngle: Double, r: Double): DoubleArray {

	val adjacent = r / Math.tan(Math.toRadians(medianAngle))

	val coords = doubleArrayOf(0.0, 0.0)
	coords[0] = adjacent * Math.cos(Math.toRadians(angle)) + x
	coords[1] = adjacent * Math.sin(Math.PI * 2 - Math.toRadians(angle)) + y

	return coords
}

/**
 * @function getCenter
 * @since 0.4.0
 * @hidden
 */
private fun getCenter(angle: Double, x1: Double, y1: Double, r: Double, medianAngle: Double, ccw: Boolean): DoubleArray {

	val hyp = r / Math.sin(Math.toRadians(medianAngle))
	val rad = if (ccw) Math.toRadians(angle - medianAngle) else Math.toRadians(angle + medianAngle)

	val coords = doubleArrayOf(0.0, 0.0)
	coords[0] = hyp * Math.cos(rad) + x1
	coords[1] = hyp * Math.sin(Math.PI * 2 - rad) + y1

	return coords
}

/**
 * @function getAngle
 * @since 0.4.0
 * @hidden
 */
private fun getAngle(x0: Double, y0: Double, x1: Double, y1: Double): Double {

	val deltaX = x0 - x1
	val deltaY = y0 - y1

	var angle = Math.toDegrees(Math.atan2(deltaY, deltaX))

	if (angle > 0) {
		angle = 360 - angle
	} else if (angle < 0) {
		angle = Math.abs(angle)
	}

	return angle
}

/**
 * @function getAngle
 * @since 0.4.0
 * @hidden
 */
private fun getAngle(x0: Double, y0: Double, x1: Double, y1: Double, x2: Double, y2: Double): Double {

	val a = Math.sqrt(Math.pow(x1 - x0, 2.0) + Math.pow(y1 - y0, 2.0))
	val b = Math.sqrt(Math.pow(x1 - x2, 2.0) + Math.pow(y1 - y2, 2.0))
	val c = Math.sqrt(Math.pow(x0 - x2, 2.0) + Math.pow(y0 - y2, 2.0))

	// angle between P0-P1 and P1-P2
	return Math.toDegrees(Math.acos((Math.pow(a, 2.0) + Math.pow(b, 2.0) - Math.pow(c, 2.0)) / (2.0 * a * b)))
}

/**
 * @function getStartAngle
 * @since 0.4.0
 * @hidden
 */
private fun getStartAngle(x0: Double, y0: Double, x1: Double, y1: Double): Double {
	return 360 - getAngle(x0, y0, x1, y1)
}

/**
 * @function getSweepAngle
 * @since 0.4.0
 * @hidden
 */
private fun getSweepAngle(angle: Double, turnsLeft: Boolean): Double {

	var a = (90 - angle) * 2

	if (turnsLeft) {
		a = -a
	}

	return a
}

/**
 * @function isCCW
 * @since 0.4.0
 * @hidden
 */
fun isCCW(x0: Double, y0: Double, x1: Double, y1: Double, x2: Double, y2: Double): Boolean {
	return cross(x0, y0, x1, y1, x2, y2) > 0
}

/**
 * @function isColinear
 * @since 0.4.0
 * @hidden
 */
private fun isColinear(x0: Double, y0: Double, x1: Double, y1: Double, x2: Double, y2: Double): Boolean {
	return cross(x0, y0, x1, y1, x2, y2) == 0.0
}

/**
 * @function cross
 * @since 0.4.0
 * @hidden
 */
private fun cross(x0: Double, y0: Double, x1: Double, y1: Double, x2: Double, y2: Double): Double {
	return (x0 - x1) * (y2 - y1) - (y0 - y1) * (x2 - x1)
}