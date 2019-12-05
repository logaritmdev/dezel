/**
 * @protocol WebViewObserver
 * @since 0.7.0
 */
public protocol WebViewObserver : AnyObject {
	func willLoad(webView: WebView, url: URL) -> Bool
	func didLoad(webView: WebView)
	func didUpdateContentSize(webView: WebView, size: CGSize)
}
