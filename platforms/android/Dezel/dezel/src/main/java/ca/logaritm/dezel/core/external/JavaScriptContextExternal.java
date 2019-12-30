package ca.logaritm.dezel.core.external;

/**
 * @class JavaScriptContextExternal
 * @since 0.1.0
 * @hidden
 */
public class JavaScriptContextExternal {

	/**
	 * @method create
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long create(String identifier);

	/**
	 * @method delete
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void delete(long context);

	/**
	 * @method getGlobalObject
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long getGlobalObject(long context);

	/**
	 * @method evaluate
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void evaluate(long context, String string);

	/**
	 * @method evaluate
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void evaluate(long context, String string, String file);

	/**
	 * @method setAttribute
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setAttribute(long context, int key, Object val);

	/**
	 * @method getAttribute
	 * @since 0.1.0
	 * @hidden
	 */
	static native public Object getAttribute(long context, int key);

	/**
	 * @method setAttribute
	 * @since 0.6.0
	 * @hidden
	 */
	static native public void delAttribute(long context, int key);

	/**
	 * @method setExceptionCallback
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setExceptionCallback(long context, Object callback, Object ctx);

	/**
	 * @method garbageCollect
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void garbageCollect(long context);
}
