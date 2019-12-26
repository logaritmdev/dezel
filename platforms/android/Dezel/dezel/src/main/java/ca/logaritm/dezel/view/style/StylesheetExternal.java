package ca.logaritm.dezel.view.style;

/**
 * @
 */
public class StylesheetInternal {

	/**
	 * @method create
	 * @since 0.7.0
	 * @hidden
	 */
	static native public long create();

	static native public void delete(long handle);

	static native public void setVariable(long handle);

	static native public void evaluate(long handle);

}
