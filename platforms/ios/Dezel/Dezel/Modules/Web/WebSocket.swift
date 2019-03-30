/**
 * @class WebSocket
 * @since 0.1.0
 * @hidden
 */
public class WebSocket: EventTarget, WebSocketDelegate {

	public static let Connecting = 0
	public static let Open = 1
	public static let Closing = 2
	public static let Closed = 3

	//--------------------------------------------------------------------------
	// MARK:Properties
	//--------------------------------------------------------------------------

	/**
	 * @property url
	 * @since 0.1.0
	 * @hidden
	 */
	open var url: Property = Property(string: "")

	/**
	 * @property protocols
	 * @since 0.1.0
	 * @hidden
	 */
	open var protocols: Property = Property(string: "")

	/**
	 * @property extensions
	 * @since 0.1.0
	 * @hidden
	 */
	open var extensions: Property = Property(string: "")

	/**
	 * @property readyState
	 * @since 0.1.0
	 * @hidden
	 */
	open var readyState: Property = Property(number: 0)

	/**
	 * @property bufferedAmount
	 * @since 0.1.0
	 * @hidden
	 */
	open var bufferedAmount: Property = Property(number: 0)

	/**
	 * @property binaryType
	 * @since 0.1.0
	 * @hidden
	 */
	open var binaryType: Property = Property(number: 0)

	/**
	 * @property socket
	 * @since 0.1.0
	 * @hidden
	 */
	open var socket: WebSocketConnection!

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.2.0
	 * @hidden
	 */
	public required init(context: JavaScriptContext) {
		super.init(context: context)
		NotificationCenter.default.addObserver(self, selector: #selector(WebSocket.applicationReloadHandler), name: Notification.Name("applicationreload"), object: nil)
	}

	/**
	 * @inherited
	 * @method dispose
	 * @since 0.6.0
	 */
	override open func dispose() {
		NotificationCenter.default.removeObserver(self, name: Notification.Name("applicationreload"), object: nil)
		super.dispose()
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Application Hanlders
	//--------------------------------------------------------------------------

	/**
	 * @method applicationReloadHandler
	 * @since 0.2.0
	 * @hidden
	 */
	@objc open func applicationReloadHandler(notification: Notification) {
		self.socket.disconnect()
		self.socket.delegate = nil
	}

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_url
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_url(callback: JavaScriptGetterCallback) {
		callback.returns(self.url)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_protocol
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_protocol(callback: JavaScriptGetterCallback) {
		callback.returns(self.protocols)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_extensions
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_extensions(callback: JavaScriptGetterCallback) {
		callback.returns(self.extensions)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_readyState
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_readyState(callback: JavaScriptGetterCallback) {
		callback.returns(self.readyState)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_bufferedAmount
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_bufferedAmount(callback: JavaScriptGetterCallback) {
		callback.returns(self.bufferedAmount)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_binaryType
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_binaryType(callback: JavaScriptGetterCallback) {
		callback.returns(self.binaryType)
	}

	/**
	 * @method jsSet_binaryType
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_binaryType(callback: JavaScriptSetterCallback) {
		self.binaryType = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_open
	 * @since 0.1.0
	 */
	@objc open func jsFunction_open(callback: JavaScriptFunctionCallback) {

		// TODO
		// Protocols

		self.url = Property(value: callback.argument(0))

		self.socket = WebSocketConnection(url: URL(string: self.url.string)!, protocols: nil)
		self.socket.delegate = self
		self.socket.connect()
	}

	/**
	 * @method jsFunction_send
	 * @since 0.1.0
	 */
	@objc open func jsFunction_send(callback: JavaScriptFunctionCallback) {

		// TODO
		// ArrayBuffer

		if (self.readyState.number.int() == WebSocket.Connecting) {
			self.context.throwError(string: "INVALID_STATE")
		}

		self.socket.write(callback.argument(0).string)
	}

	/**
	 * @method jsFunction_close
	 * @since 0.1.0
	 */
	@objc open func jsFunction_close(callback: JavaScriptFunctionCallback) {

		// TODO
		// Handle closing code and reason

		let readyState = self.readyState.number.int()
		if (readyState == WebSocket.Closing ||
			readyState == WebSocket.Closed) {
			return
		}

		self.readyState = Property(number: Double(WebSocket.Closing))

		self.socket.disconnect()
	}

	//--------------------------------------------------------------------------
	// Delegate
	//--------------------------------------------------------------------------

	/**
	 * @method websocketDidConnect
	 * @since 0.1.0
	 * @hidden
	 */
	open func websocketDidConnect(_ socket: WebSocketConnection) {
		self.dispatchEvent(type: "Event", event: "open")
	}

	/**
	 * @method websocketDidDisconnect
	 * @since 0.1.0
	 * @hidden
	 */
	open func websocketDidDisconnect(_ socket: WebSocketConnection, error: Error?) {
		self.dispatchEvent(type: "CloseEvent", event: "close")
	}

	/**
	 * @method websocketDidReceiveData
	 * @since 0.1.0
	 * @hidden
	 */
	open func websocketDidReceiveData(_ socket: WebSocketConnection, data: Data) {
		print("Not implemented yet")
	}

	/**
	 * @method websocketDidReceiveMessage
	 * @since 0.1.0
	 * @hidden
	 */
	open func websocketDidReceiveMessage(_ socket: WebSocketConnection, text: String) {
		self.dispatchEvent(type: "MessageEvent", event: "message", inits: ["data": text])
	}
}
