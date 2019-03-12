/**
 * @class AlertButton
 * @since 0.1.0
 * @hidden
 */
open class AlertButton: JavaScriptClass {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The alert button's label.
	 * @property label
	 * @since 0.1.0
	 */
	open var label: Property = Property(string: "")

	/**
	 * The alert button's image.
	 * @property image
	 * @since 0.6.0
	 */
	open var image: Property = Property()

	/**
	 * The alert button's style.
	 * @property style
	 * @since 0.1.0
	 */
	open var style: Property = Property(string: "normal")

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_label
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_label(callback: JavaScriptSetterCallback) {
		callback.returns(self.label)
	}

	/**
	 * @method jsSet_label
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_label(callback: JavaScriptSetterCallback) {
		self.label = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_image
	 * @since 0.6.0
	 * @hidden
	 */
	@objc open func jsGet_image(callback: JavaScriptGetterCallback) {
		callback.returns(self.image)
	}

	/**
	 * @method jsSet_style
	 * @since 0.6.0
	 * @hidden
	 */
	@objc open func jsSet_image(callback: JavaScriptSetterCallback) {
		self.image = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_style
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_style(callback: JavaScriptSetterCallback) {
		callback.returns(self.style)
	}

	/**
	 * @method jsSet_style
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_style(callback: JavaScriptSetterCallback) {
		self.style = Property(value: callback.value)
	}
}
