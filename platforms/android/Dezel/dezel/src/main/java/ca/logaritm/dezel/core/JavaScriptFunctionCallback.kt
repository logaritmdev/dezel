package ca.logaritm.dezel.core

/**
 * @class JavaScriptFunctionCallback
 * @super JavascriptCallback
 * @since 0.1.0
 */
public class JavaScriptFunctionCallback(context: JavaScriptContext, target: Long, callee: Long, argc: Int, argv: LongArray) : JavaScriptCallback(context, target, callee, argc, argv) {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method argument
	 * @since 0.1.0
	 */
	public fun argument(index: Int, protect: Boolean = true): JavaScriptValue {
		return if (index < this.argc) JavaScriptValue.create(this.context, this.argv[index], bridge = true) else this.context.Undefined
	}
}