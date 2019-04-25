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
	static native public long createNull(long contextPtr);

	/**
	 * @method createUndefined
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long createUndefined(long contextPtr);

	/**
	 * @method createString
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long createString(long contextPtr, String value);

	/**
	 * @method createNumber
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long createNumber(long contextPtr, double value);

	/**
	 * @method createBoolean
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long createBoolean(long contextPtr, boolean value);

	/**
	 * @method createEmtpyObject
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long createEmtpyObject(long contextPtr);

	/**
	 * @method createEmptyArray
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long createEmptyArray(long contextPtr);

	/**
	 * @method createFunction
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long createFunction(long contextPtr, Object value, String name, Object ctx);

	/**
	 * @method protect
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void protect(long contextPtr, long valuePtr);

	/**
	 * @method unprotect
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void unprotect(long contextPtr, long valuePtr);

	/**
	 * @method call
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void call(long contextPtr, long valuePtr, long object, long[] argv, int argc, Object result);

	/**
	 * @method callMethod
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void callMethod(long contextPtr, long valuePtr, String method, long[] argv, int argc, Object result);

	/**
	 * @method construct
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void construct(long contextPtr, long valuePtr, long[] argv, int argc, Object result);

	/**
	 * @method defineProperty
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void defineProperty(long contextPtr, long valuePtr, String property, long propertyValue, Object getter, Object setter, boolean writable, boolean enumerable, boolean configurable, Object ctx);

	/**
	 * @method setProperty
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setProperty(long contextPtr, long valuePtr, String property, long propertyValue);

	/**
	 * @method setProperty
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setProperty(long contextPtr, long valuePtr, String property, String propertyValue);

	/**
	 * @method setProperty
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setProperty(long contextPtr, long valuePtr, String property, double propertyValue);

	/**
	 * @method setProperty
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setProperty(long contextPtr, long valuePtr, String property, boolean propertyValue);

	/**
	 * @method getProperty
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long getProperty(long contextPtr, long valuePtr, String property);

	/**
	 * @method setPropertyAtIndex
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setPropertyAtIndex(long contextPtr, long valuePtr, int index, long propertyValue);

	/**
	 * @method setPropertyAtIndex
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setPropertyAtIndex(long contextPtr, long valuePtr, int index, String propertyValue);

	/**
	 * @method setPropertyAtIndex
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setPropertyAtIndex(long contextPtr, long valuePtr, int index, double propertyValue);

	/**
	 * @method setPropertyAtIndex
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setPropertyAtIndex(long contextPtr, long valuePtr, int index, boolean propertyValue);

	/**
	 * @method getPropertyAtIndex
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long getPropertyAtIndex(long contextPtr, long valuePtr, int index);

	/**
	 * @method setPrototype
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setPrototype(long contextPtr, long valuePtr, long prototype);

	/**
	 * @method getPrototype
	 * @since 0.1.0
	 * @hidden
	 */
	static native public long getPrototype(long contextPtr, long valuePtr);

	/**
	 * @method setAttribute
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setAttribute(long contextPtr, long valuePtr, int key, Object value);

	/**
	 * @method getAttribute
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setAttribute(long valuePtr, int key, Object value);
	
	/**
	 * @method getAttribute
	 * @since 0.1.0
	 * @hidden
	 */
	static native public Object getAttribute(long contextPtr, long valuePtr, int key);

	/**
	 * @method getAttribute
	 * @since 0.1.0
	 * @hidden
	 */
	static native public Object getAttribute(long valuePtr, int key);

	/**
	 * @method delAttribute
	 * @since 0.6.0
	 * @hidden
	 */
	static native public void delAttribute(long contextPtr, long valuePtr, int key);

	/**
	 * @method delAttribute
	 * @since 0.6.0
	 * @hidden
	 */
	static native public void delAttribute(long valuePtr, int key);

	/**
	 * @method setAssociatedObject
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setAssociatedObject(long contextPtr, long valuePtr, Object object);
	
	/**
	 * @method getAssociatedObject
	 * @since 0.1.0
	 * @hidden
	 */
	static native public Object getAssociatedObject(long contextPtr, long valuePtr);

	/**
	 * @method getAssociatedObject
	 * @since 0.1.0
	 * @hidden
	 */
	static native public Object getAssociatedObject(long valuePtr);

	/**
	 * @method delAssociatedObject
	 * @since 0.6.0
	 * @hidden
	 */
	static native public void delAssociatedObject(long contextPtr, long valuePtr);

	/**
	 * @method setFinalizeHandler
	 * @since 0.1.0
	 * @hidden
	 */
	static native public void setFinalizeHandler(long contextPtr, long valuePtr, Object wrapper, Object context);

	/**
	 * @method equals
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean equals(long contextPtr, long v1, long v2);

	/**
	 * @method equals
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean equals(long contextPtr, long v1, String v2);

	/**
	 * @method equals
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean equals(long contextPtr, long v1, double v2);

	/**
	 * @method equals
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean equals(long contextPtr, long v1, boolean v2);

	/**
	 * @method isString
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean isString(long contextPtr, long valuePtr);

	/**
	 * @method isNumber
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean isNumber(long contextPtr, long valuePtr);

	/**
	 * @method isBoolean
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean isBoolean(long contextPtr, long valuePtr);

	/**
	 * @method isFunction
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean isFunction(long contextPtr, long valuePtr);

	/**
	 * @method isObject
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean isObject(long contextPtr, long valuePtr);

	/**
	 * @method isArray
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean isArray(long contextPtr, long valuePtr);

	/**
	 * @method isUndefined
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean isUndefined(long contextPtr, long valuePtr);

	/**
	 * @method isNull
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean isNull(long contextPtr, long valuePtr);

	/**
	 * @method getTypeOf
	 * @since 0.1.0
	 * @hidden
	 */
	static native public int getType(long contextPtr, long valuePtr);

	/**
	 * @method toString
	 * @since 0.1.0
	 * @hidden
	 */
	static native public String toString(long contextPtr, long valuePtr);

	/**
	 * @method toNumber
	 * @since 0.1.0
	 * @hidden
	 */
	static native public double toNumber(long contextPtr, long valuePtr);

	/**
	 * @method toBoolean
	 * @since 0.1.0
	 * @hidden
	 */
	static native public boolean toBoolean(long contextPtr, long valuePtr);

}
