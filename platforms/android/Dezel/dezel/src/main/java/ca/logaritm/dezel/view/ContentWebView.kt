package ca.logaritm.dezel.view

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.net.http.SslError
import android.util.Log
import android.util.Size
import android.util.SizeF
import android.view.MotionEvent
import android.view.View
import android.webkit.*
import android.widget.RelativeLayout
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

	/**
	 * @property webViewWebClient
	 * @since 0.6.0
	 * @hidden
	 */
	private var webViewWebClient: WebViewClient = object: WebViewClient() {

		/**
		 * @method onPageFinished
		 * @since 0.6.0
		 * @hidden
		 */
		override fun onPageFinished(view: WebView, url: String) {
			val w = this@ContentWebView.computeHorizontalScrollRange()
			val h = this@ContentWebView.computeVerticalScrollRange()
			contentViewListener?.onUpdateContentSize(this@ContentWebView, Size(w, h))
			contentViewListener?.onLoad(this@ContentWebView)
		}

		/**
		 * @method onReceivedSslError
		 * @since 0.6.0
		 * @hidden
		 */
		override fun onReceivedSslError(view: WebView, handler: SslErrorHandler, error: SslError) {
			handler.proceed()
		}

		/**
		 * @method shouldOverrideUrlLoading
		 * @since 0.6.0
		 * @hidden
		 */
		override fun shouldOverrideUrlLoading(view: WebView, url: String): Boolean {
			return this.shouldOverrideUrlLoading(url)
		}

		/**
		 * @method shouldOverrideUrlLoading
		 * @since 0.6.0
		 * @hidden
		 */
		override fun shouldOverrideUrlLoading(view: WebView, request: WebResourceRequest): Boolean {
			return this.shouldOverrideUrlLoading(request.url.toString())
		}

		/**
		 * @method shouldOverrideUrlLoading
		 * @since 0.6.0
		 * @hidden
		 */
		private fun shouldOverrideUrlLoading(url: String): Boolean {

			if (url.startsWith("tel:")) {
				context.startActivity(Intent(Intent.ACTION_DIAL, Uri.parse(url)))
				return true
			}

			if (url.startsWith("mailto:")) {
				context.startActivity(Intent(Intent.ACTION_SENDTO, Uri.parse(url)))
				return true
			}

			val allow = contentViewListener?.onBeforeLoad(this@ContentWebView, url)
			if (allow == false) {
				return true
			}

			return false
		}
	}

	/**
	 * @property webViewChromeClient
	 * @since 0.6.0
	 * @hidden
	 */
	private val webViewChromeClient: WebChromeClient = object: WebChromeClient() {

		/**
		 * @method onGeolocationPermissionsShowPrompt
		 * @since 0.6.0
		 * @hidden
		 */
		override fun onGeolocationPermissionsShowPrompt(origin: String?, callback: GeolocationPermissions.Callback) {
			callback(origin, true, false)
		}
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
		this.settings.javaScriptCanOpenWindowsAutomatically = true
		this.settings.databaseEnabled = true
		this.settings.domStorageEnabled = true
		this.settings.setGeolocationEnabled(true)

		/*
		 * Setting this is very important because it will have an effect
		 * on the height of the html element inside the web page.
		 */

		this.layoutParams = RelativeLayout.LayoutParams(
			RelativeLayout.LayoutParams.MATCH_PARENT,
			RelativeLayout.LayoutParams.MATCH_PARENT
		)

		this.webViewClient = this.webViewWebClient
		this.webChromeClient = this.webViewChromeClient

		WebView.setWebContentsDebuggingEnabled(true);
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