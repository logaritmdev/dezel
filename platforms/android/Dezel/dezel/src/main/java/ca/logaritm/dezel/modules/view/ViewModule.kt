package ca.logaritm.dezel.modules.view

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.Module
import ca.logaritm.dezel.modules.view.optimize.ContentOptimizer
import ca.logaritm.dezel.modules.view.optimize.ListOptimizer

/**
 * @class ViewModule
 * @since 0.1.0
 * @hidden
 */
open class ViewModule(context: JavaScriptContext): Module(context) {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	override fun initialize() {
		this.context.registerClass("dezel.view.ImageView", ImageView::class.java)
		this.context.registerClass("dezel.view.SpinnerView", SpinnerView::class.java)
		this.context.registerClass("dezel.view.TextView", TextView::class.java)
		this.context.registerClass("dezel.view.View", View::class.java)
		this.context.registerClass("dezel.view.Window", Window::class.java)
		this.context.registerClass("dezel.view.WebView", WebView::class.java)
		this.context.registerClass("dezel.view.ContentOptimizer", ContentOptimizer::class.java)
		this.context.registerClass("dezel.view.ListOptimizer", ListOptimizer::class.java)
	}
}

