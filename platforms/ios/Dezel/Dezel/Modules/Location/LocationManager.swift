import CoreLocation

/**
 * @class LocationManager
 * @since 0.1.0
 * @hidden
 */
open class LocationManager: JavaScriptClass, CLLocationManagerDelegate {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * Whether location services are enabled.
	 * @property enabled
	 * @since 0.1.0
	 */
	private(set) public var enabled: Bool = false

	/**
	 * Whether location services were requested.
	 * @property requested
	 * @since 0.1.0
	 */
	private(set) public var requested: Bool = false

	/**
	 * Whether location services were authorized.
	 * @property authorized
	 * @since 0.1.0
	 */
	private(set) public var authorized: Bool = false

	/**
     * The location services required authorization.
     * @property authorization
     * @since 0.1.0
     */
	private(set) public var authorization: CLAuthorizationStatus = .notDetermined

	/**
	 * @property locationManager
	 * @since 0.1.0
	 * @hidden
	 */
	private var locationManager: CLLocationManager = CLLocationManager()

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
		self.locationManager.delegate = self
	}

	/**
	 * Removes listeners upon destruction.
	 * @destructor
	 * @since 0.1.0
	 */
	deinit {
		NotificationCenter.default.removeObserver(self)
	}

	/**
     * @method updateServiceStatus
     * @since 0.1.0
     * @hidden
     */
	open func updateServiceStatus() {

		let enabled = self.isServiceEnabled()

		if (self.enabled != enabled) {
			self.enabled = enabled

			self.property("enabled", boolean: enabled)

			if (enabled) {
				self.holder.callMethod("nativeEnable")
			} else {
				self.holder.callMethod("nativeDisable")
			}
		}

		if (self.isServiceRequested() == false) {
			return
		}

		let authorized = self.isServiceAuthorized()

		if (self.requested == false || self.authorized != authorized) {

			self.requested = true
			self.authorized = authorized

			self.property("requested", boolean: self.requested)
			self.property("authorized", boolean: self.authorized)

			if (authorized) {
				self.holder.callMethod("nativeAuthorize")
			} else {
				self.holder.callMethod("nativeUnauthorize")
			}
		}
	}

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
		self.updateServiceStatus()
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Location Manager Delegate
	//--------------------------------------------------------------------------

	/**
	 * @since 0.1.0
	 * @hidden
	 */
	public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

	}

	/**
	 * @since 0.1.0
	 * @hidden
	 */
	public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		self.updateServiceStatus()
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

		if (callback.arguments < 1) {
			return
		}

		switch (callback.argument(0).string) {

			case "wheninuse":
				self.authorization = .authorizedWhenInUse
			case "always":
				self.authorization = .authorizedAlways

			default:
				self.authorization = .authorizedWhenInUse
				break
		}

		self.enabled = self.isServiceEnabled()
		self.requested = self.isServiceRequested()
		self.authorized = self.isServiceAuthorized()

		self.property("enabled", boolean: self.enabled)
		self.property("requested", boolean: self.requested)
		self.property("authorized", boolean: self.authorized)

		self.updateServiceStatus()
	}

	/**
	 * @method jsFunction_requestAuthorization
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_requestAuthorization(callback: JavaScriptFunctionCallback) {

		switch (self.authorization) {

			case .authorizedWhenInUse:
				self.locationManager.requestWhenInUseAuthorization()

			case .authorizedAlways:
				self.locationManager.requestAlwaysAuthorization()

			default: break
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
     * @method isServiceEnabled
     * @since 0.1.0
	 * @hidden
     */
	private func isServiceEnabled() -> Bool {
		return CLLocationManager.locationServicesEnabled()
	}

	/**
     * @method isServiceRequested
     * @since 0.1.0
	 * @hidden
     */
	private func isServiceRequested() -> Bool {
		return CLLocationManager.authorizationStatus() != .notDetermined
	}

	/**
     * @method isServiceAuthorized
     * @since 0.1.0
	 * @hidden
     */
	private func isServiceAuthorized() -> Bool {
		return CLLocationManager.authorizationStatus() != .notDetermined && CLLocationManager.authorizationStatus() == self.authorization
	}
}
