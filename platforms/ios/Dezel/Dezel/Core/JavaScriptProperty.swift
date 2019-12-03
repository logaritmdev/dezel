/**
 * @class JavaScriptProperty
 * @super NSObject
 * @since 0.7.0
 */
public class JavaScriptProperty: NSObject {

	//--------------------------------------------------------------------------
	// MARK: Type Alias
	//--------------------------------------------------------------------------

	/**
	 * @alias JavaScriptPropertyHandler
	 * @since 0.7.0
	 */
	public typealias JavaScriptPropertyHandler = (JavaScriptProperty) -> Void

	//--------------------------------------------------------------------------
	// MARK: Static
	//--------------------------------------------------------------------------

	/**
	 * @property NullValue
	 * @since 0.7.0
	 */
	public static let Null: JavaScriptPropertyValue = JavaScriptPropertyValue()

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property lock
	 * @since 0.7.0
	 */
	private(set) public var lock: AnyObject?

	/**
	 * @property type
	 * @since 0.7.0
	 */
	public var type: JavaScriptPropertyType {
		return self.currentValue.type
	}

	/**
	 * @property unit
	 * @since 0.7.0
	 */
	public var unit: JavaScriptPropertyUnit {
		return self.currentValue.unit
	}

	/**
	 * @property string
	 * @since 0.7.0
	 */
	public var string: String {
		return self.currentValue.string
	}

	/**
	 * @property number
	 * @since 0.7.0
	 */
	public var number: Double {
		return self.currentValue.number
	}

	/**
	 * @property boolean
	 * @since 0.7.0
	 */
	public var boolean: Bool {
		return self.currentValue.boolean
	}

	/**
	 * @property value
	 * @since 0.7.0
	 */
	public var value: JavaScriptValue? {
		return self.currentValue.value
	}

	/**
	 * @property variable
	 * @since 0.7.0
	 */
	public var variable: JavaScriptPropertyVariableValue? {
		return self.currentValue as? JavaScriptPropertyVariableValue
	}

	/**
	 * @property function
	 * @since 0.7.0
	 */
	public var function: JavaScriptPropertyFunctionValue? {
		return self.currentValue as? JavaScriptPropertyFunctionValue
	}

	/**
	 * @property composite
	 * @since 0.7.0
	 */
	public var composite: JavaScriptPropertyCompositeValue? {
		return self.currentValue as? JavaScriptPropertyCompositeValue
	}

	/**
	 * @property isNull
	 * @since 0.7.0
	 */
	public var isNull: Bool {
		return self.currentValue.isNull
	}

	/**
	 * @property isString
	 * @since 0.7.0
	 */
	public var isString: Bool {
		return self.currentValue.isString
	}

	/**
	 * @property isNumber
	 * @since 0.7.0
	 */
	public var isNumber: Bool {
		return self.currentValue.isNumber
	}

	/**
	 * @property isBoolean
	 * @since 0.7.0
	 */
	public var isBoolean: Bool {
		return self.currentValue.isBoolean
	}

	/**
	 * @property isObject
	 * @since 0.7.0
	 */
	public var isObject: Bool {
		return self.currentValue.isObject
	}

	/**
	 * @property isArray
	 * @since 0.7.0
	 */
	public var isArray: Bool {
		return self.currentValue.isArray
	}

	/**
	 * @property isCallback
	 * @since 0.7.0
	 */
	public var isCallback: Bool {
		return self.currentValue.isCallback
	}

	/**
	 * @property isVariable
	 * @since 0.7.0
	 */
	public var isVariable: Bool {
		return self.currentValue.isVariable
	}

	/**
	 * @property isFunction
	 * @since 0.7.0
	 */
	public var isFunction: Bool {
		return self.currentValue.isFunction
	}

	/**
	 * @property isComposite
	 * @since 0.7.0
	 */
	public var isComposite: Bool {
		return self.currentValue.isComposite
	}

	/**
	 * @property initialValue
	 * @since 0.7.0
	 * @hidden
	 */
	private var initialValue: JavaScriptPropertyValue

	/**
	 * @property currentValue
	 * @since 0.7.0
	 * @hidden
	 */
	private var currentValue: JavaScriptPropertyValue

	/**
	 * @property handler
	 * @since 0.7.0
	 * @hidden
	 */
	private var handler: JavaScriptPropertyHandler?

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public init(handler: JavaScriptPropertyHandler? = nil) {
		self.initialValue = JavaScriptProperty.Null
		self.currentValue = JavaScriptProperty.Null
		self.handler = handler
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public init(string: String, handler: JavaScriptPropertyHandler? = nil) {
		self.initialValue = JavaScriptPropertyStringValue(value: string)
		self.currentValue = JavaScriptPropertyStringValue(value: string)
		self.handler = handler
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public init(number: Double, handler: JavaScriptPropertyHandler? = nil) {
		self.initialValue = JavaScriptPropertyNumberValue(value: number)
		self.currentValue = JavaScriptPropertyNumberValue(value: number)
		self.handler = handler
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public init(number: Double, unit: JavaScriptPropertyUnit, handler: JavaScriptPropertyHandler? = nil) {
		self.initialValue = JavaScriptPropertyNumberValue(value: number, unit: unit)
		self.currentValue = JavaScriptPropertyNumberValue(value: number, unit: unit)
		self.handler = handler
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public init(boolean: Bool, handler: JavaScriptPropertyHandler? = nil) {
		self.initialValue = JavaScriptPropertyBooleanValue(value: boolean)
		self.currentValue = JavaScriptPropertyBooleanValue(value: boolean)
		self.handler = handler
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public convenience init(lock: AnyObject, handler: JavaScriptPropertyHandler? = nil) {
		self.init(handler: handler)
		self.lock = lock
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public convenience init(string: String, lock: AnyObject, handler: JavaScriptPropertyHandler? = nil) {
		self.init(string: string, handler: handler)
		self.lock = lock
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public convenience init(number: Double, lock: AnyObject, handler: JavaScriptPropertyHandler? = nil) {
		self.init(number: number, handler: handler)
		self.lock = lock
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public convenience init(number: Double, unit: JavaScriptPropertyUnit, lock: AnyObject, handler: JavaScriptPropertyHandler? = nil) {
		self.init(number: number, unit: unit, handler: handler)
		self.lock = lock
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public convenience init(boolean: Bool, lock: AnyObject, handler: JavaScriptPropertyHandler? = nil) {
		self.init(boolean: boolean, handler: handler)
		self.lock = lock
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 */
	public func reset(lock: AnyObject? = nil, initial: Bool = false) {

		if isLocked(self.lock, key: lock) {
			return
		}

		self.lock = lock

		if (initial) {

			if (self.equals(self.initialValue) == false) {
				self.update(self.initialValue)
				self.change()
			}

		} else {

			if (self.isNull == false) {
				self.update()
				self.change()
			}

		}
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 */
	public func reset(_ value: String, lock: AnyObject? = nil, parse: Bool = false) {

		if isLocked(self.lock, key: lock) {
			return
		}

		self.lock = lock

		if (parse) {
			self.parse(value)
			return
		}

		if (self.equals(value) == false) {
			self.update(value)
			self.change()
		}
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 */
	public func reset(_ value: Double, lock: AnyObject? = nil) {

		if isLocked(self.lock, key: lock) {
			return
		}

		self.lock = lock

		if (self.equals(value) == false) {
			self.update(value)
			self.change()
		}
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 */
	public func reset(_ value: Double, unit: JavaScriptPropertyUnit, lock: AnyObject? = nil) {

		if isLocked(self.lock, key: lock) {
			return
		}

		self.lock = lock

		if (self.equals(value, unit: unit) == false) {
			self.update(value, unit: unit)
			self.change()
		}
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 */
	public func reset(_ value: Bool, lock: AnyObject? = nil) {

		if isLocked(self.lock, key: lock) {
			return
		}

		self.lock = lock

		if (self.equals(value) == false) {
			self.update(value)
			self.change()
		}
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 */
	public func reset(_ value: JavaScriptValue, lock: AnyObject? = nil, parse: Bool = false) {

		if isLocked(self.lock, key: lock) {
			return
		}

		self.lock = lock

		switch (true) {

			case value.isNull:
				self.reset(lock: lock)
			case value.isUndefined:
				self.reset(lock: lock)
			case value.isString:
				self.reset(value.string, lock: lock, parse: parse)
			case value.isNumber:
				self.reset(value.number, lock: lock)
			case value.isBoolean:
				self.reset(value.boolean, lock: lock)

			default:

				if (self.equals(value) == false) {
					self.update(value)
					self.change()
				}

				break
		}

		self.currentValue.reset(value)
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 */
	public func reset(_ value: JavaScriptProperty, lock: AnyObject? = nil) {

		if isLocked(self.lock, key: lock) {
			return
		}

		self.lock = lock

		if (self.equals(value) == false) {
			self.update(value)
			self.change()
		}
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 */
	public func reset(_ value: JavaScriptPropertyValue, lock: AnyObject? = nil) {

		if isLocked(self.lock, key: lock) {
			return
		}

		self.lock = lock

		if (self.equals(value) == false) {
			self.update(value)
			self.change()
		}
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	public func equals(_ value: String) -> Bool {
		return self.currentValue.equals(value)
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	public func equals(_ value: Double) -> Bool {
		return self.currentValue.equals(value)
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	public func equals(_ value: Double, unit: JavaScriptPropertyUnit) -> Bool {
		return self.currentValue.equals(value, unit: unit)
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	public func equals(_ value: Bool) -> Bool {
		return self.currentValue.equals(value)
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	public func equals(_ value: JavaScriptValue) -> Bool {
		return self.currentValue.equals(value)
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	internal func equals(_ value: JavaScriptProperty) -> Bool {
		return self.equals(value.currentValue)
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	public func equals(_ value: JavaScriptPropertyValue) -> Bool {

		switch (self.type) {

			case .null:
				return value.type == .null
			case .string:
				return value.equals(self.string)
			case .number:
				return value.equals(self.number)
			case .boolean:
				return value.equals(self.boolean)

			default:
				break;
		}

		return self.currentValue === value
	}

	/**
	 * @method cast
	 * @since 0.7.0
	 */
	public func cast<T>(_ type: T.Type) -> T? {
		return self.currentValue.cast(type)
	}

	//--------------------------------------------------------------------------
	// MARK: Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method parse
	 * @since 0.7.0
	 * @hidden
	 */
	internal func parse(_ value: String) {
		ValueParse(value, toPtr(self), javaScriptPropertyParse)
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 */
	internal func reset(_ value: JavaScriptPropertyVariableValue, lock: AnyObject? = nil) {

		if isLocked(self.lock, key: lock) {
			return
		}

		self.lock = lock

		if (self.equals(value) == false) {
			self.update(value)
			self.change()
		}
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 */
	internal func reset(_ value: JavaScriptPropertyFunctionValue, lock: AnyObject? = nil) {

		if isLocked(self.lock, key: lock) {
			return
		}

		self.lock = lock

		if (self.equals(value) == false) {
			self.update(value)
			self.change()
		}
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 */
	internal func reset(_ value: JavaScriptPropertyCompositeValue, lock: AnyObject? = nil) {

		if isLocked(self.lock, key: lock) {
			return
		}

		self.lock = lock

		if (self.equals(value) == false) {
			self.update(value)
			self.change()
		}
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	internal func equals(_ value: JavaScriptPropertyVariableValue) -> Bool {
		return self.currentValue === value
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	internal func equals(_ value: JavaScriptPropertyFunctionValue) -> Bool {
		return self.currentValue === value
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	internal func equals(_ value: JavaScriptPropertyCompositeValue) -> Bool {
		return self.currentValue === value
	}

	/**
	 * @method toHandle
	 * @since 0.7.0
	 * @hidden
	 */
	open func toHandle(_ context: JavaScriptContext) -> JSValueRef? {
		return self.currentValue.toHandle(context)
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private func update() {
		self.currentValue = JavaScriptProperty.Null
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private func update(_ value: JavaScriptProperty) {
		self.currentValue = value.currentValue
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private func update(_ value: JavaScriptPropertyValue) {
		self.currentValue = value
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private func update(_ value: JavaScriptValue) {
		self.currentValue = JavaScriptPropertyScriptValue(value: value)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private func update(_ value: String) {
		self.currentValue = JavaScriptPropertyStringValue(value: value)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private func update(_ value: Double) {
		self.currentValue = JavaScriptPropertyNumberValue(value: value)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private func update(_ value: Double, unit: JavaScriptPropertyUnit) {
		self.currentValue = JavaScriptPropertyNumberValue(value: value, unit: unit)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private func update(_ value: Bool) {
		self.currentValue = JavaScriptPropertyBooleanValue(value: value)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private func update(_ value: JavaScriptPropertyVariableValue) {
		self.currentValue = value
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private func update(_ value: JavaScriptPropertyFunctionValue) {
		self.currentValue = value
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private func update(_ value: JavaScriptPropertyCompositeValue) {
		self.currentValue = value
	}

	/**
	 * @method change
	 * @since 0.7.0
	 * @hidden
	 */
	private func change() {
		self.handler?(self)
	}
}

/**
 * @function toPtr
 * @since 0.7.0
 * @hidden
 */
private func toPtr(_ val: JavaScriptProperty) -> UnsafeMutableRawPointer {
	return Unmanaged.passUnretained(val).toOpaque()
}

/**
 * @function toVal
 * @since 0.7.0
 * @hidden
 */
private func toVal(_ ptr: UnsafeMutableRawPointer) -> JavaScriptProperty {
	return Unmanaged<JavaScriptProperty>.fromOpaque(ptr).takeUnretainedValue()
}

/**
 * @function javaScriptPropertyParse
 * @since 0.7.0
 * @hidden
 */
private let javaScriptPropertyParse: @convention(c) (UnsafeMutablePointer<ValueRef?>?, Int, UnsafeMutableRawPointer?) -> Void = { values, length, context in

	let values = values!
	let context = context!

	let property = toVal(context)

	if (length == 1) {

		guard let value = values.pointee else {
			return
		}

		switch (ValueGetType(value)) {

			case kValueTypeNull:
				property.resetWithNull()
			case kValueTypeString:
				property.resetWithString(value)
			case kValueTypeNumber:
				property.resetWithNumber(value)
			case kValueTypeBoolean:
				property.resetWithBoolean(value)
			case kValueTypeVariable:
				property.resetWithVariable(value)
			case kValueTypeFunction:
				property.resetWithFunction(value)

			default:
				break;
		}

		return
	}

	/*
	 * The parser returned multiple values. In this case we create a
	 * composite value and reset the property with it.
	 */

	var components = [JavaScriptPropertyValue]()

	for i in 0 ..< length {

		guard let value = (values + i).pointee else {
			continue
		}

		switch (ValueGetType(value)) {

			case kValueTypeNull:
				components.append(JavaScriptProperty.Null)
			case kValueTypeString:
				components.append(property.createString(value))
			case kValueTypeNumber:
				components.append(property.createNumber(value))
			case kValueTypeBoolean:
				components.append(property.createBoolean(value))
			case kValueTypeVariable:
				components.append(property.createVariable(value))
			case kValueTypeFunction:
				components.append(property.createFunction(value))

			default:
				break
		}
	}

	property.reset(JavaScriptPropertyCompositeValue(values: components))
}
