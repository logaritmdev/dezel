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

		let function = DLValueCreateFunction(context.handle, JavaScriptFunctionWrapperCallback, name)

		self.context = context
		self.handler = handler
		self.function = function

		super.init()

		DLValueSetFinalizeHandler(context.handle, function, JavaScriptFunctionWrapperFinalize)
		DLValueSetAssociatedObject(context.handle, function, Unmanaged.passRetained(self).toOpaque())
	}
}

/**
 * @since 0.1.0
 * @hidden
 */
private let JavaScriptFunctionWrapperCallback: @convention(c) (JSContextRef?, JSObjectRef?, JSObjectRef?, Int, UnsafePointer<JSValueRef?>?) -> JSValueRef? = { context, object, callee, argc, argv in

	let context = context!
	let object = object!
	let callee = callee!
	let argv = argv!
	let argc = argc

	let wrapper = Unmanaged<JavaScriptFunctionWrapper>.fromOpaque(DLValueGetAssociatedObject(context, callee)).takeUnretainedValue()

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
 * @since 0.1.0
 * @hidden
 */
private let JavaScriptFunctionWrapperFinalize: @convention(c) (JSContextRef?, DLValueDataRef?) -> Void = { context, handle in
	Unmanaged<JavaScriptFunctionWrapper>.fromOpaque(DLValueDataGetAssociatedObject(handle!)).release()
}
