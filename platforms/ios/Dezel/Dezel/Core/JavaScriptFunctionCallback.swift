/**
 * The arguments object provided to a function.
 * @class JavaScriptFunctionCallback
 * @since 0.1.0
 */
public final class JavaScriptFunctionCallback: JavaScriptCallback {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * Returns an argument at a specified index.
	 * @method argument
	 * @since 0.1.0
	 */
	final public func argument(_ index: Int) -> JavaScriptValue {
		return index < self.argc ? JavaScriptValue.create(self.context, handle: self.argv[index]!) : self.context.jsundefined
	}

	/**
	 * Returns an argument at a specified index.
	 * @method argument
	 * @since 0.1.0
	 */
	final public func argument(_ index: Int, protect: Bool) -> JavaScriptValue {
		return index < self.argc ? JavaScriptValue.create(self.context, handle: self.argv[index]!, protect: protect) : self.context.jsundefined
	}
}
