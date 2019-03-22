package ca.logaritm.dezel.core;

/**
 * @class JavaScriptValueExternal
 * @since 0.1.0
 * @hidden
 */
public class JavaScriptValueExternal {

	/**
	 * @method createNull
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long createNull(long context);

	/**
	 * @method createUndefined
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long createUndefined(long context);

	/**
	 * @method createString
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long createString(long context, String value);

	/**
	 * @method createNumber
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long createNumber(long context, double value);

	/**
	 * @method createBoolean
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long createBoolean(long context, boolean value);

	/**
	 * @method createEmtpyObject
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long createEmtpyObject(long context);

	/**
	 * @method createEmptyArray
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long createEmptyArray(long context);

	/**
	 * @method createFunction
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long createFunction(long context, Object value, String name, Object ctx);

	/**
	 * @method protect
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void protect(long context, long value);

	/**
	 * @method unprotect
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void unprotect(long context, long value);

	/**
	 * @method call
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void call(long context, long value, long object, long[] argv, int argc, Object result);

	/**
	 * @method callMethod
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void callMethod(long context, long value, String method, long[] argv, int argc, Object result);

	/**
	 * @method construct
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void construct(long context, long value, long[] argv, int argc, Object result);

	/**
	 * @method defineProperty
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void defineProperty(long context, long value, String property, long propertyValue, Object getter, Object setter, boolean writable, boolean enumerable, boolean configurable, Object ctx);

	/**
	 * @method setProperty
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setProperty(long context, long value, String property, long propertyValue);

	/**
	 * @method setProperty
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setProperty(long context, long value, String property, String propertyValue);

	/**
	 * @method setProperty
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setProperty(long context, long value, String property, double propertyValue);

	/**
	 * @method setProperty
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setProperty(long context, long value, String property, boolean propertyValue);

	/**
	 * @method getProperty
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long getProperty(long context, long value, String property);

	/**
	 * @method deleteProperty
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void deleteProperty(long context, long value, String property);

	/**
	 * @method setPropertyAtIndex
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setPropertyAtIndex(long context, long value, int index, long propertyValue);

	/**
	 * @method setPropertyAtIndex
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setPropertyAtIndex(long context, long value, int index, String propertyValue);

	/**
	 * @method setPropertyAtIndex
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setPropertyAtIndex(long context, long value, int index, double propertyValue);

	/**
	 * @method setPropertyAtIndex
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setPropertyAtIndex(long context, long value, int index, boolean propertyValue);

	/**
	 * @method getPropertyAtIndex
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long getPropertyAtIndex(long context, long value, int index);

	/**
	 * @method setPrototype
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setPrototype(long context, long value, long prototype);

	/**
	 * @method getPrototype
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long getPrototype(long context, long value);

	/**
	 * @method setAttribute
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setAttribute(long context, long value, int key, Object val);

	/**
	 * @method getAttribute
	 * @since 0.1.0
	 * @hidden
	 */
	static native public Object getAttribute(long context, long value, int key);

	/**
	 * @method getAttribute
	 * @since 0.1.0
	 * @hidden
	 */
	static native public Object getAttribute(long handle, int key);

	/**
	 * @method deleteAttribute
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void deleteAttribute(long context, long value, int key);

	/**
	 * @method deleteAttribute
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void deleteAttribute(long handle, int key);

	/**
	 * @method setAssociatedObject
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setAssociatedObject(long context, long value, Object object);

	/**
	 * @method setAssociatedObject
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setAssociatedObject(long handle, Object object);

	/**
	 * @method getAssociatedObject
	 * @since 0.1.0
	 * @hidden
	 */
	static native public Object getAssociatedObject(long context, long value);

	/**
	 * @method getAssociatedObject
	 * @since 0.1.0
	 * @hidden
	 */
	static native public Object getAssociatedObject(long handle);

	/**
	 * @method deleteAssociatedObject
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void deleteAssociatedObject(long context, long value);

	/**
	 * @method deleteAssociatedObject
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void deleteAssociatedObject(long handle);

	/**
	 * @method setFinalizeHandler
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setFinalizeHandler(long context, long value, Object wrapper, Object ctx);

	/**
	 * @method equals
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean equals(long context, long v1, long v2);

	/**
	 * @method equals
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean equals(long context, long v1, String v2);

	/**
	 * @method equals
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean equals(long context, long v1, double v2);

	/**
	 * @method equals
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean equals(long context, long v1, boolean v2);

	/**
	 * @method isString
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean isString(long context, long value);

	/**
	 * @method isNumber
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean isNumber(long context, long value);

	/**
	 * @method isBoolean
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean isBoolean(long context, long value);

	/**
	 * @method isFunction
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean isFunction(long context, long value);

	/**
	 * @method isObject
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean isObject(long context, long value);

	/**
	 * @method isArray
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean isArray(long context, long value);

	/**
	 * @method isUndefined
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean isUndefined(long context, long value);

	/**
	 * @method isNull
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean isNull(long context, long value);

	/**
	 * @method getTypeOf
	 * @since 0.1.0
	 * @hidden
	 */
	static native public int getType(long context, long value);

	/**
	 * @method toString
	 * @since 0.1.0
	 * @hidden
	 */
	static native public String toString(long context, long value);

	/**
	 * @method toNumber
	 * @since 0.1.0
	 * @hidden
	 */
	static native public double toNumber(long context, long value);

	/**
	 * @method toBoolean
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean toBoolean(long context, long value);

}
