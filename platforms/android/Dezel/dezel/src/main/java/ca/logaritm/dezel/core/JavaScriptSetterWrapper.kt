package ca.logaritm.dezel.core

/**
 * @class JavaScriptSetterWrapper
 * @since 0.1.0
 * @hidden
 */
internal class JavaScriptSetterWrapper(handler: JavaScriptSetterHandler) {

	private val handler: JavaScriptSetterHandler

	init {
		this.handler = handler
	}

	public fun execute(callback: JavaScriptSetterCallback) {
		this.handler(callback)
	}
}