/**
 * @class JavaScriptFunctionWrapper
 * @since 0.1.0
 * @hidden
 */
public final class JavaScriptFunctionWrapper: NSObject {

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
	internal var handler: JavaScriptFunctionHandler

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
	public init(context: JavaScriptContext, handler: @escaping JavaScriptFunctionHandler, name: String? = nil) {

		let function = JavaScriptValueCreateFunction(context.handle, javaScriptFunctionWrapperCallback, name)

		self.context = context
		self.handler = handler
		self.function = function

		super.init()

		JavaScriptValueSetFinalizeHandler(context.handle, function, javaScriptFunctionWrapperFinalize)
		JavaScriptValueSetAssociatedObject(context.handle, function, Unmanaged.passRetained(self).toOpaque())
	}
}

/**
 * @function javaScriptFunctionWrapperCallback
 * @since 0.7.0
 * @hidden
 */
private let javaScriptFunctionWrapperCallback: @convention(c) (JSContextRef?, JSObjectRef?, JSObjectRef?, Int, UnsafePointer<JSValueRef?>?) -> JSValueRef? = { context, object, callee, argc, argv in

	let context = context!
	let object = object!
	let callee = callee!
	let argv = argv!
	let argc = argc

	let wrapper = Unmanaged<JavaScriptFunctionWrapper>.fromOpaque(JavaScriptValueGetAssociatedObject(context, callee)).takeUnretainedValue()

	let argument = JavaScriptFunctionCallback(
		context: wrapper.context,
		target: object,
		callee: callee,
		argc: argc,
		argv: argv
	)

	wrapper.handler(argument)

	return argument.result
}

/**
 * @function javaScriptFunctionWrapperFinalize
 * @since 0.7.0
 * @hidden
 */
private let javaScriptFunctionWrapperFinalize: @convention(c) (JSContextRef?, JavaScriptValueDataRef?) -> Void = { context, handle in
	Unmanaged<JavaScriptFunctionWrapper>.fromOpaque(JavaScriptValueDataGetAssociatedObject(handle!)).release()
}
