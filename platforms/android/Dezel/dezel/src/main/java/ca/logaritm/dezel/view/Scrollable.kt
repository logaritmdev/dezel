package ca.logaritm.dezel.view

import android.view.View
import ca.logaritm.dezel.view.type.Overscroll
import ca.logaritm.dezel.view.type.Scrollbars

/**
 * Provides the methods to manage a view that is scrollable.
 * @interface Scrollable
 * @since 0.2.0
 */
public interface Scrollable {

	/**
	 * The scrollable view's listener.
	 * @property scrollableListener
	 * @since 0.2.0
	 */
	var scrollableListener: ScrollableListener?

	/**
	 * Whether the scrollable view is scrollable.
	 * @property scrollable
	 * @since 0.2.0
	 */
	var scrollable: Boolean

	/**
	 * Whether the scrollable view displays scrollbars.
	 * @property scrollbars
	 * @since 0.2.0
	 */
	var scrollbars: Scrollbars

	/**
	 * Whether the scrollable view can overscroll.
	 * @property overscroll
	 * @since 0.2.0
	 */
	var overscroll: Overscroll

	/**
	 * The scrollable view's scroll top.
	 * @property scrollTop
	 * @since 0.2.0
	 */
	var scrollTop: Int

	/**
	 * The scrollable view's scroll left.
	 * @property scrollLeft
	 * @since 0.2.0
	 */
	var scrollLeft: Int

	/**
	 * The scrollable view's scroll width.
	 * @property scrollWidth
	 * @since 0.2.0
	 */
	var scrollWidth: Int

	/**
	 * The scrollable view's scroll height.
	 * @property scrollHeight
	 * @since 0.2.0
	 */
	var scrollHeight: Int

	/**
	 * Whether the scrollable view has momentum.
	 * @property momentum
	 * @since 0.2.0
	 */
	var momentum: Boolean

	/**
	 * The scrollable view's top content inset.
	 * @property contentInsetTop
	 * @since 0.2.0
	 */
	var contentInsetTop: Int

	/**
	 * The scrollable view's left content inset.
	 * @property contentInsetLeft
	 * @since 0.2.0
	 */
	var contentInsetLeft: Int

	/**
	 * The scrollable view's right content inset.
	 * @property contentInsetRight
	 * @since 0.2.0
	 */
	var contentInsetRight: Int

	/**
	 * The scrollable view's bottom content inset.
	 * @property contentInsetBottom
	 * @since 0.2.0
	 */
	var contentInsetBottom: Int

	/**
	 * Whether the scrollable view's is paged.
	 * @property paged
	 * @since 0.2.0
	 */
	var paged: Boolean

	/**
	 * Whether the scrollable view's is zoomable.
	 * @property zoomable
	 * @since 0.3.0
	 */
	var zoomable: Boolean

	/**
	 * The scrollable view min zoom.
	 * @property minZoom
	 * @since 0.3.0
	 */
	var minZoom: Float

	/**
	 * The scrollable view max zoom.
	 * @property maxZoom
	 * @since 0.3.0
	 */
	var maxZoom: Float

	/**
	 * The view that is zoomed.
	 * @property zoomedView
	 * @since 0.3.0
	 */
	var zoomedView: View?

	/**
	 * @method scrollTo
	 * @since 0.1.0
	 * @hidden
	 */
	fun scrollTo(x: Int, y: Int)
}