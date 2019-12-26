/**
 * @protocol Scrollable
 * @since 0.2.0
 */
public protocol Scrollable: AnyObject {

	/**
	 * @property scrollableDelegate
	 * @since 0.2.0
	 */
	var scrollableDelegate: ScrollableDelegate? { get set }

	/**
	 * @property scrollable
	 * @since 0.2.0
	 */
	var scrollable: Bool { get set }

	/**
	 * @property scrollbars
	 * @since 0.2.0
	 */
	var scrollbars: Scrollbars { get set }

	/**
	 * @property overscroll
	 * @since 0.2.0
	 */
	var overscroll: Overscroll { get set }

	/**
	 * @property scrollTop
	 * @since 0.2.0
	 */
	var scrollTop: CGFloat { get set }

	/**
	 * @property scrollLeft
	 * @since 0.2.0
	 */
	var scrollLeft: CGFloat { get set }

	/**
	 * @property scrollWidth
	 * @since 0.2.0
	 */
	var scrollWidth: CGFloat { get set }

	/**
	 * @property scrollHeight
	 * @since 0.2.0
	 */
	var scrollHeight: CGFloat { get set }

	/**
	 * @property scrollInertia
	 * @since 0.2.0
	 */
	var scrollInertia: Bool { get set }

	/**
	 * @property contentInsetTop
	 * @since 0.2.0
	 */
	var contentInsetTop: CGFloat { get set }

	/**
	 * @property contentInsetLeft
	 * @since 0.2.0
	 */
	var contentInsetLeft: CGFloat { get set }

	/**
	 * @property contentInsetRight
	 * @since 0.2.0
	 */
	var contentInsetRight: CGFloat { get set }

	/**
	 * @property contentInsetBottom
	 * @since 0.2.0
	 */
	var contentInsetBottom: CGFloat { get set }

	/**
	 * @property paged
	 * @since 0.2.0
	 */
	var paged: Bool { get set }

	/**
	 * @property zoomable
	 * @since 0.3.0
	 */
	var zoomable: Bool { get set }

	/**
	 * @property minZoom
	 * @since 0.3.0
	 */
	var minZoom: CGFloat { get set }

	/**
	 * @property maxZoom
	 * @since 0.3.0
	 */
	var maxZoom: CGFloat { get set }

	/**
	 * @property maxZoom
	 * @since 0.3.0
	 */
	var zoomedView: UIView? { get set }

	/**
	 * @method scrollTo
	 * @since 0.2.0
	 */
	func scrollTo(x: CGFloat, y: CGFloat)

}
