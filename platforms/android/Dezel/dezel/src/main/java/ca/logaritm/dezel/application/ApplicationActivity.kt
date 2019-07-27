package ca.logaritm.dezel.application

import android.app.Activity
import android.content.Intent
import android.graphics.Color
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Parcelable
import android.support.v4.content.LocalBroadcastManager
import android.util.Log
import android.view.MotionEvent
import android.view.View
import android.view.WindowManager
import android.view.inputmethod.InputMethodManager
import android.widget.RelativeLayout
import ca.logaritm.dezel.BuildConfig
import ca.logaritm.dezel.application.keyboard.KeyboardObserver
import ca.logaritm.dezel.application.keyboard.KeyboardObserverListener
import ca.logaritm.dezel.core.*
import ca.logaritm.dezel.extension.Delegates
import ca.logaritm.dezel.extension.viewport
import ca.logaritm.dezel.layout.Layout
import ca.logaritm.dezel.modules.application.Application
import ca.logaritm.dezel.modules.application.ApplicationModule
import ca.logaritm.dezel.modules.core.CoreModule
import ca.logaritm.dezel.modules.device.DeviceModule
import ca.logaritm.dezel.modules.dialog.DialogModule
import ca.logaritm.dezel.modules.form.FormModule
import ca.logaritm.dezel.modules.global.GlobalModule
import ca.logaritm.dezel.modules.graphic.GraphicModule
import ca.logaritm.dezel.modules.graphic.ImageLoader
import ca.logaritm.dezel.modules.locale.LocaleModule
import ca.logaritm.dezel.modules.platform.PlatformModule
import ca.logaritm.dezel.modules.view.ViewModule
import ca.logaritm.dezel.style.Styler
import ca.logaritm.dezel.view.graphic.Convert

/**
 * The root activity of a Dezel application.
 * @class ApplicationActivity
 * @since 0.7.0
 */
open class ApplicationActivity : Activity(), KeyboardObserverListener {

	//--------------------------------------------------------------------------
	// Enum
	//--------------------------------------------------------------------------

	/**
	 * The activity state.
	 * @enum State
	 * @since 0.7.0
	 */
	public enum class State {
		FOREGROUND,
		BACKGROUND
	}

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	companion object {

		/**
		 * @const kApplicationControllerKey
		 * @since 0.7.0
		 * @hidden
		 */
		internal val kApplicationActivityKey = Object()
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The application's view.
	 * @property view
	 * @since 0.7.0
	 */
	public lateinit var view: RelativeLayout
		private set

	/**
	 * The application's JavaScript context.
	 * @property context
	 * @since 0.7.0
	 */
	public var context: JavaScriptContext = JavaScriptContext()
		private set

	/**
	 * The application's styles manager.
	 * @property styler
	 * @since 0.7.0
	 */
	public var styler: Styler = Styler()
		private set

	/**
	 * The application's layout manager.
	 * @property layout
	 * @since 0.7.0
	 */
	public var layout: Layout = Layout()
		private set

	/**
	 * The application's JavaScript application object.
	 * @property application
	 * @since 0.7.0
	 */
	public var application: Application? = null
		private set

	/**
	 * @property modules
	 * @since 0.7.0
	 * @hidden
	 */
	private var modules: MutableMap<String, Class<*>> = mutableMapOf()

	/**
	 * @property classes
	 * @since 0.7.0
	 * @hidden
	 */
	private var classes: MutableMap<String, Class<*>> = mutableMapOf()

	/**
	 * @property sources
	 * @since 0.7.0
	 * @hidden
	 */
	private var sources: MutableList<Source> = mutableListOf()

	/**
	 * @property running
	 * @since 0.7.0
	 * @hidden
	 */
	private var running: Boolean = false

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Creates the application context and required components.
	 * @method setup
	 * @since 0.7.0
	 */
	open fun configure() {

	}

	/**
	 * Creates the application context and required components.
	 * @method setup
	 * @since 0.7.0
	 */
	open fun setup() {

		if (this.running) {
			return
		}

		this.running = true

		val viewport = this.viewport

		this.layout.scale = Convert.density
		this.layout.viewportWidth = viewport.width
		this.layout.viewportHeight = viewport.height

		this.styler.setVariable("safe-area-top-inset", "${this.getSafeAreaTopInset()}px")
		this.styler.setVariable("safe-area-bottom-inset", "${this.getSafeAreaBottomInset()}px")

		this.context.attribute(kApplicationActivityKey, this)
		this.context.global.property("_DEV_", this.isDev())
		this.context.global.property("_SIM_", this.isSim())

		this.context.handleError { error ->

			var file = "<no file>"
			var line = "<no line>"
			var stack = ""

			if (error.isObject) {
				file = error.property("sourceURL").string
				line = error.property("line").string
				stack = error.property("stack").string
			}

			val message =
				"${error.string} \n" +
				"File: $file \n" +
				"Line: $line \n" +
				"Stack Trace: \n" +
				stack

			this.onThrowError(error)

			throw JavaScriptException(message)
		}

		this.registerModule("dezel.CoreModule", CoreModule::class.java)
		this.registerModule("dezel.GlobalModule", GlobalModule::class.java)
		this.registerModule("dezel.LocaleModule", LocaleModule::class.java)
		this.registerModule("dezel.DeviceModule", DeviceModule::class.java)
		this.registerModule("dezel.PlatformModule", PlatformModule::class.java)
		this.registerModule("dezel.DialogModule", DialogModule::class.java)
		this.registerModule("dezel.GraphicModule", GraphicModule::class.java)
		this.registerModule("dezel.ViewModule", ViewModule::class.java)
		this.registerModule("dezel.FormModule", FormModule::class.java)
		this.registerModule("dezel.ApplicationModule", ApplicationModule::class.java)

		this.configure()

		this.context.registerModules(this.modules)
		this.context.registerClasses(this.classes)
		this.context.setup()

		this.sources.forEach { source ->
			when (source.category) {
				Source.Category.STYLE  -> this.evaluateStyle(source.data, source.location)
				Source.Category.SCRIPT -> this.evaluateScript(source.data, source.location)
			}
		}

		this.onLoad()
	}

	/**
	 * Registers a module.
	 * @method registerModule
	 * @since 0.7.0
	 */
	open fun registerModule(uid: String, value: Class<*>) {
		this.modules[uid] = value
	}

	/**
	 * Registers a class.
	 * @method registerClass
	 * @since 0.7.0
	 */
	open fun registerClass(uid: String, value: Class<*>) {
		this.classes[uid] = value
	}

	/**
	 * Registers a stylerNode file.
	 * @method registerStyle
	 * @since 0.7.0
	 */
	open fun registerStyle(location: String) {
		this.sources.add(Source(this, location, Source.Category.STYLE))
	}

	/**
	 * Registers a script file.
	 * @method registerScript
	 * @since 0.7.0
	 */
	open fun registerScript(location: String) {
		this.sources.add(Source(this, location, Source.Category.SCRIPT))
	}

	/**
	 * Evaluates a style file.
	 * @method evaluateStyle
	 * @since 0.7.0
	 */
	open fun evaluateStyle(source: String, file: String) {
		this.context.evaluate(source, file)
	}

	/**
	 * Evaluates a script file.
	 * @method evaluateScript
	 * @since 0.7.0
	 */
	open fun evaluateScript(source: String, file: String) {
		this.styler.load(source, file)
	}

	/**
	 * Launches the specified application.
	 * @method launch
	 * @since 0.7.0
	 */
	open fun launch(application: Application, identifier: String = "default") {

		this.application?.destroy()
		this.application = application

		this.styler.root = application.window.stylerNode
		this.layout.root = application.window.layoutNode

		val viewport = this.viewport
		application.window.width = Property(viewport.width.toDouble(), PropertyUnit.PX)
		application.window.height = Property(viewport.height.toDouble(), PropertyUnit.PX)
		this.view.addView(application.window.wrapper)

		this.statusBar.bringToFront()

		this.onLaunchApplication(application)
	}

	/**
	 * Reloads the current application.
	 * @method reload
	 * @since 0.7.0
	 */
	public fun reload() {

		// TODO
		// FIX THIS
	}

	/**
	 * Opens a resource URL.
	 * @method openResourceURL
	 * @since 0.7.0
	 */
	open fun openResourceURL(url: Uri) {
		this.application?.holder?.callMethod("nativeOnOpenResourceURL", arrayOf(this.context.createString(url.toString())))
	}

	/**
	 * Opens a universal URL.
	 * @method openUniversalURL
	 * @since 0.7.0
	 */
	open fun openUniversalURL(url: Uri) {
		this.application?.holder?.callMethod("nativeOnOpenUniversalURL", arrayOf(this.context.createString(url.toString())))
	}

	//--------------------------------------------------------------------------
	// Methods - Touch Management
	//--------------------------------------------------------------------------

	/**
	 * Dispatches a native touch event to the JavaScript application.
	 * @method dispatchTouchEvent
	 * @since 0.7.0
	 */
	override fun dispatchTouchEvent(e: MotionEvent) : Boolean {

		val dispatch = super.dispatchTouchEvent(e)

		when (e.actionMasked) {
			MotionEvent.ACTION_CANCEL       -> this.dispatchTouchCancel(e)
			MotionEvent.ACTION_DOWN         -> this.dispatchTouchStart(e)
			MotionEvent.ACTION_POINTER_DOWN -> this.dispatchTouchStart(e)
			MotionEvent.ACTION_MOVE         -> this.dispatchTouchMove(e)
			MotionEvent.ACTION_UP           -> this.dispatchTouchEnd(e)
			MotionEvent.ACTION_POINTER_UP   -> this.dispatchTouchEnd(e)
		}

		return dispatch
	}

	/**
	 * Dispatches a touchcancel event to the JavaScript application.
	 * @method dispatchTouchCancel
	 * @since 0.7.0
	 */
	open fun dispatchTouchCancel(e: MotionEvent) {
		this.dispatchTouchEvent("nativeOnTouchCancel", e)
	}

	/**
	 * Dispatches a touchstart event to the JavaScript application.
	 * @method dispatchTouchStart
	 * @since 0.7.0
	 */
	open fun dispatchTouchStart(e: MotionEvent) {
		this.dispatchTouchEvent("nativeOnTouchStart", e)
	}

	/**
	 * Dispatches a touchmove event to the JavaScript application.
	 * @method dispatchTouchMove
	 * @since 0.7.0
	 */
	open fun dispatchTouchMove(e: MotionEvent) {
		this.dispatchTouchEvent("nativeOnTouchMove", e)
	}

	/**
	 * Dispatches a touchend event to the JavaScript application.
	 * @method dispatchTouchEnd
	 * @since 0.7.0
	 */
	open fun dispatchTouchEnd(e: MotionEvent) {
		this.dispatchTouchEvent("nativeOnTouchEnd", e)
	}

	//--------------------------------------------------------------------------
	// Methods - State Management
	//--------------------------------------------------------------------------

	/**
	 * Notifies the application it has moved to the background.
	 * @method onEnterBackground
	 * @since 0.7.0
	 */
	open fun onEnterBackground() {
		this.application?.holder?.callMethod("nativeOnEnterBackground")
	}

	/**
	 * Notifies the application it has moved to the foreground.
	 * @method onEnterForeground
	 * @since 0.7.0
	 */
	open fun onEnterForeground() {
		this.application?.holder?.callMethod("nativeOnEnterForeground")
	}

	//--------------------------------------------------------------------------
	// Methods - Keyboard Management
	//--------------------------------------------------------------------------

	/**
	 * Manually present the soft keyboard for the specified view.
	 * @method presentSoftKeyboard
	 * @since 0.7.0
	 */
	open fun presentSoftKeyboard(source: View) {
		this.keyboardTarget = source
		if (this.keyboardVisible == false) {
			this.keyboardManager.showSoftInput(source, InputMethodManager.SHOW_IMPLICIT)
			this.keyboardPresenting = true
		}
	}

	/**
	 * Manually dismiss the soft keyboard.
	 * @method dismissSoftKeyboard
	 * @since 0.7.0
	 */
	open fun dismissSoftKeyboard(source: View) {
		if (this.keyboardVisible) {
			this.view.post {
				if (this.keyboardTarget == source) {
					this.keyboardTarget = null
					this.keyboardManager.hideSoftInputFromWindow(this.window.decorView.windowToken, 0)
					this.keyboardDismissing = true
				}
			}
		}
	}

	/**
	 * Notifies the application it has moved to the foreground.
	 * @method onBeforeKeyboardShow
	 * @since 0.7.0
	 */
	open fun onBeforeKeyboardShow(height: Int) {
		this.dispatchKeyboardEvent("nativeOnBeforeKeyboardShow", height)
	}

	/**
	 * Notifies the application it has moved to the foreground.
	 * @method onKeyboardShow
	 * @since 0.7.0
	 */
	open fun onKeyboardShow(height: Int) {
		this.dispatchKeyboardEvent("nativeOnKeyboardShow", height)
	}

	/**
	 * Notifies the application it has moved to the foreground.
	 * @method onBeforeKeyboardHide
	 * @since 0.7.0
	 */
	open fun onBeforeKeyboardHide(height: Int) {
		this.dispatchKeyboardEvent("nativeOnBeforeKeyboardHide", height)
	}

	/**
	 * Notifies the application it has moved to the foreground.
	 * @method onKeyboardHide
	 * @since 0.7.0
	 */
	open fun onKeyboardHide(height: Int) {
		this.dispatchKeyboardEvent("nativeOnKeyboardHide", height)
	}

	/**
	 * Notifies the application it has moved to the foreground.
	 * @method onBeforeKeyboardResize
	 * @since 0.7.0
	 */
	open fun onBeforeKeyboardResize(height: Int) {
		this.dispatchKeyboardEvent("nativeOnBeforeKeyboardResize", height)
	}

	/**
	 * Notifies the application it has moved to the foreground.
	 * @method onKeyboardResize
	 * @since 0.7.0
	 */
	open fun onKeyboardResize(height: Int) {
		this.dispatchKeyboardEvent("nativeboardResize", height)
	}

	//--------------------------------------------------------------------------
	// Methods - Activity Management
	//--------------------------------------------------------------------------

	/**
	 * The application's state.
	 * @property state
	 * @since 0.7.0
	 */
	public var state: State = State.FOREGROUND
		private set

	/**
	 * @inherited
	 * @method onCreate
	 * @since 0.7.0
	 */
	override fun onCreate(savedInstanceState: Bundle?) {

		super.onCreate(savedInstanceState)

		Convert.density = this.resources.displayMetrics.density

		ImageLoader.setup(this)

		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {

			this.window.setFlags(
				WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS,
				WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS
			)

			this.window.decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR

		} else {

			this.window.setFlags(
				WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS,
				WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS
			)

			this.window.setFlags(
				WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION,
				WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION
			)
		}

		this.window.decorView.setOnSystemUiVisibilityChangeListener {

			val viewport = this.viewport
			this.layout.viewportWidth = viewport.width
			this.layout.viewportHeight = viewport.height

			val application = this.application
			if (application != null) {
				application.window.width = Property(viewport.width.toDouble(), PropertyUnit.PX)
				application.window.height = Property(viewport.height.toDouble(), PropertyUnit.PX)
			}
		}

		this.view = RelativeLayout(this)
		this.view.isFocusable = true
		this.view.isFocusableInTouchMode = true
		this.view.setBackgroundColor(Color.BLACK)

		this.setContentView(this.view)

		this.keyboardObserver = KeyboardObserver(this, this.view)

		this.statusBar = View(this)
		this.statusBar.layoutParams = RelativeLayout.LayoutParams(
			this.getStatusBarWidth(),
			this.getStatusBarHeight()
		)

		this.view.addView(this.statusBar)
	}

	/**
	 * @inherited
	 * @method onPause
	 * @since 0.7.0
	 */
	override fun onPause() {

		super.onPause()

		this.keyboardObserver.listener = null

		if (this.state == State.FOREGROUND) {
			this.state = State.BACKGROUND
			this.onEnterBackground()
		}

		LocalBroadcastManager.getInstance(this).sendBroadcastSync(Intent("dezel.application.BACKGROUND"))
	}

	/**
	 * @inherited
	 * @method onResume
	 * @since 0.7.0
	 */
	override fun onResume() {

		super.onResume()

		this.keyboardObserver.listener = this

		if (this.state == State.BACKGROUND) {
			this.state = State.FOREGROUND
			this.onEnterForeground()
		}

		LocalBroadcastManager.getInstance(this).sendBroadcastSync(Intent("dezel.application.FOREGROUND"))
	}

	/**
	 * @inherited
	 * @method onDestroy
	 * @since 0.7.0
	 */
	override fun onDestroy() {
		this.state = State.BACKGROUND
		this.keyboardObserver.listener = null
		this.keyboardObserver.close()
		super.onDestroy()
	}

	//--------------------------------------------------------------------------
	// Methods - Activity Intent Management
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onNewIntent
	 * @since 0.7.0
	 */
	override fun onNewIntent(intent: Intent?) {

		when (intent?.action) {

			Intent.ACTION_VIEW -> {
				val uri = intent.data
				if (uri is Uri) {
					this.openUniversalURL(uri)
				}
			}

			Intent.ACTION_SEND -> {
				val uri = intent.getParcelableExtra<Parcelable>(Intent.EXTRA_STREAM)
				if (uri is Uri) {
					this.openResourceURL(uri)
				}
			}

			else -> {
				// Nothing
			}
		}
	}

	//--------------------------------------------------------------------------
	// Methods - Activity Permission Management
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onRequestPermissionsResult
	 * @since 0.7.0
	 */
	override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, results: IntArray) {
		for (i in 0 until permissions.size) {
			val intent = Intent("dezel.application.PERMISSION_CHANGED")
			intent.putExtra("permission", permissions[i])
			intent.putExtra("result", results[i])
			LocalBroadcastManager.getInstance(this).sendBroadcastSync(intent)
		}
	}

	//--------------------------------------------------------------------------
	// Methods - Activity Back Management
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onBackPressed
	 * @since 0.7.0
	 */
	override fun onBackPressed() {

		val application = this.application
		if (application == null) {
			super.onBackPressed()
			return
		}

		val handled = this.context.createReturnValue()

		application.holder.callMethod("nativeOnBack", null, handled)

		if (handled.boolean == true) {
			return
		}

		super.onBackPressed()
	}

	//--------------------------------------------------------------------------
	// Methods - Activity Keyboard Management
	//--------------------------------------------------------------------------

	/**
	 * @property keyboardObserver
	 * @since 0.7.0
	 * @hidden
	 */
	private lateinit var keyboardObserver: KeyboardObserver

	/**
	 * @property keyboardManager
	 * @since 0.7.0
	 * @hidden
	 */
	private val keyboardManager: InputMethodManager
		get() = getSystemService(android.content.Context.INPUT_METHOD_SERVICE) as InputMethodManager

	/**
	 * @property keyboardPresenting
	 * @since 0.7.0
	 * @hidden
	 */
	private var keyboardPresenting: Boolean = false

	/**
	 * @property keyboardDismissing
	 * @since 0.7.0
	 * @hidden
	 */
	private var keyboardDismissing: Boolean = false

	/**
	 * @property keyboardVisible
	 * @since 0.7.0
	 * @hidden
	 */
	private var keyboardVisible: Boolean = false

	/**
	 * @property keyboardHeight
	 * @since 0.7.0
	 * @hidden
	 */
	private var keyboardHeight: Int = 0

	/**
	 * @property keyboardTarget
	 * @since 0.7.0
	 * @hidden
	 */
	private var keyboardTarget: View? = null

	/**
	 * @property keyboardHandler
	 * @since 0.7.0
	 * @hidden
	 */
	private var keyboardHandler: Handler = Handler()

	/**
	 * @method onKeyboardHeightChanged
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onKeyboardHeightChanged(height: Int, orientation: Int) {

		this.keyboardVisible = height > 0

		if (this.keyboardPresenting || this.keyboardDismissing) {

			if (this.keyboardPresenting) {
				this.keyboardPresenting = false
				this.onBeforeKeyboardShow(height)
				this.onKeyboardShow(height)
			}

			if (this.keyboardDismissing) {
				this.keyboardDismissing = false
				this.onBeforeKeyboardHide(this.keyboardHeight)
				this.onKeyboardHide(this.keyboardHeight)
			}

		} else {

			if (height == 0 && this.keyboardHeight > 0) {
				this.onBeforeKeyboardHide(this.keyboardHeight)
				this.onKeyboardHide(this.keyboardHeight)
			}

		}

		if (this.keyboardHeight != height) {
			this.onBeforeKeyboardResize(this.keyboardHeight)
			this.onKeyboardResize(this.keyboardHeight)
		}

		this.keyboardHeight = height
	}

	//--------------------------------------------------------------------------
	// Methods - Status Bar Management
	//--------------------------------------------------------------------------

	/**
	 * The status bar visibility status.
	 * @property statusBarVisible
	 * @since 0.7.0
	 */
	open var statusBarVisible: Boolean by Delegates.OnSet(true) {
		this.updateStatusBar()
	}

	/**
	 * The status bar foreground color (white or black)
	 * @property statusBarForegroundColor
	 * @since 0.7.0
	 */
	open var statusBarForegroundColor: Int by Delegates.OnSet(Color.BLACK) {
		this.updateStatusBar()
	}

	/**
	 * The status bar background color.
	 * @property statusBarBackgroundColor
	 * @since 0.7.0
	 */
	open var statusBarBackgroundColor: Int by Delegates.OnSet(Color.TRANSPARENT) {
		this.updateStatusBar()
	}

	/**
	 * @property statusBar
	 * @since 0.7.0
	 * @hidden
	 */
	private lateinit var statusBar: View

	/**
	 * @method updateStatusBar
	 * @since 0.7.0
	 * @hidden
	 */
	private fun updateStatusBar() {

		if (this.statusBarVisible == false) {
			this.statusBar.visibility = View.GONE
			this.window.decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_FULLSCREEN
			return
		}

		this.statusBar.visibility = View.VISIBLE

		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {

			var visibility = View.SYSTEM_UI_FLAG_VISIBLE

			if (this.statusBarForegroundColor == Color.WHITE) {
				visibility = visibility and View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR.inv()
			} else {
				visibility = visibility or View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR
			}

			this.window.decorView.systemUiVisibility = visibility
		}

		this.statusBar.setBackgroundColor(this.statusBarBackgroundColor)
	}

	/**
	 * @method getStatusBarWidth
	 * @since 0.7.0
	 * @hidden
	 */
	private fun getStatusBarWidth(): Int {
		return RelativeLayout.LayoutParams.MATCH_PARENT
	}

	/**
	 * @method getStatusBarHeight
	 * @since 0.7.0
	 * @hidden
	 */
	private fun getStatusBarHeight(): Int {

		val resource = this.resources.getIdentifier("status_bar_height", "dimen", "android")
		if (resource > 0) {
			return this.resources.getDimensionPixelSize(resource)
		}

		return 0
	}

	//--------------------------------------------------------------------------
	// Methods - Lifecycle
	//--------------------------------------------------------------------------

	/**
	 * Called when the application controller is loaded.
	 * @method onLoad
	 * @since 0.7.0
	 */
	open fun onLoad() {

	}

	/**
	 * Called when a JavaScript error is thrown.
	 * @method onThrowError
	 * @since 0.7.0
	 */
	open fun onThrowError(error: JavaScriptValue): Boolean {
		return true
	}

	/**
	 * Called when a JavaScript application is launched.
	 * @method onLaunchApplication
	 * @since 0.7.0
	 */
	open fun onLaunchApplication(application: Application) {

	}

	/**
	 * Called when a JavaScript application is reloaded.
	 * @method onReloadApplication
	 * @since 0.7.0
	 */
	open fun onReloadApplication(application: Application) {

	}

	//--------------------------------------------------------------------------
	// Variables
	//--------------------------------------------------------------------------

	/**
	 * @method getSafeAreaTopInset
	 * @since 0.7.0
	 * @hidden
	 */
	private fun getSafeAreaTopInset(): Double {
		return Convert.toDp(this.getStatusBarHeight()).toDouble()
	}

	/**
	 * @method getSafeAreaBottomInset
	 * @since 0.7.0
	 * @hidden
	 */
	private fun getSafeAreaBottomInset(): Double {
		return 0.0
	}

	/**
	 * @method isDev
	 * @since 0.7.0
	 * @hidden
	 */
	private fun isDev(): Boolean {
		return BuildConfig.DEBUG
	}

	/**
	 * @method isSim
	 * @since 0.7.0
	 * @hidden
	 */
	private fun isSim(): Boolean {
		return Build.HARDWARE == "goldfish"
	}

	/**
	 * @method dispatchTouchEvent
	 * @since 0.7.0
	 * @hidden
	 */
	private fun dispatchTouchEvent(name: String, event: MotionEvent) {

		val application = this.application
		if (application == null) {
			return
		}

		val array = context.createEmptyArray()

		val identifier = event.getPointerId(event.actionIndex)

		val k = event.findPointerIndex(identifier)
		val x = event.getX(k)
		val y = event.getY(k)

		val touch = this.context.createEmptyObject()
		touch.property("identifier", identifier.toDouble())
		touch.property("x", Convert.toDp(x).toDouble())
		touch.property("y", Convert.toDp(y).toDouble())

		array.property(0, touch)

		application.holder.callMethod(name, arrayOf(array))
	}

	/**
	 * @method dispatchKeyboardEvent
	 * @since 0.7.0
	 * @hidden
	 */
	private fun dispatchKeyboardEvent(name: String, height: Int, delay: Long = 0) {

		val application = this.application
		if (application == null) {
			return
		}

		this.keyboardHandler.postDelayed({

			val args = arrayOf<JavaScriptValue?>(
				this.context.createNumber(Convert.toDp(height.toFloat())),
				this.context.createNumber(250.0),
				this.context.createString("cubic-bezier(0.25,0.1,0.25,1)")
			)

			application.holder.callMethod(name, args, null)

		}, delay)
	}
}

//--------------------------------------------------------------------------
// Extensions
//--------------------------------------------------------------------------

/**
 * Convenience property to retrieve the application from the context.
 * @property application
 * @since 0.1.0
 */
public val JavaScriptContext.application: ApplicationActivity
	get() = this.attribute(ApplicationActivity.kApplicationActivityKey) as ApplicationActivity