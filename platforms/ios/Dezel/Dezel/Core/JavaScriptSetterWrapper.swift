/**
 * @class JavaScriptSetterWrapper
 * @since 0.1.0
 * @hidden
 */
internal final class JavaScriptSetterWrapper {

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
	internal var handler: JavaScriptSetterHandler

	/**
	 * @property function
	 * @since 0.1.0
	 * @hidden
	 */
	internal var function: JSObjectRef!

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	internal init(context: JavaScriptContext, handler: @escaping JavaScriptSetterHandler) {

		let function = JavaScriptValueCreateFunction(context.handle, javaScriptSetterWrapperCallback, nil)

		self.context = context
		self.handler = handler
		self.function = function

		JavaScriptValueSetFinalizeHandler(context.handle, function, javaScriptSetterWrapperFinalize)
		JavaScriptValueSetAssociatedObject(context.handle, function, Unmanaged.passRetained(self).toOpaque())
	}
}

/**
 * @function javaScriptSetterWrapperCallback
 * @since 0.7.0
 * @hidden
 */
private let javaScriptSetterWrapperCallback: @convention(c) (JSContextRef?, JSObjectRef?, JSObjectRef?, Int, UnsafePointer<JSValueRef?>?) -> JSValueRef? = { context, object, callee, argc, argv in

	let context = context!
	let object = object!
	let callee = callee!
	let argv = argv!
	let argc = argc

	let wrapper = Unmanaged<JavaScriptSetterWrapper>.fromOpaque(JavaScriptValueGetAssociatedObject(context, callee)).takeUnretainedValue()

	let arguments = JavaScriptSetterCallback(
		context: wrapper.context,
		target: object,
		callee: callee,
		argc: argc,
		argv: argv
	)

	wrapper.handler(arguments)

	return nil
}

/**
 * @function javaScriptSetterWrapperFinalize
 * @since 0.7.0
 * @hidden
 */
private let javaScriptSetterWrapperFinalize: @convention(c) (JSContextRef?, JavaScriptValueDataRef?) -> Void = { context, handle in
	Unmanaged<JavaScriptSetterWrapper>.fromOpaque(JavaScriptValueDataGetAssociatedObject(handle!)).release()
}
