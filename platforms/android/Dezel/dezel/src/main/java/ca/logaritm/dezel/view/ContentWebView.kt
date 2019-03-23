package ca.logaritm.dezel.view

import android.content.Context
import android.util.Log
import android.util.Size
import android.util.SizeF
import android.view.MotionEvent
import android.view.View
import android.webkit.*
import ca.logaritm.dezel.extension.Delegates
import ca.logaritm.dezel.view.type.Overscroll
import ca.logaritm.dezel.view.type.Scrollbars

/**
 * @class ContentWebView
 * @since 0.5.0
 * @hidden
 */
open class ContentWebView(context: Context, listener: ContentWebViewListener) : WebView(context), Scrollable {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property contentViewListener
	 * @since 0.5.0
	 * @hidden
	 */
	open var contentViewListener: ContentWebViewListener? = null


	/**
	 * The scroll view's listener.
	 * @property scrollableListener
	 * @since 0.2.0
	 */
	override var scrollableListener: ScrollableListener? = null

	/**
	 * Whether the scroll view is scrollable.
	 * @property scrollable
	 * @since 0.1.0
	 */
	override var scrollable: Boolean = false

	/**
	 * Whether the scroll displays scrollbars.
	 * @property scrollbars
	 * @since 0.2.0
	 */
	override var scrollbars: Scrollbars by Delegates.OnSet(Scrollbars.NONE) { value ->

		when (value) {

			Scrollbars.NONE       -> {
				this.isVerticalScrollBarEnabled = false
				this.isHorizontalScrollBarEnabled = false
			}

			Scrollbars.BOTH       -> {
				this.isVerticalScrollBarEnabled = true
				this.isHorizontalScrollBarEnabled = true
			}

			Scrollbars.VERTICAL   -> {
				this.isVerticalScrollBarEnabled = true
				this.isHorizontalScrollBarEnabled = false
			}

			Scrollbars.HORIZONTAL -> {
				this.isVerticalScrollBarEnabled = false
				this.isHorizontalScrollBarEnabled = true
			}
		}
	}

	/**
	 * Whether the scrollable view can overscroll.
	 * @property overscroll
	 * @since 0.2.0
	 */
	override var overscroll: Overscroll by Delegates.OnSet(Overscroll.AUTO) { value ->
		when (value) {
			Overscroll.AUTO     -> { this.overScrollMode = View.OVER_SCROLL_IF_CONTENT_SCROLLS }
			Overscroll.NEVER    -> { this.overScrollMode = View.OVER_SCROLL_NEVER }
			Overscroll.ALWAYS   -> { this.overScrollMode = View.OVER_SCROLL_ALWAYS }
			Overscroll.ALWAYS_X -> { this.overScrollMode = View.OVER_SCROLL_ALWAYS }
			Overscroll.ALWAYS_Y -> { this.overScrollMode = View.OVER_SCROLL_ALWAYS }
		}
	}

	/**
	 * The scrollable view's scroll top.
	 * @property scrollTop
	 * @since 0.1.0
	 */
	override var scrollTop: Int
		get() = this.scrollY
		set(value) {
			this.scrollY = value
		}

	/**
	 * The scroll view's scroll left.
	 * @property scrollLeft
	 * @since 0.1.0
	 */
	override var scrollLeft: Int
		get() = this.scrollX
		set(value) {
			this.scrollX = value
		}

	/**
	 * The scrollable view's scroll width.
	 * @property scrollWidth
	 * @since 0.2.0
	 */
	override var scrollWidth: Int by Delegates.OnSet(0) {
		Log.i("DEZEL", "WebView scrollWidth is not supported")
	}

	/**
	 * The scrollable view's scroll height.
	 * @property scrollHeight
	 * @since 0.1.0
	 */
	override var scrollHeight: Int by Delegates.OnSet(0) {
		Log.i("DEZEL", "WebView scrollHeight is not supported")
	}

	/**
	 * Whether the scroll view has momentum.
	 * @property momentum
	 * @since 0.1.0
	 */
	override var momentum: Boolean by Delegates.OnSet(true) {
		Log.i("DEZEL", "WebView momentum is not supported")
	}

	/**
	 * The scroll view's top content inset.
	 * @property contentInsetTop
	 * @since 0.2.0
	 */
	override var contentInsetTop: Int by Delegates.OnSet(0) {
		Log.i("DEZEL", "WebView contentInsetTop is not supported")
	}

	/**
	 * The scroll view's left content inset.
	 * @property contentInsetLeft
	 * @since 0.2.0
	 */
	override var contentInsetLeft: Int by Delegates.OnSet(0) {
		Log.i("DEZEL", "WebView contentInsetLeft is not supported")
	}

	/**
	 * The scroll view's right content inset.
	 * @property contentInsetRight
	 * @since 0.2.0
	 */
	override var contentInsetRight: Int by Delegates.OnSet(0) {
		Log.i("DEZEL", "WebView contentInsetRight is not supported")
	}

	/**
	 * The scroll view's bottom content inset.
	 * @property contentInsetBottom
	 * @since 0.2.0
	 */
	override var contentInsetBottom:  Int by Delegates.OnSet(0) {
		Log.i("DEZEL", "WebView contentInsetBottom is not supported")
	}

	/**
	 * Whether the scroll view's is paged.
	 * @property paged
	 * @since 0.2.0
	 */
	override var paged: Boolean by Delegates.OnSet(false) {
		Log.i("DEZEL", "WebView paged is not supported")
	}

	/**
	 * Whether the scrollable view's is zoomable.
	 * @property zoomable
	 * @since 0.3.0
	 */
	override var zoomable: Boolean by Delegates.OnSet(false) { value ->
		this.settings.setSupportZoom(value)
	}

	/**
	 * The scrollable view min zoom.
	 * @property minZoom
	 * @since 0.3.0
	 */
	override var minZoom: Float by Delegates.OnSet(1.0f) {
		Log.i("DEZEL", "WebView minZoom is not supported")
	}

	/**
	 * The scrollable view max zoom.
	 * @property maxZoom
	 * @since 0.3.0
	 */
	override var maxZoom: Float by Delegates.OnSet(1.0f) {
		Log.i("DEZEL", "WebView maxZoom is not supported")
	}

	/**
	 * The view that is zoomed.
	 * @property zoomedView
	 * @since 0.3.0
	 */
	override var zoomedView: View? by Delegates.OnChangeOptional(null) { _, _ ->

	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.5.0
	 */
	init {

		this.contentViewListener = listener

		this.settings.allowFileAccess = true
		this.settings.allowFileAccessFromFileURLs = true
		this.settings.allowContentAccess = true
		this.settings.javaScriptEnabled = true

		this.webViewClient = object : WebViewClient() {

			override fun onPageFinished(view: WebView, url: String) {
				val w = this@ContentWebView.computeHorizontalScrollRange()
				val h = this@ContentWebView.computeVerticalScrollRange()
				this@ContentWebView.contentViewListener?.onUpdateContentSize(this@ContentWebView, Size(w, h))
				this@ContentWebView.contentViewListener?.onLoad(this@ContentWebView)
			}

			override fun shouldOverrideUrlLoading(view: WebView, request: WebResourceRequest): Boolean {

				val allow = this@ContentWebView.contentViewListener?.onBeforeLoad(this@ContentWebView, request.url.toString())
				if (allow == false) {
					return true
				}

				return super.shouldOverrideUrlLoading(view, request)
			}
		}
	}

	/**
	 * Measures the natural viewport of this view.
	 * @method measure
	 * @since 0.5.0
	 */
	open fun measure(bounds: SizeF, min: SizeF, max: SizeF): SizeF {

		var w = bounds.width
		if (w == 0f) {
			w = this.computeHorizontalScrollRange().toFloat()
		}

		var h = bounds.height
		if (h == 0f) {
			h = this.computeVerticalScrollRange().toFloat()
		}

		return SizeF(w, h)
	}

	/**
	 * @inherited
	 * @method onInterceptTouchEvent
	 * @since 0.1.0
	 */
	override fun onInterceptTouchEvent(event: MotionEvent): Boolean {

		if (this.scrollable == false) {
			return false
		}

		return super.onInterceptTouchEvent(event)
	}
}