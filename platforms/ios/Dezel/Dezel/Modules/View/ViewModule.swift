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
		self.context.registerClass("dezel.view.ImageView", with: ImageView.self)
		self.context.registerClass("dezel.view.SpinnerView", with: SpinnerView.self)
		self.context.registerClass("dezel.view.TextView", with: TextView.self)
		self.context.registerClass("dezel.view.View", with: View.self)
		self.context.registerClass("dezel.view.Window", with: Window.self)
		self.context.registerClass("dezel.view.WebView", with: WebView.self)
		self.context.registerClass("dezel.view.ContentOptimizer", with: ContentOptimizer.self)
		self.context.registerClass("dezel.view.ListOptimizer", with: ListOptimizer.self)
		self.context.registerClass("dezel.view.GridOptimizer", with: GridOptimizer.self)
	}
}

