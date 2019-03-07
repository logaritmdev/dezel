/**
 * Provides the methods to manage a view that is scrollable.
 * @protocol Scrollable
 * @since 0.1.0
 */
public protocol Scrollable: AnyObject {

	/**
	 * The scrollable view's delegate.
	 * @property scrollableDelegate
	 * @since 0.2.0
	 */
	var scrollableDelegate: ScrollableDelegate? { get set }

	/**
	 * Whether the scrollable view is scrollable.
	 * @property scrollable
	 * @since 0.2.0
	 */
	var scrollable: Bool { get set }

	/**
	 * Whether the scrollable view displays scrollbars.
	 * @property scrollbars
	 * @since 0.2.0
	 */
	var scrollbars: Scrollbars { get set }

	/**
	 * Whether the scrollable view can overscroll.
	 * @property overscroll
	 * @since 0.2.0
	 */
	var overscroll: Overscroll { get set }

	/**
	 * The scrollable view's scroll top.
	 * @property scrollTop
	 * @since 0.2.0
	 */
	var scrollTop: CGFloat { get set }

	/**
	 * The scrollable view's scroll left.
	 * @property scrollLeft
	 * @since 0.2.0
	 */
	var scrollLeft: CGFloat { get set }

	/**
	 * The scrollable view's scroll width.
	 * @property scrollWidth
	 * @since 0.2.0
	 */
	var scrollWidth: CGFloat { get set }

	/**
	 * The scrollable view's scroll height.
	 * @property scrollHeight
	 * @since 0.2.0
	 */
	var scrollHeight: CGFloat { get set }

	/**
	 * Whether the scrollable view has momentum.
	 * @property momentum
	 * @since 0.2.0
	 */
	var momentum: Bool { get set }

	/**
	 * The scrollable view's top content inset.
	 * @property contentInsetTop
	 * @since 0.2.0
	 */
	var contentInsetTop: CGFloat { get set }

	/**
	 * The scrollable view's left content inset.
	 * @property contentInsetLeft
	 * @since 0.2.0
	 */
	var contentInsetLeft: CGFloat { get set }

	/**
	 * The scrollable view's right content inset.
	 * @property contentInsetRight
	 * @since 0.2.0
	 */
	var contentInsetRight: CGFloat { get set }

	/**
	 * The scrollable view's bottom content inset.
	 * @property contentInsetBottom
	 * @since 0.2.0
	 */
	var contentInsetBottom: CGFloat { get set }

	/**
	 * Whether the scrollable view's is paged.
	 * @property paged
	 * @since 0.2.0
	 */
	var paged: Bool { get set }

	/**
	 * Whether the scrollable view's is zoomable.
	 * @property zoomable
	 * @since 0.3.0
	 */
	var zoomable: Bool { get set }

	/**
	 * The scrollable view min zoom.
	 * @property minZoom
	 * @since 0.3.0
	 */
	var minZoom: CGFloat { get set }

	/**
	 * The scrollable view max zoom.
	 * @property maxZoom
	 * @since 0.3.0
	 */
	var maxZoom: CGFloat { get set }

	/**
	 * The view that is zoomed.
	 * @property maxZoom
	 * @since 0.3.0
	 */
	var zoomedView: UIView? { get set }

	/**
	 * Smooth scroll the scrollablew view's to the specified location.
	 * @method scrollTo
	 * @since 0.1.0
	 */
	func scrollTo(x: CGFloat, y: CGFloat)

}


