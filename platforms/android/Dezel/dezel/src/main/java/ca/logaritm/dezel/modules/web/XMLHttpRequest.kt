package ca.logaritm.dezel.modules.web

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.support.v4.content.LocalBroadcastManager
import ca.logaritm.dezel.application.application
import ca.logaritm.dezel.core.*
import ca.logaritm.dezel.networking.HttpRequest
import ca.logaritm.dezel.networking.HttpRequestListener

/**
 * @class XMLHttpRequest
 * @since 0.1.0
 * @hidden
 */
open class XMLHttpRequest(context: JavaScriptContext) : EventTarget(context), HttpRequestListener {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	companion object {
		const val Unsent = 0
		const val Opened = 1
		const val HeadersReceived = 2
		const val Loading = 3
		const val Done = 4
	}

	/**
	 * The request's url.
	 * @property url
	 * @since 0.1.0
	 */
	open var url: Property = Property("")

	/**
	 * The request's ready state.
	 * @property readyState
	 * @since 0.1.0
	 */
	open var readyState: Property = Property(XMLHttpRequest.Unsent.toDouble())

	/**
	 * The request's response type.
	 * @property responseType
	 * @since 0.1.0
	 */
	open var responseType: Property = Property()

	/**
	 * The request's response url.
	 * @property responseURL
	 * @since 0.1.0
	 */
	open var responseURL: Property = Property()

	/**
	 * The request's response.
	 * @property response
	 * @since 0.1.0
	 */
	open var response: Property = Property()

	/**
	 * The request's response as text.
	 * @property responseText
	 * @since 0.1.0
	 */
	open var responseText: Property = Property()

	/**
	 * The request's response as xml.
	 * @property responseXML
	 * @since 0.1.0
	 */
	open var responseXML: Property = Property()

	/**
	 * The request's response status.
	 * @property status
	 * @since 0.1.0
	 */
	open var status: Property = Property(0.0)

	/**
	 * The request's response status text.
	 * @property statusText
	 * @since 0.1.0
	 */
	open var statusText: Property = Property("")

	/**
	 * The request's timeout delay.
	 * @property timeout
	 * @since 0.1.0
	 */
	open var timeout: Property = Property(0.0)

	/**
	 * Whether cross-site access control should be made using credentials.
	 * @property withCredentials
	 * @since 0.1.0
	 */
	open var withCredentials: Property = Property(false)

	/**
	 * @property requestHeaders
	 * @since 0.1.0
	 * @hidden
	 */
	private var requestHeaders: MutableMap<String, String> = mutableMapOf()

	/**
	 * @property requestUsername
	 * @since 0.1.0
	 * @hidden
	 */
	private var requestUsername: String? = null

	/**
	 * @property requestPassword
	 * @since 0.1.0
	 * @hidden
	 */
	private var requestPassword: String? = null

	/**
	 * @property responseHeaders
	 * @since 0.1.0
	 * @hidden
	 */
	private var responseHeaders: MutableMap<String, String> = mutableMapOf()

	/**
	 * @property sent
	 * @since 0.1.0
	 * @hidden
	 */
	private var sent: Boolean = false

	/**
	 * @property error
	 * @since 0.1.0
	 * @hidden
	 */
	private var error: Boolean = false

	/**
	 * @property request
	 * @since 0.1.0
	 * @hidden
	 */
	private lateinit var request: HttpRequest

	//--------------------------------------------------------------------------
	//  Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method dispose
	 * @since 0.6.0
	 */
	override fun dispose() {
		this.request.abort()
		this.request.listener = null
		super.dispose()
	}

	//--------------------------------------------------------------------------
	// JS Properties
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
	 * @method jsGet_response
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_response(callback: JavaScriptGetterCallback) {
		callback.returns(this.response)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_responseText
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_responseText(callback: JavaScriptGetterCallback) {
		callback.returns(this.responseText)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_responseType
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_responseType(callback: JavaScriptGetterCallback) {
		callback.returns(this.responseType)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_responseURL
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_responseURL(callback: JavaScriptGetterCallback) {
		callback.returns(this.responseURL)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_responseXML
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_responseXML(callback: JavaScriptGetterCallback) {
		callback.returns(this.responseXML)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_status
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_status(callback: JavaScriptGetterCallback) {
		callback.returns(this.status)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_statusText
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_statusText(callback: JavaScriptGetterCallback) {
		callback.returns(this.statusText)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_timeout
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_timeout(callback: JavaScriptGetterCallback) {
		callback.returns(this.statusText)
	}

	/**
	 * @method jsSet_timeout
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_timeout(callback: JavaScriptSetterCallback) {
		this.timeout = Property(callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_withCredentials
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsGet_withCredentials(callback: JavaScriptGetterCallback) {
		callback.returns(this.withCredentials)
	}

	/**
	 * @method jsSet_withCredentials
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsSet_withCredentials(callback: JavaScriptSetterCallback) {
		this.withCredentials = Property(callback.value)
	}

	//--------------------------------------------------------------------------
	// JS Function
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_open
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_open(callback: JavaScriptFunctionCallback) {

		if (::request.isInitialized) {
			this.request.abort()
		}

		val method = callback.argument(0).string.toUpperCase()

		if (method != "GET" &&
			method != "PUT" &&
			method != "POST" &&
			method != "HEAD" &&
			method != "DELETE" &&
			method != "OPTIONS") {
			this.context.throwError("Invalid request method")
			return
		}

		this.url = Property(callback.argument(1))
		val username = callback.argument(3)
		val password = callback.argument(4)

		if (username.isString) this.requestUsername = username.string
		if (password.isString) this.requestPassword = password.string

		this.request = HttpRequest(this.url.string, method)
		this.request.listener = this

		this.sent = false
		this.error = false

		this.setReadyState(XMLHttpRequest.Opened)
	}

	/**
	 * @method jsFunction_send
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_send(callback: JavaScriptFunctionCallback) {

		if (this.readyState.number.toInt() != XMLHttpRequest.Opened || this.sent) {
			this.context.throwError("Invalid state")
			return
		}

		this.request.headers = this.requestHeaders
		this.request.timeout = this.timeout.number
		this.request.send(callback.argument(0).string)

		this.dispatchEvent("Event", "loadstart")

		this.sent = true
	}

	/**
	 * @method jsFunction_abort
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_abort(callback: JavaScriptFunctionCallback) {

		this.request.abort()

		val readyState = this.readyState.number.toInt()
		if (readyState == XMLHttpRequest.HeadersReceived ||
			readyState == XMLHttpRequest.Loading ||
			(readyState == XMLHttpRequest.Opened && this.sent)) {
			this.sent = false
			this.setReadyState(XMLHttpRequest.Done)
			this.dispatchEvent("Event", "abort")
		}

		this.setReadyState(XMLHttpRequest.Unsent)
	}

	/**
	 * @method jsFunction_setRequestHeader
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_setRequestHeader(callback: JavaScriptFunctionCallback) {
		val k = callback.argument(0).string
		val v = callback.argument(1).string
		this.requestHeaders[k] = v
	}

	/**
	 * @method jsFunction_getResponseHeader
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_getResponseHeader(callback: JavaScriptFunctionCallback) {
		val value = this.responseHeaders[callback.argument(0).string]
		if (value != null) {
			callback.returns(value)
		}
	}

	/**
	 * @method jsFunction_getAllResponseHeaders
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_getAllResponseHeaders(callback: JavaScriptFunctionCallback) {

		var headers = ""

		for ((key, value) in this.responseHeaders) {
			headers += key + ": " + value + "\n";
		}

		callback.returns(headers)
	}

	/**
	 * @method jsFunction_overrideMimeType
	 * @since 0.1.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_overrideMimeType(callback: JavaScriptFunctionCallback) {

	}

	//--------------------------------------------------------------------------
	// Request Delegate
	//--------------------------------------------------------------------------

	/**
	 * @method onSend
	 * @since 0.1.0
	 * @hidden
	 */
	override fun onSend(request: HttpRequest, data: String) {
		this.responseURL = Property(this.url.string)
		this.holder.protect()
	}

	/**
	 * @method onProgress
	 * @since 0.1.0
	 * @hidden
	 */
	override fun onProgress(request: HttpRequest, value: Int, total: Int) {
		this.dispatchEvent("ProgressEvent", "progress", mutableMapOf(
			"lengthComputable" to true,
			"loaded" to value.toDouble(),
			"total" to total.toDouble()
		))
	}

	/**
	 * @method onTimeout
	 * @since 0.1.0
	 * @hidden
	 */
	override fun onTimeout(request: HttpRequest) {
		this.dispatchEvent("Event", "timeout")
		this.holder.unprotect()
	}

	/**
	 * @method onFail
	 * @since 0.1.0
	 * @hidden
	 */
	override fun onFail(request: HttpRequest, code: Int) {
		this.dispatchEvent("Event", "timeout")
		this.holder.unprotect()
	}

	/**
	 * @method onAbort
	 * @since 0.1.0
	 * @hidden
	 */
	override fun onAbort(request: HttpRequest) {

	}

	/**
	 * @method onComplete
	 * @since 0.1.0
	 * @hidden
	 */
	override fun onComplete(request: HttpRequest) {

		val headers = this.context.createEmptyObject()

		for ((key, value) in request.responseHeaders) {
			headers.property(key, value)
		}

		val string = request.response

		this.response = Property(string)
		this.responseText = Property(string)
		this.responseXML = Property()

		this.status = Property(request.responseCode.toDouble())

		when (request.responseCode) {
			100  -> this.statusText = Property("Continue")
			101  -> this.statusText = Property("Switching Protocols")
			103  -> this.statusText = Property("Checkpoint")
			200  -> this.statusText = Property("OK")
			201  -> this.statusText = Property("Created")
			202  -> this.statusText = Property("Accepted")
			203  -> this.statusText = Property("Non-Authoritative Information")
			204  -> this.statusText = Property("No Content")
			205  -> this.statusText = Property("Reset Content")
			206  -> this.statusText = Property("Partial Content")
			300  -> this.statusText = Property("Multiple Choices")
			301  -> this.statusText = Property("Moved Permanently")
			302  -> this.statusText = Property("Found")
			303  -> this.statusText = Property("See Other")
			304  -> this.statusText = Property("Not Modified")
			306  -> this.statusText = Property("Switch Proxy")
			307  -> this.statusText = Property("Temporary Redirect")
			308  -> this.statusText = Property("Resume Incomplete")
			400  -> this.statusText = Property("Bad Request")
			401  -> this.statusText = Property("Unauthorized")
			402  -> this.statusText = Property("Payment Required")
			403  -> this.statusText = Property("Forbidden")
			404  -> this.statusText = Property("Not Found")
			405  -> this.statusText = Property("Method Not Allowed")
			406  -> this.statusText = Property("Not Acceptable")
			407  -> this.statusText = Property("Proxy Authentication Required")
			408  -> this.statusText = Property("Request Timeout")
			409  -> this.statusText = Property("Conflict")
			410  -> this.statusText = Property("Gone")
			411  -> this.statusText = Property("Length Required")
			412  -> this.statusText = Property("Precondition Failed")
			413  -> this.statusText = Property("Request Entity Too Large")
			414  -> this.statusText = Property("Request-URI Too Long")
			415  -> this.statusText = Property("Unsupported Media Type")
			416  -> this.statusText = Property("Requested Range Not Satisfiable")
			417  -> this.statusText = Property("Expectation Failed")
			500  -> this.statusText = Property("Internal Server Error")
			501  -> this.statusText = Property("Not Implemented")
			502  -> this.statusText = Property("Bad Gateway")
			503  -> this.statusText = Property("Service Unavailable")
			504  -> this.statusText = Property("Gateway Timeout")
			505  -> this.statusText = Property("HTTP Version Not Supported")
			511  -> this.statusText = Property("Network Authentication Required")
			else -> this.statusText = Property("")
		}

		this.setReadyState(XMLHttpRequest.Done)

		this.unprotect()
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method setReadyState
	 * @since 0.1.0
	 * @hidden
	 */
	private fun setReadyState(readyState: Int) {

		if (this.readyState.number.toInt() == readyState) {
			return
		}

		this.readyState = Property(readyState.toDouble())

		if (readyState <= XMLHttpRequest.Opened ||
			readyState == XMLHttpRequest.Done) {
			this.dispatchEvent("Event", "readystatechange")
		}

		if (readyState == XMLHttpRequest.Done && this.error == false) {
			this.dispatchEvent("Event", "load")
			this.dispatchEvent("Event", "loadend")
		}
	}
}

