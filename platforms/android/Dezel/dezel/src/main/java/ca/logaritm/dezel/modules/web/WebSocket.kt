package ca.logaritm.dezel.modules.web

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Handler
import android.support.v4.content.LocalBroadcastManager
import android.util.Log
import ca.logaritm.dezel.application.application
import ca.logaritm.dezel.core.*
import com.neovisionaries.ws.client.*
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
	 * @property socketIsInitialized
	 * @since 0.6.0
	 * @hidden
	 */
	open val socketIsInitialized: Boolean
		get() = this::socket.isInitialized

	/**
	 * @property handler
	 * @since 0.6.0
	 * @hidden
	 */
	private var handler: Handler = Handler()

	/**
	 * @property adapter
	 * @since 0.6.0
	 * @hidden
	 */
	private val adapter: WebSocketAdapter = object : WebSocketAdapter() {

		override fun onConnected(websocket: AndroidWebSocket, headers: MutableMap<String, MutableList<String>>?) {
			handler.post {
				onOpen()
			}
		}

		override fun onError(websocket: AndroidWebSocket, cause: WebSocketException) {
			handler.post {
				onClose(false)
			}
		}

		override fun onDisconnected(websocket: AndroidWebSocket, serverCloseFrame: WebSocketFrame, clientCloseFrame: WebSocketFrame, closedByServer: Boolean) {
			handler.post {
				onClose(closedByServer)
			}
		}

		override fun onTextMessage(websocket: AndroidWebSocket, text: String) {
			handler.post {
				onMessage(text)
			}
		}
	}

	//--------------------------------------------------------------------------
	//  Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method dispose
	 * @since 0.6.0
	 */
	override fun dispose() {
		this.socket.disconnect()
		super.dispose()
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

		this.socket = WebSocketFactory().createSocket(this.url.string)
		this.socket.addListener(this.adapter)

		try {

			this.socket.connectAsynchronously()

		} catch (e: OpeningHandshakeException) {
			Log.e("DEZEL", "WebSocket Error", e)
		} catch (e: HostnameUnverifiedException) {
			Log.e("DEZEL", "WebSocket Error", e)
		} catch (e: WebSocketException) {
			Log.e("DEZEL", "WebSocket Error", e)
		}
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

		if (this.socketIsInitialized) {
			this.socket.sendText(callback.argument(0).string)
		}
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

		if (this.socketIsInitialized) {
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
}