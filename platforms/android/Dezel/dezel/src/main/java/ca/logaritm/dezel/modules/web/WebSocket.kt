package ca.logaritm.dezel.modules.web

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.AsyncTask
import android.os.Handler
import android.support.v4.content.LocalBroadcastManager
import ca.logaritm.dezel.core.*
import com.neovisionaries.ws.client.WebSocketAdapter
import com.neovisionaries.ws.client.WebSocketException
import com.neovisionaries.ws.client.WebSocketFactory
import com.neovisionaries.ws.client.WebSocketFrame
import com.neovisionaries.ws.client.WebSocket as AndroidWebSocket

/**
 * @class WebSocket
 * @since 0.1.0
 * @hidden
 */
open class WebSocket(context: JavaScriptContext) : EventTarget(context) {
// TODO, the readyState is probably not handled correctly
	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	companion object {
		const val Connecting = 0
		const val Open = 1
		const val Closing = 2
		const val Closed = 3
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property url
	 * @since 0.1.0
	 * @hidden
	 */
	open var url: Property = Property("")

	/**
	 * @property protocols
	 * @since 0.1.0
	 * @hidden
	 */
	open var protocols: Property = Property("")

	/**
	 * @property extensions
	 * @since 0.1.0
	 * @hidden
	 */
	open var extensions: Property = Property("")

	/**
	 * @property readyState
	 * @since 0.1.0
	 * @hidden
	 */
	open var readyState: Property = Property(0.0)

	/**
	 * @property bufferedAmount
	 * @since 0.1.0
	 * @hidden
	 */
	open var bufferedAmount: Property = Property(0.0)

	/**
	 * @property binaryType
	 * @since 0.1.0
	 * @hidden
	 */
	open var binaryType: Property = Property(0.0)

	/**
	 * @property socket
	 * @since 0.1.0
	 * @hidden
	 */
	open lateinit var socket: AndroidWebSocket

	/**
	 * @property applicationReloadReceiver
	 * @since 0.2.0
	 * @hidden
	 */
	private val applicationReloadReceiver: BroadcastReceiver = object : BroadcastReceiver() {
		override fun onReceive(context: Context, intent: Intent) {
			this@WebSocket.socket.disconnect()
		}
	}

	//--------------------------------------------------------------------------
	//  Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.2.0
	 */
	init {
		LocalBroadcastManager.getInstance(this.context.application).registerReceiver(this.applicationReloadReceiver, IntentFilter("dezel.application.RELOAD"))
	}

	/**
	 * @destructor
	 * @since 0.2.0
	 */
	protected fun finalize() {
		LocalBroadcastManager.getInstance(this.context.application).unregisterReceiver(this.applicationReloadReceiver)
	}

	//--------------------------------------------------------------------------
	//  JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_url
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_url(callback: JavaScriptGetterCallback) {
		callback.returns(this.url)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_protocol
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_protocol(callback: JavaScriptGetterCallback) {
		callback.returns(this.protocols)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_extensions
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_extensions(callback: JavaScriptGetterCallback) {
		callback.returns(this.extensions)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_readyState
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_readyState(callback: JavaScriptGetterCallback) {
		callback.returns(this.readyState)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_bufferedAmount
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_bufferedAmount(callback: JavaScriptGetterCallback) {
		callback.returns(this.bufferedAmount)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_binaryType
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_binaryType(callback: JavaScriptGetterCallback) {
		callback.returns(this.binaryType)
	}

	/**
	 * @method jsSet_binaryType
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_binaryType(callback: JavaScriptSetterCallback) {
		this.binaryType = Property(callback.value)
	}

	//--------------------------------------------------------------------------
	// JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_open
	 * @since 0.1.0
	 */
	@Suppress("unused")
	open fun jsFunction_open(callback: JavaScriptFunctionCallback) {
		// TODO
		// Protocols

		this.url = Property(callback.argument(0))

		WebSocketCreator().execute(this.url.string)
	}

	/**
	 * @method jsFunction_send
	 * @since 0.1.0
	 */
	@Suppress("unused")
	open fun jsFunction_send(callback: JavaScriptFunctionCallback) {

		// TODO
		// ArrayBuffer

		if (this.readyState.number.toInt() == WebSocket.Connecting) {
			this.context.throwError("INVALID_STATE")
		}

		this.socket.sendText(callback.argument(0).string)
	}

	/**
	 * @method jsFunction_close
	 * @since 0.1.0
	 */
	@Suppress("unused")
	open fun jsFunction_close(callback: JavaScriptFunctionCallback) {

		// TODO
		// Handle closing code and reason

		val readyState = this.readyState.number.toInt()
		if (readyState == WebSocket.Closing ||
			readyState == WebSocket.Closed) {
			return
		}

		this.readyState = Property(WebSocket.Closing.toDouble())

		if (this::socket.isInitialized) {
			this.socket.disconnect()
		}
	}

	//--------------------------------------------------------------------------
	// WebSocket Handler
	//--------------------------------------------------------------------------

	/**
	 * @method onOpen
	 * @since 0.1.0
	 * @hidden
	 */
	private fun onOpen() {
		this.dispatchEvent("Event", "open")
	}

	/**
	 * @method onClose
	 * @since 0.1.0
	 * @hidden
	 */
	private fun onClose(clean: Boolean) {
		this.dispatchEvent("CloseEvent", "close")
	}

	/**
	 * @method onMessage
	 * @since 0.1.0
	 * @hidden
	 */
	private fun onMessage(text: String) {
		this.dispatchEvent("MessageEvent", "message", mutableMapOf("data" to text))
	}

	//--------------------------------------------------------------------------
	// Classes
	//--------------------------------------------------------------------------

	private val handlerr: Handler = Handler()

	/**
	 * @class WebSocketCreator
	 * @since 0.1.0
	 * @hidden
	 */
	private inner class WebSocketCreator : AsyncTask<String, Void, com.neovisionaries.ws.client.WebSocket>() {

		/**
		 * @method doInBackground
		 * @since 0.1.0
		 * @hidden
		 */
		override fun doInBackground(vararg params: String?): com.neovisionaries.ws.client.WebSocket {

			val socket = WebSocketFactory().createSocket(params[0])

			socket.addListener(object : WebSocketAdapter() {

				/**
				 * @method onConnected
				 * @since 0.1.0
				 * @hidden
				 */
				override fun onConnected(websocket: com.neovisionaries.ws.client.WebSocket?, headers: MutableMap<String, MutableList<String>>?) {
					handlerr.post {
						onOpen()
					}
				}

				/**
				 * @method onError
				 * @since 0.1.0
				 * @hidden
				 */
				override fun onError(websocket: com.neovisionaries.ws.client.WebSocket?, cause: WebSocketException?) {
					handlerr.post {
						onClose(false)
					}
				}

				/**
				 * @method onDisconnected
				 * @since 0.1.0
				 * @hidden
				 */
				override fun onDisconnected(websocket: com.neovisionaries.ws.client.WebSocket?, serverCloseFrame: WebSocketFrame?, clientCloseFrame: WebSocketFrame?, closedByServer: Boolean) {
					handlerr.post {
						onClose(closedByServer)
					}
				}

				/**
				 * @method onTextMessage
				 * @since 0.1.0
				 * @hidden
				 */
				override fun onTextMessage(websocket: com.neovisionaries.ws.client.WebSocket, text: String) {
					handlerr.post {
						onMessage(text)
					}
				}
			})

			socket.connect()

			return socket
		}

		/**
		 * @method onPostExecute
		 * @since 0.1.0
		 * @hidden
		 */
		override fun onPostExecute(result: com.neovisionaries.ws.client.WebSocket) {
			socket = result
		}
	}
}