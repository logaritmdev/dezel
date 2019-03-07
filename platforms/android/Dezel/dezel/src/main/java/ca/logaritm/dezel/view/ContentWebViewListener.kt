package ca.logaritm.dezel.view

import android.util.Size

/**
 * @protocol ContentWebViewListener
 * @since 0.5.0
 */
public interface ContentWebViewListener {
	fun onBeforeLoad(webView: ContentWebView, url: String): Boolean
	fun onLoad(webView: ContentWebView)
	fun onUpdateContentSize(webView: ContentWebView, size: Size)
}