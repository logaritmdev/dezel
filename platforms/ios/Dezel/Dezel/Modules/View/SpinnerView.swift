/**
 * @class SpinnerView
 * @since 0.1.0
 * @hidden
 */
open class SpinnerView: View {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The activity view's active status.
	 * @property active
	 * @since 0.1.0
	 */
	@objc open var active: Property = Property(boolean: false) {
		willSet {
			self.view.active = newValue.boolean
		}
	}

	/**
	 * The activity view's color.
	 * @property color
	 * @since 0.1.0
	 */
	@objc open var color: Property = Property(string: "#000") {
		willSet {
			self.view.color = UIColor(cgColor: newValue.string.toColor())
		}
	}

	/**
	 * @property view
	 * @since 0.1.0
	 * @hidden
	 */
	private var view: ContentSpinnerView {
		return self.content as! ContentSpinnerView
	}

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method createContentView
	 * @since 0.5.0
	 */
	override open func createContentView() -> ContentSpinnerView {
		return ContentSpinnerView(frame: .zero)
	}

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_active
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_active(callback: JavaScriptGetterCallback) {
		callback.returns(self.active)
	}

	/**
	 * @method jsSet_active
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_active(callback: JavaScriptSetterCallback) {
		self.active = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_color
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_color(callback: JavaScriptGetterCallback) {
		callback.returns(self.color)
	}

	/**
	 * @method jsSet_color
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_color(callback: JavaScriptSetterCallback) {
		self.color = Property(value: callback.value)
	}
}
