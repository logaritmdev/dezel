/**
 * @class JavaScriptFormModule
 * @since 0.7.0
 */
open class JavaScriptFormModule: Module {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method register
	 * @since 0.7.0
	 */
	override open func register(context: JavaScriptContext) {
		context.registerClass("dezel.form.TextInput", with: JavaScriptTextInput.self)
		context.registerClass("dezel.form.TextArea", with: JavaScriptTextArea.self)
	}
}

