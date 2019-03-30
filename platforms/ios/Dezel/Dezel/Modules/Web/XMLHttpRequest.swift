/**
 * @class XMLHttpRequest
 * @since 0.1.0
 * @hidden
 */
open class XMLHttpRequest: EventTarget, HttpRequestDelegate {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	public static let Unsent = 0
	public static let Opened = 1
	public static let HeadersReceived = 2
	public static let Loading = 3
	public static let Done = 4

	/**
	 * The request's url.
	 * @property url
	 * @since 0.1.0
	 */
	open var url: Property = Property(string: "")

	/**
	 * The request's ready state.
	 * @property readyState
	 * @since 0.1.0
	 */
	open var readyState: Property = Property(number: Double(XMLHttpRequest.Unsent))

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
	open var status: Property = Property(number: 0)

	/**
	 * The request's response status text.
	 * @property statusText
	 * @since 0.1.0
	 */
	open var statusText: Property = Property(string: "")

	/**
	 * The request's timeout delay.
	 * @property timeout
	 * @since 0.1.0
	 */
	open var timeout: Property = Property(number: 0)

	/**
	 * Whether cross-site access control should be made using credentials.
	 * @property withCredentials
	 * @since 0.1.0
	 */
	open var withCredentials: Property = Property(boolean: false)

	/**
	 * @property requestHeaders
	 * @since 0.1.0
	 * @hidden
	 */
	private var requestHeaders: [String: String] = [:]

	/**
	 * @property requestUsername
	 * @since 0.1.0
	 * @hidden
	 */
	private var requestUsername: String?

	/**
	 * @property requestPassword
	 * @since 0.1.0
	 * @hidden
	 */
	private var requestPassword: String?

	/**
	 * @property responseHeaders
	 * @since 0.1.0
	 * @hidden
	 */
	private var responseHeaders: [String: String] = [:]

	/**
	 * @property sent
	 * @since 0.1.0
	 * @hidden
	 */
	private var sent: Bool = false

	/**
	 * @property error
	 * @since 0.1.0
	 * @hidden
	 */
	private var error: Bool = false

	/**
	 * @property request
	 * @since 0.1.0
	 * @hidden
	 */
	private var request: HttpRequest!

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
		self.request.abort()
		self.request.delegate = nil
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Request Delegate
	//--------------------------------------------------------------------------

	/**
	 * @method didSend
	 * @since 0.1.0
	 * @hidden
	 */
	public func didSend(request: HttpRequest, data: Data?) {
		self.responseURL = Property(string: self.url.string)
		self.holder.protect()
	}

	/**
	 * @method didProgress
	 * @since 0.1.0
	 * @hidden
	 */
	public func didProgress(request: HttpRequest, value: Int64, total: Int64) {
		self.dispatchEvent(type: "ProgressEvent", event: "progress", inits: [
			"lengthComputable": true,
			"loaded": Double(value),
			"total": Double(total)
		])
	}

	/**
	 * @method didTimeout
	 * @since 0.1.0
	 * @hidden
	 */
	public func didTimeout(request: HttpRequest, error: Error) {
		self.dispatchEvent(type: "Event", event: "timeout")
		self.dispatchEvent(type: "Event", event: "error", inits: ["code": Double((error as NSError).code), "description": error.localizedDescription])
		self.holder.unprotect()
	}

	/**
	 * @method didFail
	 * @since 0.1.0
	 * @hidden
	 */
	public func didFail(request: HttpRequest, error: Error) {

		let err = error as NSError
		let code = Double(err.code)
		let description = err.localizedDescription

		self.dispatchEvent(type: "Event", event: "error", inits: ["code": code, "description": description])

		self.holder.unprotect()
	}

	/**
	 * @method didAbort
	 * @since 0.1.0
	 * @hidden
	 */
	public func didAbort(request: HttpRequest) {

	}

	/**
	 * @method didComplete
	 * @since 0.1.0
	 * @hidden
	 */
	public func didComplete(request: HttpRequest, response: URLResponse, data: Data) {

		if  let response = response as? HTTPURLResponse {

			var encoding = String.Encoding.utf8

			if let name = response.textEncodingName {
				let enkoding = CFStringConvertIANACharSetNameToEncoding(name as CFString)
				if (enkoding != kCFStringEncodingInvalidId) {
					encoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(enkoding))
				}
			}

			for (key, val) in response.allHeaderFields {
				if let key = key as? String, let val = val as? String {
					self.responseHeaders[key] = val
				}
			}

			let string = NSString(data: data as Data, encoding: encoding.rawValue)! as String

			self.response = Property(string: string)
			self.responseText = Property(string: string)
			self.responseXML = Property()

			self.status = Property(number: Double(response.statusCode))

			switch (response.statusCode) {

				case 100: self.statusText = Property(string: "Continue")
				case 101: self.statusText = Property(string: "Switching Protocols")
				case 103: self.statusText = Property(string: "Checkpoint")
				case 200: self.statusText = Property(string: "OK")
				case 201: self.statusText = Property(string: "Created")
				case 202: self.statusText = Property(string: "Accepted")
				case 203: self.statusText = Property(string: "Non-Authoritative Information")
				case 204: self.statusText = Property(string: "No Content")
				case 205: self.statusText = Property(string: "Reset Content")
				case 206: self.statusText = Property(string: "Partial Content")
				case 300: self.statusText = Property(string: "Multiple Choices")
				case 301: self.statusText = Property(string: "Moved Permanently")
				case 302: self.statusText = Property(string: "Found")
				case 303: self.statusText = Property(string: "See Other")
				case 304: self.statusText = Property(string: "Not Modified")
				case 306: self.statusText = Property(string: "Switch Proxy")
				case 307: self.statusText = Property(string: "Temporary Redirect")
				case 308: self.statusText = Property(string: "Resume Incomplete")
				case 400: self.statusText = Property(string: "Bad Request")
				case 401: self.statusText = Property(string: "Unauthorized")
				case 402: self.statusText = Property(string: "Payment Required")
				case 403: self.statusText = Property(string: "Forbidden")
				case 404: self.statusText = Property(string: "Not Found")
				case 405: self.statusText = Property(string: "Method Not Allowed")
				case 406: self.statusText = Property(string: "Not Acceptable")
				case 407: self.statusText = Property(string: "Proxy Authentication Required")
				case 408: self.statusText = Property(string: "Request Timeout")
				case 409: self.statusText = Property(string: "Conflict")
				case 410: self.statusText = Property(string: "Gone")
				case 411: self.statusText = Property(string: "Length Required")
				case 412: self.statusText = Property(string: "Precondition Failed")
				case 413: self.statusText = Property(string: "Request Entity Too Large")
				case 414: self.statusText = Property(string: "Request-URI Too Long")
				case 415: self.statusText = Property(string: "Unsupported Media Type")
				case 416: self.statusText = Property(string: "Requested Range Not Satisfiable")
				case 417: self.statusText = Property(string: "Expectation Failed")
				case 500: self.statusText = Property(string: "Internal Server Error")
				case 501: self.statusText = Property(string: "Not Implemented")
				case 502: self.statusText = Property(string: "Bad Gateway")
				case 503: self.statusText = Property(string: "Service Unavailable")
				case 504: self.statusText = Property(string: "Gateway Timeout")
				case 505: self.statusText = Property(string: "HTTP Version Not Supported")
				case 511: self.statusText = Property(string: "Network Authentication Required")

				default:
					self.statusText = Property(string: "")
			}
		}

		self.setReadyState(XMLHttpRequest.Done)

		self.unprotect()
	}

	//--------------------------------------------------------------------------
	// MARK: JS Properties
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
	 * @method jsGet_response
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_response(callback: JavaScriptGetterCallback) {
		callback.returns(self.response)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_responseText
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_responseText(callback: JavaScriptGetterCallback) {
		callback.returns(self.responseText)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_responseType
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_responseType(callback: JavaScriptGetterCallback) {
		callback.returns(self.responseType)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_responseURL
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_responseURL(callback: JavaScriptGetterCallback) {
		callback.returns(self.responseURL)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_responseXML
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_responseXML(callback: JavaScriptGetterCallback) {
		callback.returns(self.responseXML)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_status
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_status(callback: JavaScriptGetterCallback) {
		callback.returns(self.status)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_statusText
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_statusText(callback: JavaScriptGetterCallback) {
		callback.returns(self.statusText)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_timeout
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_timeout(callback: JavaScriptGetterCallback) {
		callback.returns(self.statusText)
	}

	/**
	 * @method jsSet_timeout
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_timeout(callback: JavaScriptSetterCallback) {
		self.timeout = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_withCredentials
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_withCredentials(callback: JavaScriptGetterCallback) {
		callback.returns(self.withCredentials)
	}

	/**
	 * @method jsSet_withCredentials
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_withCredentials(callback: JavaScriptSetterCallback) {
		self.withCredentials = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------
	// MARK: JS Function
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_open
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_open(callback: JavaScriptFunctionCallback) {

		self.request?.abort()
		self.request = nil

		let method = callback.argument(0).string.uppercased()

		if (method != "GET" &&
			method != "PUT" &&
			method != "POST" &&
			method != "HEAD" &&
			method != "DELETE" &&
			method != "OPTIONS") {
			self.context.throwError(string: "Invalid request method")
			return
		}

		self.url = Property(value: callback.argument(1))
		let username = callback.argument(3)
		let password = callback.argument(4)

		if (username.isString) { self.requestUsername = username.string }
		if (password.isString) { self.requestPassword = password.string }

		self.request = HttpRequest(url: self.url.string, method: method)
		self.request.delegate = self

		self.sent = false
		self.error = false

		self.setReadyState(XMLHttpRequest.Opened)
	}

	/**
	 * @method jsFunction_send
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_send(callback: JavaScriptFunctionCallback) {

		if (self.readyState.number.int() != XMLHttpRequest.Opened || self.sent) {
			self.context.throwError(string: "Invalid state")
			return
		}

		self.request.headers = self.requestHeaders
		self.request.timeout = self.timeout.number
		self.request.send(data: callback.argument(0).string.data(using: String.Encoding.utf8)!)

		self.dispatchEvent(type: "Event", event: "loadstart")

		self.sent = true
	}

	/**
	 * @method jsFunction_abort
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_abort(callback: JavaScriptFunctionCallback) {

		self.request?.abort()

		let readyState = self.readyState.number.int()
		if (readyState == XMLHttpRequest.HeadersReceived ||
			readyState == XMLHttpRequest.Loading ||
			(readyState == XMLHttpRequest.Opened && self.sent)) {
			self.sent = false
			self.setReadyState(XMLHttpRequest.Done)
			self.dispatchEvent(type: "Event", event: "abort")
		}

		self.setReadyState(XMLHttpRequest.Unsent)
	}

	/**
	 * @method jsFunction_setRequestHeader
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_setRequestHeader(callback: JavaScriptFunctionCallback) {
		let k = callback.argument(0).string
		let v = callback.argument(1).string
		self.requestHeaders[k] = v
	}

	/**
	 * @method jsFunction_getResponseHeader
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_getResponseHeader(callback: JavaScriptFunctionCallback) {
		if let value = self.responseHeaders[callback.argument(0).string] {
			callback.returns(string: value)
		}
	}

	/**
	 * @method jsFunction_getAllResponseHeaders
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_getAllResponseHeaders(callback: JavaScriptFunctionCallback) {

		var headers = ""

		for (key, value) in self.responseHeaders {
			headers += key + ": " + value + "\n";
		}

		callback.returns(string: headers)
	}

	/**
	 * @method jsFunction_overrideMimeType
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_overrideMimeType(callback: JavaScriptFunctionCallback) {

	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method setReadyState
	 * @since 0.1.0
	 * @hidden
	 */
	private func setReadyState(_ readyState: Int) {

		if (self.readyState.number.int() == readyState) {
			return
		}

		self.readyState = Property(number: Double(readyState))

		if (readyState <= XMLHttpRequest.Opened ||
			readyState == XMLHttpRequest.Done) {
			self.dispatchEvent(type: "Event", event: "readystatechange")
		}

		if (readyState == XMLHttpRequest.Done && self.error == false) {
			self.dispatchEvent(type: "Event", event: "load")
			self.dispatchEvent(type: "Event", event: "loadend")
		}
	}
}
