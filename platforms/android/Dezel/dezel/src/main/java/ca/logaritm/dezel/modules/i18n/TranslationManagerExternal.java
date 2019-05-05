package ca.logaritm.dezel.modules.i18n;

/**
 * @class TranslationManagerExternal
 * @since 0.5.0
 * @hidden
 */
public class TranslationManagerExternal {

	/**
	 * @method load
	 * @since 0.5.0
	 * @hidden
	 */
	static native void load(byte[] data);

	/**
	 * @method clear
	 * @since 0.6.0
	 * @hidden
	 */
	static native void clear();

	/**
	 * @method translate
	 * @since 0.5.0
	 * @hidden
	 */
	static native String translate(String message);

	/**
	 * @method translate
	 * @since 0.5.0
	 * @hidden
	 */
	static native String translate(String message, String context);
}
