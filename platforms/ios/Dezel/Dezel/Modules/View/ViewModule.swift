/**
 * @class ViewModule
 * @since 0.1.0
 * @hidden
 */
open class ViewModule: Module {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	override open func initialize() {
		self.context.registerClass("dezel.view.ImageView", with: JavaScriptImageView.self)
		self.context.registerClass("dezel.view.SpinnerView", with: JavaScriptSpinnerView.self)
		self.context.registerClass("dezel.view.TextView", with: JavaScriptTextView.self)
		self.context.registerClass("dezel.view.View", with: JavaScriptView.self)
		self.context.registerClass("dezel.view.Window", with: JavaScriptWindow.self)
		self.context.registerClass("dezel.view.WebView", with: JavaScriptWebView.self)
		self.context.registerClass("dezel.view.ViewOptimizer", with: JavaScriptViewOptimizer.self)
		self.context.registerClass("dezel.view.ListOptimizer", with: JavaScriptListOptimizer.self)
		self.context.registerClass("dezel.view.GridOptimizer", with: JavaScriptGridOptimizer.self)
	}
}

