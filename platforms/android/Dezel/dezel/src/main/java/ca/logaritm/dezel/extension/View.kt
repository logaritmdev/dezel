package ca.logaritm.dezel.extension

import android.view.View
import android.view.ViewGroup

/**
 * @method View.addView
 * @since 0.2.0
 * @hidden
 */
internal fun View.addView(view: View, index: Int) {

	if (this is ViewGroup) {

		/*
		 * Android does not automatically removes the view from its parent
		 * when adding it to another view. This has to be done manually
		 * otherwise it will throw an exception.
		 */

		view.removeFromParent()

		this.addView(view, index)
	}
}

/**
 * @method View.removeFromPArent
 * @since 0.1.0
 * @hidden
 */
internal fun View.removeFromParent() {
	val parent = this.parent
	if (parent is ViewGroup) {
		parent.removeView(this)
	}
}

/**
 * @method View.setMeasuredFrame
 * @since 0.1.0
 * @hidden
 */
internal fun View.setMeasuredFrame(t: Int, l: Int, w: Int, h: Int) {

	this.forceLayout()

	this.measure(
		View.MeasureSpec.makeMeasureSpec(w, View.MeasureSpec.EXACTLY),
		View.MeasureSpec.makeMeasureSpec(h, View.MeasureSpec.EXACTLY)
	)

	this.layout(l, t, l + w, t + h)
}