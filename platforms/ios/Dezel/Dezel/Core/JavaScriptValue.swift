/**
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
		return JavaScriptValue.create(context, handle: JavaScriptValueCreateNull(context.handle))
	}

	/**
	 * @method createUndefined
	 * @since 0.1.0
	 * @hidden
	 */
	internal class func createUndefined(_ context: JavaScriptContext) -> JavaScriptValue {
		return JavaScriptValue.create(context, handle: JavaScriptValueCreateUndefined(context.handle))
	}

	/**
	 * @method createString
	 * @since 0.1.0
	 * @hidden
	 */
	internal class func createString(_ context: JavaScriptContext, value: String) -> JavaScriptValue {
		return JavaScriptValue.create(context, handle: JavaScriptValueCreateString(context.handle, value))
	}

	/**
	 * @method createNumber
	 * @since 0.1.0
	 * @hidden
	 */
	internal class func createNumber(_ context: JavaScriptContext, value: Double) -> JavaScriptValue {
		return JavaScriptValue.create(context, handle: JavaScriptValueCreateNumber(context.handle, value))
	}

	/**
	 * @method createBoolean
	 * @since 0.1.0
	 * @hidden
	 */
	internal class func createBoolean(_ context: JavaScriptContext, value: Bool) -> JavaScriptValue {
		return JavaScriptValue.create(context, handle: JavaScriptValueCreateBoolean(context.handle, value))
	}

	/**
	 * @method createEmptyObject
	 * @since 0.1.0
	 * @hidden
	 */
	internal class func createEmptyObject(_ context: JavaScriptContext) -> JavaScriptValue {
		return JavaScriptValue.create(context, handle: JavaScriptValueCreateEmptyObject(context.handle, nil))
	}

	/**
	 * @method createEmptyArray
	 * @since 0.1.0
	 * @hidden
	 */
	internal class func createEmptyArray(_ context: JavaScriptContext) -> JavaScriptValue {
		return JavaScriptValue.create(context, handle: JavaScriptValueCreateEmptyArray(context.handle))
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
	 * @property context
	 * @since 0.1.0
	 */
	private(set) public var context: JavaScriptContext

	/**
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
	 * @property isUndefined
	 * @since 0.4.0
	 */
	public var isUndefined: Bool {
		return JavaScriptValueGetType(self.context.handle, self.handle) == kJavaScriptValueTypeUndefined
	}

	/**
	 * @property isNull
	 * @since 0.4.0
	 */
	public var isNull: Bool {
		return JavaScriptValueGetType(self.context.handle, self.handle) == kJavaScriptValueTypeNull
	}

	/**
	 * @property isBoolean
	 * @since 0.4.0
	 */
	public var isBoolean: Bool {
		return JavaScriptValueGetType(self.context.handle, self.handle) == kJavaScriptValueTypeBoolean
	}

	/**
	 * @property isNumber
	 * @since 0.4.0
	 */
	public var isNumber: Bool {
		return JavaScriptValueGetType(self.context.handle, self.handle) == kJavaScriptValueTypeNumber
	}

	/**
	 * @property isString
	 * @since 0.4.0
	 */
	public var isString: Bool {
		return JavaScriptValueGetType(self.context.handle, self.handle) == kJavaScriptValueTypeString
	}

	/**
	 * @property isObject
	 * @since 0.4.0
	 */
	public var isObject: Bool {
		return JavaScriptValueGetType(self.context.handle, self.handle) == kJavaScriptValueTypeObject
	}

	/**
	 * @property isObject
	 * @since 0.4.0
	 */
	public var isArray: Bool {
		return JavaScriptValueGetType(self.context.handle, self.handle) == kJavaScriptValueTypeArray
	}

	/**
	 * @property isFunction
	 * @since 0.4.0
	 */
	public var isFunction: Bool {
		return JavaScriptValueGetType(self.context.handle, self.handle) == kJavaScriptValueTypeFunction
	}

	//--------------------------------------------------------------------------
	// MARK: Properties - Conversions
	//--------------------------------------------------------------------------

	/**
	 * @property string
	 * @since 0.2.0
	 */
	public lazy var string: String = {
		return JavaScriptValueToString(self.context.handle, self.handle).strdup
	}()

	/**
	 * @property number
	 * @since 0.2.0
	 */
	public lazy var number: Double = {
		return JavaScriptValueToNumber(self.context.handle, self.handle)
	}()

	/**
	 * @property boolean
	 * @since 0.2.0
	 */
	public lazy var boolean: Bool = {
		return JavaScriptValueToBoolean(self.context.handle, self.handle)
	}()

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	public required init(context: JavaScriptContext) {

		/*
		 * Even though this method is marked as public it should be treated
		 * as internal. This has been changed to fix an issue where some
		 * JavaScriptClass instance would not be instantiated as the
		 * proper type unless this method is public.
		 */

		self.context = context
		super.init()
	}

	/**
	 * @method protect
	 * @since 0.1.0
	 */
	open func protect() {

		if (self.protected == 0) {
			JavaScriptValueProtect(self.context.handle, self.handle)
		}

		self.protected += 1

		self.didProtectValue()
	}

	/**
	 * @method unprotect
	 * @since 0.1.0
	 */
	open func unprotect() {

		if (self.handle == nil) {
			return
		}

		if (self.protected == 1) {
			JavaScriptValueUnprotect(self.context.handle, self.handle)
		}

		if (self.protected > 0) {
			self.protected -= 1
		}

		self.didUnprotectValue()
	}

	/**
	 * @method dispose
	 * @since 0.1.0
	 */
	open func dispose() {

		if (self.handle == nil) {
			return
		}

		self.unprotect()

		self.handle = nil
	}

	/**
	 * @method cast
	 * @since 0.1.0
	 */
	open func cast<T>(_ type: T.Type) -> T? {
		return Unmanaged<AnyObject>.fromOpaque(JavaScriptValueGetAssociatedObject(self.context.handle, self.handle)).takeUnretainedValue() as? T
	}

	/**
	 * @method call
	 * @since 0.1.0
	 */
	open func call() {
		JavaScriptValueCall(self.context.handle, self.handle, nil, 0, nil)
	}

	/**
	 * @method call
	 * @since 0.1.0
	 */
	open func call(_ arguments: JavaScriptArguments?, target: JavaScriptValue?, result: JavaScriptValue? = nil) {

		let argc = toArgc(arguments)
		let argv = toArgv(arguments, context: self.context)

		if let value = JavaScriptValueCall(self.context.handle, self.handle, toJs(target, in: self.context), UInt32(argc), argv) {
			result?.reset(value)
		}

		argv.deallocate()
	}

	/**
	 * @method callMethod
	 * @since 0.1.0
	 */
	open func callMethod(_ method: String) {
		JavaScriptValueCallMethod(self.context.handle, self.handle, method, 0, nil)
	}

	/**
	 * @method callMethod
	 * @since 0.1.0
	 */
	open func callMethod(_ method: String, arguments: JavaScriptArguments?, result: JavaScriptValue? = nil) {

		let argc = toArgc(arguments)
		let argv = toArgv(arguments, context: self.context)

		if let value = JavaScriptValueCallMethod(self.context.handle, self.handle, method, UInt32(argc), argv), let result = result {
			result.reset(value)
		}

		argv.deallocate()
	}

	/**
	 * @method construct
	 * @since 0.1.0
	 */
	open func construct() {
		JavaScriptValueConstruct(self.context.handle, self.handle, 0, nil)
	}

	/**
	 * @method construct
	 * @since 0.1.0
	 */
	open func construct(_ arguments: JavaScriptArguments?, result: JavaScriptValue? = nil) {

		let argc = toArgc(arguments)
		let argv = toArgv(arguments, context: self.context)

		if let value = JavaScriptValueConstruct(self.context.handle, self.handle, UInt32(argc), argv), let result = result {
			result.reset(value)
		}

		argv.deallocate()
	}

	/**
	 * @method defineProperty
	 * @since 0.1.0
	 */
	open func defineProperty(_ property: String, value: JavaScriptValue?, getter: JavaScriptGetterHandler? = nil, setter: JavaScriptSetterHandler? = nil, writable: Bool = true, enumerable: Bool = true, configurable: Bool = true) {

		if let value = value {
			JavaScriptValueDefineProperty(self.context.handle, self.handle, property, nil, nil, toJs(value, in: self.context), writable, enumerable, configurable)
			return
		}

		var get: JSObjectRef? = nil
		var set: JSObjectRef? = nil

		if let handler = getter { get = JavaScriptGetterWrapper(context: context, handler: handler).function }
		if let handler = setter { set = JavaScriptSetterWrapper(context: context, handler: handler).function }

		JavaScriptValueDefineProperty(self.context.handle, self.handle, property, get, set, nil, writable, enumerable, configurable)
	}

	/**
	 * @method property
	 * @since 0.1.0
	 */
	open func property(_ name: String, value: JavaScriptValue?) {
		JavaScriptValueSetProperty(self.context.handle, self.handle, name, toJs(value, in: self.context))
	}

	/**
	 * @method property
	 * @since 0.1.0
	 */
	open func property(_ name: String, property: JavaScriptProperty) {
		JavaScriptValueSetProperty(self.context.handle, self.handle, name, toJs(property, in: self.context))
	}

	/**
	 * @method property
	 * @since 0.1.0
	 */
	open func property(_ name: String, string value: String) {
		JavaScriptValueSetPropertyWithString(self.context.handle, self.handle, name, value)
	}

	/**
	 * @method property
	 * @since 0.1.0
	 */
	open func property(_ name: String, number value: Double) {
		JavaScriptValueSetPropertyWithNumber(self.context.handle, self.handle, name, value)
	}

	/**
	 * @method property
	 * @since 0.4.0
	 */
	open func property(_ name: String, number value: Float) {
		JavaScriptValueSetPropertyWithNumber(self.context.handle, self.handle, name, Double(value))
	}

	/**
	 * @method property
	 * @since 0.4.0
	 */
	open func property(_ name: String, number value: Int) {
		JavaScriptValueSetPropertyWithNumber(self.context.handle, self.handle, name, Double(value))
	}

	/**
	 * @method property
	 * @since 0.4.0
	 */
	open func property(_ name: String, number value: CGFloat) {
		JavaScriptValueSetPropertyWithNumber(self.context.handle, self.handle, name, Double(value))
	}

	/**
	 * @method property
	 * @since 0.1.0
	 */
	open func property(_ name: String, boolean value: Bool) {
		JavaScriptValueSetPropertyWithBoolean(self.context.handle, self.handle, name, value)
	}

	/**
	 * @method property
	 * @since 0.1.0
	 */
	open func property(_ name: String) -> JavaScriptValue {
		return JavaScriptValue.create(self.context, handle: JavaScriptValueGetProperty(self.context.handle, self.handle, name))
	}

	/**
	 * @method property
	 * @since 0.1.0
	 */
	open func property(_ index: Int, value: JavaScriptValue?) {
		JavaScriptValueSetPropertyAtIndex(self.context.handle, self.handle, UInt32(index), toJs(value, in: self.context))
	}

	/**
	 * @method property
	 * @since 0.1.0
	 */
	open func property(_ index: Int, string value: String) {
		JavaScriptValueSetPropertyAtIndexWithString(self.context.handle, self.handle, UInt32(index), value)
	}

	/**
	 * @method property
	 * @since 0.1.0
	 */
	open func property(_ index: Int, number value: Double) {
		JavaScriptValueSetPropertyAtIndexWithNumber(self.context.handle, self.handle, UInt32(index), value)
	}

	/**
	 * @method property
	 * @since 0.4.0
	 */
	open func property(_ index: Int, number value: Float) {
		JavaScriptValueSetPropertyAtIndexWithNumber(self.context.handle, self.handle, UInt32(index), Double(value))
	}

	/**
	 * @method property
	 * @since 0.4.0
	 */
	open func property(_ index: Int, number value: Int) {
		JavaScriptValueSetPropertyAtIndexWithNumber(self.context.handle, self.handle, UInt32(index), Double(value))
	}

	/**
	 * @method property
	 * @since 0.4.0
	 */
	open func property(_ index: Int, number value: CGFloat) {
		JavaScriptValueSetPropertyAtIndexWithNumber(self.context.handle, self.handle, UInt32(index), Double(value))
	}

	/**
	 * @method property
	 * @since 0.1.0
	 */
	open func property(_ index: Int, boolean value: Bool) {
		JavaScriptValueSetPropertyAtIndexWithBoolean(self.context.handle, self.handle, UInt32(index), value)
	}

	/**
	 * @method property
	 * @since 0.1.0
	 */
	open func property(_ index: Int) -> JavaScriptValue {
		return JavaScriptValue.create(self.context, handle: JavaScriptValueGetPropertyAtIndex(self.context.handle, self.handle, UInt32(index)))
	}

	/**
	 * @method forEach
	 * @since 0.7.0
	 */
	open func forEach(_ handler: @escaping JavaScriptForEachHandler) {
		let wrapper = JavaScriptValueForEachWrapper(context: self.context, handler: handler)
		JavaScriptValueForEach(self.context.handle, self.handle, javaScriptValueForEachCallback,
			toUnretainedOpaque(wrapper)
		)
	}

	/**
	 * @method forOwn
	 * @since 0.7.0
	 */
	open func forOwn(_ handler: @escaping JavaScriptForOwnHandler) {
		let wrapper = JavaScriptValueForOwnWrapper(context: self.context, handler: handler)
		JavaScriptValueForOwn(self.context.handle, self.handle, javaScriptValueForOwnCallback,
			toUnretainedOpaque(wrapper)
		)
	}

	/**
	 * @method prototype
	 * @since 0.1.0
	 */
	open func prototype(_ prototype: JavaScriptValue) {
		JavaScriptValueSetPrototype(self.context.handle, self.handle, toJs(prototype, in: self.context))
	}

	/**
	 * @method prototype
	 * @since 0.1.0
	 */
	open func prototype() -> JavaScriptValue {
		return JavaScriptValue.create(self.context, handle: JavaScriptValueGetPrototype(self.context.handle, self.handle))
	}

	/**
	 * @method equals
	 * @since 0.1.0
	 */
	open func equals(_ value: JavaScriptValue) -> Bool {
		return JavaScriptValueEquals(self.context.handle, self.handle, toJs(value, in: self.context))
	}

	/**
	 * @method equals
	 * @since 0.1.0
	 */
	open func equals(string value: String) -> Bool {
		return JavaScriptValueEqualsString(self.context.handle, self.handle, value)
	}

	/**
	 * @method equals
	 * @since 0.1.0
	 */
	open func equals(number value: Double) -> Bool {
		return JavaScriptValueEqualsNumber(self.context.handle, self.handle, value)
	}

	/**
	 * @method equals
	 * @since 0.1.0
	 */
	open func equals(boolean value: Bool) -> Bool {
		return JavaScriptValueEqualsBoolean(self.context.handle, self.handle, value)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Extensions
	//--------------------------------------------------------------------------

	/**
	 * @method didProtectValue
	 * @since 0.4.0
	 */
	open func didProtectValue() {

	}

	/**
	 * @method didUnprotectValue
	 * @since 0.4.0
	 */
	open func didUnprotectValue() {

	}

	/**
	 * @method didReset
	 * @since 0.4.0
	 */
	open func didResetValue() {

	}

	//--------------------------------------------------------------------------
	// MARK: Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method toHandle
	 * @since 0.7.0
	 * @hidden
	 */
	open func toHandle(_ context: JavaScriptContext) -> JSValueRef {
		return self.handle
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method reset
	 * @since 0.1.0
	 * @hidden
	 */
	internal func reset(_ handle: JSValueRef, protect: Bool = true) {

		self.unprotect()

		self.handle = handle

		if (protect) {
			self.protect()
		}

		self.didResetValue()
	}
}

internal let kFinalizeWrapperKey = Int64(CChar(exactly:0)!.hashValue)
internal let kExceptionWrapperKey = Int64(CChar(exactly: 0)!.hashValue)

/**
 * @alias JavaScriptFinalizeHandler
 * @since 0.2.0
 */
public typealias JavaScriptFinalizeHandler = (JavaScriptFinalizeCallback) -> (Void)

/**
 * @alias JavaScriptFunctionHandler
 * @since 0.2.0
 */
public typealias JavaScriptFunctionHandler = (JavaScriptFunctionCallback) -> (Void)

/**
 * @alias JavaScriptGetterHandler
 * @since 0.2.0
 */
public typealias JavaScriptGetterHandler = (JavaScriptGetterCallback) -> (Void)

/**
 * @alias JavaScriptSetterHandler
 * @since 0.2.0
 */
public typealias JavaScriptSetterHandler = (JavaScriptSetterCallback) -> (Void)

/**
 * @alias JavaScriptArguments
 * @since 0.2.0
 */
public typealias JavaScriptArguments = [JavaScriptValue?]

/**
 * @alias JavaScriptForOwnHandler
 * @since 0.7.0
 */
public typealias JavaScriptForOwnHandler = (String, JavaScriptValue) -> Void

/**
 * @alias JavaScriptForEachHandler
 * @since 0.7.0
 */
public typealias JavaScriptForEachHandler = (Int, JavaScriptValue) -> Void

/**
 * @extension JavaScriptValue
 * @since 0.7.0
 * @hidden
 */
internal extension JavaScriptValue {

	/**
	 * @method toTimeInterval
	 * @since 0.7.0
	 * @hidden
	 */
	func toURL() -> URL? {
		return URL(string: self.string)
	}

	/**
	 * @method toTimeInterval
	 * @since 0.7.0
	 * @hidden
	 */
	func toTimeInterval() -> TimeInterval {
		return TimeInterval(self.number)
	}

	/**
	 * @method toArrayOfString
	 * @since 0.7.0
	 * @hidden
	 */
	func toArrayOfString() -> [String] {

		var array: [String] = []

		self.forEach { index, value in
			array.append(value.string)
		}

		return array
	}

	/**
	 * @method toArrayOfNumber
	 * @since 0.7.0
	 * @hidden
	 */
	func toArrayOfNumber() -> [Double] {

		var array: [Double] = []

		self.forEach { index, value in
			array.append(value.number)
		}

		return array
	}

	/**
	 * @method toDictionaryOfString
	 * @since 0.7.0
	 * @hidden
	 */
	func toDictionaryOfString() -> [String: String] {

		var dictionary: [String: String] = [:]

		self.forOwn { property, value in
			dictionary[property] = value.string
		}

		return dictionary
	}

	/**
	 * @method toDictionaryOfNumber
	 * @since 0.7.0
	 * @hidden
	 */
	func toDictionaryOfNumber() -> [String: Double] {

		var dictionary: [String: Double] = [:]

		self.forOwn { property, value in
			dictionary[property] = value.number
		}

		return dictionary
	}
}

/**
 * @function toJs
 * @since 0.7.0
 * @hidden
 */
internal func toJs(_ value: JavaScriptProperty?, in context: JavaScriptContext) -> JSValueRef? {
	return value?.toHandle(context) ?? context.jsnull.handle
}

/**
 * @function toJs
 * @since 0.7.0
 * @hidden
 */
internal func toJs(_ value: JavaScriptValue?, in context: JavaScriptContext) -> JSValueRef? {
	return value?.toHandle(context) ?? context.jsnull.handle
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
internal func toArgv(_ values: JavaScriptArguments?, context: JavaScriptContext) -> UnsafeMutablePointer<JSValueRef?> {

	if let values = values {

		let result = UnsafeMutablePointer<JSValueRef?>.allocate(capacity: values.count)

		for i in 0 ..< values.count {
			result[i] = toJs(values[i], in: context)
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

/**
 * @function toRetainedOpaque
 * @since 0.7.0
 * @hidden
 */
internal func toRetainedOpaque(_ value: AnyObject?) -> UnsafeMutableRawPointer? {

	if let value = value {
		return UnsafeMutableRawPointer(Unmanaged.passRetained(value).toOpaque())
	}

	return nil
}

/**
 * @function toUnretainedOpaque
 * @since 0.6.0
 * @hidden
 */
internal func toUnretainedOpaque(_ value: AnyObject?) -> UnsafeMutableRawPointer? {

	if let value = value {
		return UnsafeMutableRawPointer(Unmanaged.passUnretained(value).toOpaque())
	}

	return nil
}

/**
* @function toRetainedObject
* @since 0.6.0
* @hidden
*/
internal func toRetainedObject(_ value: UnsafeMutableRawPointer?) -> AnyObject? {

	if let value = value {
		return Unmanaged<AnyObject>.fromOpaque(value).takeRetainedValue()
	}

	return nil
}

/**
* @function toUnretainedObject
* @since 0.6.0
* @hidden
*/
internal func toUnretainedObject(_ value: UnsafeMutableRawPointer?) -> AnyObject? {

	if let value = value {
		return Unmanaged<AnyObject>.fromOpaque(value).takeUnretainedValue()
	}

	return nil
}
