package ca.logaritm.dezel.modules.global

import android.os.AsyncTask
import android.os.Handler
import ca.logaritm.dezel.core.JavaScriptClass
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback
import ca.logaritm.dezel.extension.fatalError
import com.neovisionaries.ws.client.*

/**
 * @class JavaScriptWebSocket
 * @super JavaScriptClass
 * @since 0.7.0
 */
open class JavaScriptWebSocket(context: JavaScriptContext) : JavaScriptClass(context) {

	//--------------------------------------------------------------------------
	// MARK:Properties
	//--------------------------------------------------------------------------

	/**
	 * @property socket
	 * @since 0.7.0
	 */
	open var socket: WebSocket? = null

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method dispose
	 * @since 0.7.0
	 */
	override fun dispose() {
		this.socket?.disconnect()
		this.socket = null
		super.dispose()
	}

	//--------------------------------------------------------------------------
	// JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_open
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_open(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 2) {
			fatalError("Method JavaScriptWebSocket.open() requires 2 arguments.")
		}

		WebSocketCreator().execute(callback.argument(0).string)
	}

	/**
	 * @method jsFunction_send
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_send(callback: JavaScriptFunctionCallback) {

		if (callback.arguments < 1) {
			fatalError("Method JavaScriptWebSocket.send() requires 1 argument.")
		}

		this.socket?.sendText(callback.argument(0).string)
	}

	/**
	 * @method jsFunction_close
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_close(callback: JavaScriptFunctionCallback) {
		this.socket?.disconnect()
	}

	//--------------------------------------------------------------------------
	// WebSocket Handler
	//--------------------------------------------------------------------------

	/**
	 * @method onOpen
	 * @since 0.7.0
	 * @hidden
	 */
	private fun onOpen() {
		this.callMethod("nativeOnConnect", arrayOf(
			this.context.createString(""),
			this.context.createString("")
		))
	}

	/**
	 * @method onClose
	 * @since 0.7.0
	 * @hidden
	 */
	private fun onClose(clean: Boolean) {
		this.callMethod("nativeOnDisconnect")
	}

	/**
	 * @method onMessage
	 * @since 0.7.0
	 * @hidden
	 */
	private fun onMessage(text: String) {
		this.callMethod("nativeOnReceiveMessage", arrayOf(
			this.context.createString(text)
		))
	}

	//--------------------------------------------------------------------------
	// Classes
	//--------------------------------------------------------------------------

	private val handler: Handler = Handler()

	/**
	 * @class WebSocketCreator
	 * @since 0.7.0
	 * @hidden
	 */
	private inner class WebSocketCreator : AsyncTask<String, Void, WebSocket>() {

		/**
		 * @method doInBackground
		 * @since 0.7.0
		 * @hidden
		 */
		override fun doInBackground(vararg params: String?): WebSocket {

			val socket = WebSocketFactory().createSocket(params[0])

			socket.addListener(object : WebSocketAdapter() {

				/**
				 * @method onConnected
				 * @since 0.7.0
				 * @hidden
				 */
				override fun onConnected(websocket: WebSocket?, headers: MutableMap<String, MutableList<String>>?) {
					handler.post {
						onOpen()
					}
				}

				/**
				 * @method onError
				 * @since 0.7.0
				 * @hidden
				 */
				override fun onError(websocket: WebSocket?, cause: WebSocketException?) {
					handler.post {
						onClose(false)
					}
				}

				/**
				 * @method onDisconnected
				 * @since 0.7.0
				 * @hidden
				 */
				override fun onDisconnected(websocket: WebSocket?, serverCloseFrame: WebSocketFrame?, clientCloseFrame: WebSocketFrame?, closedByServer: Boolean) {
					handler.post {
						onClose(closedByServer)
					}
				}

				/**
				 * @method onTextMessage
				 * @since 0.7.0
				 * @hidden
				 */
				override fun onTextMessage(websocket: WebSocket, text: String) {
					handler.post {
						onMessage(text)
					}
				}
			})

			socket.connect()

			return socket
		}

		/**
		 * @method onPostExecute
		 * @since 0.7.0
		 * @hidden
		 */
		override fun onPostExecute(result: WebSocket) {
			socket = result
		}
	}
}