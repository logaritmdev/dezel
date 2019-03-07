/**
 * @class JavaScriptClassSetterWrapper
 * @since 0.1.0
 * @hidden
 */
internal final class JavaScriptClassSetterWrapper: NSObject {

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

		let function = DLValueCreateFunction(context.handle, JavaScriptClassSetterWrapperCallback, nil)

		self.context = context
		self.function = function
		self.cls = cls
		self.sel = sel
		self.imp = imp

		super.init()

		DLValueSetFinalizeHandler(context.handle, function, JavaScriptClassSetterWrapperFinalize)
		DLValueSetAssociatedObject(context.handle, function, Unmanaged.passRetained(self).toOpaque())
	}
}

/**
 * @since 0.1.0
 * @hidden
 */
private let JavaScriptClassSetterWrapperCallback: @convention(c) (JSContextRef?, JSObjectRef?, JSObjectRef?, Int, UnsafePointer<JSValueRef?>?) -> JSValueRef? = { context, object, callee, argc, argv in

	let context = context!
	let object = object!
	let callee = callee!
	let argv = argv!

	let wrapper = Unmanaged<JavaScriptClassSetterWrapper>.fromOpaque(
		DLValueGetAssociatedObject(context, callee)
	).takeUnretainedValue()

	guard let instance = DLValueGetAssociatedObject(context, object) else {
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
 * @since 0.1.0
 * @hidden
 */
private let JavaScriptClassSetterWrapperFinalize: @convention(c) (JSContextRef?, DLValueDataRef?) -> Void = { context, handle in
	Unmanaged<JavaScriptClassSetterWrapper>.fromOpaque(DLValueDataGetAssociatedObject(handle!)).release()
}
