import Foundation

/**
 * The application delegate that must extend the application delegate.
 * @class ApplicationDelegate
 * @since 0.7.0
 */
open class ApplicationDelegate: UIResponder, UIApplicationDelegate {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

    /**
     * The application window.
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
	 * @inherited
	 * @method applicationOpenUrl
	 * @since 0.7.0
	 */
	open func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
		NotificationCenter.default.post(name: Notification.Name("handleresource"), object: self, userInfo: ["url": url])
		return true
	}

	/**
	 * @inherited
	 * @method applicationContinueUserActivity
	 * @since 0.7.0
	 */
	open func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {

		if let url = userActivity.webpageURL {
			NotificationCenter.default.post(name: Notification.Name("handlelink"), object: self, userInfo: ["url": url])
		}

		return true
	}

	/**
	 * @inherited
	 * @method applicationDidRegisterForRemoteNotificationsWithDeviceToken
	 * @since 0.7.0
	 */
    open func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        let token = deviceToken.map { data -> String in
            return String(format:"%02.2hhx", data)
        }.joined()
		
        NotificationCenter.default.post(name: Notification.Name("receiveremotenotificationstoken"), object: self, userInfo: ["token": token])
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
