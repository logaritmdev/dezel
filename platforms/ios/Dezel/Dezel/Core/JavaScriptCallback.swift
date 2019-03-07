/**
 * The base class for callbacks.
 * @class JavaScriptCallback
 * @since 0.1.0
 */
open class JavaScriptCallback: NSObject {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The callback context.
	 * @property context
	 * @since 0.1.0
	 */
	private(set) public var context: JavaScriptContext

	/**
	 * The callback object.
	 * @property target
	 * @since 0.1.0
	 */
	private(set) public lazy var target: JavaScriptValue = {
		return JavaScriptValue.create(self.context, handle: self.callbackTarget, protect: false)
	}()

	/**
	 * The callback function.
	 * @property callee
	 * @since 0.1.0
	 */
	private(set) public lazy var callee: JavaScriptValue = {
		return JavaScriptValue.create(self.context, handle: self.callbackCallee, protect: false)
	}()

	/**
	 * The callback argument length.
	 * @property arguments
	 * @since 0.1.0
	 */
	private(set) public var arguments: Int

	/**
	 * @property argc
	 * @since 0.1.0
	 * @hidden
	 */
	private(set) internal var argc: Int

	/**
	 * @property argv
	 * @since 0.1.0
	 * @hidden
	 */
	private(set) internal var argv: UnsafePointer<JSValueRef?>

	/**
	 * @property result
	 * @since 0.1.0
	 * @hidden
	 */
	private(set) internal var result: JSValueRef?

	/**
	 * @property callbackTarget
	 * @since 0.2.0
	 * @hidden
	 */
	private var callbackTarget: JSObjectRef

	/**
	 * @property callbackCallee
	 * @since 0.2.0
	 * @hidden
	 */
	private var callbackCallee: JSObjectRef

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
     * @constructor
     * @since 0.1.0
	 * @hidden
     */
	public init(context: JavaScriptContext, target: JSObjectRef, callee: JSObjectRef, argc: Int, argv: UnsafePointer<JSValueRef?>) {

		self.context = context

		self.callbackTarget = target
		self.callbackCallee = callee
		self.arguments = argc

		self.argc = argc
		self.argv = argv
	}

	/**
	 * Assigns the callback's return value.
	 * @method returns
	 * @since 0.1.0
	 */
	final public func returns(_ value: JavaScriptValue?) {
		self.result = toHandleO(value)
	}

	/**
	 * Assigns the callback's return value using a property.
	 * @method returns
	 * @since 0.1.0
	 */
	final public func returns(_ property: Property) {
		self.result = property.value(in: self.context).handle
	}

	/**
	 * Assigns the callback's return value using a string.
	 * @method returns
	 * @since 0.1.0
	 */
	final public func returns(string value: String) {
		self.result = DLValueCreateString(self.context.handle, value)
	}

	/**
	 * Assigns the callback's return value using a number.
	 * @method returns
	 * @since 0.1.0
	 */
	final public func returns(number value: Double) {
		self.result = DLValueCreateNumber(self.context.handle, value)
	}

	/**
	 * Assigns the callback's return value using a number.
	 * @method returns
	 * @since 0.3.0
	 */
	final public func returns(number value: Float) {
		self.result = DLValueCreateNumber(self.context.handle, Double(value))
	}

	/**
	 * Assigns the callback's return value using a number.
	 * @method returns
	 * @since 0.3.0
	 */
	final public func returns(number value: Int) {
		self.result = DLValueCreateNumber(self.context.handle, Double(value))
	}

	/**
	 * Assigns the callback's return value using a boolean.
	 * @method returns
	 * @since 0.1.0
	 */
	final public func returns(boolean value: Bool) {
		self.result = DLValueCreateBoolean(self.context.handle, value)
	}
}
