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
	final public func argument(_ index: Int, protect: Bool = true) -> JavaScriptValue {

		guard let handle = self.argv[index] else {
			return self.context.Undefined
		}

		return JavaScriptValue.create(self.context, handle: handle, bridge: true, protect: protect)
	}
}
