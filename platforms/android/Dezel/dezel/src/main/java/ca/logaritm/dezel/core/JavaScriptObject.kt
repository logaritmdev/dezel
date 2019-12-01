package ca.logaritm.dezel.core

/**
 * @class JavaScriptObject
 * @super JavaScriptValue
 * @since 0.1.0
 */
open class JavaScriptObject(context: JavaScriptContext): JavaScriptValue(context) {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
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
	 * @method attribute
	 * @since 0.1.0
	 */
	open fun attribute(key: Any): Any? {
		return JavaScriptValueExternal.getAttribute(this.context.handle, this.handle, key.hashCode())
	}

	/**
	 * @method attribute
	 * @since 0.1.0
	 */
	open fun attribute(key: Any, value: Any) {
		val hash = key.hashCode()
		JavaScriptValueExternal.delAttribute(this.context.handle, this.handle, hash)
		JavaScriptValueExternal.setAttribute(this.context.handle, this.handle, hash, value)
	}

	/**
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
	 * @method setProperty
	 * @since 0.7.0
	 */
	open fun setProperty(name: String, value: JavaScriptValue?) {
		JavaScriptPropertyAccessor.get(this, name).set(this, value)
	}

	/**
	 * @method getProperty
	 * @since 0.7.0
	 */
	open fun getProperty(name: String): JavaScriptProperty? {
		return JavaScriptPropertyAccessor.get(this, name).get(this)
	}

	//--------------------------------------------------------------------------
	// Methods - Extensions
	//--------------------------------------------------------------------------

	/**
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

