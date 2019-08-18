/**
 * @class JavaScriptExceptionWrapper
 * @since 0.1.0
 * @hidden
 */
internal final class JavaScriptExceptionWrapper: NSObject {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property context
	 * @since 0.1.0
	 * @hidden
	 */
	internal var context: JavaScriptContext

	/**
	 * @property callback
	 * @since 0.1.0
	 * @hidden
	 */
	internal var callback: JavaScriptExceptionHandler

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	internal init(context: JavaScriptContext, callback: @escaping JavaScriptExceptionHandler) {
		self.context = context
		self.callback = callback
	}
}
