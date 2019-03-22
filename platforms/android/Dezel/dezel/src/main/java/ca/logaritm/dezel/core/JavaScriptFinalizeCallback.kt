package ca.logaritm.dezel.core

/**
 * A finalizer callback.
 * @class JavaScriptFinalizeCallback
 * @since 0.1.0
 */
public class JavaScriptFinalizeCallback {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The finalized handle's context.
	 * @property context
	 * @since 0.1.0
	 */
	public var context: JavaScriptContext
		private set

	/**
	 * The finalized handle's ghost.
	 * @property value
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
	internal constructor(context: JavaScriptContext, handle: Long) {
		this.context = context
		this.handle = handle
	}

	/**
	 * Returns an attribute from this finalized value.
	 * @method attribute
	 * @since 0.4.0
	 */
	public fun attribute(key: Any): Any? {
		return JavaScriptValueExternal.getAttribute(this.handle, key.hashCode())
	}

	/**
	 * Deletes an attribute from this finalized value.
	 * @method deleteAttribute
	 * @since 0.4.0
	 */
	public fun deleteAttribute(key: Any) {
		JavaScriptValueExternal.deleteAttribute(this.handle, key.hashCode())
	}
}