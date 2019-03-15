package ca.logaritm.dezel.modules.notification.fcm


import com.google.android.gms.tasks.OnCompleteListener
import com.google.android.gms.tasks.Task
import com.google.firebase.iid.FirebaseInstanceId
import com.google.firebase.iid.InstanceIdResult

/**
 * @class NotificationMessagingToken
 * @since 0.6.0
 */
public object NotificationMessagingToken {

	/**
	 * Retrieve the current token.
	 * @method getToken
	 * @since 0.6.0
	 */
	public fun getToken(callback: (String) -> Unit) {

		val complete = object : OnCompleteListener<InstanceIdResult> {

			override fun onComplete(task: Task<InstanceIdResult>) {

				if (task.isSuccessful == false ||
					task.isComplete == false) {
					return
				}

				val token = task.result?.token
				if (token == null) {
					return
				}

				callback(token)
			}
		}

		FirebaseInstanceId.getInstance().instanceId.addOnCompleteListener(complete)
	}
}