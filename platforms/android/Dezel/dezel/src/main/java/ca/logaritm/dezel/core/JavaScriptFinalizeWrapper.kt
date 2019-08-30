package ca.logaritm.dezel.core

/**
 * @class JavaScriptFinalizeWrapper
 * @since 0.1.0
 */
internal class JavaScriptFinalizeWrapper(handler: JavaScriptFinalizeHandler) {

	private val handler: JavaScriptFinalizeHandler

	init {
		this.handler = handler
	}

	public fun execute(handler: JavaScriptFinalizeCallback) {
		this.handler(handler)
	}
}