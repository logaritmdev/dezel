/**
 * @class JavaScriptDialogModule
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptDialogModule: Module {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method register
	 * @since 0.7.0
	 */
	override open func register(context: JavaScriptContext) {
		context.registerClass("dezel.dialog.Alert", with: JavaScriptAlert.self)
		context.registerClass("dezel.dialog.AlertButton", with: JavaScriptAlertButton.self)
	}
}
