package ca.logaritm.dezel.modules.notification

import android.app.Notification
import android.app.NotificationChannel
import android.app.PendingIntent
import android.app.Service
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.graphics.BitmapFactory
import android.media.RingtoneManager
import android.os.Build
import android.support.v4.app.NotificationManagerCompat
import android.support.v4.content.LocalBroadcastManager
import ca.logaritm.dezel.core.JavaScriptClass
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback
import ca.logaritm.dezel.extension.applicationName
import ca.logaritm.dezel.extension.setMessage
import ca.logaritm.dezel.extension.setTitle
import ca.logaritm.dezel.modules.notification.fcm.NotificationMessagingToken
import android.app.NotificationManager as AndroidNotificationManager

/**
 * @class NotificationManager
 * @since 0.1.0
 * @hidden
 */
open class NotificationManager(context: JavaScriptContext) : JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	companion object {

		/**
		 * Whether or not remote notifications are enabled
		 * @property enableRemoteNotifications
		 * @since 0.6.0
		 */
		public var enableRemoteNotifications: Boolean = false

	}

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
	private val notificationManager: AndroidNotificationManager
		get() = this.context.application.getSystemService(Service.NOTIFICATION_SERVICE) as AndroidNotificationManager

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
	 * @property messagingServiceTokenReceiver
	 * @since 0.6.0
	 * @hidden
	 */
	private val messagingServiceTokenReceiver: BroadcastReceiver = object: BroadcastReceiver() {
		override fun onReceive(ctx: Context, intent: Intent) {
			updateRemoteNotificationsToken(intent.getStringExtra("token"))
		}
	}

	/**
	 * @property messagingServiceMessageReceiver
	 * @since 0.6.0
	 * @hidden
	 */
	private val messagingServiceMessageReceiver: BroadcastReceiver = object: BroadcastReceiver() {
		override fun onReceive(ctx: Context, intent: Intent) {
			val notification = NotificationData()
			notification.title = intent.getStringExtra("title")
			notification.message = intent.getStringExtra("message")
			notify(notification)
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
		LocalBroadcastManager.getInstance(this.context.application).registerReceiver(this.messagingServiceMessageReceiver, IntentFilter("dezel.notification.messaging.MESSAGE"))
		LocalBroadcastManager.getInstance(this.context.application).registerReceiver(this.messagingServiceTokenReceiver, IntentFilter("dezel.notification.messaging.TOKEN"))
	}

	/**
	 * @inherited
	 * @method dispose
	 * @since 0.6.0
	 */
	override fun dispose() {
		LocalBroadcastManager.getInstance(this.context.application).unregisterReceiver(this.applicationEnterBackgroundReceiver)
		LocalBroadcastManager.getInstance(this.context.application).unregisterReceiver(this.applicationEnterForegroundReceiver)
		LocalBroadcastManager.getInstance(this.context.application).unregisterReceiver(this.messagingServiceMessageReceiver)
		LocalBroadcastManager.getInstance(this.context.application).unregisterReceiver(this.messagingServiceTokenReceiver)
		super.dispose()
	}

	/**
	 * @method notify
	 * @since 0.6.0
	 * @hidden
	 */
	public fun notify(notification: NotificationData)  {

		val sound = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)

		val builder: Notification.Builder

		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {

			builder = Notification.Builder(this.context.application, "application_fcm_channel")
			builder.setTitle(notification.title)
			builder.setMessage(notification.message)
			builder.setVisibility(Notification.VISIBILITY_PUBLIC)

			val channel = NotificationChannel(
				"application_fcm_channel",
				this.context.application.applicationName,
				AndroidNotificationManager.IMPORTANCE_HIGH
			)

			channel.setSound(sound, null)
			channel.enableLights(true)
			channel.enableVibration(true)
			channel.lockscreenVisibility = Notification.VISIBILITY_PUBLIC

			this.notificationManager.createNotificationChannel(channel)

		} else {

			builder = Notification.Builder(this.context.application)
			builder.setTitle(notification.title)
			builder.setMessage(notification.message)
			builder.setVisibility(Notification.VISIBILITY_PUBLIC)
			builder.setPriority(Notification.PRIORITY_MAX)
			builder.setSound(sound)

		}

		val largeIcon = this.context.application.resources.getIdentifier("notification_large_icon", "drawable", this.context.application.packageName)
		var smallIcon = this.context.application.resources.getIdentifier("notification_small_icon", "drawable", this.context.application.packageName)

		if (smallIcon == 0) {
			smallIcon = this.context.application.applicationInfo.icon
		}

		if (largeIcon > 0) builder.setLargeIcon(BitmapFactory.decodeResource(this.context.application.resources, largeIcon))
		if (smallIcon > 0) builder.setSmallIcon(smallIcon)

		builder.setContentIntent(
			PendingIntent.getActivity(
				this.context.application.applicationContext, 0, Intent(
				this.context.application.applicationContext,
				this.context.application.javaClass
			), 0)
		)

		if (notification.id == "") {
			notification.id = "0"
		}

		this.notificationManager.notify(notification.id.toInt(), builder.build())

		val data = this.context.createEmptyObject()
		data.property("id", notification.id)
		data.property("title", notification.title)
		data.property("message", notification.message)
		this.holder.callMethod("nativeNotification", arrayOf(data), null)
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
		this.requestRemoteNotificationsToken()
	}

	/**
	 * @method jsFunction_notify
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_notify(callback: JavaScriptFunctionCallback) {
		val notification = NotificationData()
		notification.id = callback.argument(0).string
		notification.title = callback.argument(1).string
		notification.message = callback.argument(2).string
		this.notify(notification)
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

	/**
	 * @method requestRemoteNotificationsToken
	 * @since 0.6.0
	 * @hidden
	 */
	private fun requestRemoteNotificationsToken() {
		if (NotificationManager.enableRemoteNotifications) {
			NotificationMessagingToken.getToken { token ->
				this.updateRemoteNotificationsToken(token)
			}
		}
	}

	/**
	 * @method updateRemoteNotificationsToken
	 * @since 0.6.0
	 * @hidden
	 */
	private fun updateRemoteNotificationsToken(token: String) {
		this.holder.callMethod("nativeReceiveToken", arrayOf(this.context.createString(token), this.context.createString("fcm")))
	}

	//--------------------------------------------------------------------------
	// Classes
	//--------------------------------------------------------------------------

	/**
	 * @class NotificationData
	 * @since 0.6.0
	 */
	public data class NotificationData(var id: String = "", var title: String = "", var message: String = "")
}