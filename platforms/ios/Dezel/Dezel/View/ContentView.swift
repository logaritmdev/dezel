
/**
 * @class ContentView
 * @since 0.1.0
 * @hidden
 */
open class ContentView : UIScrollView, UIScrollViewDelegate, Scrollable {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The scroll view's delegate.
	 * @property scrollableDelegate
	 * @since 0.2.0
	 */
	open weak var scrollableDelegate: ScrollableDelegate?

	/**
	 * Whether the scroll view is scrollable.
	 * @property scrollable
	 * @since 0.1.0
	 */
	open var scrollable: Bool = false {
		willSet {
			self.isScrollEnabled = newValue
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
					self.showsVerticalScrollIndicator = false
					self.showsHorizontalScrollIndicator = false

				case .both:
					self.showsVerticalScrollIndicator = true
					self.showsHorizontalScrollIndicator = true

				case .vertical:
					self.showsVerticalScrollIndicator = true
					self.showsHorizontalScrollIndicator = false

				case .horizontal:
					self.showsVerticalScrollIndicator = true
					self.showsHorizontalScrollIndicator = false
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
					self.bounces = true
					self.alwaysBounceVertical = false
					self.alwaysBounceHorizontal = false

				case .never:
					self.bounces = false
					self.alwaysBounceVertical = false
					self.alwaysBounceHorizontal = false

				case .always:
					self.bounces = true
					self.alwaysBounceVertical = true
					self.alwaysBounceHorizontal = true

				case .alwaysX:
					self.bounces = true
					self.alwaysBounceVertical = false
					self.alwaysBounceHorizontal = true

				case .alwaysY:
					self.bounces = true
					self.alwaysBounceVertical = true
					self.alwaysBounceHorizontal = false
			}
		}
	}

	/**
	 * The scrollable view's scroll top.
	 * @property scrollTop
	 * @since 0.1.0
	 */
	open var scrollTop: CGFloat = 0 {
		willSet {
			if (self.contentOffset.y != newValue) {
				self.contentOffset = self.contentOffset.setTop(newValue)
			}
		}
	}

	/**
	 * The scroll view's scroll left.
	 * @property scrollLeft
	 * @since 0.1.0
	 */
	open var scrollLeft: CGFloat = 0 {
		willSet {
			if (self.contentOffset.x != newValue) {
				self.contentOffset = self.contentOffset.setLeft(newValue)
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
			if (self.contentSize.width != newValue) {
				self.contentSize = self.contentSize.setWidth(newValue)
			}
		}
	}

	/**
	 * The scrollable view's scroll height.
	 * @property scrollHeight
	 * @since 0.1.0
	 */
	open var scrollHeight: CGFloat = 0 {
		willSet {
			if (self.contentSize.height != newValue) {
				self.contentSize = self.contentSize.setHeight(newValue)
			}
		}
	}

	/**
	 * Whether the scroll view has momentum.
	 * @property momentum
	 * @since 0.1.0
	 */
	open var momentum: Bool = true

	/**
	 * The scroll view's top content inset.
	 * @property contentInsetTop
	 * @since 0.2.0
	 */
	open var contentInsetTop: CGFloat = 0 {
		willSet {
			self.contentInset = self.contentInset.setTop(newValue)
		}
	}

	/**
	 * The scroll view's left content inset.
	 * @property contentInsetLeft
	 * @since 0.2.0
	 */
	open var contentInsetLeft: CGFloat = 0 {
		willSet {
			self.contentInset = self.contentInset.setLeft(newValue)
		}
	}

	/**
	 * The scroll view's right content inset.
	 * @property contentInsetRight
	 * @since 0.2.0
	 */
	open var contentInsetRight: CGFloat = 0 {
		willSet {
			self.contentInset = self.contentInset.setRight(newValue)
		}
	}

	/**
	 * The scroll view's bottom content inset.
	 * @property contentInsetBottom
	 * @since 0.2.0
	 */
	open var contentInsetBottom: CGFloat = 0 {
		willSet {
			self.contentInset = self.contentInset.setBottom(newValue)
		}
	}

	/**
	 * Whether the scroll view's is paged.
	 * @property paged
	 * @since 0.2.0
	 */
	open var paged: Bool = false {
		willSet {
			self.isPagingEnabled = newValue
		}
	}

	/**
	 * Whether the scrollable view's is zoomable.
	 * @property zoomable
	 * @since 0.3.0
	 */
	open var zoomable: Bool = false

	/**
	 * The scrollable view min zoom.
	 * @property minZoom
	 * @since 0.3.0
	 */
	open var minZoom: CGFloat = 1.0 {
		willSet {
			self.minimumZoomScale = newValue
		}
	}

	/**
	 * The scrollable view max zoom.
	 * @property maxZoom
	 * @since 0.3.0
	 */
	open var maxZoom: CGFloat = 1.0 {
		willSet {
			self.maximumZoomScale = newValue
		}
	}

	/**
	 * The view that is zoomed.
	 * @property zoomedView
	 * @since 0.3.0
	 */
	open var zoomedView: UIView?

	/**
	 * @property scrolling
	 * @since 0.1.0
	 * @hidden
	 */
	private var scrolling: Bool = false

	/**
	 * @property timeout
	 * @since 0.1.0
	 * @hidden
	 */
	private var timeout: Timer?

	/**
	 * @property timerScrollLeft
	 * @since 0.1.0
	 * @hidden
	 */
	private var timerScrollLeft: CGFloat = 0

	/**
	 * @property timerScrollTop
	 * @since 0.1.0
	 * @hidden
	 */
	private var timerScrollTop: CGFloat = 0

	/**
	 * @property application
	 * @since 0.1.0
	 * @hidden
	 */
	private var application: DezelApplicationController

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	public required init(application: DezelApplicationController, frame: CGRect) {

		self.application = application

		super.init(frame:frame)

		self.clipsToBounds = true
		self.isScrollEnabled = false
		self.isPagingEnabled = false
		self.delaysContentTouches = false
		self.showsVerticalScrollIndicator = false
		self.showsHorizontalScrollIndicator = false

		if #available(iOS 11, *) {
			self.contentInsetAdjustmentBehavior = .never
		}

		self.layer.contentsScale = UIScreen.main.scale
		self.layer.rasterizationScale = UIScreen.main.scale

		self.delegate = self
	}

	/**
	 * @inherited
	 * @method touchesCancelled
	 * @since 0.1.0
	 */
	override open func touchesCancelled(_ touches:Set<UITouch>, with event:UIEvent?) {
		super.touchesCancelled(touches, with:event)
		self.application.dispatchTouchCancel(touches)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Animations
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method action
	 * @since 0.1.0
	 */
	override open func action(for layer: CALayer, forKey event: String) -> CAAction? {
		return Transition.action(for: layer, key: event)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Scrollable View
	//--------------------------------------------------------------------------

	/**
	 * Smooth scroll the scroll view's to the specified location.
	 * @method scrollTo
	 * @since 0.1.0
	 */
	open func scrollTo(x: CGFloat, y: CGFloat) {
		self.scrollRectToVisible(CGRect(x: x, y: y, width: 1, height: 1), animated: true)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Scroll View Delegate
	//--------------------------------------------------------------------------

	/**
	 * @method scrollViewDidScroll
	 * @since 0.1.0
	 * @hidden
	 */
	open func scrollViewDidScroll(_ scrollView: UIScrollView) {

		if (self.scrolling == false) {
			self.scrolling = true
			self.didBeginScrolling()
		}

		let t = scrollView.contentOffset.y
		let l = scrollView.contentOffset.x

		if (self.scrolling) {
			self.didScroll(top: t, left: l)
		}

		if (self.isDragging) {
			self.didDrag()
		} else {
			self.watch()
		}
	}

	/**
	 * @method scrollViewDidEndScrollingAnimation
	 * @since 0.1.0
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
	 * @since 0.1.0
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
	 * @since 0.1.0
	 * @hidden
	 */
	open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		self.didBeginDragging()
	}

	/**
	 * @method scrollViewWillEndDragging
	 * @since 0.1.0
	 * @hidden
	 */
	open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if (self.momentum == false) {
			targetContentOffset.pointee = scrollView.contentOffset
			self.didFinishDragging()
		}
	}

	/**
	 * @method scrollViewDidEndDragging
	 * @since 0.1.0
	 * @hidden
	 */
	open func scrollViewDidEndDragging(_ scrollView:UIScrollView, willDecelerate decelerate: Bool) {

		if (decelerate == false) {
			if (self.scrolling) {
				self.scrolling = false
				self.didFinishScrolling()
				self.unwatch()
			}
		}

		self.scrollableDelegate?.didFinishDragging(scrollable: self)
	}

	/**
	 * @method scrollViewDidEndZooming
	 * @since 0.3.0
	 * @hidden
	 */
	public func scrollViewDidZoom(_ scrollView: UIScrollView) {
		self.scrollableDelegate?.didZoom(scrollable: self)
	}

	/**
	 * @method scrollViewDidEndZooming
	 * @since 0.3.0
	 * @hidden
	 */
	public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
		self.scrollableDelegate?.didBeginZooming(scrollable: self)
	}

	/**
	 * @method scrollViewDidEndZooming
	 * @since 0.3.0
	 * @hidden
	 */
	public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
		self.scrollableDelegate?.didFinishZooming(scrollable: self, scale: scale)
	}

	/**
	 * @method viewForZooming
	 * @since 0.3.0
	 * @hidden
	 */
	public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return self.zoomedView
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
		if (self.timeout == nil) {
			self.timeout = Timer.scheduledTimer(timeInterval:(32 / 1000), target: self, selector: #selector(didStopScrolling), userInfo: nil, repeats: true)
			self.timerScrollTop = self.contentOffset.y
			self.timerScrollLeft = self.contentOffset.y
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
	 * @since 0.2.0
	 * @hidden
	 */
	private func didBeginDragging() {
		self.scrollableDelegate?.didBeginDragging(scrollable: self)
	}

	/**
	 * @method didFinishDragging
	 * @since 0.2.0
	 * @hidden
	 */
	private func didFinishDragging() {
		self.scrollableDelegate?.didFinishDragging(scrollable: self)
	}

	/**
	 * @method didDrag
	 * @since 0.2.0
	 * @hidden
	 */
	private func didDrag() {
		self.scrollableDelegate?.didDrag(scrollable: self)
	}

	/**
	 * @method didBeginScrolling
	 * @since 0.2.0
	 * @hidden
	 */
	private func didBeginScrolling() {
		self.scrollableDelegate?.didBeginScrolling(scrollable: self)
	}

	/**
	 * @method didFinishScrolling
	 * @since 0.2.0
	 * @hidden
	 */
	private func didFinishScrolling() {
		self.scrollableDelegate?.didFinishScrolling(scrollable: self)
	}

	/**
	 * @method didScroll
	 * @since 0.2.0
	 * @hidden
	 */
	private func didScroll(top: CGFloat, left: CGFloat) {
		self.scrollableDelegate?.didScroll(scrollable: self, top: top, left: left)
	}

	/**
	 * @method didStopScrolling
	 * @since 0.21.0
	 * @hidden
	 */
	@objc open func didStopScrolling() {

		let t = self.contentOffset.y
		let l = self.contentOffset.x

		if (self.timerScrollTop == t &&
			self.timerScrollLeft == l) {
			self.scrollableDelegate?.didFinishScrolling(scrollable: self)
			self.unwatch()
			return
		}

		self.timerScrollTop = t
		self.timerScrollLeft = l
	}
}
