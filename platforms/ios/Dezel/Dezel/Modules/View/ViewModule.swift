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
		self.context.registerClass("dezel.view.ImageView", type: ImageView.self)
		self.context.registerClass("dezel.view.SpinnerView", type: SpinnerView.self)
		self.context.registerClass("dezel.view.TextView", type: TextView.self)
		self.context.registerClass("dezel.view.View", type: View.self)
		self.context.registerClass("dezel.view.Window", type: Window.self)
		self.context.registerClass("dezel.view.WebView", type: WebView.self)
		self.context.registerClass("dezel.view.ContentOptimizer", type: ContentOptimizer.self)
		self.context.registerClass("dezel.view.ListOptimizer", type: ListOptimizer.self)
		self.context.registerClass("dezel.view.GridOptimizer", type: GridOptimizer.self)
	}
}

