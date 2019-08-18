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
		return if (index < this.argc) JavaScriptValue.create(this.context, this.argv[index]) else this.context.jsundefined
	}

	/**
	 * Returns an argument at a specified index.
	 * @method argument
	 * @since 0.1.0
	 */
	public fun argument(index: Int, protect: Boolean): JavaScriptValue {
		return if (index < this.argc) JavaScriptValue.create(this.context, this.argv[index], protect) else this.context.jsundefined
	}
}