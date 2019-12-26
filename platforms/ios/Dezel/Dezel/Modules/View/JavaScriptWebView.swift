import WebKit

/**
 * @class JavaScriptWebView
 * @super JavaScriptView
 * @since 0.7.0
 */
open class JavaScriptWebView: JavaScriptView, WebViewObserver {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property view
	 * @since 0.7.0
	 * @hidden
	 */
	private var view: WebView {
		return self.content as! WebView
	}

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method createContentView
	 * @since 0.7.0
	 */
	override open func createContentView() -> WebView {
		return WebView(frame: .zero, observer: self)
	}

	/**
	 * @method dispose
	 * @since 0.6.0
	 */
	override open func dispose() {
		self.view.observer = nil
		self.view.stopLoading()
		super.dispose()
	}

	/**
	 * @method measure
	 * @since 0.7.0
	 */
	override open func measure(bounds: CGSize, min: CGSize, max: CGSize) -> CGSize {
		return self.view.measure(bounds: bounds, min: min, max: max)
	}

	//--------------------------------------------------------------------------
	// MARK: WebView Delegate
	//--------------------------------------------------------------------------

	/**
	 * @method willLoad
	 * @since 0.7.0
	 * @hidden
	 */
	public func willLoad(webView: WebView, url: URL) -> Bool {
		let result = self.context.createReturnValue()
		self.callMethod("nativeOnBeforeLoad", arguments: [self.context.createString(url.absoluteString)], result: result)
		return result.boolean
	}

	/**
	 * @method didLoad
	 * @since 0.7.0
	 * @hidden
	 */
	public func didLoad(webView: WebView) {
		self.callMethod("nativeOnLoad")
	}

	/**
	 * @method didUpdateContentSize
	 * @since 0.7.0
	 * @hidden
	 */
	open func didUpdateContentSize(webView: WebView, size: CGSize) {

		let contentWidth = Double(size.width)
		let contentHeight = Double(size.height)

		if (self.resolvedContentWidth != contentWidth) {
			if (self.node.isWrappingContentWidth) {
				self.node.invalidateLayout()
			}
		}

		if (self.resolvedContentHeight != contentHeight) {
			if (self.node.isWrappingContentHeight) {
				self.node.invalidateLayout()
			}
		}
	}

	//--------------------------------------------------------------------------
	// MARK: JS Methods
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_load
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_load(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptWebView.load() requires 1 argument.")
		}

		self.view.load(url: callback.argument(0).string)
	}

	/**
	 * @method jsFunction_loadHTML
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_loadHTML(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptWebView.loadHTML() requires 1 argument.")
		}

		self.view.load(html: callback.argument(0).string)
	}

	/**
	 * @method jsFunction_reload
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_reload(callback: JavaScriptFunctionCallback) {
		self.view.reload()
	}

	/**
	 * @method jsFunction_stop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_stop(callback: JavaScriptFunctionCallback) {
		self.view.stopLoading()
	}

	/**
	 * @method jsFunction_back
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_back(callback: JavaScriptFunctionCallback) {
		self.view.goBack()
	}

	/**
	 * @method jsFunction_forward
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_forward() {
		self.view.goForward()
	}
}
