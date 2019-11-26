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
	 * @property active
	 * @since 0.7.0
	 */
	@objc public lazy var active = JavaScriptProperty(boolean: false) { value in
		self.view.active = value.boolean
	}

	/**
	 * @property color
	 * @since 0.7.0
	 */
	@objc public lazy var color = JavaScriptProperty(string: "#000") { value in
		self.view.color = UIColor(cgColor: value.string.toColor())
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_active
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_active(callback: JavaScriptGetterCallback) {
		callback.returns(self.active)
	}

	/**
	 * @method jsSet_active
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_active(callback: JavaScriptSetterCallback) {
		self.active.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_color
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_color(callback: JavaScriptGetterCallback) {
		callback.returns(self.color)
	}

	/**
	 * @method jsSet_color
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_color(callback: JavaScriptSetterCallback) {
		self.color.reset(callback.value, lock: self)
	}
}
