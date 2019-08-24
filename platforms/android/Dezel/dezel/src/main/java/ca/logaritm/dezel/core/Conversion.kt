package ca.logaritm.dezel.core

import java.util.*

/**
 * JavaScriptValue type conversion methods.
 * @object Conversion
 * @since 0.1.0
 */
public object Conversion {

	/**
	 * Converts a string to a number.
	 * @method toNumber
	 * @since 0.7.0
	 */
	public fun toNumber(string: String): Double {

		if (string == "") {
			return 0.0
		}

		var limit = 0

		for (char in string) {
			limit += 1
			if (char.isDigit() == false &&
				char != '+' &&
				char != '-' &&
				char != '.') {
				break
			}
		}

		if (limit == 1) {
			return Double.NaN
		}

		return try {
			string.substring(0, limit - 1).toDouble()
		} catch (e: Exception) {
			Double.NaN
		}
	}

	/**
	 * Converts a boolean to a number.
	 * @method toNumber
	 * @since 0.1.0
	 */
	public fun toNumber(boolean: Boolean): Double {
		return if (boolean) 1.0 else 0.0
	}

	/**
	 * Converts a number to a string.
	 * @method toString
	 * @since 0.7.0
	 */
	public fun toString(number: Double): String {
		return if (number % 1 == 0.0) String.format(Locale.getDefault(), "%.0f", number) else number.toString()
	}

	/**
	 * Converts a boolean to a string.
	 * @method toString
	 * @since 0.7.0
	 */
	public fun toString(boolean: Boolean): String {
		return boolean.toString()
	}

	/**
	 * Converts a string to a boolean.
	 * @method toBoolean
	 * @since 0.1.0
	 */
	public fun toBoolean(string: String): Boolean {
		return string.isNotEmpty()
	}

	/**
	 * Converts a number to a boolean.
	 * @method toBoolean
	 * @since 0.1.0
	 */
	public fun toBoolean(number: Double): Boolean {
		return number != 0.0
	}
}