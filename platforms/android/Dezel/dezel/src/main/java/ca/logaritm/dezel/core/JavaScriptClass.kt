package ca.logaritm.dezel.core

/**
 * The base class for bridged classes.
 * @class JavaScriptClass
 * @since 0.1.0
 */
open class JavaScriptClass(context: JavaScriptContext) : JavaScriptObject(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The JavaScript object that holds this bridged instance.
	 * @property holder
	 * @since 0.4.0
	 */
	public lateinit var holder: JavaScriptValue
		private set

	//--------------------------------------------------------------------------
	// JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_holder
	 * @since 0.4.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_holder(callback: JavaScriptGetterCallback) {
		callback.returns(if (this::holder.isInitialized) this.holder else null)
	}

	/**
	 * @method jsSet_holder
	 * @since 0.4.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_holder(callback: JavaScriptSetterCallback) {
		this.holder = callback.value
		this.holder.unprotect()
	}

	//--------------------------------------------------------------------------
	// JS Methods
	//--------------------------------------------------------------------------

	/**
	 * Default constructor implementation.
	 * @method jsFunction_constructor
	 * @since 0.1.0
	 */
	open fun jsFunction_constructor(callback: JavaScriptFunctionCallback) {

	}
}