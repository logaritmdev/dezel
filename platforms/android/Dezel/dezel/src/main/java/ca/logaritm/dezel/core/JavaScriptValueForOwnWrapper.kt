package ca.logaritm.dezel.core

/**
 * @class JavaScriptValueForOwnWrapper
 * @since 0.7.0
 * @hidden
 */
internal class JavaScriptValueForOwnWrapper(context: JavaScriptContext, handler: JavaScriptForOwnHandler) {

	/**
	 * @property context
	 * @since 0.7.0
	 * @hidden
	 */
	public var context: JavaScriptContext

	/**
	 * @property handler
	 * @since 0.7.0
	 * @hidden
	 */
	public var handler: JavaScriptForOwnHandler

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	init {
		this.context = context
		this.handler = handler
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	public fun execute(key: String, value: Long) {
		this.handler(key, JavaScriptValue.create(this.context, value))
	}
}