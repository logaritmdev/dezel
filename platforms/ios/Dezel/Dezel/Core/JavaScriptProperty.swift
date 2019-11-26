/**
 * @class JavaScriptProperty
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
	// MARK: Properties
	//--------------------------------------------------------------------------

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
	 * @property isNull
	 * @since 0.7.0
	 */
	public var isNull: Bool {
		return self.type == .null
	}

	/**
	 * @property isString
	 * @since 0.7.0
	 */
	public var isString: Bool {
		return self.type == .string
	}

	/**
	 * @property isNumber
	 * @since 0.7.0
	 */
	public var isNumber: Bool {
		return self.type == .number
	}

	/**
	 * @property isBoolean
	 * @since 0.7.0
	 */
	public var isBoolean: Bool {
		return self.type == .boolean
	}

	/**
	 * @property isObject
	 * @since 0.7.0
	 */
	public var isObject: Bool {
		return self.type == .object
	}

	/**
	 * @property isArray
	 * @since 0.7.0
	 */
	public var isArray: Bool {
		return self.type == .array
	}

	/**
	 * @property lock
	 * @since 0.7.0
	 * @hidden
	 */
	private var lock: AnyObject?

	/**
	 * @property initial
	 * @since 0.7.0
	 * @hidden
	 */
	private var initialValue: JavaScriptPropertyValue

	/**
	 * @property storage
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
		self.initialValue = JavaScriptPropertyValue()
		self.currentValue = self.initialValue
		self.handler = handler
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public init(string: String, handler: JavaScriptPropertyHandler? = nil) {
		self.initialValue = JavaScriptPropertyStringValue(value: string)
		self.currentValue = self.initialValue
		self.handler = handler
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public init(number: Double, handler: JavaScriptPropertyHandler? = nil) {
		self.initialValue = JavaScriptPropertyNumberValue(value: number)
		self.currentValue = self.initialValue
		self.handler = handler
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public init(number: Double, unit: JavaScriptPropertyUnit, handler: JavaScriptPropertyHandler? = nil) {
		self.initialValue = JavaScriptPropertyNumberValue(value: number, unit: unit)
		self.currentValue = self.initialValue
		self.handler = handler
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public init(boolean: Bool, handler: JavaScriptPropertyHandler? = nil) {
		self.initialValue = JavaScriptPropertyBooleanValue(value: boolean)
		self.currentValue = self.initialValue
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
	 * @method parse
	 * @since 0.7.0
	 */
	public func parse(_ value: String, lock: AnyObject? = nil) {

		if isLocked(self.lock, key: lock) {
			return
		}

		self.lock = lock

 		guard let result = JavaScriptPropertyParser.parse(value) else {
			self.reset(value)
			return
		}

		switch (result.type) {

			case .string:
				self.reset(result.string)
			case .number:
				self.reset(result.number, unit: result.unit)
			case .boolean:
				self.reset(result.boolean)

			default:
				break
		}
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
	public func reset(_ value: JavaScriptValue?, lock: AnyObject? = nil) {

		if isLocked(self.lock, key: lock) {
			return
		}

		self.lock = lock

		guard let value = value else {
			self.reset()
			return
		}

		if let result = JavaScriptPropertyParser.parse(value) {

			switch (result.type) {

				case .null:
					self.reset(lock: lock)
				case .string:
					self.reset(result.string, lock: lock)
				case .number:
					self.reset(result.number, unit: result.unit, lock: lock)
				case .boolean:
					self.reset(result.boolean, lock: lock)

				default:
					break
			}

		} else {

			if (self.equals(value) == false) {
				self.update(value)
				self.change()
			}

		}

		self.currentValue.reset(value)
	}

	/**
	 * @method reset
	 * @since 0.7.0
	 */
	public func reset(_ value: String, lock: AnyObject? = nil) {

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
		self.currentValue = JavaScriptPropertyValue()
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
		self.currentValue = JavaScriptPropertyRawValue(value: value)
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
	 * @method change
	 * @since 0.7.0
	 * @hidden
	 */
	private func change() {
		self.handler?(self)
	}
}
