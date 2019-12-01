package ca.logaritm.dezel.core

/**
 * @class JavaScriptSetterWrapper
 * @since 0.1.0
 * @hidden
 */
internal class JavaScriptSetterWrapper(handler: JavaScriptSetterHandler) {

	/**
	 * @property handler
	 * @since 0.1.0
	 * @hidden
	 */
	private val handler: JavaScriptSetterHandler

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
	public fun execute(callback: JavaScriptSetterCallback) {
		this.handler(callback)
	}
}