
/**
 * @class JavaScriptPropertyValue
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptPropertyValue {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The property's type.
	 * @property type
	 * @since 0.7.0
	 */
	public var type: JavaScriptPropertyType = .null

	/**
	 * The property's unit.
	 * @property unit
	 * @since 0.7.0
	 */
	public var unit: JavaScriptPropertyUnit = .none

	/**
	 * The property's string value.
	 * @property string
	 * @since 0.7.0
	 */
	public lazy var string: String = {
		return self.toString()
	}()

	/**
	 * The property's number value.
	 * @property number
	 * @since 0.7.0
	 */
	public lazy var number: Double = {
		return self.toNumber()
	}()

	/**
	 * The property's boolean value.
	 * @property boolean
	 * @since 0.7.0
	 */
	public lazy var boolean: Bool = {
		return self.toBoolean()
	}()

	/**
	 * @property value
	 * @since 0.7.0
	 * @hidden
	 */
	private var value: JavaScriptValue?

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the property storage.
	 * @constructor
	 * @since 0.7.0
	 */
	public init(type: JavaScriptPropertyType = .null, unit: JavaScriptPropertyUnit = .none, value: JavaScriptValue? = nil) {

		self.type = type
		self.unit = unit

		/*
		 * The data parameter is the JavaScript value given initialy. It's
		 * useful to keep a reference instead of recreating a JavaScript value
		 * from the primitive values.
		 */

		self.value = value
	}

	/**
	 * Stores the backing JavaScript value.
	 * @method store
	 * @since 0.7.0
	 */
	open func store(_ value: JavaScriptValue?) {
		self.value = value
	}

	/**
	 * Returns the data as a string.
	 * @method toString
	 * @since 0.7.0
	 */
	open func toString() -> String {
		return ""
	}

	/**
	 * Returns the data as a number.
	 * @method toNumber
	 * @since 0.7.0
	 */
	open func toNumber() -> Double {
		return 0.0
	}

	/**
	 * Returns the data as a boolean.
	 * @method toBoolean
	 * @since 0.7.0
	 */
	open func toBoolean() -> Bool {
		return false
	}

	/**
	 * Indicate whether this property's value is a specified JavaScript value.
	 * @method equals
	 * @since 0.7.0
	 */
	open func equals(_ value: JavaScriptValue) -> Bool {
		return self.value?.equals(value) ?? false
	}

	/**
	 * Indicate whether this property's value is a specified string.
	 * @method equals
	 * @since 0.7.0
	 */
	open func equals(_ value: String) -> Bool {
		return self.type == .string && self.string == value
	}

	/**
	 * Indicate whether this property's value is a specified number.
	 * @method equals
	 * @since 0.7.0
	 */
	open func equals(_ value: Double) -> Bool {
		return self.type == .number && self.number == value
	}

	/**
	 * Indicate whether this property's value is a specified number.
	 * @method equals
	 * @since 0.7.0
	 */
	open func equals(_ value: Double, unit: JavaScriptPropertyUnit) -> Bool {
		return self.type == .number && self.number == value && self.unit == unit
	}

	/**
	 * Indicate whether this property's value is a specified boolean.
	 * @method equals
	 * @since 0.7.0
	 */
	open func equals(_ value: Bool) -> Bool {
		return self.type == .boolean && self.boolean == value
	}

	/**
	 * Casts the property to a specified type
	 * @method equals
	 * @since 0.7.0
	 */
	open func cast<T>(_ type: T.Type) -> T? {
		return self.value?.cast(type)
	}

	//--------------------------------------------------------------------------
	// MARK: Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method toHandle
	 * @since 0.7.0
	 * @hidden
	 */
	internal func toHandle(_ context: JavaScriptContext) -> JSValueRef? {

		if let value = self.value {
			return value.toHandle(context)
		}

		if (self.unit == .none) {

			switch (self.type) {

				case .null:
					self.value = context.jsnull
				case .string:
					self.value = context.createString(self.string)
				case .number:
					self.value = context.createNumber(self.number)
				case .boolean:
					self.value = context.createBoolean(self.boolean)

				default:
					break
			}

		} else {

			self.value = context.createString(self.string)
			
		}

		return self.value?.toHandle(context)
	}
}
