package ca.logaritm.dezel.modules.notification.fcm

import android.content.Intent
import android.os.Handler
import android.os.Looper
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
	 * Convenience handler to execute stuff on the main thread.
	 * @property handler
	 * @since 0.6.0
	 */
	public val handler: Handler by lazy {
		Handler(Looper.getMainLooper())
	}

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

		this.handler.post {
			LocalBroadcastManager.getInstance(this).sendBroadcastSync(intent)
		}
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

		this.handler.post {
			LocalBroadcastManager.getInstance(this).sendBroadcastSync(intent)
		}
	}
}