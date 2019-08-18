package ca.logaritm.dezel.core

/**
 * @class JavaScriptValueForOwnWrapper
 * @since 0.7.0
 * @hidden
 */
internal class JavaScriptValueForOwnWrapper(context: JavaScriptContext, callback: JavaScriptForOwnHandler) {

	/**
	 * @property context
	 * @since 0.7.0
	 * @hidden
	 */
	public var context: JavaScriptContext

	/**
	 * @property callback
	 * @since 0.7.0
	 * @hidden
	 */
	public var callback: JavaScriptForOwnHandler

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	init {
		this.context = context
		this.callback = callback
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	public fun execute(key: String, value: Long) {
		this.callback(key, JavaScriptValue.create(this.context, value))
	}
}