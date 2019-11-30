/**
 * @class JavaScriptFinalizeWrapper
 * @since 0.1.0
 * @hidden
 */
internal final class JavaScriptFinalizeWrapper {

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
	 * @property handler
	 * @since 0.1.0
	 * @hidden
	 */
	internal var handler: JavaScriptFinalizeHandler

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	internal init(context: JavaScriptContext, handle: JSValueRef, handler: @escaping JavaScriptFinalizeHandler) {

		self.context = context
		self.handler = handler

		JavaScriptValueSetFinalizeHandler(context.handle, handle, javaScriptFinalizeWrapperCallback)
		JavaScriptValueSetAttribute(context.handle, handle, kFinalizeWrapperKey, Unmanaged.passRetained(self).toOpaque())
	}
}

/**
 * @function javaScriptFinalizeWrapperCallback
 * @since 0.7.0
 * @hidden
 */
private let javaScriptFinalizeWrapperCallback : @convention(c) (JSContextRef?, JavaScriptValueDataRef?) -> Void = { context, handle in

	let wrapper = Unmanaged<JavaScriptFinalizeWrapper>.fromOpaque(
		JavaScriptValueDataGetAttribute(handle, kFinalizeWrapperKey)
	).takeRetainedValue()

	wrapper.handler(JavaScriptFinalizeCallback(context: wrapper.context, handle: handle!))

	JavaScriptValueDataSetAttribute(handle, kFinalizeWrapperKey, nil)
}
