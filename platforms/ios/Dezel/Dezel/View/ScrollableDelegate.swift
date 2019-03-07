/**
 * The delegate for scroll events.
 * @protocol ScrollableDelegate
 * @since 0.2.0
 */
public protocol ScrollableDelegate: AnyObject {

	/**
	 * Called when the content view begins draggins.
	 * @method didBeginDragging
	 * @since 0.2.0
	 */
	func didBeginDragging(scrollable: Scrollable)

	/**
	 * Called when the content view finishes dragging.
	 * @method didFinishDragging
	 * @since 0.2.0
	 */
	func didFinishDragging(scrollable: Scrollable)

	/**
	 * Called when the content view scrolls while having a touch.
	 * @method didDrag
	 * @since 0.2.0
	 */
	func didDrag(scrollable: Scrollable)

	/**
	 * Called when the content view begins scrolling.
	 * @method didBeginScrolling
	 * @since 0.2.0
	 */
	func didBeginScrolling(scrollable: Scrollable)

	/**
	 * Called when the content view finished scrolling.
	 * @method didFinishScrolling
	 * @since 0.2.0
	 */
	func didFinishScrolling(scrollable: Scrollable)

	/**
	 * Called when the content view scrolls.
	 * @method didScroll
	 * @since 0.2.0
	 */
	func didScroll(scrollable: Scrollable, top: CGFloat, left: CGFloat)

	/**
	 * Called when the content view begins zooming.
	 * @method didBeginZooming
	 * @since 0.3.0
	 */
	func didBeginZooming(scrollable: Scrollable)

	/**
	 * Called when the content view finishes zooming.
	 * @method didFinishZooming
	 * @since 0.3.0
	 */
	func didFinishZooming(scrollable: Scrollable, scale: CGFloat)

	/**
	 * Called when the content view zoom changes.
	 * @method didZoom
	 * @since 0.3.0
	 */
	func didZoom(scrollable: Scrollable)
}
