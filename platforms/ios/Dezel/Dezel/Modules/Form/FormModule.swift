/**
 * @class FormModule
 * @since 0.1.0
 */
open class FormModule: Module {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	override open func initialize() {
		self.context.registerClass("dezel.form.TextInput", value: TextInput.self)
		self.context.registerClass("dezel.form.TextArea", value: TextArea.self)
	}
}

