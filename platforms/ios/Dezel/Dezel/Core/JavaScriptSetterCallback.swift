/**
 * @class JavaScriptSetterCallback
 * @super JavaScriptCallback
 * @since 0.1.0
 */
public final class JavaScriptSetterCallback: JavaScriptCallback {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property value
	 * @since 0.1.0
	 */
	private(set) lazy public var value: JavaScriptValue = {
		return JavaScriptValue.create(self.context, handle: self.argv[0])
	}()
}
