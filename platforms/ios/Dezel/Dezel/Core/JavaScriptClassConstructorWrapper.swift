/**
 * @class JavaScriptClassConstructorWrapper
 * @since 0.1.0
 * @hidden
 */
internal final class JavaScriptClassConstructorWrapper {

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

		let function = JavaScriptValueCreateFunction(context.handle, javaScriptClassConstructorWrapperCallback, name)

		self.context = context
		self.function = function
		self.cls = cls
		self.sel = sel
		self.imp = imp

		JavaScriptValueSetFinalizeHandler(context.handle, function, javaScriptClassConstructorWrapperFinalize)
		JavaScriptValueSetAssociatedObject(context.handle, function, Unmanaged.passRetained(self).toOpaque())
	}
}

/**
 * @function javaScriptClassConstructorWrapperCallback
 * @since 0.7.0
 * @hidden
 */
private let javaScriptClassConstructorWrapperCallback: @convention(c) (JSContextRef?, JSObjectRef?, JSObjectRef?, Int, UnsafePointer<JSValueRef?>?) -> JSValueRef? = { context, object, callee, argc, argv in

	let context = context!
	let object = object!
	let callee = callee!
	let argv = argv!

	let wrapper = Unmanaged<JavaScriptClassConstructorWrapper>.fromOpaque(
		JavaScriptValueGetAssociatedObject(context, callee)
	).takeUnretainedValue()

	guard let klass = wrapper.cls as? JavaScriptClass.Type else {
		fatalError("Error creating object instance. Expected JavaScriptClass, found \(wrapper.cls)")
	}

	let instance = klass.init(context: wrapper.context)

	instance.reset(
		object,
		protect: false
	)

	JavaScriptValueSetAssociatedObject(context, object, UnsafeMutableRawPointer(Unmanaged.passRetained(instance).toOpaque()))

	let callback = JavaScriptFunctionCallback(
		context: wrapper.context,
		target: object,
		callee: callee,
		argc: argc,
		argv: argv
	)

	objc_callMethod(
		wrapper.sel,
		wrapper.imp,
		instance,
		callback
	)

	return object
}

/**
 * @function javaScriptClassConstructorWrapperFinalize
 * @since 0.7.0
 * @hidden
 */
private let javaScriptClassConstructorWrapperFinalize: @convention(c) (JSContextRef?, JavaScriptValueDataRef?) -> Void = { context, handle in
	Unmanaged<JavaScriptGetterWrapper>.fromOpaque(JavaScriptValueDataGetAssociatedObject(handle!)).release()
}
