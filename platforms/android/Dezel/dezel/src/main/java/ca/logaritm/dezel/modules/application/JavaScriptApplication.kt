package ca.logaritm.dezel.modules.application

import android.bluetooth.BluetoothAdapter
import android.content.Intent
import android.net.Uri
import android.provider.Settings
import ca.logaritm.dezel.application.ApplicationActivity
import ca.logaritm.dezel.application.activity
import ca.logaritm.dezel.core.*
import ca.logaritm.dezel.modules.view.JavaScriptWindow
import ca.logaritm.dezel.view.graphic.Color


/**
 * @class JavaScriptApplication
 * @super JavaScriptClass
 * @since 0.7.0
 */
open class JavaScriptApplication(context: JavaScriptContext) : JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property window
	 * @since 0.7.0
	 */
	public lateinit var window: JavaScriptWindow
		private set

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method destroy
	 * @since 0.7.0
	 */
	open fun destroy() {
		this.callMethod("nativeOnDestroy")
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method openApplicationSettings
	 * @since 0.7.0
	 * @hidden
	 */
	private fun openApplicationSettings() {
		this.context.activity.startActivity(Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, Uri.fromParts("package", this.context.activity.packageName, null)))
	}

	/**
	 * @method openLocationSettings
	 * @since 0.7.0
	 * @hidden
	 */
	private fun openLocationSettings() {
		this.context.activity.startActivity(Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS))
	}

	/**
	 * @method openBluetoothSettings
	 * @since 0.7.0
	 * @hidden
	 */
	private fun openBluetoothSettings() {

		val adapter = BluetoothAdapter.getDefaultAdapter()
		if (adapter == null) {
			this.openApplicationSettings()
			return
		}

		this.context.activity.startActivity(Intent(Settings.ACTION_BLUETOOTH_SETTINGS))
	}

	//--------------------------------------------------------------------------
	// JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @property statusBarVisible
	 * @since 0.7.0
	 */
	public val statusBarVisible by lazy {
		JavaScriptProperty(true) { value ->
			this.context.activity.statusBarVisible = value.boolean
		}
	}

	/**
	 * @property statusBarForegroundColor
	 * @since 0.7.0
	 */
	public val statusBarForegroundColor by lazy {
		JavaScriptProperty("black") { value ->
			this.context.activity.statusBarForegroundColor = Color.parse(value.string)
		}
	}

	/**
	 * @property statusBarBackgroundColor
	 * @since 0.7.0
	 */
	public val statusBarBackgroundColor by lazy {
		JavaScriptProperty("transparent") { value ->
			this.context.activity.statusBarBackgroundColor = Color.parse(value.string)
		}
	}

	/**
	 * @property badge
	 * @since 0.7.0
	 */
	public val badge by lazy {
		JavaScriptProperty(0.0)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_window
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_window(callback: JavaScriptGetterCallback) {
		callback.returns(this.window)
	}

	/**
	 * @method jsSet_window
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_window(callback: JavaScriptSetterCallback) {
		this.window = callback.value.cast(JavaScriptWindow::class.java)!!
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_statusBarVisible
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_statusBarVisible(callback: JavaScriptGetterCallback) {
		callback.returns(this.statusBarVisible)
	}

	/**
	 * @method jsSet_statusBarVisible
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_statusBarVisible(callback: JavaScriptSetterCallback) {
		this.statusBarVisible.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_statusBarForegroundColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_statusBarForegroundColor(callback: JavaScriptGetterCallback) {
		callback.returns(this.statusBarForegroundColor)
	}

	/**
	 * @method jsSet_statusBarForegroundColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_statusBarForegroundColor(callback: JavaScriptSetterCallback) {
		this.statusBarForegroundColor.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_statusBarBackgroundColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_statusBarBackgroundColor(callback: JavaScriptGetterCallback) {
		callback.returns(this.statusBarBackgroundColor)
	}

	/**
	 * @method jsSet_statusBarBackgroundColor
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_statusBarBackgroundColor(callback: JavaScriptSetterCallback) {
		this.statusBarBackgroundColor.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_badge
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_badge(callback: JavaScriptGetterCallback) {
		callback.returns(this.badge)
	}

	/**
	 * @method jsSet_badge
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_badge(callback: JavaScriptSetterCallback) {
		this.badge.reset(callback.value, this)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_state
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_state(callback: JavaScriptGetterCallback) {
		when (this.context.activity.state) {
			ApplicationActivity.State.FOREGROUND -> callback.returns("foreground")
			ApplicationActivity.State.BACKGROUND -> callback.returns("background")
		}
	}

	//--------------------------------------------------------------------------
	// JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_run
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_run(callback: JavaScriptFunctionCallback) {
		this.context.activity.launch(this)
	}

	/**
	 * @method jsFunction_openURL
	 * @since 0.7.0
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
			this.context.activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
			return
		}

		if (url.startsWith("tel:")) {
			this.context.activity.startActivity(Intent(Intent.ACTION_DIAL, Uri.parse(url)))
			return
		}

		if (url.startsWith("mailto:")) {
			this.context.activity.startActivity(Intent(Intent.ACTION_SENDTO, Uri.parse(url)))
			return
		}

		if (url == "settings:app") {
			this.openApplicationSettings()
			return
		}

		if (url == "settings:location") {
			this.openLocationSettings()
			return
		}

		if (url == "settings:bluetooth") {
			this.openBluetoothSettings()
			return
		}
	}
}