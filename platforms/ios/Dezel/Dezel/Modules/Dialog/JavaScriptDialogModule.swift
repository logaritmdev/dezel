/**
 * @class JavaScriptDialogModule
 * @super JavaScriptModule
 * @since 0.7.0
 */
open class JavaScriptDialogModule: JavaScriptModule {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method configure
	 * @since 0.7.0
	 */
	override open func configure(context: JavaScriptContext) {
		context.registerClass("dezel.dialog.Alert", with: JavaScriptAlert.self)
		context.registerClass("dezel.dialog.AlertButton", with: JavaScriptAlertButton.self)
	}
}
