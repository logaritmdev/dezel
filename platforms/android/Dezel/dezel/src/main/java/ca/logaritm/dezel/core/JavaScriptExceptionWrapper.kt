package ca.logaritm.dezel.core

/**
 * @class JavaScriptExceptionWrapper
 * @since 0.1.0
 */
internal class JavaScriptExceptionWrapper(handler: JavaScriptExceptionHandler) {

	/**
	 * @property handler
	 * @since 0.7.0
	 * @hidden
	 */
	private val handler: JavaScriptExceptionHandler

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	init {
		this.handler = handler
	}

	/**
	 * @method execute
	 * @since 0.1.0
	 */
	public fun execute(error: JavaScriptValue) {
		this.handler(error)
	}
}