/**
 * @class JavaScriptFinalizeWrapper
 * @since 0.1.0
 * @hidden
 */
internal final class JavaScriptFinalizeWrapper: NSObject {

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

		super.init()

		JavaScriptValueSetFinalizeHandler(context.handle, handle, JavaScriptFinalizeWrapperCallback)
		JavaScriptValueSetAttribute(context.handle, handle, kFinalizeWrapperKey, Unmanaged.passRetained(self).toOpaque())
	}
}

/**
 * @since 0.1.0
 * @hidden
 */
private let JavaScriptFinalizeWrapperCallback : @convention(c) (JSContextRef?, JavaScriptValueDataRef?) -> Void = { context, handle in

	let wrapper = Unmanaged<JavaScriptFinalizeWrapper>.fromOpaque(
		JavaScriptValueDataGetAttribute(handle, kFinalizeWrapperKey)
	).takeRetainedValue()

	wrapper.handler(JavaScriptFinalizeCallback(context: wrapper.context, handle: handle!))

	JavaScriptValueDataSetAttribute(handle, kFinalizeWrapperKey, nil)
}
