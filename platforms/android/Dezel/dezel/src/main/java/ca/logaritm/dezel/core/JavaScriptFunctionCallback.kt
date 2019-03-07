package ca.logaritm.dezel.core

/**
 * The arguments object provided to a function.
 * @class JavaScriptFunctionCallback
 * @since 0.1.0
 */
public class JavaScriptFunctionCallback(context: JavaScriptContext, target: Long, callee: Long, argc: Int, argv: LongArray) : JavaScriptCallback(context, target, callee, argc, argv) {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Returns an argument at a specified index.
	 * @method argument
	 * @since 0.1.0
	 */
	public fun argument(index: Int): JavaScriptValue {
		return JavaScriptValue.create(this.context, this.argv[index])
	}

	/**
	 * Returns an argument at a specified index.
	 * @method argument
	 * @since 0.1.0
	 */
	public fun argument(index: Int, protect: Boolean): JavaScriptValue {
		return JavaScriptValue.create(this.context, this.argv[index], protect)
	}
}