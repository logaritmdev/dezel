import Foundation

/**
 * @class ApplicationDelegate
 * @super UIResponder
 * @since 0.7.0
 */
open class ApplicationDelegate: UIResponder, UIApplicationDelegate {

	//--------------------------------------------------------------------------
	// MARK: Static
	//--------------------------------------------------------------------------

	/**
	 * @const touchesBeganNotificaiton
	 * @since 0.7.0
	 * @hidden
	 */
	public static let touchesBeganNotification = Notification.Name("touchesBegan")

	/**
	 * @const touchesMovedNotification
	 * @since 0.7.0
	 * @hidden
	 */
	public static let touchesMovedNotification = Notification.Name("touchesMoved")

	/**
	 * @const touchesEndedNotification
	 * @since 0.7.0
	 * @hidden
	 */
	public static let touchesEndedNotification = Notification.Name("touchesEnded")

	/**
	 * @const touchesCancelledNotification
	 * @since 0.7.0
	 * @hidden
	 */
	public static let touchesCanceledNotification = Notification.Name("touchesCancelled")

	/**
	 * @const openUniversalURLNotification
	 * @since 0.7.0
	 * @hidden
	 */
	public static let openUniversalURLNotification = Notification.Name("openUniversalURL")

	/**
	 * @const openResourceURLNotification
	 * @since 0.7.0
	 * @hidden
	 */
	public static let openResourceURLNotification = Notification.Name("openResourceURL")

	/**
	 * @const remoteNotificationsTokenNotification
	 * @since 0.7.0
	 * @hidden
	 */
	public static let remoteNotificationsTokenNotification = Notification.Name("remoteNotificationsToken")

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

    /**
     * @property window
	 * @since 0.7.0
	 * @hidden
     */
    open var window: UIWindow? {

		get {
            return self.applicationWindow
        }

		set {
			fatalError("Window is not mutable.")
		}
    }

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method applicationOpenUrl
	 * @since 0.7.0
	 */
	open func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
		NotificationCenter.default.post(name: ApplicationDelegate.openUniversalURLNotification, object: self, userInfo: ["url": url])
		return true
	}

	/**
	 * @method applicationContinueUserActivity
	 * @since 0.7.0
	 */
	open func application(_ application: UIApplication, continue activity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
		NotificationCenter.default.post(name: ApplicationDelegate.openResourceURLNotification, object: self, userInfo: ["url": activity.webpageURL as Any])
		return true
	}

	/**
	 * @method applicationDidRegisterForRemoteNotificationsWithDeviceToken
	 * @since 0.7.0
	 */
    open func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken token: Data) {
        NotificationCenter.default.post(name: ApplicationDelegate.remoteNotificationsTokenNotification, object: self, userInfo: ["token": token])
    }

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @property applicationWindow
	 * @since 0.7.0
	 * @hidden
	 */
	private var applicationWindow: ApplicationWindow = ApplicationWindow(frame: UIScreen.main.bounds)
}
