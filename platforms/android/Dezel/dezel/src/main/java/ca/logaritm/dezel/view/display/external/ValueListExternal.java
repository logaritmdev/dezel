package ca.logaritm.dezel.view.display.external;

/**
 * @class ValueListExternal
 * @since 0.7.0
 * @hidden
 */
public class ValueListExternal {

	/**
	 * @method delete
	 * @since 0.7.0
	 * @hidden
	 */
	static public native void delete(long handle);

	/**
	 * @method getCount
	 * @since 0.7.0
	 * @hidden
	 */
	static public native int getCount(long handle);

	/**
	 * @method getValue
	 * @since 0.7.0
	 * @hidden
	 */
	static public native long getValue(long handle, int index);

}
