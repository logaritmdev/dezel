package ca.logaritm.dezel.core

/**
 * @class JavaScriptNull
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptNull(context: JavaScriptContext): JavaScriptValue(context) {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	init {
		this.reset(JavaScriptValueExternal.createNull(context.handle), false)
	}

	/**
	 * @method protect
	 * @since 0.7.0
	 * @hidden
	 */
	override fun protect() {

		/*
		 * Prevent this value from being protected because there's no need,
		 * the garbage collected will never collect null.
		 */

	}

	/**
	 * @method protect
	 * @since unprotect
	 * @hidden
	 */
	override fun unprotect() {

		/*
		 * Prevent this value from being unprotected because there's no need,
		 * the garbage collected will never collect null.
		 */

	}

	/**
	 * Disposes the value.
	 * @method dispose
	 * @since 0.1.0
	 */
	override fun dispose() {

		/*
		 * Prevent this value from being disposed. This can lead to unwanted
		 * crash if this instance is disposed.
		 */

	}
}
