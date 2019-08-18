package ca.logaritm.dezel.core

/**
 * @class JavaScriptFinalizeWrapper
 * @since 0.1.0
 */
internal class JavaScriptFinalizeWrapper(callback: JavaScriptFinalizeHandler) {

	private val callback: JavaScriptFinalizeHandler

	init {
		this.callback = callback
	}

	public fun execute(handler: JavaScriptFinalizeCallback) {
		this.callback(handler)
	}
}