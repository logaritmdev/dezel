
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
	 * @property type
	 * @since 0.7.0
	 */
	public var type: JavaScriptPropertyType = .null

	/**
	 * @property unit
	 * @since 0.7.0
	 */
	public var unit: JavaScriptPropertyUnit = .none

	/**
	 * @property string
	 * @since 0.7.0
	 */
	public lazy var string: String = {
		return self.toString()
	}()

	/**
	 * @property number
	 * @since 0.7.0
	 */
	public lazy var number: Double = {
		return self.toNumber()
	}()

	/**
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
	 * @method reset
	 * @since 0.7.0
	 */
	open func reset(_ value: JavaScriptValue?) {
		self.value = value
	}

	/**
	 * @method toString
	 * @since 0.7.0
	 */
	open func toString() -> String {
		return ""
	}

	/**
	 * @method toNumber
	 * @since 0.7.0
	 */
	open func toNumber() -> Double {
		return 0.0
	}

	/**
	 * @method toBoolean
	 * @since 0.7.0
	 */
	open func toBoolean() -> Bool {
		return false
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	open func equals(_ value: JavaScriptValue) -> Bool {
		return self.value?.equals(value) ?? false
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	open func equals(_ value: String) -> Bool {
		return self.type == .string && self.string == value
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	open func equals(_ value: Double) -> Bool {
		return self.type == .number && self.number == value
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	open func equals(_ value: Double, unit: JavaScriptPropertyUnit) -> Bool {
		return self.type == .number && self.number == value && self.unit == unit
	}

	/**
	 * @method equals
	 * @since 0.7.0
	 */
	open func equals(_ value: Bool) -> Bool {
		return self.type == .boolean && self.boolean == value
	}

	/**
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
