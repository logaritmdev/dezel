package ca.logaritm.dezel.extension.view

import android.view.View
import android.view.ViewGroup
import ca.logaritm.dezel.modules.view.JavaScriptView

/**
 * @method ViewGroup.forEach
 * @since 0.1.0
 * @hidden
 */
internal inline fun ViewGroup.forEach(action: (View) -> Unit) {
	for (i in 0 until this.childCount) {
		action(this.getChildAt(i))
	}
}

internal fun ViewGroup.addView(view: JavaScriptView) {
	this.addView(view.wrapper)
}