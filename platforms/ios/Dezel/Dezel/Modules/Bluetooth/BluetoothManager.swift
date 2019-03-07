import CoreBluetooth

/**
 * @class BluetoothManager
 * @since 0.5.0
 * @hidden
 */
open class BluetoothManager : JavaScriptClass, CBPeripheralManagerDelegate {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * Whether bluetooth services are enabled.
	 * @property enabled
	 * @since 0.5.0
	 */
	private(set) public var enabled: Bool = false

	/**
	 * Whether bluetooth services were requested.
	 * @property requested
	 * @since 0.5.0
	 */
	private(set) public var requested: Bool = false

	/**
	 * Whether bluetooth services were authorized.
	 * @property authorized
	 * @since 0.5.0
	 */
	private(set) public var authorized: Bool = false

	/**
	 * @property peripheralManager
	 * @since 0.5.0
	 * @hidden
	 */
	private(set) public var peripheralManager: CBPeripheralManager!

	//--------------------------------------------------------------------------
	// MARK: Peripheral Manager Delegate
	//--------------------------------------------------------------------------

	/**
	 * @method peripheralManagerDidUpdateState
	 * @since 0.5.0
	 * @hidden
	 */
	open func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {

		let enabled = peripheral.state == .poweredOn

		if (self.enabled != enabled) {
			self.enabled = enabled

			self.property("enabled", boolean: enabled)

			if (enabled) {
				self.holder.callMethod("nativeEnable")
			} else {
				self.holder.callMethod("nativeDisable")
			}
		}
	}

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
     * @method jsFunction_init
     * @since 0.5.0
     * @hidden
     */
	@objc open func jsFunction_init(callback: JavaScriptFunctionCallback) {

		self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: [CBCentralManagerOptionShowPowerAlertKey: 0])

		self.enabled = self.isServiceEnabled()
		self.requested = self.isServiceRequested()
		self.authorized = self.isServiceAuthorized()

		self.property("enabled", boolean: self.enabled)
		self.property("requested", boolean: self.requested)
		self.property("authorized", boolean: self.authorized)
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
		return self.peripheralManager.state == .poweredOn
	}

	/**
     * @method isServiceRequested
     * @since 0.5.0
	 * @hidden
     */
	private func isServiceRequested() -> Bool {
		return true // TODO
	}

	/**
     * @method isServiceAuthorized
     * @since 0.5.0
	 * @hidden
     */
	private func isServiceAuthorized() -> Bool {
		return true // TODO
	}
}

