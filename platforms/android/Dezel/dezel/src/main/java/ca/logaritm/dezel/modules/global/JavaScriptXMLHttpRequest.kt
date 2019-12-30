package ca.logaritm.dezel.modules.global

import android.util.Log
import ca.logaritm.dezel.core.JavaScriptClass
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptFunctionCallback
import ca.logaritm.dezel.extension.core.createObject
import ca.logaritm.dezel.extension.core.createString
import ca.logaritm.dezel.extension.core.toDictionaryOfString
import ca.logaritm.dezel.extension.core.toURL
import ca.logaritm.dezel.extension.fatalError
import ca.logaritm.dezel.networking.HttpRequest
import ca.logaritm.dezel.networking.HttpRequestListener
import ca.logaritm.dezel.networking.HttpResponse

/**
 * @class JavaScriptXMLHttpRequest
 * @super JavaScriptClass
 * @since 0.7.0
 */
open class JavaScriptXMLHttpRequest(context: JavaScriptContext) : JavaScriptClass(context), HttpRequestListener {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property request
	 * @since 0.7.0
	 * @hidden
	 */
	private var request: HttpRequest? = null

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method dispose
	 * @since 0.6.0
	 */
	override fun dispose() {
		this.request?.abort()
		this.request = null
		super.dispose()
	}

	//--------------------------------------------------------------------------
	// Request JavaScriptViewListener
	//--------------------------------------------------------------------------

	/**
	 * @method onError
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onError(request: HttpRequest, response: HttpResponse) {

		this.callMethod("nativeOnError", arrayOf(
			this.context.createNumber(response.statusCode),
			this.context.createString(response.statusText)
		))

		this.unprotect()
	}

	/**
	 * @method onTimeout
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onTimeout(request: HttpRequest, response: HttpResponse) {

		this.callMethod("nativeOnTimeout", arrayOf(
			this.context.createNumber(response.statusCode),
			this.context.createString(response.statusText)
		))

		this.unprotect()
	}

	/**
	 * @method onProgress
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onProgress(request: HttpRequest, loaded: Int, length: Int) {
		this.callMethod("nativeOnProgress", arrayOf(
			this.context.createNumber(loaded),
			this.context.createNumber(length)
		))
	}

	/**
	 * @method onComplete
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onComplete(request: HttpRequest, response: HttpResponse) {

		this.callMethod("nativeOnComplete", arrayOf(
			this.context.createString(response.data),
			this.context.createString(response.statusText),
			this.context.createNumber(response.statusCode),
			this.context.createObject(response.headers),
			this.context.createString(response.url)
		))

		this.unprotect()
	}

	//--------------------------------------------------------------------------
	// JS funtion
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_request
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_request(callback: JavaScriptFunctionCallback) {

		this.request?.abort()
		this.request = null

		if (callback.arguments < 7) {
			fatalError("Method JavaScriptXMLHttpRequest.request() requires 7 arguments.")
		}

		val requestUrl      = callback.argument(0)
		val requestMethod   = callback.argument(1).string
		val requestHeaders  = callback.argument(2)
		val requestTimeout  = callback.argument(3)
		val requestUsername = callback.argument(4)
		val requestPassword = callback.argument(5)
		val requestData     = callback.argument(6)

		val url = requestUrl.toURL()
		if (url == null) {
			Log.e("DEZEL", "Invalid XMLHttpRequest URL.")
			return
		}

		val headers = requestHeaders.toDictionaryOfString()
		val timeout = requestTimeout.number

		var username: String? = null
		var password: String? = null

		if (requestUsername.isString) { username = requestUsername.string }
		if (requestPassword.isString) { password = requestPassword.string }

		val request = HttpRequest(url, requestMethod)
		request.timeout = timeout
		request.headers = headers
		request.username = username
		request.password = password
		request.listener = this

		if (requestData.isString) {
			request.data = requestData.string.toByteArray(charset("UTF-8"))
		}

		request.send()

		this.request = request

		this.protect()
	}

	/**
	 * @method jsFunction_abort
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_abort(callback: JavaScriptFunctionCallback) {
		this.request?.abort()
	}

	/**
	 * @method jsFunction_reset
	 * @since 0.7.0
	 * @hidden
	 */
	@Suppress("unused")
	open fun jsFunction_reset(callback: JavaScriptFunctionCallback) {
		this.request?.listener = null
		this.request?.abort()
	}	
}