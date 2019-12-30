package ca.logaritm.dezel.view.display.external;

/**
 * @class StylesheetExternal
 * @since 0.7.0
 * @hidden
 */
public class StylesheetExternal {

	/**
	 * @method create
	 * @since 0.7.0
	 * @hidden
	 */
	static native public long create();

	/**
	 * @method delete
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void delete(long handle);

	/**
	 * @method setVariable
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void setVariable(long handle, String name, String value);

	/**
	 * @method evaluate
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void evaluate(long handle, String source, String url);

}
