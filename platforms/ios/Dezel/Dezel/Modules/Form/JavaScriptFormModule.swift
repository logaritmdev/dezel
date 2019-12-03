/**
 * @class JavaScriptFormModule
 * @super JavaScriptModule
 * @since 0.7.0
 */
open class JavaScriptFormModule: JavaScriptModule {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method configure
	 * @since 0.7.0
	 */
	override open func configure(context: JavaScriptContext) {
		context.registerClass("dezel.form.TextInput", with: JavaScriptTextInput.self)
		context.registerClass("dezel.form.TextArea", with: JavaScriptTextArea.self)
	}
}

