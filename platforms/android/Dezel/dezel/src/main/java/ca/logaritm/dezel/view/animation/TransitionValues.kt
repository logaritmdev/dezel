package ca.logaritm.dezel.view.animation

import ca.logaritm.dezel.modules.view.View

import android.view.View as AndroidView

/**
 * @class TransitionValues
 * @since 0.1.0
 * @hidden
 */
internal class TransitionValues(val view: View) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property values
	 * @since 0.1.0
	 * @hidden
	 */
	internal var values: MutableMap<String, Any> = mutableMapOf()
}