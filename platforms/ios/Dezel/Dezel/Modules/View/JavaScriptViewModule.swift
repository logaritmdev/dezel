/**
 * @class JavaScriptViewModule
 * @super JavaScriptModule
 * @since 0.7.0
 */
open class JavaScriptViewModule: JavaScriptModule {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method register
	 * @since 0.7.0
	 */
	override open func register(context: JavaScriptContext) {
		context.registerClass("dezel.view.ImageView", with: JavaScriptImageView.self)
		context.registerClass("dezel.view.SpinnerView", with: JavaScriptSpinnerView.self)
		context.registerClass("dezel.view.TextView", with: JavaScriptTextView.self)
		context.registerClass("dezel.view.View", with: JavaScriptView.self)
		context.registerClass("dezel.view.Window", with: JavaScriptWindow.self)
		context.registerClass("dezel.view.WebView", with: JavaScriptWebView.self)
		context.registerClass("dezel.view.ViewOptimizer", with: JavaScriptViewOptimizer.self)
		context.registerClass("dezel.view.ListOptimizer", with: JavaScriptListOptimizer.self)
		context.registerClass("dezel.view.GridOptimizer", with: JavaScriptGridOptimizer.self)
	}
}

