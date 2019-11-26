/**
 * @class Property
 * @since 0.1.0
 */
open class JavaScriptProperty: NSObject {

	//--------------------------------------------------------------------------
	// MARK: Static
	//--------------------------------------------------------------------------

	/**
	 * @method parse
	 * @since 0.2.0
	 */
	public static func parse(_ raw: String) -> JavaScriptProperty {
		let property = JavaScriptProperty()
		property.parse(string: raw)
		return property
	}

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property type
	 * @since 0.1.0
	 */
	private(set) public var type: PropertyType = .null

	/**
	 * @property unit
	 * @since 0.1.0
	 */
	private(set) public var unit: PropertyUnit = .none

	/**
	 * @property string
	 * @since 0.1.0
	 */
	lazy private(set) public var string: String = self.initializeString()

	/**
	 * @property number
	 * @since 0.1.0
	 */
	lazy private(set) public var number: Double = self.initializeNumber()

	/**
	 * @property boolean
	 * @since 0.1.0
	 */
	lazy private(set) public var boolean: Bool = self.initializeBoolean()

	/**
	 * @property cache
	 * @since 0.1.0
	 * @hidden
	 */
	private var cache: JavaScriptValue?

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	public override init() {
		super.init()
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	public convenience init(string: String) {
		self.init()
		self.set(string)
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	public convenience init(number: Double) {
		self.init()
		self.set(number, unit: .none)
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	public convenience init(number: Double, unit: PropertyUnit = .none) {
		self.init()
		self.set(number, unit: unit)
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	public convenience init(boolean: Bool) {
		self.init()
		self.set(boolean)
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	public convenience init(value: JavaScriptValue) {

		self.init()

		self.cache = value

		if (value.isNull ||
			value.isUndefined) {
			self.type = .null
			return
		}

		if (value.isArray) {
			self.type = .array
			return
		}

		if (value.isObject) {
			self.type = .object
			return
		}

		if (value.isString) {
			self.parse(string: value.string)
			return
		}

		if (value.isNumber) {
			self.set(value.number, unit: .none)
			return
		}

		if (value.isBoolean) {
			self.set(value.boolean)
			return
		}
	}

	/**
	 * @method reset
	 * @since 0.1.0
	 */
	public func reset(string value: String) {
		self.cache = nil
		self.set(value)
	}

	/**
	 * @method reset
	 * @since 0.1.0
	 */
	public func reset(number value: Double) {
		self.cache = nil
		self.set(value, unit: .none)
	}

	/**
	 * @method reset
	 * @since 0.1.0
	 */
	public func reset(number value: Double, unit: PropertyUnit) {
		self.cache = nil
		self.set(value, unit: unit)
	}

	/**
	 * @method reset
	 * @since 0.1.0
	 */
	public func reset(boolean value: Bool) {
		self.cache = nil
		self.set(value)
	}

	/**
	 * @method value
	 * @since 0.1.0
	 */
	open func value(in context: JavaScriptContext) -> JavaScriptValue {

		if let value = self.cache {
			return value
		}

		switch (self.type) {
			case .null:    self.cache = context.createNull()
			case .array:   self.cache = context.createEmptyArray()
			case .object:  self.cache = context.createEmptyObject()
			case .string:  self.cache = context.createString(self.string)
			case .number:  self.cache = context.createNumber(self.number, unit: self.unit)
			case .boolean: self.cache = context.createBoolean(self.boolean)
		}

		return self.cache!
	}

	/**
	 * @method cast
	 * @since 0.1.0
	 */
	open func cast<T>(_ type: T.Type) -> T? {

		guard let value = self.cache else {
			fatalError("Unable to cast")
		}

		return value.cast(type)
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method set
	 * @since 0.2.0
	 * @hidden
	 */
	private func set(_ value: String) {
		self.type = .string
		self.unit = .none
		self.string = value
	}

	/**
	 * @method set
	 * @since 0.2.0
	 * @hidden
	 */
	private func set(_ value: Double, unit: PropertyUnit) {
		self.type = .number
		self.unit = unit
		self.number = value
	}

	/**
	 * @method set
	 * @since 0.2.0
	 * @hidden
	 */
	private func set(_ value: Bool) {
		self.type = .boolean
		self.unit = .none
		self.boolean = value
	}

	/**
	 * @method parse
	 * @since 0.2.0
	 * @hidden
	 */
	private func parse(string: String) {

		if (string.length == 0) {
			self.set("")
			return
		}

		if let letter = string.first {
			if (letter != "+" &&
				letter != "-" &&
				letter != "." &&
				(letter < "0" || letter > "9")) {
				self.set(string)
				return
			}
		}

		if (string.suffix(1) == "%") {
			self.set(Conversion.ston(string), unit: .pc)
			return
		}

		switch (string.suffix(2).lowercased()) {

			case "px":
				self.set(Conversion.ston(string), unit: .px)
				return

			case "vw":
				self.set(Conversion.ston(string), unit: .vw);
				return

			case "vh":
				self.set(Conversion.ston(string), unit: .vh)
				return

			case "pw":
				self.set(Conversion.ston(string), unit: .pw)
				return

			case "ph":
				self.set(Conversion.ston(string), unit: .ph)
				return

			case "cw":
				self.set(Conversion.ston(string), unit: .cw)
				return

			case "ch":
				self.set(Conversion.ston(string), unit: .ch)
				return

			default: break
		}

		switch (string.suffix(3).lowercased()) {

			case "deg":
				self.set(Conversion.ston(string), unit: .deg)
				return

			case "rad":
				self.set(Conversion.ston(string), unit: .rad)
				return

			default: break
		}

		self.set(string)
	}

	//--------------------------------------------------------------------------
	// MARK: Private API - Lazy Initializer
	//--------------------------------------------------------------------------

	/**
	 * @method initializeString
	 * @since 0.1.0
	 * @hidden
	 */
	private func initializeString() -> String {
		switch (self.type) {
			case .null:    return ""
			case .array:   return ""
			case .object:  return ""
			case .string:  return ""
			case .number:  return Conversion.ntos(self.number)
			case .boolean: return Conversion.btos(self.boolean)
		}
	}

	/**
	 * @method initializeNumber
	 * @since 0.1.0
	 * @hidden
	 */
	private func initializeNumber() -> Double {
		switch (self.type) {
			case .null:    return 0.0
			case .array:   return Double.nan
			case .object:  return Double.nan
			case .number:  return 0.0
			case .string:  return Conversion.ston(self.string)
			case .boolean: return Conversion.bton(self.boolean)
		}
	}

	/**
	 * @method initializeBoolean
	 * @since 0.1.0
	 * @hidden
	 */
	private func initializeBoolean() -> Bool {
		switch (self.type) {
			case .null:    return false
			case .array:   return true
			case .object:  return true
			case .string:  return Conversion.stob(self.string)
			case .number:  return Conversion.ntob(self.number)
			case .boolean: return false
		}
	}
}
