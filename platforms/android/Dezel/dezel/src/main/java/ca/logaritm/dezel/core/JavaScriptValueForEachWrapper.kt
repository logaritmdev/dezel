package ca.logaritm.dezel.core

/**
 * @class JavaScriptValueForEachWrapper
 * @since 0.7.0
 * @hidden
 */
public class JavaScriptValueForEachWrapper(context: JavaScriptContext, handler: JavaScriptForEachHandler) {

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
	public var handler: JavaScriptForEachHandler

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
	public fun execute(key: Int, value: Long) {
		this.handler(key, JavaScriptValue.create(this.context, value))
	}
}