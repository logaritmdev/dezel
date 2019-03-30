package ca.logaritm.dezel.core

import android.util.Log

/**
 * @class JavaScriptExceptionWrapper
 * @since 0.1.0
 */
internal class JavaScriptExceptionWrapper(handler: JavaScriptExceptionHandler) {

	private val handler: JavaScriptExceptionHandler

	init {
		this.handler = handler
	}

	public fun execute(error: JavaScriptValue) {
		this.handler(error)
	}
}