/**
 * @class DialogModule
 * @since 0.1.0
 * @hidden
 */
open class DialogModule: Module {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	override open func initialize() {
		self.context.registerClass("dezel.dialog.Alert", type: Alert.self)
		self.context.registerClass("dezel.dialog.AlertButton", type: AlertButton.self)
	}
}
