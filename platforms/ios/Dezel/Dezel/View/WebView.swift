import WebKit

/**
 * @class WebView
 * @super WKWebView
 * @since 0.7.0
 */
public class WebView: WKWebView, WKNavigationDelegate, UIScrollViewDelegate, Scrollable {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property scrollableDelegate
	 * @since 0.7.0
	 */
	open weak var scrollableDelegate: ScrollableDelegate?

	/**
	 * @property scrollable
	 * @since 0.7.0
	 */
	open var scrollable: Bool = false {
		willSet {
			self.scrollView.isScrollEnabled = newValue
		}
	}

	/**
	 * @property scrollbars
	 * @since 0.7.0
	 */
	open var scrollbars: Scrollbars = .none {

		willSet {

			switch (newValue) {

				case .none:
					self.scrollView.showsVerticalScrollIndicator = false
					self.scrollView.showsHorizontalScrollIndicator = false

				case .both:
					self.scrollView.showsVerticalScrollIndicator = true
					self.scrollView.showsHorizontalScrollIndicator = true

				case .vertical:
					self.scrollView.showsVerticalScrollIndicator = true
					self.scrollView.showsHorizontalScrollIndicator = false

				case .horizontal:
					self.scrollView.showsVerticalScrollIndicator = true
					self.scrollView.showsHorizontalScrollIndicator = false
			}
		}
	}

	/**
	 * @property overscroll
	 * @since 0.7.0
	 */
	open var overscroll: Overscroll = .auto {

		willSet {

			switch (newValue) {

				case .auto:
					self.scrollView.bounces = true
					self.scrollView.alwaysBounceVertical = false
					self.scrollView.alwaysBounceHorizontal = false

				case .never:
					self.scrollView.bounces = false
					self.scrollView.alwaysBounceVertical = false
					self.scrollView.alwaysBounceHorizontal = false

				case .always:
					self.scrollView.bounces = true
					self.scrollView.alwaysBounceVertical = true
					self.scrollView.alwaysBounceHorizontal = true

				case .alwaysX:
					self.scrollView.bounces = true
					self.scrollView.alwaysBounceVertical = false
					self.scrollView.alwaysBounceHorizontal = true

				case .alwaysY:
					self.scrollView.bounces = true
					self.scrollView.alwaysBounceVertical = true
					self.scrollView.alwaysBounceHorizontal = false
			}
		}
	}

	/**
	 * @property scrollTop
	 * @since 0.7.0
	 */
	open var scrollTop: CGFloat = 0 {
		willSet {
			if (self.scrollView.contentOffset.y != newValue) {
				self.scrollView.contentOffset = self.scrollView.contentOffset.setTop(newValue)
			}
		}
	}

	/**
	 * @property scrollLeft
	 * @since 0.7.0
	 */
	open var scrollLeft: CGFloat = 0 {
		willSet {
			if (self.scrollView.contentOffset.x != newValue) {
				self.scrollView.contentOffset = self.scrollView.contentOffset.setLeft(newValue)
			}
		}
	}

	/**
	 * @property scrollWidth
	 * @since 0.7.0
	 */
	open var scrollWidth: CGFloat = 0 {
		willSet {
			if (self.scrollView.contentSize.width != newValue) {
				self.scrollView.contentSize = self.scrollView.contentSize.setWidth(newValue)
			}
		}
	}

	/**
	 * @property scrollHeight
	 * @since 0.7.0
	 */
	open var scrollHeight: CGFloat = 0 {
		willSet {
			if (self.scrollView.contentSize.height != newValue) {
				self.scrollView.contentSize = self.scrollView.contentSize.setHeight(newValue)
			}
		}
	}

	/**
	 * @property scrollInertia
	 * @since 0.7.0
	 */
	open var scrollInertia: Bool = true

	/**
	 * @property contentInsetTop
	 * @since 0.7.0
	 */
	open var contentInsetTop: CGFloat = 0 {
		willSet {
			self.scrollView.contentInset = self.scrollView.contentInset.setTop(newValue)
		}
	}

	/**
	 * @property contentInsetLeft
	 * @since 0.7.0
	 */
	open var contentInsetLeft: CGFloat = 0 {
		willSet {
			self.scrollView.contentInset = self.scrollView.contentInset.setLeft(newValue)
		}
	}

	/**
	 * @property contentInsetRight
	 * @since 0.7.0
	 */
	open var contentInsetRight: CGFloat = 0 {
		willSet {
			self.scrollView.contentInset = self.scrollView.contentInset.setRight(newValue)
		}
	}

	/**
	 * @property contentInsetBottom
	 * @since 0.7.0
	 */
	open var contentInsetBottom: CGFloat = 0 {
		willSet {
			self.scrollView.contentInset = self.scrollView.contentInset.setBottom(newValue)
		}
	}

	/**
	 * @property paged
	 * @since 0.7.0
	 */
	open var paged: Bool = false {
		willSet {
			self.scrollView.isPagingEnabled = newValue
		}
	}

	/**
	 * @property zoomable
	 * @since 0.7.0
	 */
	open var zoomable: Bool = false {
		willSet {

		}
	}

	/**
	 * @property minZoom
	 * @since 0.7.0
	 */
	open var minZoom: CGFloat = 1.0 {
		willSet {

		}
	}

	/**
	 * @property maxZoom
	 * @since 0.7.0
	 */
	open var maxZoom: CGFloat = 1.0 {
		willSet {

		}
	}

	/**
	 * @property zoomedView
	 * @since 0.7.0
	 */
	open var zoomedView: UIView?

	/**
	 * @property observer
	 * @since 0.7.0
	 * @hidden
	 */
	internal weak var observer: WebViewObserver?

	/**
	 * @property contentLoaded
	 * @since 0.7.0
	 * @hidden
	 */
	private var contentLoaded: Bool = false

	/**
	 * @property contentLoading
	 * @since 0.7.0
	 * @hidden
	 */
	private var contentLoading: Bool = false

	/**
	 * @property scrollViewDelegate
	 * @since 0.6.0
	 * @hidden
	 */
	private var scrollViewDelegate: ScrollViewDelegate!

	//----------------------------------------------------------------------
	// MARK: Methods
	//----------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.6.0
	 * @hidden
	 */
	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/**
	 * @constructor
	 * @since 0.6.0
	 * @hidden
	 */
	public required init(frame: CGRect, observer: WebViewObserver?) {

		super.init(frame: frame, configuration: WKWebViewConfiguration())

		self.navigationDelegate = self
		self.translatesAutoresizingMaskIntoConstraints = true

		self.scrollViewDelegate = ScrollViewDelegate(content: self)

		self.scrollView.isScrollEnabled = false
		self.scrollView.showsVerticalScrollIndicator = false
		self.scrollView.showsHorizontalScrollIndicator = false
		self.scrollView.delegate = self.scrollViewDelegate

		self.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
		self.scrollView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
		self.scrollView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)

		self.scrollView.addGestureRecognizer(
			ScrollViewTouchCancelGesture(scrollView: self.scrollView, target: self, action: #selector(scrollViewDidCancelTouch))
		)

		self.observer = observer
	}

	/**
	 * @destructor
	 * @since 0.7.0
	 * @hidden
	 */
	deinit {
		self.removeObserver(self, forKeyPath: "loading")
		self.scrollView.removeObserver(self, forKeyPath: "contentSize")
		self.scrollView.removeObserver(self, forKeyPath: "contentOffset")
	}

	/**
	 * @method action
	 * @since 0.7.0
	 */
	override open func action(for layer: CALayer, forKey event: String) -> CAAction? {
		return Transition.action(for: layer, key: event)
	}

	/**
	 * @method measure
	 * @since 0.7.0
	 */
	open func measure(bounds: CGSize, min: CGSize, max: CGSize) -> CGSize {
		return self.scrollView.contentSize.clamp(min: min, max: max)
	}

	/**
	 * @method load
	 * @since 0.7.0
	 * @hidden
	 */
	open func load(url: String) {

		guard let base = Bundle.main.resourceURL else {
			fatalError("Unable to retrieve application resource url")
		}

		if (url.hasPrefix("file://")) {
			if let url = URL(string: url) {
				self.contentLoaded = false
				self.contentLoading = true
				self.loadFileURL(url, allowingReadAccessTo: base.appendingPathComponent("app"))
			}
			return
		}

		if let url = URL(string: url) {
			self.contentLoaded = false
			self.contentLoading = true
			self.load(URLRequest(url: url))
		}
	}

	/**
	 * @method load
	 * @since 0.7.0
	 * @hidden
	 */
	open func load(html: String) {

		guard let base = Bundle.main.resourceURL else {
			fatalError("Unable to retrieve application resource url")
		}

		self.contentLoaded = false
		self.contentLoading = true

		self.loadHTMLString(html, baseURL: base.appendingPathComponent("app"))
	}

	/**
	 * @method observeValue
	 * @since 0.7.0
	 * @hidden
	 */
	public override func observeValue(forKeyPath key: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {

		guard
			let key = key,
			let chg = change else {
			return
		}

		if (key == "loading") {

			if let value = chg[NSKeyValueChangeKey.newKey] as? Bool {

				if (value == true) {
					self.contentLoaded = false
					self.contentLoading = true
					return
				}

				if (value == false) {
					if (self.contentLoading) {
						self.contentLoading = false
						if (self.contentLoaded == false) {
							self.contentLoaded = true
							self.observer?.didLoad(webView: self)
						}
					}
				}
			}

			return
		}

		if (key == "contentSize") {

			if let value = change?[NSKeyValueChangeKey.newKey] as? CGSize {
				self.observer?.didUpdateContentSize(webView: self, size: value)
			}

			return
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Scrollable
	//--------------------------------------------------------------------------

	/**
	 * @method scrollTo
	 * @since 0.1.0
	 */
	open func scrollTo(x: CGFloat, y: CGFloat) {
		self.scrollView.scrollRectToVisible(CGRect(x: x, y: y, width: 1, height: 1), animated: true)
	}

	//----------------------------------------------------------------------
	// MARK: WebView Delegate
	//----------------------------------------------------------------------

	/**
	 * @since 0.7.0
	 * @hidden
	 */
	public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

	}

	/**
	 * @since 0.7.0
	 * @hidden
	 */
	public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
		print("Error \(error.localizedDescription)")
	}

	/**
	 * @since 0.7.0
	 * @hidden
	 */
	public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

		guard let delegate = self.observer else {
			decisionHandler(.cancel)
			return
		}

		guard let url = navigationAction.request.url else {
			decisionHandler(.cancel)
			return
		}

		if (url.scheme == "tel") {
			UIApplication.shared.open(url, options: [:], completionHandler: nil)
			decisionHandler(.cancel)
			return
		}

		if (url.scheme == "mailto") {
			UIApplication.shared.open(url, options: [:], completionHandler: nil)
			decisionHandler(.cancel)
			return
		}

		let allow = delegate.willLoad(webView: self, url: navigationAction.request.url!)
		if (allow) {
			decisionHandler(.allow)
		} else {
			decisionHandler(.cancel)
		}
	}

	//--------------------------------------------------------------------------
	// MARK: ScrollView Touch Cancel Gesture
	//--------------------------------------------------------------------------

	/**
	 * @method scrollViewDidCancelTouch
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func scrollViewDidCancelTouch(gesture: ScrollViewTouchCancelGesture) {
		UIApplication.shared.window?.dispatchTouchCanceled(gesture.touches)
	}

	//--------------------------------------------------------------------------
	// MARK: Classes
	//--------------------------------------------------------------------------

	/**
	 * @class ScrollViewDelegate
	 * @super NSObject
	 * @since 0.6.0
	 * @hidden
	 */
	private class ScrollViewDelegate: NSObject, UIScrollViewDelegate {

		//--------------------------------------------------------------------------
		// MARK: Properties
		//--------------------------------------------------------------------------

		/**
		 * @property content
		 * @since 0.6.0
		 * @hidden
		 */
		private weak var content: WebView?

		/**
		 * @property scrolling
		 * @since 0.6.0
		 * @hidden
		 */
		private var scrolling: Bool = false

		/**
		 * @property timeout
		 * @since 0.6.0
		 * @hidden
		 */
		private var timeout: Timer?

		/**
		 * @property timerStartScrollLeft
		 * @since 0.6.0
		 * @hidden
		 */
		private var timerStartScrollLeft: CGFloat = 0

		/**
		 * @property timerStartScrollTop
		 * @since 0.6.0
		 * @hidden
		 */
		private var timerStartScrollTop: CGFloat = 0

		//--------------------------------------------------------------------------
		// MARK: Methods
		//--------------------------------------------------------------------------

		/**
		 * @constructor
		 * @since 0.6.0
		 */
		public init(content: WebView) {
			self.content = content
			super.init()
		}

		/**
		 * @method scrollViewDidScroll
		 * @since 0.6.0
		 * @hidden
		 */
		open func scrollViewDidScroll(_ scrollView: UIScrollView) {

			guard let content = self.content else {
				return
			}

			if (self.scrolling == false) {
				self.scrolling = true
				self.didBeginScrolling()
			}

			let t = scrollView.contentOffset.y
			let l = scrollView.contentOffset.x

			if (self.scrolling) {
				self.didScroll(top: t, left: l)
			}

			if (content.scrollView.isDragging) {
				self.didDrag()
			} else {
				self.watch()
			}
		}

		/**
		 * @method scrollViewDidEndScrollingAnimation
		 * @since 0.6.0
		 * @hidden
		 */
		open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
			if (self.scrolling) {
				self.scrolling = false
				self.unwatch()
				self.didFinishScrolling()
			}
		}

		/**
		 * @method scrollViewDidEndDecelerating
		 * @since 0.6.0
		 * @hidden
		 */
		open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
			if (self.scrolling) {
				self.scrolling = false
				self.unwatch()
				self.didFinishScrolling()
			}
		}

		/**
		 * @method scrollViewWillBeginDragging
		 * @since 0.6.0
		 * @hidden
		 */
		open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
			self.didBeginDragging()
		}

		/**
		 * @method scrollViewWillEndDragging
		 * @since 0.6.0
		 * @hidden
		 */
		open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

			guard let content = self.content else {
				return
			}

			if (content.scrollInertia == false) {
				targetContentOffset.pointee = scrollView.contentOffset
				self.didFinishDragging()
			}
		}

		/**
		 * @method scrollViewDidEndDragging
		 * @since 0.6.0
		 * @hidden
		 */
		open func scrollViewDidEndDragging(_ scrollView:UIScrollView, willDecelerate decelerate: Bool) {

			if (decelerate == false) {
				if (self.scrolling) {
					self.scrolling = false
					self.unwatch()
					self.didFinishScrolling()
				}
			}

			self.didFinishDragging()
		}

		//--------------------------------------------------------------------------
		// MARK: Private API
		//--------------------------------------------------------------------------

		/**
		 * @method watch
		 * @since 0.1.0
		 * @hidden
		 */
		private func watch() {

			guard let content = self.content else {
				return
			}

			if (self.timeout == nil) {
				self.timeout = Timer.scheduledTimer(timeInterval:(32 / 1000), target: self, selector: #selector(didStopScrolling), userInfo: nil, repeats: true)
				self.timerStartScrollTop = content.scrollView.contentOffset.y
				self.timerStartScrollLeft = content.scrollView.contentOffset.y
			}
		}

		/**
		 * @method unwatch
		 * @since 0.1.0
		 * @hidden
		 */
		private func unwatch() {
			self.timeout?.invalidate()
			self.timeout = nil
		}

		/**
		 * @method didBeginDragging
		 * @since 0.6.0
		 * @hidden
		 */
		private func didBeginDragging() {
			if let content = self.content {
				content.scrollableDelegate?.didBeginDragging(scrollable: content)
			}
		}

		/**
		 * @method didFinishDragging
		 * @since 0.6.0
		 * @hidden
		 */
		private func didFinishDragging() {
			if let content = self.content {
				content.scrollableDelegate?.didFinishDragging(scrollable: content)
			}
		}

		/**
		 * @method didDrag
		 * @since 0.6.0
		 * @hidden
		 */
		private func didDrag() {
			if let content = self.content {
				content.scrollableDelegate?.didDrag(scrollable: content)
			}
		}

		/**
		 * @method didBeginScrolling
		 * @since 0.6.0
		 * @hidden
		 */
		private func didBeginScrolling() {
			if let content = self.content {
				content.scrollableDelegate?.didBeginScrolling(scrollable: content)
			}
		}

		/**
		 * @method didFinishScrolling
		 * @since 0.6.0
		 * @hidden
		 */
		private func didFinishScrolling() {
			if let content = self.content {
				content.scrollableDelegate?.didFinishScrolling(scrollable: content)
			}
		}

		/**
		 * @method didScroll
		 * @since 0.6.0
		 * @hidden
		 */
		private func didScroll(top: CGFloat, left: CGFloat) {
			if let content = self.content {
				content.scrollableDelegate?.didScroll(scrollable: content, top: top, left: left)
			}
		}

		/**
		 * @method didStopScrolling
		 * @since 0.6.0
		 * @hidden
		 */
		@objc open func didStopScrolling() {

			guard let content = self.content else {
				return
			}

			let t = content.scrollView.contentOffset.y
			let l = content.scrollView.contentOffset.x

			if (self.timerStartScrollTop == t &&
				self.timerStartScrollLeft == l) {
				self.unwatch()
				self.didFinishScrolling()
				return
			}

			self.timerStartScrollTop = t
			self.timerStartScrollLeft = l
		}
	}
}
