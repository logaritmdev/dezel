/**
 * Parses numeric properties.
 * @class JavaScriptPropertyParser
 * @since 0.7.0
 */
open class JavaScriptPropertyParser {

	//--------------------------------------------------------------------------
	// MARK: Classes
	//--------------------------------------------------------------------------

	/**
	 * The result.
	 * @struct Result
	 * @since 0.7.0
	 */
	public class Result {

		/**
		 * The result's type.
		 * @property type
		 * @since 0.7.0
		 */
		public var type: JavaScriptPropertyType = .null

		/**
		 * The result's unit.
		 * @property unit
		 * @since 0.7.0
		 */
		public var unit: JavaScriptPropertyUnit = .none

		/**
		 * The result's string.
		 * @property string
		 * @since 0.7.0
		 */
		public var string: String!

		/**
		 * The result's number.
		 * @property number
		 * @since 0.7.0
		 */
		public var number: Double!

		/**
		 * The result's boolean.
		 * @property boolean
		 * @since 0.7.0
		 */
		public var boolean: Bool!

		/**
		 * Indicate whether the result is null.
		 * @property isNull
		 * @since 0.7.0
		 */
		public var isNull: Bool {
			return self.type == .null
		}

		/**
		 * Indicate whether the result is a string.
		 * @property isString
		 * @since 0.7.0
		 */
		public var isString: Bool {
			return self.type == .string
		}

		/**
		 * Indicate whether the result is a number.
		 * @property isNumber
		 * @since 0.7.0
		 */
		public var isNumber: Bool {
			return self.type == .number
		}

		/**
		 * Indicate whether the result is a boolean.
		 * @property isBoolean
		 * @since 0.7.0
		 */
		public var isBoolean: Bool {
			return self.type == .boolean
		}

		/**
		 * Initializes the result.
		 * @constructor
		 * @since 0.7.0
		 */
		public init() {
			self.type = .null
			self.unit = .none
		}

		/**
		 * Initializes the result.
		 * @constructor
		 * @since 0.7.0
		 */
		public init(string: String) {
			self.type = .string
			self.unit = .none
			self.string = string
		}

		/**
		 * Initializes the result.
		 * @constructor
		 * @since 0.7.0
		 */
		public init(number: Double) {
			self.type = .number
			self.unit = .none
			self.number = number
		}

		/**
		 * Initializes the result.
		 * @constructor
		 * @since 0.7.0
		 */
		public init(number: Double, unit: JavaScriptPropertyUnit) {
			self.type = .number
			self.unit = unit
			self.number = number
		}

		/**
		 * Initializes the result.
		 * @constructor
		 * @since 0.7.0
		 */
		public init(boolean: Bool) {
			self.type = .boolean
			self.unit = .none
			self.boolean = boolean
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * Parses the specified JavaScript value.
	 * @method parse
	 * @since 0.7.0
	 */
	public static func parse(_ value: JavaScriptValue) -> Result? {

		switch (true) {

			case value.isNull:
				return Result()
			case value.isUndefined:
				return Result()
			case value.isString:
				return self.parse(value.string)
			case value.isNumber:
				return Result(number: value.number)
			case value.isBoolean:
				return Result(boolean: value.boolean)

			default:
				break
		}

		return nil
	}

	/**
	 * Parses the specified string.
	 * @method parse
	 * @since 0.7.0
	 */
	public static func parse(_ value: String) -> Result? {

		if (value.isNumeric) {

			if (value.suffix(1) == "%") {
				return Result(number: value.toNumber(), unit: .pc)
			}

			switch (value.last2) {

				case "px": return Result(number: value.toNumber(), unit: .px)
				case "vw": return Result(number: value.toNumber(), unit: .vw)
				case "vh": return Result(number: value.toNumber(), unit: .vh)
				case "pw": return Result(number: value.toNumber(), unit: .pw)
				case "ph": return Result(number: value.toNumber(), unit: .ph)
				case "cw": return Result(number: value.toNumber(), unit: .cw)
				case "ch": return Result(number: value.toNumber(), unit: .ch)

				default:
					break
			}

			switch (value.last3) {

				case "deg": return Result(number: value.toNumber(), unit: .deg)
				case "rad": return Result(number: value.toNumber(), unit: .rad)

				default:
					break
			}

			return Result(number: value.toNumber())

		} else if (value == "null") {

			return Result()

		} else if (value == "true") {

			return Result(boolean: true)

		} else if (value == "false") {

			return Result(boolean: false)

		}

		return nil
	}
}
