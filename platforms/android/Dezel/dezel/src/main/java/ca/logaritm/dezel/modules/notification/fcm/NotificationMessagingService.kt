package ca.logaritm.dezel.modules.notification.fcm

import android.app.NotificationManager
import android.app.Service
import android.content.Intent
import android.support.v4.content.LocalBroadcastManager
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import java.util.*

/**
 * @class NotificationMessagingService
 * @since 0.6.0
 */
open class NotificationMessagingService: FirebaseMessagingService() {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property notificationManager
	 * @since 0.1.0
	 * @hidden
	 */
	private val notificationManager: NotificationManager
		get() = this.application.getSystemService(Service.NOTIFICATION_SERVICE) as NotificationManager

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onNewToken
	 * @since 0.6.0
	 */
	override fun onNewToken(token: String) {

		val since = Date().time

		val intent = Intent("dezel.notification.messaging.TOKEN")
		intent.putExtra("token", token)
		intent.putExtra("since", since)

		LocalBroadcastManager.getInstance(this).sendBroadcastSync(intent)
	}

	/**
	 * @inherited
	 * @method onMessageReceived
	 * @since 0.6.0
	 */
	override fun onMessageReceived(message: RemoteMessage) {
		val intent = Intent("dezel.notification.messaging.MESSAGE")
		intent.putExtra("title", message.notification?.title ?: "")
		intent.putExtra("message", message.notification?.body ?: "")
		LocalBroadcastManager.getInstance(this).sendBroadcastSync(intent)
	}
}