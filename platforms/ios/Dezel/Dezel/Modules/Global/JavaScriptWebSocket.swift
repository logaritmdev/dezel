/**
 * @class WebSocket
 * @since 0.1.0
 * @hidden
 */
public class JavaScriptWebSocket: JavaScriptClass, WebSocketDelegate {

	//--------------------------------------------------------------------------
	// MARK:Properties
	//--------------------------------------------------------------------------

	/**
	 * The web socket connection.
	 * @property socket
	 * @since 0.1.0
	 */
	private(set) open var socket: WebSocketConnection!

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method dispose
	 * @since 0.6.0
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
	 * @since 0.1.0
	 */
	@objc open func jsFunction_open(callback: JavaScriptFunctionCallback) {

		guard let url = URL(string: callback.argument(0).string) else {
			fatalError()
		}

		var protocols: [String] = []
		callback.argument(1).forEach { index, value in
			protocols.append(value.string)
		}

		self.socket = WebSocketConnection(url: url, protocols: protocols)
		self.socket.delegate = self
		self.socket.connect()
	}

	/**
	 * @method jsFunction_send
	 * @since 0.1.0
	 */
	@objc open func jsFunction_send(callback: JavaScriptFunctionCallback) {
		self.socket.write(callback.argument(0).string)
	}

	/**
	 * @method jsFunction_close
	 * @since 0.1.0
	 */
	@objc open func jsFunction_close(callback: JavaScriptFunctionCallback) {
		self.socket.disconnect()
	}

	//--------------------------------------------------------------------------
	// MARK: WebSocket Delegate
	//--------------------------------------------------------------------------

	/**
	 * @method websocketDidConnect
	 * @since 0.1.0
	 * @hidden
	 */
	open func websocketDidConnect(_ socket: WebSocketConnection) {
		self.holder.callMethod("nativeOnConnect", arguments: [
			self.context.createString(""),
			self.context.createString("")
		])
	}

	/**
	 * @method websocketDidReceiveData
	 * @since 0.1.0
	 * @hidden
	 */
	open func websocketDidReceiveData(_ socket: WebSocketConnection, data: Data) {
		self.holder.callMethod("nativeOnReceiveData")
	}

	/**
	 * @method websocketDidReceiveMessage
	 * @since 0.1.0
	 * @hidden
	 */
	open func websocketDidReceiveMessage(_ socket: WebSocketConnection, text: String) {
		self.holder.callMethod("nativeOnReceiveMessage", arguments: [
			self.context.createString(text)
		])
	}

	/**
	 * @method websocketDidDisconnect
	 * @since 0.1.0
	 * @hidden
	 */
	open func websocketDidDisconnect(_ socket: WebSocketConnection, error: Error?) {
		self.holder.callMethod("nativeOnDisconnect")
	}
}
