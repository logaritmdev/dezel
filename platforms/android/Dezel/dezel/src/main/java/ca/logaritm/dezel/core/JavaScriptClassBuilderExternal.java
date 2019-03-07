package ca.logaritm.dezel.core;

/**
 * @class JavaScriptClassBuilderExternal
 * @hidden
 * @since 0.1.0
 */
public class JavaScriptClassBuilderExternal {

	/**
	 * @method createConstructor
	 * @hidden
	 * @since 0.1.0
	 */
	static native public void createConstructor(long context, long object, String name, String fqmn, Class cls, Object ctx);

	/**
	 * @method createFunction
	 * @hidden
	 * @since 0.1.0
	 */
	static native public void createFunction(long context, long object, String name, String fqmn, Class cls, Object ctx);

	/**
	 * @method createGetter
	 * @hidden
	 * @since 0.1.0
	 */
	static native public void createGetter(long context, long object, String name, String fqmn, Class cls, Object ctx);

	/**
	 * @method createSetter
	 * @hidden
	 * @since 0.1.0
	 */
	static native public void createSetter(long context, long object, String name, String fqmn, Class cls, Object ctx);
}
