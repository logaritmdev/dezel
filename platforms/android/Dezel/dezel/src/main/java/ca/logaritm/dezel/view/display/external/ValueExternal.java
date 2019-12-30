package ca.logaritm.dezel.view.display.external;

/**
 * @class ValueExternal
 * @since 0.7.0
 * @hidden
 */
public class ValueExternal {

	/**
	 * @method getType
	 * @since 0.7.0
	 * @hidden
	 */
	static public native int getType(long handle);

	/**
	 * @method getUnit
	 * @since 0.7.0
	 * @hidden
	 */
	static public native int getUnit(long handle);

	/**
	 * @method getString
	 * @since 0.7.0
	 * @hidden
	 */
	static public native String getString(long handle);

	/**
	 * @method getNumber
	 * @since 0.7.0
	 * @hidden
	 */
	static public native double getNumber(long handle);

	/**
	 * @method getBoolean
	 * @since 0.7.0
	 * @hidden
	 */
	static public native boolean getBoolean(long handle);

	/**
	 * @method parse
	 * @since 0.7.0
	 * @hidden
	 */
	static public native long parse(String source);
}
