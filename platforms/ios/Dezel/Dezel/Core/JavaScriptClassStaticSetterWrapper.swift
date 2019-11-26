/**
 * @class JavaScriptClassStaticSetterWrapper
 * @since 0.7.0
 * @hidden
 */
internal final class JavaScriptClassStaticSetterWrapper: NSObject {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property context
	 * @since 0.7.0
	 * @hidden
	 */
	private(set) internal var context: JavaScriptContext

	/**
	 * @property function
	 * @since 0.7.0
	 * @hidden
	 */
	private(set) internal var function: JSObjectRef!

	/**
	 * @property cls
	 * @since 0.7.0
	 * @hidden
	 */
	private(set) internal var cls: AnyClass

	/**
	 * @property sel
	 * @since 0.7.0
	 * @hidden
	 */
	private(set) internal var sel: Selector

	/**
	 * @property imp
	 * @since 0.7.0
	 * @hidden
	 */
	private(set) internal var imp: IMP

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	internal init(context: JavaScriptContext, cls: AnyClass, sel: Selector, imp: IMP, name: String) {

		let function = JavaScriptValueCreateFunction(context.handle, javaScriptClassStaticSetterWrapperCallback, nil)

		self.context = context
		self.function = function
		self.cls = cls
		self.sel = sel
		self.imp = imp

		super.init()

		JavaScriptValueSetFinalizeHandler(context.handle, function, javaScriptClassStaticSetterWrapperFinalize)
		JavaScriptValueSetAssociatedObject(context.handle, function, Unmanaged.passRetained(self).toOpaque())
	}
}

/**
 * @function javaScriptClassStaticSetterWrapperCallback
 * @since 0.7.0
 * @hidden
 */
private let javaScriptClassStaticSetterWrapperCallback: @convention(c) (JSContextRef?, JSObjectRef?, JSObjectRef?, Int, UnsafePointer<JSValueRef?>?) -> JSValueRef? = { context, object, callee, argc, argv in

	let context = context!
	let object = object!
	let callee = callee!
	let argv = argv!

	let wrapper = Unmanaged<JavaScriptClassStaticSetterWrapper>.fromOpaque(
		JavaScriptValueGetAssociatedObject(context, callee)
	).takeUnretainedValue()

	let callback = JavaScriptSetterCallback(
		context: wrapper.context,
		target: object,
		callee: callee,
		argc: argc,
		argv: argv
	)

	objc_callMethod(
		wrapper.sel,
		wrapper.imp,
		nil,
		callback
	)

	return callback.result
}

/**
 * @function javaScriptClassStaticSetterWrapperFinalize
 * @since 0.7.0
 * @hidden
 */
private let javaScriptClassStaticSetterWrapperFinalize: @convention(c) (JSContextRef?, JavaScriptValueDataRef?) -> Void = { context, handle in
	Unmanaged<JavaScriptClassStaticSetterWrapper>.fromOpaque(JavaScriptValueDataGetAssociatedObject(handle!)).release()
}
