package ca.logaritm.dezel.core

import ca.logaritm.dezel.core.external.JavaScriptValueExternal

/**
 * @class JavaScriptFinalizeCallback
 * @since 0.1.0
 */
public class JavaScriptFinalizeCallback(context: JavaScriptContext, handle: Long) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property context
	 * @since 0.1.0
	 */
	public var context: JavaScriptContext
		private set

	/**
	 * @property handle
	 * @since 0.1.0
	 */
	public var handle: Long = 0
		private set

	//--------------------------------------------------------------------------
	// Method
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	init {
		this.context = context
		this.handle = handle
	}

	/**
	 * @method attribute
	 * @since 0.4.0
	 */
	public fun attribute(key: Any): Any? {
		return JavaScriptValueExternal.getAttribute(this.handle, key.hashCode())
	}

	/**
	 * @method attribute
	 * @since 0.4.0
	 */
	public fun attribute(key: Any, value: Any?) {
		val hash = key.hashCode()
		JavaScriptValueExternal.delAttribute(this.handle, hash)
		JavaScriptValueExternal.setAttribute(this.handle, hash, value)
	}
}