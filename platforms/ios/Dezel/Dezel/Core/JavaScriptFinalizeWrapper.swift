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
	 * @property callback
	 * @since 0.1.0
	 * @hidden
	 */
	internal var callback: JavaScriptFinalizeHandler

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	internal init(context: JavaScriptContext, handle: JSValueRef, callback: @escaping JavaScriptFinalizeHandler) {

		self.context = context
		self.callback = callback

		super.init()

		DLValueSetFinalizeHandler(context.handle, handle, JavaScriptFinalizeWrapperCallback)
		DLValueSetAttribute(context.handle, handle, kFinalizeWrapperKey, Unmanaged.passRetained(self).toOpaque())
	}
}

/**
 * @since 0.1.0
 * @hidden
 */
private let JavaScriptFinalizeWrapperCallback : @convention(c) (JSContextRef?, DLValueDataRef?) -> Void = { context, handle in

	let wrapper = Unmanaged<JavaScriptFinalizeWrapper>.fromOpaque(
		DLValueDataGetAttribute(handle, kFinalizeWrapperKey)
	).takeRetainedValue()

	wrapper.callback(JavaScriptFinalizeCallback(context: wrapper.context, handle: handle!))

	DLValueDataSetAttribute(handle, kFinalizeWrapperKey, nil)
}
