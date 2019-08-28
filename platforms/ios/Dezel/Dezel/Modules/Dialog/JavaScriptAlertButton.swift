/**
 * @class JavaScriptAlertButton
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptAlertButton: JavaScriptClass {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The alert button's label.
	 * @property label
	 * @since 0.7.0
	 */
	open lazy var label = JavaScriptProperty(string: "")

	/**
	 * The alert button's image.
	 * @property image
	 * @since 0.7.0
	 */
	open lazy var image = JavaScriptProperty()

	/**
	 * The alert button's style.
	 * @property style
	 * @since 0.7.0
	 */
	open lazy var style = JavaScriptProperty(string: "normal")

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_label
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_label(callback: JavaScriptSetterCallback) {
		callback.returns(self.label)
	}

	/**
	 * @method jsSet_label
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_label(callback: JavaScriptSetterCallback) {
		self.label.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_image
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_image(callback: JavaScriptGetterCallback) {
		callback.returns(self.image)
	}

	/**
	 * @method jsSet_style
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_image(callback: JavaScriptSetterCallback) {
		self.image.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_style
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_style(callback: JavaScriptSetterCallback) {
		callback.returns(self.style)
	}

	/**
	 * @method jsSet_style
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_style(callback: JavaScriptSetterCallback) {
		self.style.reset(callback.value, lock: self)
	}
}
