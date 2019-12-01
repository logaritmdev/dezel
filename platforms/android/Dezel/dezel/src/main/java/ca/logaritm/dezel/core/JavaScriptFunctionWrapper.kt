package ca.logaritm.dezel.core

/**
 * @class JavaScriptFunctionWrapper
 * @since 0.1.0
 * @hidden
 */
internal class JavaScriptFunctionWrapper(handler: JavaScriptFunctionHandler) {

	/**
	 * @property handler
	 * @since 0.1.0
	 * @hidden
	 */
	private val handler: JavaScriptFunctionHandler

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
	public fun execute(callback: JavaScriptFunctionCallback) {
		this.handler(callback)
	}
}