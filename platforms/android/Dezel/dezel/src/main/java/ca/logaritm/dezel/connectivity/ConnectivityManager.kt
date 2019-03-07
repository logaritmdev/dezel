package ca.logaritm.dezel.connectivity

import android.content.BroadcastReceiver
import android.content.Intent
import android.content.IntentFilter
import android.net.ConnectivityManager
import ca.logaritm.dezel.core.JavaScriptClass
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback
import ca.logaritm.dezel.core.JavaScriptGetterCallback

/**
 * @class ConnectivityManager
 * @since 0.1.0
 * @hidden
 */
open class ConnectivityManager(context: JavaScriptContext) : JavaScriptClass(context) {

	/**
	 * @enum ConnectivityStatus
	 * @since 0.1.0
	 * @hidden
	 */
	public enum class ConnectivityStatus {
		NONE,
		WIFI,
		WWAN;
	}

	/**
	 * @property connectivityManager
	 * @since 0.1.0
	 * @hidden
	 */
	private val connectivityManager: ConnectivityManager
		get() = context.application.getSystemService(android.content.Context.CONNECTIVITY_SERVICE) as ConnectivityManager

	/**
	 * @property connectivityReceiver
	 * @since 0.1.0
	 * @hidden
	 */
	private val connectivityReceiver: BroadcastReceiver = object : BroadcastReceiver() {
		override fun onReceive(context: android.content.Context?, intent: Intent?) {
			check()
		}
	}

	/**
	 * @property status
	 * @since 0.1.0
	 * @hidden
	 */
	private var status: ConnectivityStatus = ConnectivityStatus.NONE

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	init {

	}

	/**
	 * @method start
	 * @since 0.1.0
	 * @hidden
	 */
	private fun start() {
		this.context.application.registerReceiver(this.connectivityReceiver, IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION))
	}

	/**
	 * @method stop
	 * @since 0.1.0
	 * @hidden
	 */
	private fun stop() {
		this.context.application.unregisterReceiver(this.connectivityReceiver)
	}

	/**
	 * @method check
	 * @since 0.1.0
	 * @hidden
	 */
	private fun check() {

		try {

			val wifi = this.connectivityManager.getNetworkInfo(ConnectivityManager.TYPE_WIFI)
			val wwan = this.connectivityManager.getNetworkInfo(ConnectivityManager.TYPE_MOBILE)

			if (wifi.isConnected == false &&
				wwan.isConnected == false) {
				this.update(ConnectivityStatus.NONE)
				return
			}

			if (wifi.isConnected) {
				this.update(ConnectivityStatus.WIFI)
				return
			}

			if (wwan.isConnected) {
				this.update(ConnectivityStatus.WWAN)
				return
			}

		} catch (e: Exception) {
			this.update(ConnectivityStatus.WWAN)
		}
	}

	/**
	 * @method update
	 * @since 0.1.0
	 * @hidden
	 */
	private fun update(status: ConnectivityStatus) {

		if (this.status == status) {
			return
		}

		this.status = status

		val value: String

		when (this.status) {
			ConnectivityStatus.NONE -> value = "none"
			ConnectivityStatus.WIFI -> value = "wifi"
			ConnectivityStatus.WWAN -> value = "wwan"
		}

		this.holder.callMethod("nativeStatusChange", arrayOf(this.context.createString(value)), null)
	}

	//--------------------------------------------------------------------------
	// JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_status
	 * @since 0.1.0
	 * @hidden
	 */
	open fun jsGet_status(callback: JavaScriptGetterCallback) {

		val value: String

		when (this.status) {
			ConnectivityStatus.NONE -> value = "none"
			ConnectivityStatus.WIFI -> value = "wifi"
			ConnectivityStatus.WWAN -> value = "wwan"
		}

		callback.returns(value)
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
		this.start()
		this.check()
	}
}