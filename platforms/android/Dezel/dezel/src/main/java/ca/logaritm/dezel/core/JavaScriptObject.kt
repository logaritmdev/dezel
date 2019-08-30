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
	 * @overridden
	 * @method dispose
	 * @since 0.6.0
	 */
	override fun dispose() {

		if (this.handle != 0L) {
			JavaScriptValueExternal.delAssociatedObject(this.context.handle, this.handle)
			JavaScriptValueExternal.setAssociatedObject(this.context.handle, this.handle, null)
		}

		super.dispose()
	}

	/**
	 * Returns an internal attribute from this object.
	 * @method attribute
	 * @since 0.1.0
	 */
	open fun attribute(key: Any): Any? {
		return JavaScriptValueExternal.getAttribute(this.context.handle, this.handle, key.hashCode())
	}

	/**
	 * Assigns an internal attribute on this object.
	 * @method attribute
	 * @since 0.1.0
	 */
	open fun attribute(key: Any, value: Any) {
		val hash = key.hashCode()
		JavaScriptValueExternal.delAttribute(this.context.handle, this.handle, hash)
		JavaScriptValueExternal.setAttribute(this.context.handle, this.handle, hash, value)
	}

	/**
	 * Assigns the object's finalize handler.
	 * @method finalize
	 * @since 0.4.0
	 */
	open fun finalize(handler: JavaScriptFinalizeHandler) {
		JavaScriptValueExternal.setFinalizeHandler(this.context.handle, this.handle, JavaScriptFinalizeWrapper(handler), this.context)
	}

	//--------------------------------------------------------------------------
	// Methods - Dynamic Access
	//--------------------------------------------------------------------------

	/**
	 * Assigns a toValue to a JavaScript property.
	 * @method setProperty
	 * @since 0.7.0
	 */
	open fun setProperty(name: String, value: JavaScriptValue?) {
		val success = JavaScriptPropertyAccessor.get(this, name).set(this, value)
		if (success == false) {
			this.property(name, value)
		}
	}

	/**
	 * Assigns a toValue to a JavaScript property.
	 * @method setProperty
	 * @since 0.7.0
	 */
	open fun setProperty(name: String, value: String) {
		val success = JavaScriptPropertyAccessor.get(this, name).set(this, value)
		if (success == false) {
			this.property(name, value)
		}
	}

	/**
	 * Assigns a toValue to a JavaScript property.
	 * @method setProperty
	 * @since 0.7.0
	 */
	open fun setProperty(name: String, value: Double, unit: JavaScriptPropertyUnit = JavaScriptPropertyUnit.NONE) {
		val success = JavaScriptPropertyAccessor.get(this, name).set(this, value, unit)
		if (success == false) {
			this.property(name, value)
		}
	}

	/**
	 * Assigns a toValue to a JavaScript property.
	 * @method setProperty
	 * @since 0.7.0
	 */
	open fun setProperty(name: String, value: Boolean) {
		val success = JavaScriptPropertyAccessor.get(this, name).set(this, value)
		if (success == false) {
			this.property(name, value)
		}
	}

	/**
	 * Returns a JavaScript property.
	 * @method getPropert
	 * @since 0.7.0
	 */
	open fun getProperty(name: String): JavaScriptProperty? {
		return JavaScriptPropertyAccessor.get(this, name).get(this)
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

			/*
			 * When an object is finalized on the JavaScript side we must
			 * dispose it from the native side because its technically no
			 * longer usable.
			 */

			val self = JavaScriptValueExternal.getAssociatedObject(callback.handle)
			if (self is JavaScriptValue) {
				self.dispose()
			}
		}
	}
}

