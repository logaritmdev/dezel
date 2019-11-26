/**
 * @class JavaScriptFunctionCallback
 * @super JavaScriptCallback
 * @since 0.1.0
 */
public final class JavaScriptFunctionCallback: JavaScriptCallback {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method argument
	 * @since 0.1.0
	 */
	final public func argument(_ index: Int) -> JavaScriptValue {

		guard let handle = self.argv[index] else {
			return self.context.jsundefined
		}

		return JavaScriptValue.create(self.context, handle: handle)
	}

	/**
	 * @method argument
	 * @since 0.1.0
	 */
	final public func argument(_ index: Int, protect: Bool) -> JavaScriptValue {

		guard let handle = self.argv[index] else {
			return self.context.jsundefined
		}

		return JavaScriptValue.create(self.context, handle: handle, protect: protect)
	}
}
