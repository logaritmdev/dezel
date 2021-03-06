package ca.logaritm.dezel.modules.application

import android.content.Intent
import android.net.Uri
import android.provider.Settings
import ca.logaritm.dezel.application.DezelApplicationActivity
import ca.logaritm.dezel.core.*
import ca.logaritm.dezel.extension.Delegates
import ca.logaritm.dezel.modules.view.Window
import ca.logaritm.dezel.view.graphic.Color

/**
 * @class Application
 * @since 0.1.0
 * @hidden
 */
open class Application(context: JavaScriptContext) : JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The application's root.
	 * @property window
	 * @since 0.1.0
	 */
	public lateinit var window: Window
		private set

	/**
	 * The application's status bar visibility.
	 * @property statusBarVisible
	 * @since 0.1.0
	 */
	open var statusBarVisible: Property by Delegates.OnSet(Property(true)) { value ->
		this.context.application.statusBarVisible = value.boolean
	}

	/**
	 * The application's status bar foreground color.
	 * @property statusBarForegroundColor
	 * @since 0.1.0
	 */
	open var statusBarForegroundColor: Property by Delegates.OnSet(Property("black")) { value ->
		this.context.application.statusBarForegroundColor = Color.parse(value.string)
	}

	/**
	 * The application's status bar background color.
	 * @property statusBarBackgroundColor
	 * @since 0.1.0
	 */
	open var statusBarBackgroundColor: Property by Delegates.OnSet(Property("transparent")) { value ->
		this.context.application.statusBarBackgroundColor = Color.parse(value.string)
	}

	/**
	 * The application's badge.
	 * @property badge
	 * @since 0.1.0
	 */
	open var badge: Property by Delegates.OnSet(Property(0.0)) {
		// TODO
		// https://github.com/leolin310148/ShortcutBadger
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Destroys the application.
	 * @method destroy
	 * @since 0.2.0
	 */
	open fun destroy() {
		this.holder.callMethod("nativeDestroy")
	}

	//--------------------------------------------------------------------------
	// JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_window
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_window(callback: JavaScriptGetterCallback) {
		callback.returns(this.window)
	}

	/**
	 * @method jsSet_window
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_window(callback: JavaScriptSetterCallback) {
		this.window = callback.value.cast(Window::class.java)!!
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_statusBarVisible
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_statusBarVisible(callback: JavaScriptGetterCallback) {
		callback.returns(this.statusBarVisible)
	}

	/**
	 * @method jsSet_statusBarVisible
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_statusBarVisible(callback: JavaScriptSetterCallback) {
		this.statusBarVisible = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_statusBarForegroundColor
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_statusBarForegroundColor(callback: JavaScriptGetterCallback) {
		callback.returns(this.statusBarForegroundColor)
	}

	/**
	 * @method jsSet_statusBarForegroundColor
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_statusBarForegroundColor(callback: JavaScriptSetterCallback) {
		this.statusBarForegroundColor = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_statusBarBackgroundColor
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_statusBarBackgroundColor(callback: JavaScriptGetterCallback) {
		callback.returns(this.statusBarBackgroundColor)
	}

	/**
	 * @method jsSet_statusBarBackgroundColor
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_statusBarBackgroundColor(callback: JavaScriptSetterCallback) {
		this.statusBarBackgroundColor = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_badge
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_badge(callback: JavaScriptGetterCallback) {
		callback.returns(this.badge)
	}

	/**
	 * @method jsSet_badge
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_badge(callback: JavaScriptSetterCallback) {
		this.badge = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_state
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_state(callback: JavaScriptGetterCallback) {
		when (this.context.application.state) {
			DezelApplicationActivity.State.FOREGROUND -> callback.returns("foreground")
			DezelApplicationActivity.State.BACKGROUND -> callback.returns("background")
		}
	}

	//--------------------------------------------------------------------------
	// JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_run
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_run(callback: JavaScriptFunctionCallback) {
		this.context.application.launch(this)
	}

	/**
	 * @method jsFunction_openURL
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_openURL(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			return
		}

		val url = callback.argument(0).string

		if (url.startsWith("http://") ||
			url.startsWith("https://")) {
			this.context.application.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
			return
		}

		if (url == "app:settings") {
			val intent = Intent()
			intent.action = Settings.ACTION_APPLICATION_DETAILS_SETTINGS
			intent.data = Uri.fromParts("package", this.context.application.packageName, null)
			this.context.application.startActivity(intent)
			return
		}

		if (url == "settings:location") {
			this.context.application.startActivity(Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS))
			return
		}

		if (url == "settings:bluetooth") {
			this.context.application.startActivity(Intent(Settings.ACTION_BLUETOOTH_SETTINGS))
			return
		}
	}
}