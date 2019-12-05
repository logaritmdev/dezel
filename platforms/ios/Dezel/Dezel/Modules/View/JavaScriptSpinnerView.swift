/**
 * @class JavaScriptSpinnerView
 * @super JavaScriptView
 * @since 0.7.0
 */
open class JavaScriptSpinnerView: JavaScriptView {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property view
	 * @since 0.7.0
	 * @hidden
	 */
	private var view: SpinnerView {
		return self.content as! SpinnerView
	}

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method createContentView
	 * @since 0.7.0
	 */
	override open func createContentView() -> SpinnerView {
		return SpinnerView(frame: .zero)
	}

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @property tint
	 * @since 0.7.0
	 */
	@objc lazy var tint = JavaScriptProperty(string: "#000") { value in
		self.view.color = UIColor(color: value)
	}

	/**
	 * @property spin
	 * @since 0.7.0
	 */
	@objc lazy var spin = JavaScriptProperty(boolean: false) { value in
		self.view.spin = value.boolean
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_tint
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_tint(callback: JavaScriptGetterCallback) {
		callback.returns(self.tint)
	}

	/**
	 * @method jsSet_tint
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_tint(callback: JavaScriptSetterCallback) {
		self.tint.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_spin
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_spin(callback: JavaScriptGetterCallback) {
		callback.returns(self.spin)
	}

	/**
	 * @method jsSet_spin
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_spin(callback: JavaScriptSetterCallback) {
		self.spin.reset(callback.value, lock: self)
	}
}
