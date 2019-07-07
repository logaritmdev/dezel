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
import ca.logaritm.dezel.modules.device.DeviceModule
import ca.logaritm.dezel.modules.dezel.Dezel
import ca.logaritm.dezel.modules.dialog.DialogModule
import ca.logaritm.dezel.modules.form.FormModule
import ca.logaritm.dezel.modules.graphic.GraphicModule
import ca.logaritm.dezel.modules.graphic.ImageLoader
import ca.logaritm.dezel.modules.locale.LocaleModule
import ca.logaritm.dezel.modules.platform.PlatformModule
import ca.logaritm.dezel.modules.view.ViewModule
import ca.logaritm.dezel.modules.web.WebModule
import ca.logaritm.dezel.networking.RemoteFileLoader
import ca.logaritm.dezel.style.Styler
import ca.logaritm.dezel.view.UpdateDisplayManager
import ca.logaritm.dezel.view.graphic.Convert
import java.io.IOException


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
		 * Returns the application activity of the specified context.
		 * @method from
		 * @since 0.7.0
		 */
		public fun from(context: JavaScriptContext): ApplicationActivity {
			return context.attribute("dezel.application.ApplicationActivity") as ApplicationActivity
		}
	}

	//--------------------------------------------------------------------------
	// Properties
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
	 * The application's state.
	 * @property state
	 * @since 0.7.0
	 */
	public var state: State = State.FOREGROUND
		private set

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
	 * The application's JavaScript application object.
	 * @property application
	 * @since 0.7.0
	 */
	public var application: Application? = null
		private set

	/**
	 * The application's styles.
	 * @property styles
	 * @since 0.7.0
	 */
	public var styles: MutableList<String> = mutableListOf()
		private set

	/**
	 * The application's scripts.
	 * @property scripts
	 * @since 0.7.0
	 */
	public var scripts: MutableList<String> = mutableListOf()
		private set

	/**
	 * The application's modules.
	 * @property modules
	 * @since 0.7.0
	 */
	public var modules: MutableMap<String, Class<*>> = mutableMapOf()
		private set

	/**
	 * The application's classes.
	 * @property classes
	 * @since 0.7.0
	 */
	public var classes: MutableMap<String, Class<*>> = mutableMapOf()
		private set

	/**
	 * The application's styles manager.
	 * @property styler
	 * @since 0.7.0
	 */
	public lateinit var styler: Styler
		private set

	/**
	 * The application's layout manager.
	 * @property layout
	 * @since 0.7.0
	 */
	public lateinit var layout: Layout
		private set

	/**
	 * The application's update display manager.
	 * @property updateDisplayManager
	 * @since 0.7.0
	 */
	public lateinit var updateDisplayManager: UpdateDisplayManager
		private set

	/**
	 * @property statusBar
	 * @since 0.7.0
	 * @hidden
	 */
	private lateinit var statusBar: View

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onCreate
	 * @since 0.7.0
	 */
	override fun onCreate(savedInstanceState: Bundle?) {

		super.onCreate(savedInstanceState)

		this.updateDisplayManager = UpdateDisplayManager()

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

		Convert.density = this.resources.displayMetrics.density

		this.view = RelativeLayout(this)
		this.view.isFocusable = true
		this.view.isFocusableInTouchMode = true
		this.view.setBackgroundColor(Color.BLACK)

		this.setContentView(this.view)

		this.statusBar = View(this)
		this.statusBar.layoutParams = RelativeLayout.LayoutParams(
			this.getStatusBarWidth(),
			this.getStatusBarHeight()
		)

		this.view.addView(this.statusBar)

		this.keyboardObserver = KeyboardObserver(this, this.view)

		this.context.global.property("_DEV_", this.isDev())
		this.context.global.property("_SIM_", this.isSim())
		this.context.attribute("dezel.application.ApplicationActivity", this)

		this.context.handleError { error ->

			var file = "<no file>"
			var line = "<no line>"
			var stack = ""

			if (error.isObject) {
				file = error.property("sourceURL").string
				line = error.property("line").string
				stack = error.property("stack").string
			}

			val message = "${error.string} \n File: $file \n Line: $line \n Stack Trace: \n $stack"

			Log.e("DEZEL", message)

			val crash = this.onApplicationTriggerError(error)
			if (crash) {
				throw JavaScriptException(message)
			}
		}

		val viewport = this.viewport

		this.styler = Styler()
		this.layout = Layout()
		this.layout.scale = Convert.density
		this.layout.viewportWidth = viewport.width
		this.layout.viewportHeight = viewport.height

		this.context.global.defineProperty("dezel", this.context.createObject(Dezel::class.java), null, null, false, true, false)

		this.registerModule("dezel.ApplicationModule", ApplicationModule::class.java)
		this.registerModule("dezel.DeviceModule", DeviceModule::class.java)
		this.registerModule("dezel.DialogModule", DialogModule::class.java)
		this.registerModule("dezel.FormModule", FormModule::class.java)
		this.registerModule("dezel.GraphicModule", GraphicModule::class.java)
		this.registerModule("dezel.LocaleModule", LocaleModule::class.java)
		this.registerModule("dezel.PlatformModule", PlatformModule::class.java)
		this.registerModule("dezel.ViewModule", ViewModule::class.java)
		this.registerModule("dezel.WebModule", WebModule::class.java)

		this.onBeforeApplicationLoad()

		this.loadClasses()
		this.loadModules()

		this.context.initialize()

		this.loadStyles()
		this.loadScripts()
	}

	/**
	 * @inherited
	 * @method onPause
	 * @since 0.7.0
	 */
	override fun onPause() {

		super.onPause()

		LocalBroadcastManager.getInstance(this).sendBroadcastSync(Intent("dezel.application.BACKGROUND"))

		this.keyboardObserver.listener = null

		if (this.state == State.FOREGROUND) {
			this.state = State.BACKGROUND
			this.application?.holder?.callMethod("nativeEnterBackground")
		}
	}

	/**
	 * @inherited
	 * @method onResume
	 * @since 0.7.0
	 */
	override fun onResume() {

		super.onResume()

		LocalBroadcastManager.getInstance(this).sendBroadcastSync(Intent("dezel.application.FOREGROUND"))

		this.keyboardObserver.listener = this

		if (this.state == State.BACKGROUND) {
			this.state = State.FOREGROUND
			this.application?.holder?.callMethod("nativeEnterForeground")
		}
	}

	/**
	 * @inherited
	 * @method onDestroy
	 * @since 0.7.0
	 */
	override fun onDestroy() {
		this.state = State.BACKGROUND
		this.keyboardObserver.close()
		super.onDestroy()
	}

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
					this.application?.holder?.callMethod("nativeHandleLink", arrayOf(this.context.createString(uri.toString())))
				}
			}

			Intent.ACTION_SEND -> {
				val uri = intent.getParcelableExtra<Parcelable>(Intent.EXTRA_STREAM)
				if (uri is Uri) {
					this.application?.holder?.callMethod("nativeHandleResource", arrayOf(this.context.createString(uri.toString())))
				}
			}

			else -> {
				// Nothing
			}
		}
	}

	/**
	 * Launches the specified application.
	 * @method launch
	 * @since 0.7.0
	 */
	open fun launch(application: Application) {

		this.styler.root = application.window.stylerNode
		this.layout.root = application.window.layoutNode

		val viewport = this.viewport
		application.window.width = Property(viewport.width.toDouble(), PropertyUnit.PX)
		application.window.height = Property(viewport.height.toDouble(), PropertyUnit.PX)

		this.application = application

		this.view.addView(application.window.wrapper)

		this.statusBar.bringToFront()

		this.onApplicationLoad()
	}

	/**
	 * Reloads the current application.
	 * @method reload
	 * @since 0.7.0
	 */
	public fun reload() {

		this.onApplicationUnload()

		this.application?.destroy()
		this.application?.window?.remove()
		this.application = null

		this.updateDisplayManager.reset()

		LocalBroadcastManager.getInstance(this).sendBroadcastSync(Intent("dezel.application.RELOAD"))

		val viewport = this.viewport

		this.styler = Styler()
		this.layout = Layout()
		this.layout.scale = Convert.density
		this.layout.viewportWidth = viewport.width
		this.layout.viewportHeight = viewport.height

		this.loadStyles()
		this.loadScripts()
	}

	/**
	 * Registers a stylerNode file.
	 * @method registerStyle
	 * @since 0.7.0
	 */
	open fun registerStyle(style: String) {
		this.styles.add(style)
	}

	/**
	 * Registers a script file.
	 * @method registerScript
	 * @since 0.7.0
	 */
	open fun registerScript(script: String) {
		this.scripts.add(script)
	}

	/**
	 * Registers a module.
	 * @method registerModule
	 * @since 0.7.0
	 */
	open fun registerModule(uid: String, module: Class<*>) {
		this.modules[uid] = module
	}

	/**
	 * Registers a class.
	 * @method registerClass
	 * @since 0.7.0
	 */
	open fun registerClass(uid: String, klass: Class<*>) {
		this.classes[uid] = klass
	}

	/**
	 * @method loadClasses
	 * @since 0.7.0
	 * @hidden
	 */
	private fun loadClasses() {
		this.classes.forEach {
			this.context.registerClass(it.key, it.value)
		}
	}

	/**
	 * @method loadModules
	 * @since 0.7.0
	 * @hidden
	 */
	private fun loadModules() {
		this.modules.forEach {
			this.context.registerModule(it.key, it.value)
		}
	}

	/**
	 * @method loadStyles
	 * @since 0.7.0
	 * @hidden
	 */
	private fun loadStyles() {

		this.styler.setVariable("safe-area-top-inset", "${this.getSafeAreaTopInset()}px")
		this.styler.setVariable("safe-area-bottom-inset", "${this.getSafeAreaBottomInset()}px")

		for (src in this.styles) {

			try {

				if (src.startsWith("http://") ||
					src.startsWith("https://")) {
					this.styler.load(RemoteFileLoader().execute(src).get(), src)
					continue
				}

				this.styler.load(this.assets.open(src).reader().use { it.readText() }, src)

			} catch (e: IOException) {
				throw Exception("Cannot load registered sheet at $src, the path is invalid.")
			}
		}
	}

	/**
	 * @method loadScripts
	 * @since 0.7.0
	 * @hidden
	 */
	private fun loadScripts() {

		for (src in this.scripts) {

			try {

				if (src.startsWith("http://") ||
					src.startsWith("https://")) {
					this.context.evaluate(RemoteFileLoader().execute(src).get(), src)
					continue
				}

				this.context.evaluate(this.assets.open(src).reader().use { it.readText() }, src)

			} catch (e: IOException) {
				throw Exception("Cannot load registered script $src, the path is invalid.")
			}
		}
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

	//--------------------------------------------------------------------------
	// Status Bar
	//--------------------------------------------------------------------------

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
	// Application Lifecycle
	//--------------------------------------------------------------------------

	/**
	 * Called when the application is about to be loaded.
	 * @method onBeforeApplicationLoad
	 * @since 0.7.0
	 */
	open fun onBeforeApplicationLoad() {

	}

	/**
	 * Called when the application has been loaded.
	 * @method onApplicationLoad
	 * @since 0.7.0
	 */
	open fun onApplicationLoad() {
		this.application?.holder?.callMethod("nativeLoad")
	}

	/**
	 * Called when the application has been unloaded.
	 * @method onApplicationUnload
	 * @since 0.7.0
	 */
	open fun onApplicationUnload() {
		this.application?.holder?.callMethod("nativeUnload")
	}

	/**
	 * Called when an error is triggered from the JavaScript context.
	 * @method onApplicationTriggerError
	 * @since 0.7.0
	 */
	open fun onApplicationTriggerError(error: JavaScriptValue): Boolean {
		return true
	}

	//--------------------------------------------------------------------------
	// Application Keyboard Management
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
	 * @method callKeyboardEventMethod
	 * @since 0.7.0
	 * @hidden
	 */
	private fun callKeyboardEventMethod(name: String, height: Int, delay: Long = 0) {

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
				this.callKeyboardEventMethod("nativeBeforeKeyboardShow", height)
				this.callKeyboardEventMethod("nativeKeyboardShow", height, 250)
			}

			if (this.keyboardDismissing) {
				this.keyboardDismissing = false
				this.callKeyboardEventMethod("nativeBeforeKeyboardHide", this.keyboardHeight)
				this.callKeyboardEventMethod("nativeKeyboardHide", this.keyboardHeight, 250)
			}

		} else {

			if (height == 0 && this.keyboardHeight > 0) {
				this.callKeyboardEventMethod("nativeBeforeKeyboardHide", this.keyboardHeight)
				this.callKeyboardEventMethod("nativeKeyboardHide", this.keyboardHeight, 250)
			}

		}

		if (this.keyboardHeight != height) {
			this.callKeyboardEventMethod("nativeBeforeKeyboardResize", this.keyboardHeight)
			this.callKeyboardEventMethod("nativeKeyboardResize", this.keyboardHeight, 250)
		}

		this.keyboardHeight = height
	}

	//--------------------------------------------------------------------------
	// Application Permissions
	//--------------------------------------------------------------------------

	/**
	 * Process the request permission result.
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
	// Application Touch Management
	//--------------------------------------------------------------------------

	/**
	 * Dispatches a native touch event to the JavaScript application.
	 * @method dispatchTouchEvent
	 * @since 0.7.0
	 */
	override fun dispatchTouchEvent(e: MotionEvent) : Boolean {

		val dispatch = super.dispatchTouchEvent(e)

		// TODO
		// Filter touches to make sure they are within this window

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
		this.application?.holder?.callMethod("dispatchTouchCancel", arrayOf(this.toTouchArray(e)), null)
	}

	/**
	 * Dispatches a touchstart event to the JavaScript application.
	 * @method dispatchTouchStart
	 * @since 0.7.0
	 */
	open fun dispatchTouchStart(e: MotionEvent) {
		this.application?.holder?.callMethod("dispatchTouchStart", arrayOf(this.toTouchArray(e)), null)
	}

	/**
	 * Dispatches a touchmove event to the JavaScript application.
	 * @method dispatchTouchMove
	 * @since 0.7.0
	 */
	open fun dispatchTouchMove(e: MotionEvent) {
		this.application?.holder?.callMethod("dispatchTouchMove", arrayOf(this.toTouchArray(e)), null)
	}

	/**
	 * Dispatches a touchend event to the JavaScript application.
	 * @method dispatchTouchEnd
	 * @since 0.7.0
	 */
	open fun dispatchTouchEnd(e: MotionEvent) {
		this.application?.holder?.callMethod("dispatchTouchEnd", arrayOf(this.toTouchArray(e)), null)
	}

	/**
	 * @method toTouchArray
	 * @since 0.7.0
	 * @hidden
	 */
	private fun toTouchArray(e: MotionEvent) : JavaScriptValue {

		val array = context.createEmptyArray()

		val identifier = e.getPointerId(e.actionIndex)

		val k = e.findPointerIndex(identifier)
		val x = e.getX(k)
		val y = e.getY(k)

		val touch = this.context.createEmptyObject()
		touch.property("identifier", identifier.toDouble())
		touch.property("x", Convert.toDp(x).toDouble())
		touch.property("y", Convert.toDp(y).toDouble())

		array.property(0, touch)

		return array
	}

	//--------------------------------------------------------------------------
	// Back Button
	//--------------------------------------------------------------------------

	/**
	 * Dispatches the back pressed event to the application.
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
		application.holder.callMethod("nativeBack", null, handled)
		if (handled.boolean == true) {
			return
		}

		super.onBackPressed()
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
}