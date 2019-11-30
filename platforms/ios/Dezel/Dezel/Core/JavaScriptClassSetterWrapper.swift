/**
 * @class JavaScriptClassSetterWrapper
 * @since 0.1.0
 * @hidden
 */
internal final class JavaScriptClassSetterWrapper {

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
	 * @property function
	 * @since 0.1.0
	 * @hidden
	 */
	private(set) internal var function: JSObjectRef!

	/**
	 * @property cls
	 * @since 0.1.0
	 * @hidden
	 */
	private(set) internal var cls: AnyClass

	/**
	 * @property sel
	 * @since 0.1.0
	 * @hidden
	 */
	private(set) internal var sel: Selector

	/**
	 * @property imp
	 * @since 0.1.0
	 * @hidden
	 */
	private(set) internal var imp: IMP

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	internal init(context: JavaScriptContext, cls: AnyClass, sel: Selector, imp: IMP, name: String) {

		let function = JavaScriptValueCreateFunction(context.handle, javaScriptClassSetterWrapperCallback, nil)

		self.context = context
		self.function = function
		self.cls = cls
		self.sel = sel
		self.imp = imp

		JavaScriptValueSetFinalizeHandler(context.handle, function, javaScriptClassSetterWrapperFinalize)
		JavaScriptValueSetAssociatedObject(context.handle, function, Unmanaged.passRetained(self).toOpaque())
	}
}

/**
 * @function javaScriptClassSetterWrapperCallback
 * @since 0.7.0
 * @hidden
 */
private let javaScriptClassSetterWrapperCallback: @convention(c) (JSContextRef?, JSObjectRef?, JSObjectRef?, Int, UnsafePointer<JSValueRef?>?) -> JSValueRef? = { context, object, callee, argc, argv in

	let context = context!
	let object = object!
	let callee = callee!
	let argv = argv!

	let wrapper = Unmanaged<JavaScriptClassSetterWrapper>.fromOpaque(
		JavaScriptValueGetAssociatedObject(context, callee)
	).takeUnretainedValue()

	guard let instance = JavaScriptValueGetAssociatedObject(context, object) else {
		return nil
	}

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
		Unmanaged<AnyObject>.fromOpaque(instance).takeUnretainedValue(),
		callback
	)

	return callback.result
}

/**
 * @function javaScriptClassSetterWrapperFinalize
 * @since 0.7.0
 * @hidden
 */
private let javaScriptClassSetterWrapperFinalize: @convention(c) (JSContextRef?, JavaScriptValueDataRef?) -> Void = { context, handle in
	Unmanaged<JavaScriptClassSetterWrapper>.fromOpaque(JavaScriptValueDataGetAssociatedObject(handle!)).release()
}
