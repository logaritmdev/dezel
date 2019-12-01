package ca.logaritm.dezel.core

/**
 * @class JavaScriptFinalizeWrapper
 * @since 0.1.0
 */
internal class JavaScriptFinalizeWrapper(handler: JavaScriptFinalizeHandler) {

	/**
	 * @property handler
	 * @since 0.1.0
	 * @hidden
	 */
	private val handler: JavaScriptFinalizeHandler

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
	public fun execute(handler: JavaScriptFinalizeCallback) {
		this.handler(handler)
	}
}