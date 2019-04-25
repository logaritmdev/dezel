package ca.logaritm.dezel.core;

/**
 * @class JavaScriptContextExternal
 * @hidden
 * @since 0.1.0
 */
public class JavaScriptContextExternal {

	/**
	 * @method create
	 * @hidden
	 * @since 0.1.0
	 */
	static native public long create(String identifier);

	/**
	 * @method delete
	 * @hidden
	 * @since 0.1.0
	 */
	static native public void delete(long context);

	/**
	 * @method getGlobalObject
	 * @hidden
	 * @since 0.1.0
	 */
	static native public long getGlobalObject(long context);

	/**
	 * @method evaluate
	 * @hidden
	 * @since 0.1.0
	 */
	static native public void evaluate(long context, String string);

	/**
	 * @method evaluate
	 * @hidden
	 * @since 0.1.0
	 */
	static native public void evaluate(long context, String string, String file);

	/**
	 * @method setAttribute
	 * @hidden
	 * @since 0.1.0
	 */
	static native public void setAttribute(long context, int key, Object val);

	/**
	 * @method getAttribute
	 * @hidden
	 * @since 0.1.0
	 */
	static native public Object getAttribute(long context, int key);

	/**
	 * @method setAttribute
	 * @hidden
	 * @since 0.6.0
	 */
	static native public void delAttribute(long context, int key);

	/**
	 * @method setExceptionCallback
	 * @hidden
	 * @since 0.1.0
	 */
	static native public void setExceptionCallback(long context, Object callback, Object ctx);

	/**
	 * @method throwError
	 * @hidden
	 * @since 0.1.0
	 */
	static native public void throwError(long context, long error);

	/**
	 * @method garbageCollect
	 * @hidden
	 * @since 0.1.0
	 */
	static native public void garbageCollect(long context);
}
