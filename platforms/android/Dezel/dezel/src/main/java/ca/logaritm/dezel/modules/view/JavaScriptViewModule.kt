package ca.logaritm.dezel.modules.view

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptModule

/**
 * @class JavaScriptViewModule
 * @super JavaScriptModule
 * @since 0.1.0
 */
open class JavaScriptViewModule: JavaScriptModule() {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method configure
	 * @since 0.7.0
	 */
	override fun configure(context: JavaScriptContext) {
		context.registerClass("dezel.view.ImageView", JavaScriptImageView::class.java)
		context.registerClass("dezel.view.SpinnerView", JavaScriptSpinnerView::class.java)
		context.registerClass("dezel.view.TextView", JavaScriptTextView::class.java)
		context.registerClass("dezel.view.View", JavaScriptView::class.java)
		context.registerClass("dezel.view.Window", JavaScriptWindow::class.java)
		context.registerClass("dezel.view.WebView", JavaScriptWebView::class.java)
		context.registerClass("dezel.view.Recycler", JavaScriptRecycler::class.java)
	}
}

