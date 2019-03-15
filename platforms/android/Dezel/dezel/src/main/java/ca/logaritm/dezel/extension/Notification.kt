package ca.logaritm.dezel.extension

import android.app.Notification

/**
 * @method Notification.Builder.setTitle
 * @since 0.6.0
 * @hidden
 */
internal fun Notification.Builder.setTitle(title: String) {
	if (title.length > 0) {
		this.setContentTitle(title)
	}
}

/**
 * @method Notification.Builder.setMessage
 * @since 0.6.0
 * @hidden
 */
internal fun Notification.Builder.setMessage(message: String) {
	if (message.length > 0) {
		this.setContentText(message)
	}
}