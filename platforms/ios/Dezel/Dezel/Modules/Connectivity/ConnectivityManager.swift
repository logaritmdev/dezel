import SystemConfiguration

/**
 * @class ConnectivityManager
 * @since 0.1.0
 * @hidden
 */
public class ConnectivityManager: JavaScriptClass {

	enum ConnectivityStatus {
		case none
		case wifi
		case wwan
	}

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property networkReachability
	 * @since 0.1.0
	 * @hidden
	 */
	private var networkReachability: SCNetworkReachability?

	/**
	 * @property networkReachabilityQueue
	 * @since 0.1.0
	 * @hidden
	 */
	private let networkReachabilityQueue: DispatchQueue = DispatchQueue(label: "ca.logaritm.connectivity")

	/**
	 * @property status
	 * @since 0.1.0
	 * @hidden
	 */
	private var status: ConnectivityStatus = .none

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

		var zeroAddress = sockaddr_in()
		zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
		zeroAddress.sin_family = sa_family_t(AF_INET)

		guard let reachability = withUnsafePointer(to: &zeroAddress, {

			$0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
				SCNetworkReachabilityCreateWithAddress(nil, $0)
			}

		}) else {
			return
		}

		self.networkReachability = reachability
	}

	/**
	 * @inherited
	 * @method dispose
	 * @since 0.6.0
	 */
	override open func dispose() {
		self.stop()
		super.dispose()
	}

	/**
	 * @method start
	 * @since 0.1.0
	 * @hidden
	 */
	private func start() {

		guard let reachability = self.networkReachability else {
			return
		}

		var context = SCNetworkReachabilityContext(version: 0, info: wrap(object: self), retain: nil, release: nil, copyDescription: nil)

		if SCNetworkReachabilitySetCallback(reachability, { (reachability: SCNetworkReachability, flags: SCNetworkReachabilityFlags, info: UnsafeMutableRawPointer?) in

			guard let info = info else {
				return
			}

			DispatchQueue.main.async {
				unwrap(pointer: info).check()
			}

		}, &context) == false {
			print("Cannot set reachability callback")
		}

		if SCNetworkReachabilitySetDispatchQueue(reachability, self.networkReachabilityQueue) == false {
			print("Cannot set reachability queue")
		}
	}

	/**
	 * @method stop
	 * @since 0.1.0
	 * @hidden
	 */
	private func stop() {

		guard let reachability = self.networkReachability else {
			return
		}

		SCNetworkReachabilitySetCallback(reachability, nil, nil)
		SCNetworkReachabilitySetDispatchQueue(reachability, nil)
	}

	/**
	 * @method check
	 * @since 0.1.0
	 * @hidden
	 */
	private func check() {

		guard let reachability = self.networkReachability else {
			return
		}

		var flags: SCNetworkReachabilityFlags = []

		if (SCNetworkReachabilityGetFlags(reachability, &flags) == false) {
			self.update(status: .none)
			return
		}

		let connection = flags.contains(.connectionRequired)
		let reachable = flags.contains(.reachable)
		let wwan = flags.contains(.isWWAN)

		if (connection == false && reachable) {

			if (wwan) {
				self.update(status: .wwan)
			} else {
				self.update(status: .wifi)
			}

		} else {
			self.update(status: .none)
		}
	}

	/**
	 * @method update
	 * @since 0.1.0
	 * @hidden
	 */
	private func update(status: ConnectivityStatus) {

		if (self.status == status) {
			return
		}

		self.status = status

		let value: String

		switch (self.status) {
			case .none: value = "none"
			case .wifi: value = "wifi"
			case .wwan: value = "wwan"
		}

		self.holder.callMethod("nativeStatusChange", arguments: [self.context.createString(value)], result: nil)
	}

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_status
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_status(callback: JavaScriptGetterCallback) {

		let value: String

		switch (self.status) {
			case .none: value = "none"
			case .wifi: value = "wifi"
			case .wwan: value = "wwan"
		}

		callback.returns(string: value)
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
		self.start()
		self.check()
	}
}

/**
 * @function wrap
 * @since 0.1.0
 * @hidden
 */
private func wrap(object: ConnectivityManager) -> UnsafeMutableRawPointer {
	return UnsafeMutableRawPointer(Unmanaged<ConnectivityManager>.passUnretained(object).toOpaque())
}

/**
 * @function unwrap
 * @since 0.1.0
 * @hidden
 */
private func unwrap(pointer: UnsafeMutableRawPointer) -> ConnectivityManager {
	return Unmanaged<ConnectivityManager>.fromOpaque(pointer).takeUnretainedValue()
}
