package ca.logaritm.dezel.modules.bluetooth

import android.Manifest
import android.bluetooth.BluetoothAdapter
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.support.v4.content.LocalBroadcastManager
import ca.logaritm.dezel.core.JavaScriptClass
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback

/**
 * @class BluetoothManager
 * @since 0.5.0
 * @hidden
 */
open class BluetoothManager(context: JavaScriptContext) : JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * Whether bluetooth services are enabled.
	 * @property enabled
	 * @since 0.5.0
	 * @hidden
	 */
	public var enabled: Boolean = false
		private set

	/**
	 * Whether bluetooth services were requested.
	 * @property requested
	 * @since 0.5.0
	 */
	public var requested: Boolean = false
		private set

	/**
	 * Whether bluetooth services were authorized.
	 * @property authorized
	 * @since 0.5.0
	 */
	public var authorized: Boolean = false
		private set

	/**
	 * @property adapter
	 * @since 0.5.0
	 * @hidden
	 */
	private var adapter: BluetoothAdapter? = BluetoothAdapter.getDefaultAdapter()

	/**
	 * @property bluetoothStatusChangedReceiver
	 * @since 0.5.0
	 * @hidden
	 */
	private val bluetoothStatusChangedReceiver = object: BroadcastReceiver() {
		override fun onReceive(context:Context?, intent:Intent?) {
			updateServiceStatus()
		}
	}

	/**
	 * @property applicationEnterForegroundReceiver
	 * @since 0.5.0
	 * @hidden
	 */
	private val applicationEnterForegroundReceiver: BroadcastReceiver = object : BroadcastReceiver() {
		override fun onReceive(context: Context, intent: Intent) {
			updateServiceStatus()
		}
	}

	/**
	 * @property applicationEnterBackgroundReceiver
	 * @since 0.5.0
	 * @hidden
	 */
	private val applicationEnterBackgroundReceiver: BroadcastReceiver = object : BroadcastReceiver() {
		override fun onReceive(context: Context, intent: Intent) {

		}
	}

	/**
	 * @property applicationPermissionChangedReceiver
	 * @since 0.5.0
	 * @hidden
	 */
	private val applicationPermissionChangedReceiver: BroadcastReceiver = object : BroadcastReceiver() {
		override fun onReceive(context: Context, intent: Intent) {
			val permission = intent.getStringExtra("permission")
			if (permission == Manifest.permission.BLUETOOTH ||
				permission == Manifest.permission.BLUETOOTH_ADMIN) {
				updateServiceStatus()
			}
		}
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.5.0
	 * @hidden
	 */
	init {
		this.context.application.registerReceiver(this.bluetoothStatusChangedReceiver, IntentFilter(BluetoothAdapter.ACTION_STATE_CHANGED))
		LocalBroadcastManager.getInstance(this.context.application).registerReceiver(this.applicationEnterBackgroundReceiver, IntentFilter("dezel.application.BACKGROUND"))
		LocalBroadcastManager.getInstance(this.context.application).registerReceiver(this.applicationEnterForegroundReceiver, IntentFilter("dezel.application.FOREGROUND"))
		LocalBroadcastManager.getInstance(this.context.application).registerReceiver(this.applicationPermissionChangedReceiver, IntentFilter("dezel.application.PERMISSION_CHANGED"))
	}

	/**
	 * @inherited
	 * @method dispose
	 * @since 0.6.0
	 */
	override fun dispose() {
		this.context.application.unregisterReceiver(this.bluetoothStatusChangedReceiver)
		LocalBroadcastManager.getInstance(this.context.application).unregisterReceiver(this.applicationEnterBackgroundReceiver)
		LocalBroadcastManager.getInstance(this.context.application).unregisterReceiver(this.applicationEnterForegroundReceiver)
		LocalBroadcastManager.getInstance(this.context.application).unregisterReceiver(this.applicationPermissionChangedReceiver)
		super.dispose()
	}

	/**
	 * Called when the status of the adapter service changes.
	 * @method updateServiceStatus
	 * @since 0.1.0
	 */
	open fun updateServiceStatus() {

		val adapter = this.adapter
		if (adapter == null) {
			return
		}

		val enabled = this.isServiceEnabled()

		if (this.enabled != enabled) {
			this.enabled = enabled

			this.property("enabled", enabled)

			if (enabled) {
				this.holder.callMethod("nativeEnable")
			} else  {
				this.holder.callMethod("nativeDisable")
			}
		}
	}

	//--------------------------------------------------------------------------
	// JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_init
	 * @since 0.5.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_init(callback: JavaScriptFunctionCallback) {
		
		this.enabled = this.isServiceEnabled()
		this.requested = this.isServiceRequested()
		this.authorized = this.isServiceAuthorized()

		this.property("enabled", this.enabled)
		this.property("requested", this.requested)
		this.property("authorized", this.authorized)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method isServiceEnabled
	 * @since 0.5.0
	 * @hidden
	 */
	private fun isServiceEnabled(): Boolean {

		val adapter = this.adapter
		if (adapter == null) {
			return false
		}

		return adapter.state == BluetoothAdapter.STATE_ON || adapter.state == BluetoothAdapter.STATE_TURNING_ON
	}

	/**
	 * @method isServiceRequested
	 * @since 0.5.0
	 * @hidden
	 */
	private fun isServiceRequested(): Boolean {
		return true // TODO
	}

	/**
	 * @method isServiceAuthorized
	 * @since 0.5.0
	 * @hidden
	 */
	private fun isServiceAuthorized(): Boolean {
		return true // TODO
	}
}

