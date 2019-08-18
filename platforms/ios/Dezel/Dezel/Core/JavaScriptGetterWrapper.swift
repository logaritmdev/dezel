/**
 * @class JavaScriptGetterWrapper
 * @since 0.1.0
 * @hidden
 */
public final class JavaScriptGetterWrapper: NSObject {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property context
	 * @since 0.1.0
	 * @hidden
	 */
	private(set) internal var context: JavaScriptContext

	/**
	 * @property callback
	 * @since 0.1.0
	 * @hidden
	 */
	private(set) internal var callback: JavaScriptGetterHandler

	/**
	 * @property function
	 * @since 0.1.0
	 * @hidden
	 */
	private(set) internal var function: JSObjectRef!

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	public init(context: JavaScriptContext, callback: @escaping JavaScriptGetterHandler) {

		let function = DLValueCreateFunction(context.handle, JavaScriptGetterWrapperCallback, nil)

		self.context = context
		self.callback = callback
		self.function = function

		super.init()

		DLValueSetFinalizeHandler(context.handle, function, JavaScriptGetterWrapperFinalize)
		DLValueSetAssociatedObject(context.handle, function, Unmanaged.passRetained(self).toOpaque())
	}
}

/**
 * @since 0.1.0
 * @hidden
 */
private let JavaScriptGetterWrapperCallback: @convention(c) (JSContextRef?, JSObjectRef?, JSObjectRef?, Int, UnsafePointer<JSValueRef?>?) -> JSValueRef? = { context, object, callee, argc, argv in

	let context = context!
	let object = object!
	let callee = callee!
	let argv = argv!

	let wrapper = Unmanaged<JavaScriptGetterWrapper>.fromOpaque(DLValueGetAssociatedObject(context, callee)).takeUnretainedValue()

	let callback = JavaScriptGetterCallback(
		context: wrapper.context,
		target: object,
		callee: callee,
		argc: argc,
		argv: argv
	)

	wrapper.callback(callback)

	return callback.result
}

/**
 * @since 0.1.0
 * @hidden
 */
private let JavaScriptGetterWrapperFinalize: @convention(c) (JSContextRef?, DLValueDataRef?) -> Void = { context, handle in
	Unmanaged<JavaScriptGetterWrapper>.fromOpaque(DLValueDataGetAssociatedObject(handle!)).release()
}
