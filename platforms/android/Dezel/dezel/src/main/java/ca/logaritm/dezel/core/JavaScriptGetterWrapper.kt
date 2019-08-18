package ca.logaritm.dezel.core

/**
 * @class JavaScriptGetterWrapper
 * @since 0.1.0
 * @hidden
 */
internal class JavaScriptGetterWrapper(callback: JavaScriptGetterHandler) {

	private val callback: JavaScriptGetterHandler

	init {
		this.callback = callback
	}

	public fun execute(callback: JavaScriptGetterCallback) {
		this.callback(callback)
	}
}