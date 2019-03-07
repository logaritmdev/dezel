package ca.logaritm.dezel.modules.location

import android.Manifest
import android.app.AlertDialog
import android.content.*
import android.content.pm.PackageManager
import android.os.Build
import android.provider.Settings
import android.support.v4.content.LocalBroadcastManager
import ca.logaritm.dezel.R
import ca.logaritm.dezel.core.JavaScriptClass
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback

/**
 * @class LocationManager
 * @since 0.1.0
 * @hidden
 */
open class LocationManager(context: JavaScriptContext) : JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * Whether location services are enabled.
	 * @property enabled
	 * @since 0.1.0
	 */
	public var enabled: Boolean = false
		private set

	/**
	 * Whether location services were requested.
	 * @property requested
	 * @since 0.1.0
	 */
	public var requested: Boolean = false
		private set

	/**
	 * Whether location services were authorized.
	 * @property authorized
	 * @since 0.1.0
	 */
	public var authorized: Boolean = false
		private set

	/**
	 * The location service's requested authorization.
	 * @property authorization
	 * @since 0.1.0
	 */
	public var authorization: String = "none"
		private set

	/**
	 * @property preferences
	 * @since 0.1.0
	 * @hidden
	 */
	private var preferences: SharedPreferences = this.context.application.getSharedPreferences("dezel.location", android.content.Context.MODE_PRIVATE)

	/**
	 * @property providerChangedReceiver
	 * @since 0.1.0
	 * @hidden
	 */
	private val providerChangedReceiver: BroadcastReceiver = object : BroadcastReceiver() {
		override fun onReceive(context: android.content.Context, intent: Intent) {
			if (intent.action == "android.location.PROVIDERS_CHANGED") {
				updateServiceStatus()
			}
		}
	}

	/**
	 * @property applicationEnterForegroundReceiver
	 * @since 0.1.0
	 * @hidden
	 */
	private val applicationEnterForegroundReceiver: BroadcastReceiver = object : BroadcastReceiver() {
		override fun onReceive(context: Context, intent: Intent) {
			updateServiceStatus()
		}
	}

	/**
	 * @property applicationEnterBackgroundReceiver
	 * @since 0.1.0
	 * @hidden
	 */
	private val applicationEnterBackgroundReceiver: BroadcastReceiver = object : BroadcastReceiver() {
		override fun onReceive(context: Context, intent: Intent) {

		}
	}

	/**
	 * @property applicationPermissionChangedReceiver
	 * @since 0.1.0
	 * @hidden
	 */
	private val applicationPermissionChangedReceiver: BroadcastReceiver = object : BroadcastReceiver() {
		override fun onReceive(context: Context, intent: Intent) {
			val permission = intent.getStringExtra("permission")
			if (permission == Manifest.permission.ACCESS_COARSE_LOCATION ||
				permission == Manifest.permission.ACCESS_FINE_LOCATION) {
				updateServiceStatus()
			}
		}
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	init {
		this.context.application.registerReceiver(this.providerChangedReceiver, IntentFilter("android.location.PROVIDERS_CHANGED"))
		LocalBroadcastManager.getInstance(this.context.application).registerReceiver(this.applicationEnterBackgroundReceiver, IntentFilter("dezel.application.BACKGROUND"))
		LocalBroadcastManager.getInstance(this.context.application).registerReceiver(this.applicationEnterForegroundReceiver, IntentFilter("dezel.application.FOREGROUND"))
		LocalBroadcastManager.getInstance(this.context.application).registerReceiver(this.applicationPermissionChangedReceiver, IntentFilter("dezel.application.PERMISSION_CHANGED"))
	}

	/**
	 * @destructor
	 * @since 0.1.0
	 * @hidden
	 */
	@Throws(Throwable::class)
	protected fun finalize() {
		LocalBroadcastManager.getInstance(this.context.application).unregisterReceiver(this.applicationEnterBackgroundReceiver)
		LocalBroadcastManager.getInstance(this.context.application).unregisterReceiver(this.applicationEnterForegroundReceiver)
		LocalBroadcastManager.getInstance(this.context.application).unregisterReceiver(this.applicationPermissionChangedReceiver)
	}

	/**
	 * Called when the status of the location service changes.
	 * @method updateServiceStatus
	 * @since 0.1.0
	 */
	open fun updateServiceStatus() {

		val enabled = this.isServiceEnabled()

		if (this.enabled != enabled) {
			this.enabled = enabled

			this.property("enabled", enabled)

			if (enabled) {
				this.holder.callMethod("nativeEnable")
			} else {
				this.holder.callMethod("nativeDisable")
			}
		}

		if (this.isServiceRequested() == false) {
			return
		}

		val authorized = this.isServiceAuthorized()

		if (this.requested == false || this.authorized != authorized) {

			this.requested = true
			this.authorized = authorized

			this.property("requested", this.requested)
			this.property("authorized", this.authorized)

			if (authorized) {
				this.holder.callMethod("nativeAuthorize")
			} else {
				this.holder.callMethod("nativeUnauthorize")
			}
		}
	}

	//--------------------------------------------------------------------------
	// JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_init
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_init(callback: JavaScriptFunctionCallback) {

		val count = callback.arguments
		if (count < 1) {
			return
		}

		when (callback.argument(0).string) {
			"coarse" ->	this.authorization = Manifest.permission.ACCESS_COARSE_LOCATION
			"fine"   ->	this.authorization = Manifest.permission.ACCESS_FINE_LOCATION
			else     ->	this.authorization = Manifest.permission.ACCESS_FINE_LOCATION
		}

		this.enabled = this.isServiceEnabled()
		this.requested = this.isServiceRequested()
		this.authorized = this.isServiceAuthorized()

		this.property("enabled", this.enabled)
		this.property("requested", this.requested)
		this.property("authorized", this.authorized)

		this.updateServiceStatus()
	}

	/**
	 * @method jsFunction_requestAuthorization
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_requestAuthorization(callback: JavaScriptFunctionCallback) {

		if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
			return
		}

		if (this.isServiceRequested()) {
			return
		}

		val editor = this.preferences.edit()
		if (editor != null) {
			editor.putBoolean("requested", true)
			editor.apply()
		}

		val request = {
			when (this.authorization) {
				Manifest.permission.ACCESS_COARSE_LOCATION -> this.context.application.requestPermissions(arrayOf(this.authorization), 0)
				Manifest.permission.ACCESS_FINE_LOCATION   -> this.context.application.requestPermissions(arrayOf(this.authorization), 0)
			}
		}

		AlertDialog.Builder(this.context.application)
			.setTitle(this.getAlertTitle())
			.setMessage(this.getAlertMessage())
			.setPositiveButton("OK", { _, _ -> request() })
			.create()
			.show()
	}

	//--------------------------------------------------------------------------
	// Privat API
	//--------------------------------------------------------------------------

	/**
	 * @method isServiceEnabled
	 * @since 0.1.0
	 * @hidden
	 */
	private fun isServiceEnabled(): Boolean {
		return Settings.Secure.getInt(this.context.application.contentResolver, Settings.Secure.LOCATION_MODE) != Settings.Secure.LOCATION_MODE_OFF
	}

	/**
	 * @method isServiceRequested
	 * @since 0.1.0
	 * @hidden
	 */
	private fun isServiceRequested(): Boolean {
		return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) this.preferences.getBoolean("requested", false) else true
	}

	/**
	 * @method isServiceAuthorized
	 * @since 0.1.0
	 * @hidden
	 */
	private fun isServiceAuthorized(): Boolean {
		return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) this.context.application.checkSelfPermission(this.authorization) == PackageManager.PERMISSION_GRANTED else true
	}

	/**
	 * @method getAlertTitle
	 * @since 0.1.0
	 * @hidden
	 */
	private fun getAlertTitle(): String {

		try {

			return this.context.application.getString(
				this.context.application.resources.getIdentifier("dezel_location_usage_title", "string", this.context.application.packageName)
			)

		} catch (e: Exception) {

		}

		return this.context.application.getString(R.string.app_name)
	}

	/**
	 * @method getAlertMessage
	 * @since 0.1.0
	 * @hidden
	 */
	private fun getAlertMessage(): String {

		try {

			return this.context.application.getString(
				this.context.application.resources.getIdentifier("dezel_location_usage_description", "string", this.context.application.packageName)
			)

		} catch (e: Exception) {

		}

		return "This application requires location services"
	}
}