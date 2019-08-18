package ca.logaritm.dezel.core

/**
 * @class JavaScriptSetterWrapper
 * @since 0.1.0
 * @hidden
 */
internal class JavaScriptSetterWrapper(callback: JavaScriptSetterHandler) {

	private val callback: JavaScriptSetterHandler

	init {
		this.callback = callback
	}

	public fun execute(callback: JavaScriptSetterCallback) {
		this.callback(callback)
	}
}