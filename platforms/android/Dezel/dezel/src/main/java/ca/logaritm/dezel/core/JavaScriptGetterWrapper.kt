package ca.logaritm.dezel.core

/**
 * @class JavaScriptGetterWrapper
 * @since 0.1.0
 * @hidden
 */
internal class JavaScriptGetterWrapper(handler: JavaScriptGetterHandler) {

	private val handler: JavaScriptGetterHandler

	init {
		this.handler = handler
	}

	public fun execute(callback: JavaScriptGetterCallback) {
		this.handler(callback)
	}
}