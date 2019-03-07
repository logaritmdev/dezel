package ca.logaritm.dezel.core

/**
 * The arguments object provided to property setter.
 * @class JavaScriptSetterCallback
 * @since 0.1.0
 */
public class JavaScriptSetterCallback(context: JavaScriptContext, target: Long, callee: Long, argc: Int, argv: LongArray) : JavaScriptCallback(context, target, callee, argc, argv) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * Returns the property setter's handle.
	 * @property value
	 * @since 0.1.0
	 */
	public val value: JavaScriptValue by lazy {
		JavaScriptValue.create(this.context, this.argv[0])
	}
}