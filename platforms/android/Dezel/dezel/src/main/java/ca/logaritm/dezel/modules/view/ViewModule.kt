package ca.logaritm.dezel.modules.view

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.Module
import ca.logaritm.dezel.modules.view.optimize.JavaScriptViewOptimizer
import ca.logaritm.dezel.modules.view.optimize.JavaScriptListOptimizer

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
		this.context.registerClass("dezel.view.JavaScriptImageView", JavaScriptImageView::class.java)
		this.context.registerClass("dezel.view.JavaScriptSpinnerView", JavaScriptSpinnerView::class.java)
		this.context.registerClass("dezel.view.JavaScriptTextView", JavaScriptTextView::class.java)
		this.context.registerClass("dezel.view.JavaScriptView", JavaScriptView::class.java)
		this.context.registerClass("dezel.view.JavaScriptWindow", JavaScriptWindow::class.java)
		this.context.registerClass("dezel.view.JavaScriptWebView", JavaScriptWebView::class.java)
		this.context.registerClass("dezel.view.JavaScriptViewOptimizer", JavaScriptViewOptimizer::class.java)
		this.context.registerClass("dezel.view.JavaScriptListOptimizer", JavaScriptListOptimizer::class.java)
	}
}

