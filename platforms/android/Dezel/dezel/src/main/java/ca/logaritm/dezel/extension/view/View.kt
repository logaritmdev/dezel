package ca.logaritm.dezel.extension.view

import android.view.View
import android.view.ViewGroup
import ca.logaritm.dezel.modules.view.JavaScriptView
import ca.logaritm.dezel.modules.view.JavaScriptWindow

/**
 * @property visible
 * @since 0.7.0
 */
internal var View.visible: Boolean
	get() = this.visibility != View.GONE
	set(value) {
		this.visibility = if (value) View.VISIBLE else View.GONE
	}

/**
 * @method JavaScriptView.addView
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
 * @method JavaScriptView.addView
 * @since 0.7.0
 * @hidden
 */
internal fun View.addView(view: JavaScriptView, index: Int) {
	this.addView(view.wrapper, index)
}

/**
 * @method JavaScriptView.addView
 * @since 0.7.0
 * @hidden
 */
internal fun View.addView(view: JavaScriptWindow, index: Int) {
	this.addView(view.wrapper, index)
}

/**
 * @method JavaScriptView.removeFromParent
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
 * @method JavaScriptView.setMeasuredFrame
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