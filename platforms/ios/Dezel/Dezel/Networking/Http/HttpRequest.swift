import Foundation

/**
 * @class HttpRequest
 * @since 0.1.0
 * @hidden
 */
open class HttpRequest: NSObject, URLSessionDelegate, URLSessionTaskDelegate, URLSessionDataDelegate {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property delegate
	 * @since 0.1.0
	 */
	open weak var delegate: HttpRequestDelegate?

	/**
	 * @property headers
	 * @since 0.1.0
	 */
	open var headers: [String: String] = [:]

	/**
	 * @property timeout
	 * @since 0.1.0
	 */
	open var timeout: TimeInterval = TimeInterval(60)

	/**
	 * @property username
	 * @since 0.1.0
	 */
	open var username: String?

	/**
	 * @property password
	 * @since 0.1.0
	 */
	open var password: String?

	/**
	 * @property data
	 * @since 0.1.0
	 */
	open var data: Data?

	/**
	 * @property url
	 * @since 0.1.0
	 * @hidden
	 */
	private var url: URL

	/**
	 * @property method
	 * @since 0.1.0
	 * @hidden
	 */
	private var method: String

	/**
	 * @property sending
	 * @since 0.1.0
	 * @hidden
	 */
	private var sending: Bool = false

	/**
	 * @property response
	 * @since 0.1.0
	 * @hidden
	 */
	private var response: URLResponse?

	/**
	 * @property responseData
	 * @since 0.1.0
	 * @hidden
	 */
	private var responseData: NSMutableData!

	/**
	 * @property responseLength
	 * @since 0.1.0
	 * @hidden
	 */
	private var responseLength: Int64 = -1

	/**
	 * @property responseLoaded
	 * @since 0.1.0
	 * @hidden
	 */
	private var responseLoaded: Int64 = 0

	/**
	 * @property urlSession
	 * @since 0.1.0
	 * @hidden
	 */
	private var urlSession: URLSession?

	//--------------------------------------------------------------------------
	// MARK: Method
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	public init(url: URL, method: String) {
		self.url = url
		self.method = method
	}

	/**
	 * @method send
	 * @since 0.1.0
	 */
	open func send() {

		if (self.sending) {
			return
		}

		self.reset()

		self.sending = true

		var request = URLRequest(url: self.url)
		request.httpMethod = self.method
		request.httpShouldHandleCookies = true
		request.httpShouldUsePipelining = false
		request.allHTTPHeaderFields = self.headers
		request.timeoutInterval = self.timeout

		if let data = self.data {
			request.httpBody = data
		}

		self.urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
		self.urlSession?.dataTask(with: request).resume()
	}

	/**
	 * @method abort
	 * @since 0.1.0
	 */
	open func abort() {
		self.reset()
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - URLSession Delegate
	//--------------------------------------------------------------------------

	/**
	 * @alias URLSessionCompletionHandler
	 * @since 0.1.0
	 * @hidden
	 */
	public typealias URLSessionCompletionHandler = (URLSession.AuthChallengeDisposition, URLCredential?) -> Void

	/**
	 * @since 0.1.0
	 * @hidden
	 */
	open func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping URLSessionCompletionHandler) {

		if
			let username = self.username,
			let password = self.password,
			challenge.previousFailureCount == 0 {
			completionHandler(.useCredential, URLCredential(user: username, password: password, persistence: .none))
			return
		}

		if (challenge.previousFailureCount == 0) {
			completionHandler(.useCredential, nil)
			return
		}

		completionHandler(.cancelAuthenticationChallenge, nil)
	}

	/**
	 * @since 0.1.0
	 * @hidden
	 */
	open func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {

		self.response = response
		self.responseLength = response.expectedContentLength
		self.responseLoaded = 0

		completionHandler(.allow)
	}

	/**
	 * @since 0.1.0
	 * @hidden
	 */
	open func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive bytes: Data) {

		self.responseData.append(bytes)

		self.responseLoaded = Int64(self.responseData.length)

		self.delegate?.didProgress(
			request: self,
			loaded: self.responseLoaded,
			length: self.responseLength
		)
	}

	/**
	 * @since 0.1.0
	 * @hidden
	 */
	open func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {

		self.urlSession?.invalidateAndCancel()
		self.urlSession = nil

		self.sending = false

		guard let res = self.response as? HTTPURLResponse else {
			return
		}

		let response = HttpResponse(url: self.url)
		response.statusCode = res.statusCode
		response.statusText = res.statusText

		for (key, val) in res.allHeaderFields {
			let k = key as! String
			let v = val as! String
			response.headers[k] = v
		}

		if let data = self.responseData {
			response.data = data.string
		}

		if let error = error as NSError? {

			if (error.code == NSURLErrorTimedOut) {

				response.statusCode = 408
				response.statusText = "Request Timeout"
				self.delegate?.didTimeout(request: self, response: response)

			} else {

				response.statusCode = -1
				response.statusText = error.localizedDescription
				self.delegate?.didError(request: self, response: response)

			}

			return
		}

		self.delegate?.didComplete(request: self, response: response)
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method reset
	 * @since 0.1.0
	 */
	private func reset() {

		self.urlSession?.invalidateAndCancel()
		self.urlSession = nil

		self.response = nil
		self.responseData = NSMutableData()
		self.responseLoaded = 0
		self.responseLength = 0

		self.data = nil
	}
}
