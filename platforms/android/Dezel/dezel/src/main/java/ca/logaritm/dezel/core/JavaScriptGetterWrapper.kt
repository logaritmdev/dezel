package ca.logaritm.dezel.core

/**
 * @class JavaScriptGetterWrapper
 * @since 0.1.0
 * @hidden
 */
internal class JavaScriptGetterWrapper(handler: JavaScriptGetterHandler) {

	/**
	 * @property handler
	 * @since 0.1.0
	 * @hidden
	 */
	private val handler: JavaScriptGetterHandler

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
	public fun execute(callback: JavaScriptGetterCallback) {
		this.handler(callback)
	}
}