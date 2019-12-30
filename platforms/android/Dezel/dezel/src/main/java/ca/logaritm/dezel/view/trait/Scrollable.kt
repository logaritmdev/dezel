package ca.logaritm.dezel.view.trait

import android.view.View
import ca.logaritm.dezel.view.type.Overscroll
import ca.logaritm.dezel.view.type.Scrollbars

/**
 * @interface Scrollable
 * @since 0.2.0
 */
public interface Scrollable {

	/**
	 * @property scrollableListener
	 * @since 0.2.0
	 */
	var scrollableListener: ScrollableListener?

	/**
	 * @property scrollable
	 * @since 0.2.0
	 */
	var scrollable: Boolean

	/**
	 * @property scrollbars
	 * @since 0.2.0
	 */
	var scrollbars: Scrollbars

	/**
	 * @property overscroll
	 * @since 0.2.0
	 */
	var overscroll: Overscroll

	/**
	 * @property scrollTop
	 * @since 0.2.0
	 */
	var scrollTop: Int

	/**
	 * @property scrollLeft
	 * @since 0.2.0
	 */
	var scrollLeft: Int

	/**
	 * @property scrollWidth
	 * @since 0.2.0
	 */
	var scrollWidth: Int

	/**
	 * @property scrollHeight
	 * @since 0.2.0
	 */
	var scrollHeight: Int

	/**
	 * @property scrollInertia
	 * @since 0.2.0
	 */
	var scrollInertia: Boolean

	/**
	 * @property contentInsetTop
	 * @since 0.2.0
	 */
	var contentInsetTop: Int

	/**
	 * @property contentInsetLeft
	 * @since 0.2.0
	 */
	var contentInsetLeft: Int

	/**
	 * @property contentInsetRight
	 * @since 0.2.0
	 */
	var contentInsetRight: Int

	/**
	 * @property contentInsetBottom
	 * @since 0.2.0
	 */
	var contentInsetBottom: Int

	/**
	 * @property paged
	 * @since 0.2.0
	 */
	var paged: Boolean

	/**
	 * @property zoomable
	 * @since 0.3.0
	 */
	var zoomable: Boolean

	/**
	 * @property minZoom
	 * @since 0.3.0
	 */
	var minZoom: Float

	/**
	 * @property maxZoom
	 * @since 0.3.0
	 */
	var maxZoom: Float

	/**
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