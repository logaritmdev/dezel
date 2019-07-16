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
		self.context.registerClass("dezel.view.ImageView", value: ImageView.self)
		self.context.registerClass("dezel.view.SpinnerView", value: SpinnerView.self)
		self.context.registerClass("dezel.view.TextView", value: TextView.self)
		self.context.registerClass("dezel.view.View", value: View.self)
		self.context.registerClass("dezel.view.Window", value: Window.self)
		self.context.registerClass("dezel.view.WebView", value: WebView.self)
		self.context.registerClass("dezel.view.ContentOptimizer", value: ContentOptimizer.self)
		self.context.registerClass("dezel.view.ListOptimizer", value: ListOptimizer.self)
		self.context.registerClass("dezel.view.GridOptimizer", value: GridOptimizer.self)
	}
}

