package ca.logaritm.dezel.core

/**
 * @class JavaScriptValueForEachWrapper
 * @since 0.7.0
 * @hidden
 */
public class JavaScriptValueForEachWrapper(context: JavaScriptContext, callback: JavaScriptForEachHandler) {

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
	public var callback: JavaScriptForEachHandler

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
	public fun execute(key: Int, value: Long) {
		this.callback(key, JavaScriptValue.create(this.context, value))
	}
}