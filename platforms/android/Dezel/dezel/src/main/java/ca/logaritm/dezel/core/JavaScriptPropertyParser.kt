package ca.logaritm.dezel.core

import ca.logaritm.dezel.extension.type.isNumeric
import ca.logaritm.dezel.extension.type.last2
import ca.logaritm.dezel.extension.type.last3
import ca.logaritm.dezel.extension.type.toNumber

/**
 * @class JavaScriptPropertyParser
 * @since 0.7.0
 */
public object JavaScriptPropertyParser {

	//--------------------------------------------------------------------------
	// Classes
	//--------------------------------------------------------------------------

	/**
	 * @struct Result
	 * @since 0.7.0
	 */
	public class Result(type: JavaScriptPropertyType = JavaScriptPropertyType.NULL, unit: JavaScriptPropertyUnit = JavaScriptPropertyUnit.NONE) {

		/**
		 * @property type
		 * @since 0.7.0
		 */
		public var type: JavaScriptPropertyType = JavaScriptPropertyType.NULL

		/**
		 * @property unit
		 * @since 0.7.0
		 */
		public var unit: JavaScriptPropertyUnit = JavaScriptPropertyUnit.NONE

		/**
		 * @property string
		 * @since 0.7.0
		 */
		public var string: String = ""

		/**
		 * @property number
		 * @since 0.7.0
		 */
		public var number: Double = 0.0

		/**
		 * @property boolean
		 * @since 0.7.0
		 */
		public var boolean: Boolean = false

		/**
		 * @property isNull
		 * @since 0.7.0
		 */
		public val isNull: Boolean
			get() = this.type == JavaScriptPropertyType.NULL

		/**
		 * @property isString
		 * @since 0.7.0
		 */
		public val isString: Boolean
			get() = this.type == JavaScriptPropertyType.STRING

		/**
		 * @property isNumber
		 * @since 0.7.0
		 */
		public val isNumber: Boolean
			get() = this.type == JavaScriptPropertyType.NUMBER

		/**
		 * @property isBoolean
		 * @since 0.7.0
		 */
		public val isBoolean: Boolean
			get() = this.type == JavaScriptPropertyType.BOOLEAN

		/**
		 * @constructor
		 * @since 0.7.0
		 */
		init {
			this.type = type
			this.unit = unit
		}

		/**
		 * @constructor
		 * @since 0.7.0
		 */
		public constructor(string: String) : this(JavaScriptPropertyType.STRING, JavaScriptPropertyUnit.NONE) {
			this.string = string
		}

		/**
		 * @constructor
		 * @since 0.7.0
		 */
		public constructor(number: Double) : this(JavaScriptPropertyType.NUMBER, JavaScriptPropertyUnit.NONE) {
			this.number = number
		}

		/**
		 * @constructor
		 * @since 0.7.0
		 */
		public constructor(number: Double, unit: JavaScriptPropertyUnit) : this(JavaScriptPropertyType.NUMBER, unit) {
			this.number = number
		}

		/**
		 * @constructor
		 * @since 0.7.0
		 */
		public constructor(boolean: Boolean) : this(JavaScriptPropertyType.BOOLEAN, JavaScriptPropertyUnit.NONE) {
			this.boolean = boolean
		}
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method parse
	 * @since 0.7.0
	 */
	public fun parse(value: JavaScriptValue): Result? {

		when (true) {
			value.isNull      -> return Result()
			value.isUndefined -> return Result()
			value.isString    -> return this.parse(value.string)
			value.isNumber    -> return Result(value.number)
			value.isBoolean   -> return Result(value.boolean)
			else              -> {}
		}

		return null
	}

	/**
	 * @method parse
	 * @since 0.7.0
	 */
	public fun parse(value: String): Result? {

		if (value.isNumeric) {

			if (value.takeLast(1) == "%") {
				return Result(value.toNumber(), JavaScriptPropertyUnit.PC)
			}

			when (value.last2) {
				"px" -> return Result(value.toNumber(), JavaScriptPropertyUnit.PX)
				"vw" -> return Result(value.toNumber(), JavaScriptPropertyUnit.VW)
				"vh" -> return Result(value.toNumber(), JavaScriptPropertyUnit.VH)
				"pw" -> return Result(value.toNumber(), JavaScriptPropertyUnit.PW)
				"ph" -> return Result(value.toNumber(), JavaScriptPropertyUnit.PH)
				"cw" -> return Result(value.toNumber(), JavaScriptPropertyUnit.CW)
				"ch" -> return Result(value.toNumber(), JavaScriptPropertyUnit.CH)
				else -> {}
			}

			when (value.last3) {
				"deg" -> return Result(value.toNumber(), JavaScriptPropertyUnit.DEG)
				"rad" -> return Result(value.toNumber(), JavaScriptPropertyUnit.RAD)
				else  -> {}
			}

			return Result(value.toNumber())

		} else if (value == "null") {

			return Result()

		} else if (value == "true") {

			return Result(true)

		} else if (value == "false") {

			return Result(false)

		}

		return null
	}
}
