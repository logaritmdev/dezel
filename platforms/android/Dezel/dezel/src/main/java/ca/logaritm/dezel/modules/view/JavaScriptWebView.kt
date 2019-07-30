package ca.logaritm.dezel.modules.view

import android.util.Size
import android.util.SizeF
import ca.logaritm.dezel.application.application
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback
import ca.logaritm.dezel.extension.ceiled
import ca.logaritm.dezel.view.WebView
import ca.logaritm.dezel.view.WebViewListener
import ca.logaritm.dezel.view.graphic.Convert

/**
 * @class JavaScriptWebView
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptWebView(context: JavaScriptContext) : JavaScriptView(context), WebViewListener {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property view
	 * @since 0.7.0
	 * @hidden
	 */
	private val view: WebView
		get() = this.content as WebView

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method createContentView
	 * @since 0.7.0
	 */
	override fun createContentView(): WebView {
		return WebView(this.context.application, this)
	}

	/**
	 * @inherited
	 * @method destroy
	 * @since 0.7.0
	 */
	override fun dispose() {
		this.view.webViewListener = null
		this.view.stopLoading()
		super.dispose()
	}

	/**
	 * @inherited
	 * @method measure
	 * @since 0.7.0
	 */
	override fun measure(bounds: SizeF, min: SizeF, max: SizeF): SizeF? {

		val size = this.view.measure(
			Convert.toPx(bounds),
			Convert.toPx(min),
			Convert.toPx(max)
		)

		return Convert.toDp(size).ceiled()
	}

	//--------------------------------------------------------------------------
	// JavaScriptWebView Listener
	//--------------------------------------------------------------------------

	/**
	 * @method willLoad
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onBeforeLoad(webView: WebView, url: String): Boolean {
		val result = this.context.createReturnValue()
		this.holder.callMethod("nativeOnBeforeLoad", arrayOf(this.context.createString(url)), result)
		return result.boolean
	}

	/**
	 * @method didLoad
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onLoad(webView: WebView) {
		this.holder.callMethod("nativeOnLoad")
	}

	/**
	 * @method didUpdateContentSize
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onUpdateContentSize(webView: WebView, size: Size) {

		val contentWidth = size.width.toDouble()
		val contentHeight = size.height.toDouble()

		if (this.resolvedContentWidth != contentWidth) {
			if (this.layoutNode.wrapsContentWidth) {
				this.layoutNode.invalidate()
			}
		}

		if (this.resolvedContentHeight != contentHeight) {
			if (this.layoutNode.wrapsContentHeight) {
				this.layoutNode.invalidate()
			}
		}
	}

	//--------------------------------------------------------------------------
	// JS Methods
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_load
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
 	open fun jsFunction_load(callback: JavaScriptFunctionCallback) {
		this.view.loadUrl(callback.argument(0).string)
	}

	/**
	 * @method jsFunction_loadHTML
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_loadHTML(callback: JavaScriptFunctionCallback) {
		this.view.loadDataWithBaseURL("file:///android_asset/app", callback.argument(0).string, "text/html; charset=utf-8", "UTF-8", "")
	}

	/**
	 * @method jsFunction_reload
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_reload(callback: JavaScriptFunctionCallback) {
		this.view.reload()
	}

	/**
	 * @method jsFunction_stop
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_stop(callback: JavaScriptFunctionCallback) {
		this.view.stopLoading()
	}

	/**
	 * @method jsFunction_back
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_back(callback: JavaScriptFunctionCallback) {
		this.view.goBack()
	}

	/**
	 * @method jsFunction_forward
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_forward(callback: JavaScriptFunctionCallback) {
		this.view.goForward()
	}
}