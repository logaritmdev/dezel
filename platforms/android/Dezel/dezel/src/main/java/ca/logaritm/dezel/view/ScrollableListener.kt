package ca.logaritm.dezel.view

/**
 * TODO
 * @interface ScrollableListener
 * @since 0.2.0
 */
public interface ScrollableListener {

	/**
	 * Called when the content view begins draggins.
	 * @method onDragStart
	 * @since 0.2.0
	 */
	fun onDragStart(scrollable: Scrollable)

	/**
	 * Called when the content view finishes dragging.
	 * @method onDragEnd
	 * @since 0.2.0
	 */
	fun onDragEnd(scrollable: Scrollable)

	/**
	 * Called when the content view scrolls while having a touch.
	 * @method onDrag
	 * @since 0.2.0
	 */
	fun onDrag(scrollable: Scrollable)

	/**
	 * Called when the content view begins scrolling.
	 * @method onScrollStart
	 * @since 0.2.0
	 */
	fun onScrollStart(scrollable: Scrollable)

	/**
	 * Called when the content view finished scrolling.
	 * @method onScrollEnd
	 * @since 0.2.0
	 */
	fun onScrollEnd(scrollable: Scrollable)

	/**
	 * Called when the content view scrolls.
	 * @method onScroll
	 * @since 0.2.0
	 */
	fun onScroll(scrollable: Scrollable, top: Int, left: Int)

	/**
	 * Called when the content view begins zooming.
	 * @method onZoomStart
	 * @since 0.3.0
	 */
	fun onZoomStart(scrollable: Scrollable)

	/**
	 * Called when the content view finishes zooming.
	 * @method onZoomEnd
	 * @since 0.3.0
	 */
	fun onZoomEnd(scrollable: Scrollable, scale: Float)

	/**
	 * Called when the content view zoom changes.
	 * @method onZoom
	 * @since 0.3.0
	 */
	fun onZoom(scrollable: Scrollable)
}
