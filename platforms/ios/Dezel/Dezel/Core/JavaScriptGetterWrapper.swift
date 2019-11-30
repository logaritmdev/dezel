/**
 * @class JavaScriptGetterWrapper
 * @since 0.1.0
 * @hidden
 */
public final class JavaScriptGetterWrapper {

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
	internal var handler: JavaScriptGetterHandler

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
	public init(context: JavaScriptContext, handler: @escaping JavaScriptGetterHandler) {

		let function = JavaScriptValueCreateFunction(context.handle, javaScriptGetterWrapperCallback, nil)

		self.context = context
		self.handler = handler
		self.function = function

		JavaScriptValueSetFinalizeHandler(context.handle, function, javaScriptGetterWrapperFinalize)
		JavaScriptValueSetAssociatedObject(context.handle, function, Unmanaged.passRetained(self).toOpaque())
	}
}

/**
 * @function javaScriptGetterWrapperCallback
 * @since 0.7.0
 * @hidden
 */
private let javaScriptGetterWrapperCallback: @convention(c) (JSContextRef?, JSObjectRef?, JSObjectRef?, Int, UnsafePointer<JSValueRef?>?) -> JSValueRef? = { context, object, callee, argc, argv in

	let context = context!
	let object = object!
	let callee = callee!
	let argv = argv!

	let wrapper = Unmanaged<JavaScriptGetterWrapper>.fromOpaque(JavaScriptValueGetAssociatedObject(context, callee)).takeUnretainedValue()

	let callback = JavaScriptGetterCallback(
		context: wrapper.context,
		target: object,
		callee: callee,
		argc: argc,
		argv: argv
	)

	wrapper.handler(callback)

	return callback.result
}

/**
 * @function javaScriptGetterWrapperFinalize
 * @since 0.7.0
 * @hidden
 */
private let javaScriptGetterWrapperFinalize: @convention(c) (JSContextRef?, JavaScriptValueDataRef?) -> Void = { context, handle in
	Unmanaged<JavaScriptGetterWrapper>.fromOpaque(JavaScriptValueDataGetAssociatedObject(handle!)).release()
}
