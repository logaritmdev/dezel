package ca.logaritm.dezel.style;

/**
 * @class StylerExternal
 * @since 0.1.0
 * @hidden
 */
public class StylerExternal {

	/**
	 * @method create
	 * @since 0.1.0
	 * @hidden
	 */
	static native long create();

	/**
	 * @method delete
	 * @since 0.1.0
	 * @hidden
	 */
	static native void delete(long handle);

	/**
	 * @method setRoot
	 * @since 0.1.0
	 * @hidden
	 */
	static native void setRoot(long handle, long node);

	/**
	 * @method load
	 * @since 0.3.0
	 * @hidden
	 */
	static native void load(long handle, String code, String file);

	/**
	 * @method setVariable
	 * @since 0.3.0
	 * @hidden
	 */
	static native void setVariable(long handle, String name, String value);
}
