package ca.logaritm.dezel.view.trait

/**
 * @interface ScrollableListener
 * @since 0.2.0
 */
public interface ScrollableListener {

	/**
	 * @method onDragStart
	 * @since 0.2.0
	 */
	fun onDragStart(scrollable: Scrollable)

	/**
	 * @method onDragEnd
	 * @since 0.2.0
	 */
	fun onDragEnd(scrollable: Scrollable)

	/**
	 * @method onDrag
	 * @since 0.2.0
	 */
	fun onDrag(scrollable: Scrollable)

	/**
	 * @method onScrollStart
	 * @since 0.2.0
	 */
	fun onScrollStart(scrollable: Scrollable)

	/**
	 * @method onScrollEnd
	 * @since 0.2.0
	 */
	fun onScrollEnd(scrollable: Scrollable)

	/**
	 * @method onScroll
	 * @since 0.2.0
	 */
	fun onScroll(scrollable: Scrollable, top: Int, left: Int)

	/**
	 * @method onZoomStart
	 * @since 0.3.0
	 */
	fun onZoomStart(scrollable: Scrollable)

	/**
	 * @method onZoomEnd
	 * @since 0.3.0
	 */
	fun onZoomEnd(scrollable: Scrollable, scale: Float)

	/**
	 * @method onZoom
	 * @since 0.3.0
	 */
	fun onZoom(scrollable: Scrollable)
}
