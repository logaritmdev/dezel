package ca.logaritm.dezel.core

/**
 * The base class for bridged object.
 * @class JavaScriptObject
 * @since 0.1.0
 */
open class JavaScriptObject(context: JavaScriptContext): JavaScriptValue(context) {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Returns an internal attribute from this object.
	 * @method attribute
	 * @since 0.1.0
	 */
	public fun attribute(key: Any): Any? {
		return JavaScriptValueExternal.getAttribute(this.context.handle, this.handle, key.hashCode())
	}

	/**
	 * Assigns an internal attribute on this object.
	 * @method attribute
	 * @since 0.1.0
	 */
	public fun attribute(key: Any, value: Any) {
		JavaScriptValueExternal.setAttribute(this.context.handle, this.handle, key.hashCode(), value)
	}

	/**
	 * Removes an internal attribute from this object.
	 * @method deleteAttribute
	 * @since 0.1.0
	 */
	public fun deleteAttribute(key: Any) {
		JavaScriptValueExternal.deleteAttribute(this.context.handle, this.handle, key.hashCode())
	}

	/**
	 * Assigns the object's finalize handler.
	 * @method finalize
	 * @since 0.4.0
	 */
	public fun finalize(handler: JavaScriptFinalizeHandler) {
		JavaScriptValueExternal.setFinalizeHandler(this.context.handle, this.handle, JavaScriptFinalizeWrapper(handler), this.context)
	}

	//--------------------------------------------------------------------------
	// Methods - Extensions
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onResetValue
	 * @since 0.4.0
	 */
	override fun onResetValue() {
		this.finalize { callback ->
			JavaScriptValueExternal.deleteGhostAssociatedObject(callback.handle)
		}
	}
}