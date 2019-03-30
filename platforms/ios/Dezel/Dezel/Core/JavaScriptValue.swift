/**
 * Contains a JavaScript value from the current context.
 * @class JavaScriptValue
 * @since 0.1.0
 */
open class JavaScriptValue : NSObject {

	//--------------------------------------------------------------------------
	// MARK: Class Methods
	//--------------------------------------------------------------------------

	/**
	 * @method createNull
	 * @since 0.1.0
	 * @hidden
	 */
	internal class func createNull(_ context: JavaScriptContext) -> JavaScriptValue {
		return JavaScriptValue.create(context, handle: DLValueCreateNull(context.handle))
	}

	/**
	 * @method createUndefined
	 * @since 0.1.0
	 * @hidden
	 */
	internal class func createUndefined(_ context: JavaScriptContext) -> JavaScriptValue {
		return JavaScriptValue.create(context, handle: DLValueCreateUndefined(context.handle))
	}

	/**
	 * @method createString
	 * @since 0.1.0
	 * @hidden
	 */
	internal class func createString(_ context: JavaScriptContext, value: String) -> JavaScriptValue {
		return JavaScriptValue.create(context, handle: DLValueCreateString(context.handle, value))
	}

	/**
	 * @method createNumber
	 * @since 0.1.0
	 * @hidden
	 */
	internal class func createNumber(_ context: JavaScriptContext, value: Double) -> JavaScriptValue {
		return JavaScriptValue.create(context, handle: DLValueCreateNumber(context.handle, value))
	}

	/**
	 * @method createBoolean
	 * @since 0.1.0
	 * @hidden
	 */
	internal class func createBoolean(_ context: JavaScriptContext, value: Bool) -> JavaScriptValue {
		return JavaScriptValue.create(context, handle: DLValueCreateBoolean(context.handle, value))
	}

	/**
	 * @method createEmptyObject
	 * @since 0.1.0
	 * @hidden
	 */
	internal class func createEmptyObject(_ context: JavaScriptContext) -> JavaScriptValue {
		return JavaScriptValue.create(context, handle: DLValueCreateEmptyObject(context.handle, nil))
	}

	/**
	 * @method createEmptyArray
	 * @since 0.1.0
	 * @hidden
	 */
	internal class func createEmptyArray(_ context: JavaScriptContext) -> JavaScriptValue {
		return JavaScriptValue.create(context, handle: DLValueCreateEmptyArray(context.handle))
	}

	/**
	 * @method createFunction
	 * @since 0.1.0
	 * @hidden
	 */
	internal class func createFunction(_ context: JavaScriptContext, handler: @escaping JavaScriptFunctionHandler) -> JavaScriptValue {
		return JavaScriptValue.create(context, handle: JavaScriptFunctionWrapper(context: context, handler: handler).function)
	}

	/**
	 * @method createFunction
	 * @since 0.1.0
	 * @hidden
	 */
	internal class func createFunction(_ context: JavaScriptContext, handler: @escaping JavaScriptFunctionHandler, name: String) -> JavaScriptValue {
		return JavaScriptValue.create(context, handle: JavaScriptFunctionWrapper(context: context, handler: handler, name: name).function)
	}

	/**
	 * @method createObject
	 * @since 0.1.0
	 * @hidden
	 */
	internal class func createObject(_ context: JavaScriptContext, template: AnyClass) -> JavaScriptValue {
		return JavaScriptObjectBuilder.build(context, template: template)
	}

	/**
	 * @method createClass
	 * @since 0.1.0
	 * @hidden
	 */
	internal class func createClass(_ context: JavaScriptContext, template: AnyClass) -> JavaScriptValue {
		return JavaScriptClassBuilder.build(context, template: template)
	}

	/**
	 * @method create
	 * @since 0.1.0
	 * @hidden
	 */
	internal class func create(_ context: JavaScriptContext, handle: JSValueRef!, protect: Bool = true) -> JavaScriptValue {
		let value = JavaScriptValue(context: context)
		value.reset(handle, protect: protect)
		return value
	}

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The value's context.
	 * @property context
	 * @since 0.1.0
	 */
	private(set) public var context: JavaScriptContext

	/**
	 * The value's handle.
	 * @property handle
	 * @since 0.1.0
	 */
	private(set) public var handle: JSValueRef!

	/**
	 * @property protected
	 * @since 0.1.0
	 * @hidden
	 */
	private var protected: Int = 0

	//--------------------------------------------------------------------------
	// MARK: Properties - Types
	//--------------------------------------------------------------------------

	/**
	 * Indicates whether the value is undefined.
	 * @property isUndefined
	 * @since 0.4.0
	 */
	public var isUndefined: Bool {
		return DLValueGetType(self.context.handle, self.handle) == 1
	}

	/**
	 * Indicates whether the value is null.
	 * @property isNull
	 * @since 0.4.0
	 */
	public var isNull: Bool {
		return DLValueGetType(self.context.handle, self.handle) == 2
	}

	/**
	 * Indicates whether the value is a boolean.
	 * @property isBoolean
	 * @since 0.4.0
	 */
	public var isBoolean: Bool {
		return DLValueGetType(self.context.handle, self.handle) == 3
	}

	/**
	 * Indicates whether the value is a number.
	 * @property isNumber
	 * @since 0.4.0
	 */
	public var isNumber: Bool {
		return DLValueGetType(self.context.handle, self.handle) == 4
	}

	/**
	 * Indicates whether the value is a string.
	 * @property isString
	 * @since 0.4.0
	 */
	public var isString: Bool {
		return DLValueGetType(self.context.handle, self.handle) == 5
	}

	/**
	 * Indicates whether the value is an object.
	 * @property isObject
	 * @since 0.4.0
	 */
	public var isObject: Bool {
		return DLValueGetType(self.context.handle, self.handle) == 6
	}

	/**
	 * Indicates whether the value is an array.
	 * @property isObject
	 * @since 0.4.0
	 */
	public var isArray: Bool {
		return DLValueGetType(self.context.handle, self.handle) == 7
	}

	/**
	 * Indicates whether the value is a function.
	 * @property isFunction
	 * @since 0.4.0
	 */
	public var isFunction: Bool {
		return DLValueGetType(self.context.handle, self.handle) == 8
	}

	//--------------------------------------------------------------------------
	// MARK: Properties - Conversions
	//--------------------------------------------------------------------------

	/**
	 * Converts the value to a string value.
	 * @property string
	 * @since 0.2.0
	 */
	public lazy var string: String = {
		return DLValueToString(self.context.handle, self.handle).string
	}()

	/**
	 * Converts the value to a double value.
	 * @property number
	 * @since 0.2.0
	 */
	public lazy var number: Double = {
		return DLValueToNumber(self.context.handle, self.handle)
	}()

	/**
	 * Converts the value to a boolean value.
	 * @property boolean
	 * @since 0.2.0
	 */
	public lazy var boolean: Bool = {
		return DLValueToBoolean(self.context.handle, self.handle)
	}()

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	internal init(context: JavaScriptContext) {
		self.context = context
		super.init()
	}

	/**
	 * Protect the value making it not garbage collectable.
	 * @method protect
	 * @since 0.1.0
	 */
	public func protect() {

		if (self.protected == 0) {
			DLValueProtect(self.context.handle, self.handle)
		}

		self.protected += 1

		self.didProtectValue()
	}

	/**
	 * Unprotect the value making it garbage collectable.
	 * @method unprotect
	 * @since 0.1.0
	 */
	public func unprotect() {

		if (self.handle == nil) {
			return
		}

		if (self.protected == 1) {
			DLValueUnprotect(self.context.handle, self.handle)
		}

		if (self.protected > 0) {
			self.protected -= 1
		}

		self.didUnprotectValue()
	}

	/**
	 * Disposes the value.
	 * @method dispose
	 * @since 0.1.0
	 */
	public func dispose() {

		if (self.handle == nil) {
			return
		}

		self.unprotect()

		self.handle = nil
	}

	/**
	 * Casts the value to a specified type.
	 * @method cast
	 * @since 0.1.0
	 */
	public func cast<T>(_ type: T.Type) -> T? {
		return Unmanaged<AnyObject>.fromOpaque(DLValueGetAssociatedObject(self.context.handle, self.handle)).takeUnretainedValue() as? T
	}

	/**
	 * Executes the value as a function.
	 * @method call
	 * @since 0.1.0
	 */
	public func call() {
		DLValueCall(self.context.handle, self.handle, nil, 0, nil)
	}

	/**
	 * Executes the value as a function with arguments.
	 * @method call
	 * @since 0.1.0
	 */
	public func call(_ arguments: JavaScriptArguments?, target: JavaScriptValue?, result: JavaScriptValue? = nil) {

		let argc = toArgc(arguments)
		let argv = toArgv(arguments)

		if let value = DLValueCall(self.context.handle, self.handle, toHandleO(target), UInt32(argc), argv) {
			result?.reset(value)
		}

		argv.deallocate()
	}

	/**
	 * Executes a method from the value.
	 * @method callMethod
	 * @since 0.1.0
	 */
	public func callMethod(_ method: String) {
		DLValueCallMethod(self.context.handle, self.handle, method, 0, nil)
	}

	/**
	 * Executes a method with arguments from the value.
	 * @method callMethod
	 * @since 0.1.0
	 */
	public func callMethod(_ method: String, arguments: JavaScriptArguments?, result: JavaScriptValue? = nil) {

		let argc = toArgc(arguments)
		let argv = toArgv(arguments)

		if let value = DLValueCallMethod(self.context.handle, self.handle, method, UInt32(argc), argv), let result = result {
			result.reset(value)
		}

		argv.deallocate()
	}

	/**
	 * Executes the value as a constructor.
	 * @method construct
	 * @since 0.1.0
	 */
	public func construct() {
		DLValueConstruct(self.context.handle, self.handle, 0, nil)
	}

	/**
	 * Executes the value as a constructor with arguments.
	 * @method construct
	 * @since 0.1.0
	 */
	public func construct(_ arguments: JavaScriptArguments?, result: JavaScriptValue? = nil) {

		let argc = toArgc(arguments)
		let argv = toArgv(arguments)

		if let value = DLValueConstruct(self.context.handle, self.handle, UInt32(argc), argv), let result = result {
			result.reset(value)
		}

		argv.deallocate()
	}

	/**
	 * Defines a property on the value.
	 * @method defineProperty
	 * @since 0.1.0
	 */
	public func defineProperty(_ property: String, value: JavaScriptValue?, getter: JavaScriptGetterHandler?, setter: JavaScriptSetterHandler?, writable: Bool, enumerable: Bool, configurable: Bool) {

		if let value = value {
			DLValueDefineProperty(self.context.handle, self.handle, property, nil, nil, toHandleO(value), writable, enumerable, configurable)
			return
		}

		var get: JSObjectRef? = nil
		var set: JSObjectRef? = nil

		if let handler = getter { get = JavaScriptGetterWrapper(context: context, handler: handler).function }
		if let handler = setter { set = JavaScriptSetterWrapper(context: context, handler: handler).function }

		DLValueDefineProperty(self.context.handle, self.handle, property, get, set, nil, writable, enumerable, configurable)
	}

	/**
	 * Assigns the value of a property.
	 * @method property
	 * @since 0.1.0
	 */
	public func property(_ name: String, value: JavaScriptValue) {
		DLValueSetProperty(self.context.handle, self.handle, name, toHandle(value))
	}

	/**
	 * Assigns the value of a property using a property.
	 * @method property
	 * @since 0.1.0
	 */
	public func property(_ name: String, property: Property) {
		DLValueSetProperty(self.context.handle, self.handle, name, property.value(in: self.context).handle)
	}

	/**
	 * Assigns the value of a property using a string.
	 * @method property
	 * @since 0.1.0
	 */
	public func property(_ name: String, string value: String) {
		DLValueSetPropertyWithString(self.context.handle, self.handle, name, value)
	}

	/**
	 * Assigns the value of a property using a number.
	 * @method property
	 * @since 0.1.0
	 */
	public func property(_ name: String, number value: Double) {
		DLValueSetPropertyWithNumber(self.context.handle, self.handle, name, value)
	}

	/**
	 * Assigns the value of a property using a number.
	 * @method property
	 * @since 0.4.0
	 */
	public func property(_ name: String, number value: Float) {
		DLValueSetPropertyWithNumber(self.context.handle, self.handle, name, Double(value))
	}

	/**
	 * Assigns the value of a property using a number.
	 * @method property
	 * @since 0.4.0
	 */
	public func property(_ name: String, number value: Int) {
		DLValueSetPropertyWithNumber(self.context.handle, self.handle, name, Double(value))
	}

	/**
	 * Assigns the value of a property using a number.
	 * @method property
	 * @since 0.4.0
	 */
	public func property(_ name: String, number value: CGFloat) {
		DLValueSetPropertyWithNumber(self.context.handle, self.handle, name, Double(value))
	}

	/**
	 * Assigns the value of a property using a boolean.
	 * @method property
	 * @since 0.1.0
	 */
	public func property(_ name: String, boolean value: Bool) {
		DLValueSetPropertyWithBoolean(self.context.handle, self.handle, name, value)
	}

	/**
	 * Returns the value of a property.
	 * @method property
	 * @since 0.1.0
	 */
	public func property(_ name: String) -> JavaScriptValue {
		return JavaScriptValue.create(self.context, handle: DLValueGetProperty(self.context.handle, self.handle, name))
	}

	/**
	 * Assigns the value of a property at a specified index.
	 * @method property
	 * @since 0.1.0
	 */
	public func property(_ index: Int, value: JavaScriptValue) {
		DLValueSetPropertyAtIndex(self.context.handle, self.handle, UInt32(index), value.handle)
	}

	/**
	 * Assigns the value of a property at a specified index using a string.
	 * @method property
	 * @since 0.1.0
	 */
	public func property(_ index: Int, string value: String) {
		DLValueSetPropertyAtIndexWithString(self.context.handle, self.handle, UInt32(index), value)
	}

	/**
	 * Assigns the value of a property at a specified index using a number.
	 * @method property
	 * @since 0.1.0
	 */
	public func property(_ index: Int, number value: Double) {
		DLValueSetPropertyAtIndexWithNumber(self.context.handle, self.handle, UInt32(index), value)
	}

	/**
	 * Assigns the value of a property at a specified index using a number.
	 * @method property
	 * @since 0.4.0
	 */
	public func property(_ index: Int, number value: Float) {
		DLValueSetPropertyAtIndexWithNumber(self.context.handle, self.handle, UInt32(index), Double(value))
	}

	/**
	 * Assigns the value of a property at a specified index using a number.
	 * @method property
	 * @since 0.4.0
	 */
	public func property(_ index: Int, number value: Int) {
		DLValueSetPropertyAtIndexWithNumber(self.context.handle, self.handle, UInt32(index), Double(value))
	}

	/**
	 * Assigns the value of a property at a specified index using a number.
	 * @method property
	 * @since 0.4.0
	 */
	public func property(_ index: Int, number value: CGFloat) {
		DLValueSetPropertyAtIndexWithNumber(self.context.handle, self.handle, UInt32(index), Double(value))
	}

	/**
	 * Assigns the value of a property at a specified index using a boolean.
	 * @method property
	 * @since 0.1.0
	 */
	public func property(_ index: Int, boolean value: Bool) {
		DLValueSetPropertyAtIndexWithBoolean(self.context.handle, self.handle, UInt32(index), value)
	}

	/**
	 * Returns the value of a property at a specified index.
	 * @method property
	 * @since 0.1.0
	 */
	public func property(_ index: Int) -> JavaScriptValue {
		return JavaScriptValue.create(self.context, handle: DLValueGetPropertyAtIndex(self.context.handle, self.handle, UInt32(index)))
	}

	/**
	 * Deletes the property of an object.
	 * @method deleteProperty
	 * @since 0.1.0
	 */
	public func deleteProperty(_ name: String) {
		DLValueDeleteProperty(self.context.handle, self.handle, name)
	}

	/**
	 * Deletes the property of an object.
	 * @method deleteProperty
	 * @since 0.1.0
	 */
	public func deleteProperty(_ index: Int) {
		DLValueDeleteProperty(self.context.handle, self.handle, String(describing: index))
	}

	/**
	 * Convenience method to loop through this value's array values.
	 * @method forEach
	 * @since 0.1.0
	 */
	public func forEach(_ handler: JavaScriptForEachHandler) {
		let length = self.length()
		if (length > 0) {
			for i in 0 ..< length {
				handler(i, self.property(i))
			}
		}
	}

	/**
	 * Assigns the internal prototype of this value.
	 * @method prototype
	 * @since 0.1.0
	 */
	public func prototype(_ prototype: JavaScriptValue) {
		DLValueSetPrototype(self.context.handle, self.handle, toHandle(prototype))
	}

	/**
	 * Returns the internal prototype of this value.
	 * @method prototype
	 * @since 0.1.0
	 */
	public func prototype() -> JavaScriptValue {
		return JavaScriptValue.create(self.context, handle: DLValueGetPrototype(self.context.handle, self.handle))
	}

	/**
	 * Indicates the value is equal and the same type as the specified value.
	 * @method equals
	 * @since 0.1.0
	 */
	public func equals(_ value: JavaScriptValue) -> Bool {
		return DLValueEquals(self.context.handle, self.handle, toHandle(value))
	}

	/**
	 * Indicates if the value is the specified string.
	 * @method equals
	 * @since 0.1.0
	 */
	public func equals(string value: String) -> Bool {
		return DLValueEqualsString(self.context.handle, self.handle, value)
	}

	/**
	 * Indicates if the value is the specified number.
	 * @method equals
	 * @since 0.1.0
	 */
	public func equals(number value: Double) -> Bool {
		return DLValueEqualsNumber(self.context.handle, self.handle, value)
	}

	/**
	 * Indicates if the value is the specified boolean.
	 * @method equals
	 * @since 0.1.0
	 */
	public func equals(boolean value: Bool) -> Bool {
		return DLValueEqualsBoolean(self.context.handle, self.handle, value)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Extensions
	//--------------------------------------------------------------------------

	/**
	 * Called when the value gets protected.
	 * @method didProtectValue
	 * @since 0.4.0
	 */
	open func didProtectValue() {

	}

	/**
	 * Called when the value gets unprotected.
	 * @method didUnprotectValue
	 * @since 0.4.0
	 */
	open func didUnprotectValue() {

	}

	/**
	 * Called when the value get reset
	 * @method didReset
	 * @since 0.4.0
	 */
	open func didResetValue() {

	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method length
	 * @since 0.1.0
	 * @hidden
	 */
	internal func length() -> Int {
		return self.property("length").number.int()
	}

	/**
	 * @method reset
	 * @since 0.1.0
	 * @hidden
	 */
	public func reset(_ handle: JSValueRef, protect: Bool = true) {

		self.unprotect()

		self.handle = handle

		if (protect) {
			self.protect()
		}

		self.didResetValue()
	}

	/**
	 * @method recycle
	 * @since 0.6.0
	 * @hidden
	 */
	public func recycle() {
		self.unprotect()
		self.handle = nil
	}
}

/**
 * The type alias for function callback.
 * @alias JavaScriptFinalizeHandler
 * @since 0.2.0
 */
public typealias JavaScriptFinalizeHandler = (JavaScriptFinalizeCallback) -> (Void)

/**
 * The function callback alias.
 * @alias JavaScriptFunctionHandler
 * @since 0.2.0
 */
public typealias JavaScriptFunctionHandler = (JavaScriptFunctionCallback) -> (Void)

/**
 * The type alias for property getter callback.
 * @alias JavaScriptGetterHandler
 * @since 0.2.0
 */
public typealias JavaScriptGetterHandler = (JavaScriptGetterCallback) -> (Void)

/**
 * The type alias for property setter callback.
 * @alias JavaScriptSetterHandler
 * @since 0.2.0
 */
public typealias JavaScriptSetterHandler = (JavaScriptSetterCallback) -> (Void)

/**
 * The type alias for arguments.
 * @alias JavaScriptArguments
 * @since 0.2.0
 */
public typealias JavaScriptArguments = [JavaScriptValue?]

/**
 * The for each callback alias.
 * @alias JavaScriptForEachHandler
 * @since 0.2.0
 */
public typealias JavaScriptForEachHandler = (Int, JavaScriptValue) -> (Void)

/**
 * @function toHandle
 * @since 0.1.0
 * @hidden
 */
internal func toHandle(_ value: JavaScriptValue) -> JSValueRef {
	return value.handle
}

/**
 * @function toHandleO
 * @since 0.1.0
 * @hidden
 */
internal func toHandleO(_ value: JavaScriptValue?) -> JSValueRef? {
	return value?.handle ?? nil
}

/**
 * @function toArgc
 * @since 0.1.0
 * @hidden
 */
internal func toArgc(_ values: JavaScriptArguments?) -> Int {
	return values?.count ?? 0
}

/**
 * @function toArgv
 * @since 0.1.0
 * @hidden
 */
internal func toArgv(_ values: JavaScriptArguments?) -> UnsafeMutablePointer<JSValueRef?> {

	if let values = values {

		let result = UnsafeMutablePointer<JSValueRef?>.allocate(capacity: values.count)

		for i in 0 ..< values.count {
			result[i] = toHandleO(values[i])
		}

		return result
	}

	return UnsafeMutablePointer<JSValueRef?>.allocate(capacity: 0)
}

/**
 * @function toHash
 * @since 0.1.0
 * @hidden
 */
internal func toHash(_ object: AnyObject) -> Int64 {

	if let hash = object.hash {
		return Int64(hash)
	}

	fatalError("Unable to acquire object hash")
}

/**
 * @function toHash
 * @since 0.1.0
 * @hidden
 */
internal func toHash(_ klass: AnyClass) -> Int64 {
	return Int64(ObjectIdentifier(klass).hashValue)
}

/**
* @function toHash
* @since 0.1.0
* @hidden
*/
internal func toHash(_ string: String) -> Int64 {
	return Int64(string.hashValue)
}

internal let kFinalizeWrapperKey = Int64(CChar(exactly:0)!.hashValue)
internal let kExceptionWrapperKey = Int64(CChar(exactly: 0)!.hashValue)
