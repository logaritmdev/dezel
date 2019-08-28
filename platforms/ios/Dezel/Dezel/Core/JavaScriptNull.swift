/**
 * @class JavaScriptNull
 * @since 0.7.0
 * @hidden
 */
 open class JavaScriptNull: JavaScriptValue {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	public override init(context: JavaScriptContext) {
		super.init(context: context)
		self.reset(DLValueCreateNull(context.handle), protect: false)
	}

	/**
	 * @method protect
	 * @since 0.7.0
	 * @hidden
	 */
	override open func protect() {

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
	override open func unprotect() {

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
	override open func dispose() {

		/*
		 * Prevent this value from being disposed. This can lead to unwanted
		 * crash if this instnace is disposed.
		 */

	}
}
