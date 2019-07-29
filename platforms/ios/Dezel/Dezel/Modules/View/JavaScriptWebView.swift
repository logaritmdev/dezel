import WebKit

/**
 * @class JavaScriptWebView
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptWebView: JavaScriptView, WebViewDelegate {

	//--------------------------------------------------------------------------
	// MARK: Static Methods
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_load
	 * @since 0.7.0
	 * @hidden
	 */
	public static func warmup() {
		WKWebView(frame: .zero, configuration: WKWebViewConfiguration()).loadHTMLString("<p>Warmup</p>", baseURL: nil)
	}

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
	 * @inherited
	 * @method createContentView
	 * @since 0.7.0
	 */
	override open func createContentView() -> WebView {
		return WebView(frame: .zero, delegate: self)
	}

	/**
	 * @inherited
	 * @method dispose
	 * @since 0.6.0
	 */
	override open func dispose() {
		self.view.contentViewDelegate = nil
		self.view.stopLoading()
		super.dispose()
	}

	/**
	 * @inherited
	 * @method measure
	 * @since 0.7.0
	 */
	override open func measure(in bounds: CGSize, min: CGSize, max: CGSize) -> CGSize {
		return self.view.measure(in: bounds, min: min, max: max)
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
		self.holder.callMethod("nativeOnBeforeLoad", arguments: [self.context.createString(url.absoluteString)], result: result)
		return result.boolean
	}

	/**
	 * @method didLoad
	 * @since 0.7.0
	 * @hidden
	 */
	public func didLoad(webView: WebView) {
		self.holder.callMethod("nativeOnLoad")
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
			if (self.layoutNode.wrapsContentWidth) {
				self.layoutNode.invalidate()
			}
		}

		if (self.resolvedContentHeight != contentHeight) {
			if (self.layoutNode.wrapsContentHeight) {
				self.layoutNode.invalidate()
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
		self.view.load(url: callback.argument(0).string)
	}

	/**
	 * @method jsFunction_loadHTML
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_loadHTML(callback: JavaScriptFunctionCallback) {
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
