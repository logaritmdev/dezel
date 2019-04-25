import WebKit

/**
 * @class ContentWebView
 * @since 0.2.0
 * @hidden
 */
public class ContentWebView: WKWebView, WKNavigationDelegate, UIScrollViewDelegate, Scrollable {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The web view's delegate.
	 * @property scrollableDelegate
	 * @since 0.2.0
	 */
	open weak var scrollableDelegate: ScrollableDelegate?

	/**
	 * Whether the web view is scrollable.
	 * @property scrollable
	 * @since 0.2.0
	 */
	open var scrollable: Bool = false {
		willSet {
			self.scrollView.isScrollEnabled = newValue
		}
	}

	/**
	 * Whether the scroll displays scrollbars.
	 * @property scrollbars
	 * @since 0.2.0
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
	 * Whether the scrollable view can overscroll.
	 * @property overscroll
	 * @since 0.2.0
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
	 * The scrollable view's scroll top.
	 * @property scrollTop
	 * @since 0.2.0
	 */
	open var scrollTop: CGFloat = 0 {
		willSet {
			if (self.scrollView.contentOffset.y != newValue) {
				self.scrollView.contentOffset = self.scrollView.contentOffset.setTop(newValue)
			}
		}
	}

	/**
	 * The web view's scroll left.
	 * @property scrollLeft
	 * @since 0.2.0
	 */
	open var scrollLeft: CGFloat = 0 {
		willSet {
			if (self.scrollView.contentOffset.x != newValue) {
				self.scrollView.contentOffset = self.scrollView.contentOffset.setLeft(newValue)
			}
		}
	}

	/**
	 * The scrollable view's scroll width.
	 * @property scrollWidth
	 * @since 0.2.0
	 */
	open var scrollWidth: CGFloat = 0 {
		willSet {
			if (self.scrollView.contentSize.width != newValue) {
				self.scrollView.contentSize = self.scrollView.contentSize.setWidth(newValue)
			}
		}
	}

	/**
	 * The scrollable view's scroll height.
	 * @property scrollHeight
	 * @since 0.2.0
	 */
	open var scrollHeight: CGFloat = 0 {
		willSet {
			if (self.scrollView.contentSize.height != newValue) {
				self.scrollView.contentSize = self.scrollView.contentSize.setHeight(newValue)
			}
		}
	}

	/**
	 * Whether the web view has momentum.
	 * @property momentum
	 * @since 0.2.0
	 */
	open var momentum: Bool = true

	/**
	 * The web view's top content inset.
	 * @property contentInsetTop
	 * @since 0.2.0
	 */
	open var contentInsetTop: CGFloat = 0 {
		willSet {
			self.scrollView.contentInset = self.scrollView.contentInset.setTop(newValue)
		}
	}

	/**
	 * The web view's left content inset.
	 * @property contentInsetLeft
	 * @since 0.2.0
	 */
	open var contentInsetLeft: CGFloat = 0 {
		willSet {
			self.scrollView.contentInset = self.scrollView.contentInset.setLeft(newValue)
		}
	}

	/**
	 * The web view's right content inset.
	 * @property contentInsetRight
	 * @since 0.2.0
	 */
	open var contentInsetRight: CGFloat = 0 {
		willSet {
			self.scrollView.contentInset = self.scrollView.contentInset.setRight(newValue)
		}
	}

	/**
	 * The web view's bottom content inset.
	 * @property contentInsetBottom
	 * @since 0.2.0
	 */
	open var contentInsetBottom: CGFloat = 0 {
		willSet {
			self.scrollView.contentInset = self.scrollView.contentInset.setBottom(newValue)
		}
	}

	/**
	 * Whether the web view's is paged.
	 * @property paged
	 * @since 0.2.0
	 */
	open var paged: Bool = false {
		willSet {
			self.scrollView.isPagingEnabled = newValue
		}
	}

	/**
	 * Whether the scrollable view's is zoomable.
	 * @property zoomable
	 * @since 0.3.0
	 */
	open var zoomable: Bool = false {
		willSet {
			
		}
	}

	/**
	 * The scrollable view min zoom.
	 * @property minZoom
	 * @since 0.3.0
	 */
	open var minZoom: CGFloat = 1.0 {
		willSet {

		}
	}

	/**
	 * The scrollable view max zoom.
	 * @property maxZoom
	 * @since 0.3.0
	 */
	open var maxZoom: CGFloat = 1.0 {
		willSet {

		}
	}

	/**
	 * The view that is zoomed.
	 * @property zoomedView
	 * @since 0.3.0
	 */
	open var zoomedView: UIView?

	/**
	 * @property contentViewDelegate
	 * @since 0.5.0
	 * @hidden
	 */
	internal weak var contentViewDelegate: ContentWebViewDelegate?

	/**
	 * @property contentLoaded
	 * @since 0.2.0
	 * @hidden
	 */
	private var contentLoaded: Bool = false

	/**
	 * @property contentLoading
	 * @since 0.2.0
	 * @hidden
	 */
	private var contentLoading: Bool = false

	/**
	 * @property scrollViewDelegate
	 * @since 0.6.0
	 * @hidden
	 */
	private var scrollViewDelegate: ScrollViewDelegate!

	/**
	 * @property application
	 * @since 0.6.0
	 * @hidden
	 */
	private var application: DezelApplicationController

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
	public required init(application: DezelApplicationController, frame: CGRect, delegate: ContentWebViewDelegate?) {

		self.application = application

		super.init(frame: frame, configuration: WKWebViewConfiguration())

		self.navigationDelegate = self
		self.contentViewDelegate = delegate
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
	}

	/**
	 * @destructor
	 * @since 0.2.0
	 * @hidden
	 */
	deinit {
		self.removeObserver(self, forKeyPath: "loading")
		self.scrollView.removeObserver(self, forKeyPath: "contentSize")
		self.scrollView.removeObserver(self, forKeyPath: "contentOffset")
	}

	/**
	 * @inherited
	 * @method action
	 * @since 0.2.0
	 */
	override open func action(for layer: CALayer, forKey event: String) -> CAAction? {
		return Transition.action(for: layer, key: event)
	}

	/**
	 * Measures the natural size of this view only including itself.
	 * @method measure
	 * @since 0.5.0
	 */
	open func measure(in bounds: CGSize, min: CGSize, max: CGSize) -> CGSize {
		return self.scrollView.contentSize.clamped(min: min, max: max)
	}

	/**
	 * @method load
	 * @since 0.2.0
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
	 * @since 0.2.0
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
	 * @since 0.2.0
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
							self.contentViewDelegate?.didLoad(webView: self)
						}
					}
				}
			}

			return
		}

		if (key == "contentSize") {

			if let value = change?[NSKeyValueChangeKey.newKey] as? CGSize {
				self.contentViewDelegate?.didUpdateContentSize(webView: self, size: value)
			}

			return
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Scrollable
	//--------------------------------------------------------------------------

	/**
	 * Smooth scroll the scroll view's to the specified location.
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
	 * @since 0.2.0
	 * @hidden
	 */
	public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

	}

	/**
	 * @since 0.2.0
	 * @hidden
	 */
	public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
		print("Error \(error.localizedDescription)")
	}

	/**
	 * @since 0.2.0
	 * @hidden
	 */
	public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

		guard let delegate = self.contentViewDelegate else {
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
	 * @since 0.2.0
	 * @hidden
	 */
	@objc open func scrollViewDidCancelTouch(gesture: ScrollViewTouchCancelGesture) {
		self.application.dispatchTouchCancel(gesture.touches)
	}

	//--------------------------------------------------------------------------
	// MARK: Classes
	//--------------------------------------------------------------------------

	/**
	 * @class ScrollViewDelegate
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
		private weak var content: ContentWebView?

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
		public init(content: ContentWebView) {
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

			if (content.momentum == false) {
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
