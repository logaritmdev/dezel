package ca.logaritm.dezel.modules.view

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.Module
import ca.logaritm.dezel.modules.view.optimize.JavaScriptListOptimizer
import ca.logaritm.dezel.modules.view.optimize.JavaScriptViewOptimizer

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
		this.context.registerClass("dezel.view.ImageView", JavaScriptImageView::class.java)
		this.context.registerClass("dezel.view.SpinnerView", JavaScriptSpinnerView::class.java)
		this.context.registerClass("dezel.view.TextView", JavaScriptTextView::class.java)
		this.context.registerClass("dezel.view.View", JavaScriptView::class.java)
		this.context.registerClass("dezel.view.Window", JavaScriptWindow::class.java)
		this.context.registerClass("dezel.view.WebView", JavaScriptWebView::class.java)
		this.context.registerClass("dezel.view.ViewOptimizer", JavaScriptViewOptimizer::class.java)
		this.context.registerClass("dezel.view.ListOptimizer", JavaScriptListOptimizer::class.java)
	}
}

