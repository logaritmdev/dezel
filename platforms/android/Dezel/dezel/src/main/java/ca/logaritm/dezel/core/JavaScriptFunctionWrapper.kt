package ca.logaritm.dezel.core

/**
 * @class JavaScriptFunctionWrapper
 * @since 0.1.0
 * @hidden
 */
internal class JavaScriptFunctionWrapper(callback: JavaScriptFunctionHandler) {

	private val callback: JavaScriptFunctionHandler

	init {
		this.callback = callback
	}

	public fun execute(callback: JavaScriptFunctionCallback) {
		this.callback(callback)
	}
}