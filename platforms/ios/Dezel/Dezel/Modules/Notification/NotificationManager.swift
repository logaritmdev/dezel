import UserNotifications

/**
 * @class NotificationManager
 * @since 0.1.0
 * @hidden
 */
public class NotificationManager: JavaScriptClass, UNUserNotificationCenterDelegate {

	//--------------------------------------------------------------------------
	// MARK: Static
	//--------------------------------------------------------------------------

	/**
	 * Whether or not remote notifications are enabled
	 * @property enableRemoteNotifications
	 * @since 0.6.0
	 */
	public static var enableRemoteNotifications: Bool = false

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
     * Whether the notification service authorization has been determined.
     * @property requested
     * @since 0.1.0
     */
	private(set) public var requested: Bool = false

	/**
     * Whether the notification service has been authorized.
     * @property authorized
     * @since 0.1.0
     */
	private(set) public var authorized: Bool = false

	/**
	 * @property userNotificationCenter
	 * @since 0.1.0
	 * @hidden
	 */
	private var userNotificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	public required init(context: JavaScriptContext) {
		super.init(context: context)
		NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(applicationDidReceiveRemoteNotificationsToken), name: Notification.Name("receiveremotenotificationstoken"), object: nil)
		self.userNotificationCenter.delegate = self
	}

	/**
	 * @inherited
	 * @method dispose
	 * @since 0.6.0
	 */
	override open func dispose() {
		NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name:Notification.Name("receiveremotenotificationstoken"), object: nil)
		super.dispose()
	}

	/**
	 * Displays a notification.
	 * @since 0.6.0
	 * @hidden
	 */
	public func notify(_ notification: NotificationData) {

		let content = UNMutableNotificationContent()

		content.sound = UNNotificationSound.default
		content.title = notification.title
		content.body = notification.message

		let request = UNNotificationRequest(identifier: notification.id == "" ? "0" : notification.id, content: content, trigger: nil)

		self.userNotificationCenter.add(request) { error in
			if let error = error {
				print("Error adding notifictaion: \(error)")
			}
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Application Lifecycle
	//--------------------------------------------------------------------------

	/**
	 * @method applicationDidEnterBackground
	 * @since 0.1.0
 	 * @hidden
	 */
	@objc open func applicationDidEnterBackground() {

	}

	/**
	 * @method applicationDidEnterForeground
	 * @since 0.1.0
 	 * @hidden
	 */
	@objc open func applicationDidEnterForeground() {

		self.userNotificationCenter.getNotificationSettings { settings in

			let authorized = self.isServiceAuthorized(settings)

			if (self.requested == false || self.authorized != authorized) {

				self.requested = true
				self.authorized = authorized

				DispatchQueue.main.async {

					self.property("requested", boolean: self.requested)
					self.property("authorized", boolean: self.authorized)

					if (authorized) {
						self.holder.callMethod("nativeAuthorize")
					} else {
						self.holder.callMethod("nativeUnauthorize")
					}
				}
			}
		}
	}

	/**
	 * @method applicationDidReceiveRemoteNotificationsToken
	 * @since 0.6.0
 	 * @hidden
	 */
	@objc open func applicationDidReceiveRemoteNotificationsToken(notification: Notification) {
		if let token = notification.userInfo?["token"] as? String {
			self.updateRemoteNotificationsToken(token)
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Notification Center Delegate
	//--------------------------------------------------------------------------

	/**
	 * @since 0.1.0
	 * @hidden
	 */
	public func userNotificationCenter(_ userNotificationCenter: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
		completionHandler()
	}

	/**
	 * @since 0.1.0
	 * @hidden
	 */
	public func userNotificationCenter(_ userNotificationCenter: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

		let data = self.context.createEmptyObject()
		data.property("title", string: notification.request.content.title)
		data.property("message", string: notification.request.content.body)
		self.holder.callMethod("nativeNotification", arguments: [data], result: nil)

		completionHandler([.alert, .sound])
	}

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
     * @method jsFunction_init
     * @since 0.1.0
     * @hidden
     */
	@objc open func jsFunction_init(callback: JavaScriptFunctionCallback) {

		self.property("requested", boolean: self.requested)
		self.property("authorized", boolean: self.authorized)

		UNUserNotificationCenter.current().getNotificationSettings { (settings) in

			self.requested = self.isServiceRequested(settings)
			self.authorized = self.isServiceAuthorized(settings)

			DispatchQueue.main.async {

				self.property("requested", boolean: self.requested)
				self.property("authorized", boolean: self.authorized)

				if (self.requested) {
					if (self.authorized) {
						self.holder.callMethod("nativeAuthorize")
					} else {
						self.holder.callMethod("nativeUnauthorize")
					}
				}

				if (self.authorized) {
					self.requestRemoteNotificationsToken()
				}
			}
		}
	}

	/**
	 * @method jsFunction_requestAuthorization
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_requestAuthorization(callback: JavaScriptFunctionCallback) {

		UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (authorized, error) in

			if (self.requested == false || self.authorized != authorized) {

				self.requested = true
				self.authorized = authorized

				DispatchQueue.main.async {

					self.property("requested", boolean: self.requested)
					self.property("authorized", boolean: self.authorized)

					self.requestRemoteNotificationsToken()

					if (authorized) {
						self.holder.callMethod("nativeAuthorize")
					} else {
						self.holder.callMethod("nativeUnauthorize")
					}
				}
			}
		}
	}

	/**
	 * @method jsFunction_notify
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_notify(callback: JavaScriptFunctionCallback) {
		var notification = NotificationData()
		notification.id = callback.argument(0).string
		notification.title = callback.argument(1).string
		notification.message = callback.argument(2).string
		self.notify(notification)
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
     * @method isServiceRequested
     * @since 0.1.0
	 * @hidden
     */
	private func isServiceRequested(_ settings: UNNotificationSettings) -> Bool {
		return settings.authorizationStatus != .notDetermined
	}

	/**
     * @method isServiceAuthorized
     * @since 0.1.0
	 * @hidden
     */
	private func isServiceAuthorized(_ settings: UNNotificationSettings) -> Bool {
		return settings.authorizationStatus == .authorized
	}

	/**
     * @method registerForRemoteNotifications
     * @since 0.6.0
	 * @hidden
     */
	private func requestRemoteNotificationsToken() {
		if (NotificationManager.enableRemoteNotifications) {
			UIApplication.shared.registerForRemoteNotifications()
		}
	}

	/**
     * @method updateRemoteNotificationsToken
     * @since 0.6.0
	 * @hidden
     */
	private func updateRemoteNotificationsToken(_ token: String) {
		self.holder.callMethod("nativeReceiveToken", arguments: [self.context.createString(token), self.context.createString("apn")])
	}

	//--------------------------------------------------------------------------
	// Classes
	//--------------------------------------------------------------------------

	/**
	 * @class NotificationData
	 * @since 0.6.0
	 */
	public struct NotificationData {
		public var id: String = ""
		public var title: String = ""
		public var message: String = ""
	}
}
