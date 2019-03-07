/**
 * @protocol ContentWebViewObserver
 * @since 0.2.0
 */
public protocol ContentWebViewDelegate : AnyObject {
	func willLoad(webView: ContentWebView, url: URL) -> Bool
	func didLoad(webView: ContentWebView)
	func didUpdateContentSize(webView: ContentWebView, size: CGSize)
}
