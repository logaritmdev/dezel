/**
 * The protocol that notifies a received about state change within an alert.
 * @protocol AlertControllerDelegate
 * @since 0.1.0
 */
public protocol AlertControllerDelegate : AnyObject {
	func alertDidPresent(alert: AlertController)
	func alertDidDismiss(alert: AlertController)
}
