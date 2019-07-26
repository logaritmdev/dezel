package ca.logaritm.dezel.core

import android.util.Log

/**
 * @class JavaScriptFunctionWrapper
 * @since 0.1.0
 * @hidden
 */
internal class JavaScriptFunctionWrapper(handler: JavaScriptFunctionHandler) {

	private val handler: JavaScriptFunctionHandler

	init {
		this.handler = handler
	}

	public fun execute(callback: JavaScriptFunctionCallback) {
		this.handler(callback)
	}
}