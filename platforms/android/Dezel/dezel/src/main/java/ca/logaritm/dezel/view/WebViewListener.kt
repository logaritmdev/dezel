package ca.logaritm.dezel.view

import android.util.Size

/**
 * @protocol WebViewListener
 * @since 0.7.0
 */
public interface WebViewListener {
	fun onBeforeLoad(webView: WebView, url: String): Boolean
	fun onLoad(webView: WebView)
	fun onUpdateContentSize(webView: WebView, size: Size)
}