/**
 * The base class for bridged classes.
 * @class JavaScriptClass
 * @since 0.1.0
 */
open class JavaScriptClass: JavaScriptObject {

	/**
	 * The JavaScript object that holds this bridged instance.
	 * @property holder
	 * @since 0.4.0
	 */
	private(set) public var holder: JavaScriptValue!

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * Called when the value gets protected.
	 * @method didProtectValue
	 * @since 0.4.0
	 */
	override open func didProtectValue() {

		/*
		 * When protecting an object from being collected, we also want to
		 * make sure its holder does not get collected.
		 */

		self.holder?.protect()
	}

	/**
	 * Called when the value gets unprotected.
	 * @method didUnprotectValue
	 * @since 0.4.0
	 */
	override open func didUnprotectValue() {

		/*
		 * When protecting an object from being collected, we also want to
		 * make sure its holder does not get collected.
		 */

		self.holder?.unprotect()
	}

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_holder
	 * @since 0.2.0
	 * @hidden
	 */
	@objc open func jsGet_holder(callback: JavaScriptGetterCallback) {
		callback.returns(self.holder)
	}

	/**
	 * @method jsSet_holder
	 * @since 0.2.0
	 * @hidden
	 */
	@objc open func jsSet_holder(callback: JavaScriptSetterCallback) {
		self.holder = callback.value
		self.holder?.unprotect()
	}

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
     * Default constructor implementation.
     * @method jsFunction_constructor
     * @since 0.1.0
     */
	@objc open func jsFunction_constructor(callback: JavaScriptFunctionCallback) {

	}
}
