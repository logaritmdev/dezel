/**
 * @protocol ScrollableDelegate
 * @since 0.2.0
 */
public protocol ScrollableDelegate: AnyObject {

	/**
	 * @method didBeginDragging
	 * @since 0.2.0
	 */
	func didBeginDragging(scrollable: Scrollable)

	/**
	 * @method didFinishDragging
	 * @since 0.2.0
	 */
	func didFinishDragging(scrollable: Scrollable)

	/**
	 * @method didDrag
	 * @since 0.2.0
	 */
	func didDrag(scrollable: Scrollable)

	/**
	 * @method didBeginScrolling
	 * @since 0.2.0
	 */
	func didBeginScrolling(scrollable: Scrollable)

	/**
	 * @method didFinishScrolling
	 * @since 0.2.0
	 */
	func didFinishScrolling(scrollable: Scrollable)

	/**
	 * @method didScroll
	 * @since 0.2.0
	 */
	func didScroll(scrollable: Scrollable, top: CGFloat, left: CGFloat)

	/**
	 * @method didBeginZooming
	 * @since 0.3.0
	 */
	func didBeginZooming(scrollable: Scrollable)

	/**
	 * @method didFinishZooming
	 * @since 0.3.0
	 */
	func didFinishZooming(scrollable: Scrollable, scale: CGFloat)

	/**
	 * @method didZoom
	 * @since 0.3.0
	 */
	func didZoom(scrollable: Scrollable)
}
