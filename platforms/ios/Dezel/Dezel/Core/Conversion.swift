
/**
 * Value type conversion methods.
 * @class Conversion
 * @since 0.1.0
 */
public class Conversion {

	/**
	 * Converts a string to a number.
	 * @method ston
	 * @since 0.1.0
	 */
	public static func ston(_ string: String) -> Double {
		return (string as NSString).doubleValue
	}

	/**
	 * Converts a string to a boolean.
	 * @method stob
	 * @since 0.1.0
	 */
	public static func stob(_ string: String) -> Bool {
		return string.length > 0
	}

	/**
	 * Converts a number to a string.
	 * @method ntos
	 * @since 0.1.0
	 */
	public static func ntos(_ number: Double) -> String {
		return number.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", number) : String(number)
	}

	/**
	 * Converts a number to a boolean.
	 * @method ntob
	 * @since 0.1.0
	 */
	public static func ntob(_ number: Double) -> Bool {
		return number != 0.0
	}

	/**
	 * Converts a boolean to a string.
	 * @method btos
	 * @since 0.1.0
	 */
	public static func btos(_ boolean: Bool) -> String {
		return boolean ? "true" : "false"
	}

	/**
	 * Converts a boolean to a number.
	 * @method bton
	 * @since 0.1.0
	 */
	public static func bton(_ boolean: Bool) -> Double {
		return boolean ? 1.0 : 0.0
	}
}
