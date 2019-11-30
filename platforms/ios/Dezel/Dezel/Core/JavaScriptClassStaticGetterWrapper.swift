/**
 * @class JavaScriptClassStaticGetterWrapper
 * @since 0.7.0
 * @hidden
 */
internal final class JavaScriptClassStaticGetterWrapper {

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

		let function = JavaScriptValueCreateFunction(context.handle, javaScriptClassStaticGetterWrapperCallback, nil)

		self.context = context
		self.function = function
		self.cls = cls
		self.sel = sel
		self.imp = imp

		JavaScriptValueSetFinalizeHandler(context.handle, function, javaScriptClassStaticGetterWrapperFinalize)
		JavaScriptValueSetAssociatedObject(context.handle, function, Unmanaged.passRetained(self).toOpaque())
	}
}

/**
 * @function javaScriptClassStaticGetterWrapperCallback
 * @since 0.7.0
 * @hidden
 */
private let javaScriptClassStaticGetterWrapperCallback: @convention(c) (JSContextRef?, JSObjectRef?, JSObjectRef?, Int, UnsafePointer<JSValueRef?>?) -> JSValueRef? = { context, object, callee, argc, argv in

	let context = context!
	let object = object!
	let callee = callee!
	let argv = argv!

	let wrapper = Unmanaged<JavaScriptClassStaticGetterWrapper>.fromOpaque(
		JavaScriptValueGetAssociatedObject(context, callee)
	).takeUnretainedValue()

	let callback = JavaScriptGetterCallback(
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
 * @function javaScriptClassStaticGetterWrapperFinalize
 * @since 0.7.0
 * @hidden
 */
private let javaScriptClassStaticGetterWrapperFinalize: @convention(c) (JSContextRef?, JavaScriptValueDataRef?) -> Void = { context, handle in
	Unmanaged<JavaScriptClassStaticGetterWrapper>.fromOpaque(JavaScriptValueDataGetAssociatedObject(handle!)).release()
}
