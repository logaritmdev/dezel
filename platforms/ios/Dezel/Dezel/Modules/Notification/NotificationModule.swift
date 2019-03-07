/**
 * @class NotificationModule
 * @since 0.1.0
 */
open class NotificationModule : Module {

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	override open func initialize() {
		self.context.registerClass("dezel.notification.NotificationManager", type: NotificationManager.self)
	}
}
