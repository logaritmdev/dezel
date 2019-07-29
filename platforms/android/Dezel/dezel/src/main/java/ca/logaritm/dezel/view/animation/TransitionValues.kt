package ca.logaritm.dezel.view.animation

import ca.logaritm.dezel.modules.view.JavaScriptView

/**
 * @class TransitionValues
 * @since 0.1.0
 * @hidden
 */
internal class TransitionValues(val view: JavaScriptView) {

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