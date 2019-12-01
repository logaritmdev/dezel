package ca.logaritm.dezel.modules.view

import android.util.Size
import android.util.SizeF
import ca.logaritm.dezel.application.activity
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback
import ca.logaritm.dezel.extension.fatalError
import ca.logaritm.dezel.extension.util.ceiled
import ca.logaritm.dezel.view.WebView
import ca.logaritm.dezel.view.WebViewListener
import ca.logaritm.dezel.view.graphic.Convert

/**
 * @class JavaScriptWebView
 * @super JavaScriptView
 * @since 0.7.0
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
	 * @method createContentView
	 * @since 0.7.0
	 */
	override fun createContentView(): WebView {
		return WebView(this.context.activity, this)
	}

	/**
	 * @method destroy
	 * @since 0.7.0
	 */
	override fun dispose() {
		this.view.webViewListener = null
		this.view.stopLoading()
		super.dispose()
	}

	/**
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
	// JavaScriptWebView JavaScriptViewListener
	//--------------------------------------------------------------------------

	/**
	 * @method willLoad
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onBeforeLoad(webView: WebView, url: String): Boolean {
		val result = this.context.createReturnValue()
		this.callMethod("nativeOnBeforeLoad", arrayOf(this.context.createString(url)), result)
		return result.boolean
	}

	/**
	 * @method didLoad
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onLoad(webView: WebView) {
		this.callMethod("nativeOnLoad")
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
			if (this.displayNode.isWrappingContentWidth) {
				this.displayNode.invalidateLayout()
			}
		}

		if (this.resolvedContentHeight != contentHeight) {
			if (this.displayNode.isWrappingContentHeight) {
				this.displayNode.invalidateLayout()
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

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptWebView.load() requires 1 argument.")
		}

		this.view.loadUrl(callback.argument(0).string)
	}

	/**
	 * @method jsFunction_loadHTML
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_loadHTML(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptWebView.loadHTML() requires 1 argument.")
		}

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