/**
 * @class JavaScriptWebSocket
 * @super JavaScriptClass
 * @since 0.7.0
 */
public class JavaScriptWebSocket: JavaScriptClass, WebSocketDelegate {

	//--------------------------------------------------------------------------
	// MARK:Properties
	//--------------------------------------------------------------------------

	/**
	 * @property socket
	 * @since 0.7.0
	 */
	private(set) open var socket: WebSocketConnection!

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method dispose
	 * @since 0.7.0
	 */
	override open func dispose() {
		self.socket.disconnect()
		self.socket.delegate = nil
		super.dispose()
	}

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_open
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsFunction_open(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 2) {
			fatalError("Method JavaScriptWebSocket.open() requires 2 arguments.")
		}

		let websocketUrl       = callback.argument(0)
		let websocketProtocols = callback.argument(1)

		guard let url = websocketUrl.toURL() else {
			NSLog("Invalid WebSocket URL")
			return
		}

		self.socket = WebSocketConnection(url: url, protocols: websocketProtocols.toArrayOfString())
		self.socket.delegate = self
		self.socket.connect()
	}

	/**
	 * @method jsFunction_send
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsFunction_send(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptWebSocket.send() requires 1 argument.")
		}

		self.socket.write(callback.argument(0).string)
	}

	/**
	 * @method jsFunction_close
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsFunction_close(callback: JavaScriptFunctionCallback) {
		self.socket.disconnect()
	}

	//--------------------------------------------------------------------------
	// MARK: WebSocket Delegate
	//--------------------------------------------------------------------------

	/**
	 * @method websocketDidConnect
	 * @since 0.7.0
	 * @hidden
	 */
	open func websocketDidConnect(_ socket: WebSocketConnection) {
		self.callMethod("nativeOnConnect", arguments: [
			self.context.createString(""),
			self.context.createString("")
		])
	}

	/**
	 * @method websocket:didReceiveData
	 * @since 0.7.0
	 * @hidden
	 */
	public func websocket(_ socket: WebSocketConnection, didReceive data: Data?) {
		self.callMethod("nativeOnReceiveData")
	}

	/**
	 * @method websocket:didReceiveMessage
	 * @since 0.7.0
	 * @hidden
	 */
	public func websocket(_ socket: WebSocketConnection, didReceiveMessage string: String) {
		self.callMethod("nativeOnReceiveMessage", arguments: [
			self.context.createString(string)
		])
	}

	/**
	 * @method websocketDidDisconnect
	 * @since 0.7.0
	 * @hidden
	 */
	open func websocketDidDisconnect(_ socket: WebSocketConnection, error: Error?) {
		self.callMethod("nativeOnDisconnect")
	}
}
