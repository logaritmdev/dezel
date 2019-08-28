/**
 * @class JavaScriptSetterWrapper
 * @since 0.1.0
 * @hidden
 */
internal final class JavaScriptSetterWrapper: NSObject {

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

		let function = DLValueCreateFunction(context.handle, JavaScriptSetterWrapperCallback, nil)

		self.context = context
		self.handler = handler
		self.function = function

		super.init()

		DLValueSetFinalizeHandler(context.handle, function, JavaScriptSetterWrapperFinalize)
		DLValueSetAssociatedObject(context.handle, function, Unmanaged.passRetained(self).toOpaque())
	}
}

/**
 * @since 0.1.0
 * @hidden
 */
private let JavaScriptSetterWrapperCallback: @convention(c) (JSContextRef?, JSObjectRef?, JSObjectRef?, Int, UnsafePointer<JSValueRef?>?) -> JSValueRef? = { context, object, callee, argc, argv in

	let context = context!
	let object = object!
	let callee = callee!
	let argv = argv!
	let argc = argc

	let wrapper = Unmanaged<JavaScriptSetterWrapper>.fromOpaque(DLValueGetAssociatedObject(context, callee)).takeUnretainedValue()

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
 * @since 0.1.0
 * @hidden
 */
private let JavaScriptSetterWrapperFinalize: @convention(c) (JSContextRef?, DLValueDataRef?) -> Void = { context, handle in
	Unmanaged<JavaScriptSetterWrapper>.fromOpaque(DLValueDataGetAssociatedObject(handle!)).release()
}
