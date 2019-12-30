package ca.logaritm.dezel.view.display.external;

/**
 * @class FunctionValueExternal
 * @since 0.7.0
 * @hidden
 */
public class FunctionValueExternal {

	/**
	 * @method getName
	 * @since 0.7.0
	 * @hidden
	 */
	static public native String getName(long handle);

	/**
	 * @method getArguments
	 * @since 0.7.0
	 * @hidden
	 */
	static public native int getArguments(long handle);

	/**
	 * @method getArgument
	 * @since 0.7.0
	 * @hidden
	 */
	static public native long getArgument(long handle, int index);
}
