/**
 * @class SheetButton
 * @since 0.5.0
 * @hidden
 */
open class SheetButton: JavaScriptClass {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The sheet button's label.
	 * @property label
	 * @since 0.5.0
	 */
	open var label: Property = Property(string: "")

	/**
	 * The sheet button's style.
	 * @property style
	 * @since 0.5.0
	 */
	open var style: Property = Property(string: "normal")

	/**
	 * The sheet button's image.
	 * @property image
	 * @since 0.5.0
	 */
	open var image: Property = Property()

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_label
	 * @since 0.5.0
	 * @hidden
	 */
	@objc open func jsGet_label(callback: JavaScriptGetterCallback) {
		callback.returns(self.label)
	}

	/**
	 * @method jsSet_label
	 * @since 0.5.0
	 * @hidden
	 */
	@objc open func jsSet_label(callback: JavaScriptSetterCallback) {
		self.label = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_style
	 * @since 0.5.0
	 * @hidden
	 */
	@objc open func jsGet_style(callback: JavaScriptGetterCallback) {
		callback.returns(self.style)
	}

	/**
	 * @method jsSet_style
	 * @since 0.5.0
	 * @hidden
	 */
	@objc open func jsSet_style(callback: JavaScriptSetterCallback) {
		self.style = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_image
	 * @since 0.5.0
	 * @hidden
	 */
	@objc open func jsGet_image(callback: JavaScriptGetterCallback) {
		callback.returns(self.image)
	}

	/**
	 * @method jsSet_style
	 * @since 0.5.0
	 * @hidden
	 */
	@objc open func jsSet_image(callback: JavaScriptSetterCallback) {
		self.image = Property(value: callback.value)
	}
}
