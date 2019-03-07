package ca.logaritm.dezel.modules.notification

import android.app.Notification
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.graphics.BitmapFactory
import android.media.RingtoneManager
import android.support.v4.app.NotificationManagerCompat
import android.support.v4.content.LocalBroadcastManager
import ca.logaritm.dezel.core.JavaScriptClass
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback

/**
 * @class NotificationManager
 * @since 0.1.0
 * @hidden
 */
open class NotificationManager(context: JavaScriptContext) : JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * Whether the notification service authorization has been determined.
	 * @property requested
	 * @since 0.1.0
	 */
	public var requested: Boolean = true
		private set

	/**
	 * Whether the notification service has been authorized.
	 * @property authorized
	 * @since 0.1.0
	 */
	public var authorized: Boolean = true
		private set

	/**
	 * @property notificationManager
	 * @since 0.1.0
	 * @hidden
	 */
	private val notificationManager: NotificationManager
		get() = this.context.application.getSystemService(Service.NOTIFICATION_SERVICE) as NotificationManager

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

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	init {
		LocalBroadcastManager.getInstance(this.context.application).registerReceiver(this.applicationEnterBackgroundReceiver, IntentFilter("dezel.application.BACKGROUND"))
		LocalBroadcastManager.getInstance(this.context.application).registerReceiver(this.applicationEnterForegroundReceiver, IntentFilter("dezel.application.FOREGROUND"))
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

		this.requested = this.isServiceRequested()
		this.authorized = this.isServiceAuthorized()

		this.property("requested", this.requested)
		this.property("authorized", this.authorized)
	}

	/**
	 * @method jsFunction_requestAuthorization
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_requestAuthorization(callback: JavaScriptFunctionCallback) {
		// nothing to do
	}

	/**
	 * @method jsFunction_notify
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_notify(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 3) {
			return
		}

		val application = this.context.application

		val id = callback.argument(0).number

		val ringtone = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)

		val builder = Notification.Builder(application)
		builder.setContentTitle(callback.argument(1).string)
		builder.setContentText(callback.argument(2).string)
		builder.setSound(ringtone)
		builder.setPriority(Notification.PRIORITY_HIGH)
		builder.setVisibility(Notification.VISIBILITY_PUBLIC)

		val largeIcon = application.resources.getIdentifier("notification_large_icon", "drawable", application.packageName)
		var smallIcon = application.resources.getIdentifier("notification_small_icon", "drawable", application.packageName)

		if (smallIcon == 0) {
			smallIcon = application.applicationInfo.icon
		}

		if (largeIcon > 0) builder.setLargeIcon(BitmapFactory.decodeResource(application.resources, largeIcon))
		if (smallIcon > 0) builder.setSmallIcon(smallIcon)

		builder.setContentIntent(
			PendingIntent.getActivity(
				application.applicationContext, 0, Intent(
					application.applicationContext,
					application.javaClass
				), 0
			)
		)

		this.notificationManager.notify(id.toInt(), builder.build())

		val data = this.context.createEmptyObject()
		data.property("title", callback.argument(1))
		data.property("message", callback.argument(2))

		this.holder.callMethod("nativeNotification", arrayOf(data), null)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method isServiceRequested
	 * @since 0.1.0
	 * @hidden
	 */
	private fun isServiceRequested(): Boolean {
		return true
	}

	/**
	 * @method isServiceAuthorized
	 * @since 0.1.0
	 * @hidden
	 */
	private fun isServiceAuthorized(): Boolean {
		return NotificationManagerCompat.from(this.context.application).areNotificationsEnabled()
	}

	/**
	 * @method updateServiceStatus
	 * @since 0.1.0
	 * @hidden
	 */
	private fun updateServiceStatus() {

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
}