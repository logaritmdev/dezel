package ca.logaritm.dezel.view

import android.util.Size

/**
 * @protocol WebViewListener
 * @since 0.7.0
 */
public interface WebViewListener {

	/**
	 * @method onBeforeLoad
	 * @since 0.7.0
	 */
	fun onBeforeLoad(webView: WebView, url: String): Boolean

	/**
	 * @method onLoad
	 * @since 0.7.0
	 */
	fun onLoad(webView: WebView)

	/**
	 * @method onUpdateContentSize
	 * @since 0.7.0
	 */
	fun onUpdateContentSize(webView: WebView, size: Size)
}