/**
 * A JavaScript property.
 * @class JavaScriptProperty
 * @since 0.7.0
 */
public class JavaScriptProperty: NSObject {

	//--------------------------------------------------------------------------
	// MARK: Type Alias
	//--------------------------------------------------------------------------

	/**
	 * The property change handler.
	 * @alias JavaScriptPropertyHandler
	 * @since 0.7.0
	 */
	public typealias JavaScriptPropertyHandler = (JavaScriptProperty) -> Void

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The property's type.
	 * @property type
	 * @since 0.7.0
	 */
	public var type: JavaScriptPropertyType {
		return self.storage.type
	}

	/**
	 * The property's unit.
	 * @property unit
	 * @since 0.7.0
	 */
	public var unit: JavaScriptPropertyUnit {
		return self.storage.unit
	}

	/**
	 * The property's string value.
	 * @property string
	 * @since 0.7.0
	 */
	public var string: String {
		return self.storage.string
	}

	/**
	 * The property's number value.
	 * @property number
	 * @since 0.7.0
	 */
	public var number: Double {
		return self.storage.number
	}

	/**
	 * The property's boolean value.
	 * @property boolean
	 * @since 0.7.0
	 */
	public var boolean: Bool {
		return self.storage.boolean
	}

	/**
	 * Indicate whether the property is null.
	 * @property isNull
	 * @since 0.7.0
	 */
	public var isNull: Bool {
		return self.type == .null
	}

	/**
	 * Indicate whether the property is a string.
	 * @property isString
	 * @since 0.7.0
	 */
	public var isString: Bool {
		return self.type == .string
	}

	/**
	 * Indicate whether the property is a number.
	 * @property isNumber
	 * @since 0.7.0
	 */
	public var isNumber: Bool {
		return self.type == .number
	}

	/**
	 * Indicate whether the property is a boolean.
	 * @property isBoolean
	 * @since 0.7.0
	 */
	public var isBoolean: Bool {
		return self.type == .boolean
	}

	/**
	 * Indicate whether the property is an object.
	 * @property isObject
	 * @since 0.7.0
	 */
	public var isObject: Bool {
		return self.type == .object
	}

	/**
	 * Indicate whether the property is an array.
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
	 * @property storage
	 * @since 0.7.0
	 * @hidden
	 */
	private var storage: JavaScriptPropertyStorage

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
	 * Initializes the property to nil.
	 * @constructor
	 * @since 0.7.0
	 */
	public init(handler: JavaScriptPropertyHandler? = nil) {
		self.storage = JavaScriptPropertyStorage()
		self.handler = handler
	}

	/**
	 * Initializes the property with a string.
	 * @constructor
	 * @since 0.7.0
	 */
	public init(string: String, handler: JavaScriptPropertyHandler? = nil) {
		self.storage = JavaScriptPropertyStorageString(value: string)
		self.handler = handler
	}

	/**
	 * Initializes the property with a number.
	 * @constructor
	 * @since 0.7.0
	 */
	public init(number: Double, handler: JavaScriptPropertyHandler? = nil) {
		self.storage = JavaScriptPropertyStorageNumber(value: number)
		self.handler = handler
	}

	/**
	 * Initializes the property with a number.
	 * @constructor
	 * @since 0.7.0
	 */
	public init(number: Double, unit: JavaScriptPropertyUnit, handler: JavaScriptPropertyHandler? = nil) {
		self.storage = JavaScriptPropertyStorageNumber(value: number, unit: unit)
		self.handler = handler
	}

	/**
	 * Initializes the property with a boolean.
	 * @constructor
	 * @since 0.7.0
	 */
	public init(boolean: Bool, handler: JavaScriptPropertyHandler? = nil) {
		self.storage = JavaScriptPropertyStorageBoolean(value: boolean)
		self.handler = handler
	}

	/**
	 * Parses the string and
	 * @method reset
	 * @since 0.7.0
	 */
	public func parse(_ value: String, lock: AnyObject? = nil) {

		if isLocked(self.lock, key: lock) {
			return
		}

		self.lock = lock

 		if let result = JavaScriptPropertyParser.parse(value) {

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

			return
		}

		self.reset(value)
	}

	/**
	 * Resets this property's value to null.
	 * @method reset
	 * @since 0.7.0
	 */
	public func reset(lock: AnyObject? = nil) {

		if isLocked(self.lock, key: lock) {
			return
		}

		self.lock = lock

		if (self.isNull == false) {
			self.update()
			self.change()
		}
	}

	/**
	 * Resets this property's value using a JavaScript value.
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
					self.reset()
				case .string:
					self.reset(result.string)
				case .number:
					self.reset(result.number, unit: result.unit)
				case .boolean:
					self.reset(result.boolean)

				default:
					break
			}

			self.storage.store(value)
			return
		}

		if (self.equals(value) == false) {
			self.update(value)
			self.change()
		}
	}

	/**
	 * Resets this property's value using a string.
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
	 * Resets this property's value using a number.
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
	 * Resets this property's value using a number.
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
	 * Resets this property's value using a boolean.
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
	 * Indicate whether this property's value is a specified JavaScript value.
	 * @method equals
	 * @since 0.7.0
	 */
	public func equals(_ value: JavaScriptValue) -> Bool {
		return self.storage.equals(value)
	}

	/**
	 * Indicate whether this property's value is a specified string.
	 * @method equals
	 * @since 0.7.0
	 */
	public func equals(_ value: String) -> Bool {
		return self.storage.equals(value)
	}

	/**
	 * Indicate whether this property's value is a specified number.
	 * @method equals
	 * @since 0.7.0
	 */
	public func equals(_ value: Double) -> Bool {
		return self.storage.equals(value)
	}

	/**
	 * Indicate whether this property's value is a specified number.
	 * @method equals
	 * @since 0.7.0
	 */
	public func equals(_ value: Double, unit: JavaScriptPropertyUnit) -> Bool {
		return self.storage.equals(value, unit: unit)
	}

	/**
	 * Indicate whether this property's value is a specified boolean.
	 * @method equals
	 * @since 0.7.0
	 */
	public func equals(_ value: Bool) -> Bool {
		return self.storage.equals(value)
	}

	/**
	 * Casts the property to a specified type.
	 * @method cast
	 * @since 0.7.0
	 */
	public func cast<T>(_ type: T.Type) -> T? {
		return self.storage.cast(type)
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
		return self.storage.toHandle(context)
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
		self.storage = JavaScriptPropertyStorage()
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private func update(_ value: JavaScriptValue) {
		self.storage = JavaScriptPropertyStorageValue(value: value)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private func update(_ value: String) {
		self.storage = JavaScriptPropertyStorageString(value: value)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private func update(_ value: Double) {
		self.storage = JavaScriptPropertyStorageNumber(value: value)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private func update(_ value: Double, unit: JavaScriptPropertyUnit) {
		self.storage = JavaScriptPropertyStorageNumber(value: value, unit: unit)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	private func update(_ value: Bool) {
		self.storage = JavaScriptPropertyStorageBoolean(value: value)
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
