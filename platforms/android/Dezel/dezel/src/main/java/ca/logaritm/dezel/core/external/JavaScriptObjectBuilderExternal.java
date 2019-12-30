package ca.logaritm.dezel.core.external;

/**
 * @class JavaScriptObjectBuilderExternal
 * @since 0.1.0
 * @hidden
 */
public class JavaScriptObjectBuilderExternal {

	/**
	 * @method createFunction
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void createFunction(long context, long object, String name, String fqmn, Class cls, Object ctx);

	/**
	 * @method createGetter
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void createGetter(long context, long object, String name, String fqmn, Class cls, Object ctx);

	/**
	 * @method createSetter
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void createSetter(long context, long object, String name, String fqmn, Class cls, Object ctx);
}
