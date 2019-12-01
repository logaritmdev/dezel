package ca.logaritm.dezel.core;

/**
 * @class JavaScriptClassBuilderExternal
 * @since 0.1.0
 * @hidden
 */
public class JavaScriptClassBuilderExternal {

	/**
	 * @method createConstructor
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void createConstructor(long context, long object, String name, String fqmn, Class cls, Object ctx);

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

	/**
	 * @method createStaticFunction
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void createStaticFunction(long context, long object, String name, String fqmn, Class cls, Object ctx);

	/**
	 * @method createStaticGetter
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void createStaticGetter(long context, long object, String name, String fqmn, Class cls, Object ctx);

	/**
	 * @method createStaticSetter
	 * @since 0.7.0
	 * @hidden
	 */
	static native public void createStaticSetter(long context, long object, String name, String fqmn, Class cls, Object ctx);
}
