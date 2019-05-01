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
	 * @hidden
	 */
	open weak var delegate: HttpRequestDelegate?

	/**
	 * @property headers
	 * @since 0.1.0
	 * @hidden
	 */
	open var headers: [String: String] = [:] {
		didSet {
			self.requestHeaders = headers
		}
	}

	/**
	 * @property timeout
	 * @since 0.1.0
	 * @hidden
	 */
	open var timeout: Double = 60 {
		didSet {
			self.requestTimeout = TimeInterval(timeout)
		}
	}

	/**
	 * @property username
	 * @since 0.1.0
	 * @hidden
	 */
	open var username: String?

	/**
	 * @property password
	 * @since 0.1.0
	 * @hidden
	 */
	open var password: String?

	/**
	 * @property url
	 * @since 0.1.0
	 * @hidden
	 */
	private(set) public var url: URL?

	/**
	 * @property urlSession
	 * @since 0.1.0
	 * @hidden
	 */
	private var urlSession: URLSession?

	/**
	 * @property requestUrl
	 * @since 0.1.0
	 * @hidden
	 */
	private var requestUrl: String

	/**
	 * @property requestMethod
	 * @since 0.1.0
	 * @hidden
	 */
	private var requestMethod: String

	/**
	 * @property requestHeaders
	 * @since 0.1.0
	 * @hidden
	 */
	private var requestHeaders: [String: String] = [:]

	/**
	 * @property requestTimeout
	 * @since 0.1.0
	 * @hidden
	 */
	private var requestTimeout: TimeInterval = 0

	/**
	 * @property response
	 * @since 0.1.0
	 * @hidden
	 */
	private var response: URLResponse?

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
	 * @property data
	 * @since 0.1.0
	 * @hidden
	 */
	private var data: NSMutableData?

	//--------------------------------------------------------------------------
	// MARK: Method
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	public init(url: String, method: String) {
		self.requestUrl = url
		self.requestMethod = method
	}

	/**
	 * @method send
	 * @since 0.1.0
	 */
	open func send(data: Data?) {

		guard let url = URL(string: self.requestUrl) else {
			return
		}

		self.reset()

		self.url = url

		var request = URLRequest(url: url)
		request.timeoutInterval = self.requestTimeout
		request.allHTTPHeaderFields = self.requestHeaders
		request.httpShouldHandleCookies = true
		request.httpShouldUsePipelining = false
		request.httpMethod = self.requestMethod

		if let data = data {
			request.httpBody = data
		}

		self.urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
		self.urlSession?.dataTask(with: request).resume()

		self.delegate?.didSend(request: self, data: data)
	}

	/**
	 * @method abort
	 * @since 0.1.0
	 */
	open func abort() {

		if (self.urlSession == nil) {
			return
		}

		self.reset()

		self.delegate?.didAbort(request: self)
	}

	/**
	 * @method reset
	 * @since 0.1.0
	 */
	private func reset() {

		self.urlSession?.invalidateAndCancel()
		self.urlSession = nil

		self.response = nil
		self.responseLoaded = 0
		self.responseLength = 0

		self.data = nil
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

		if let username = self.username, let password = self.password, challenge.previousFailureCount == 0 {
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

		self.data = NSMutableData()

		completionHandler(.allow)
	}

	/**
	 * @since 0.1.0
	 * @hidden
	 */
	open func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive bytes: Data) {

		guard let data = self.data else {
			return
		}

		data.append(bytes)

		self.responseLoaded = Int64(data.length)

		self.delegate?.didProgress(request: self, value: self.responseLoaded, total: self.responseLength)
	}

	/**
	 * @since 0.1.0
	 * @hidden
	 */
	open func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {

		self.urlSession?.invalidateAndCancel()
		self.urlSession = nil

		if let error = error as NSError? {

			if (error.code == NSURLErrorTimedOut) {
				self.delegate?.didTimeout(request: self, error: error)
				return
			}

			self.delegate?.didFail(request: self, error: error)
			return
		}

		if let response = self.response, let data = self.data {
			self.delegate?.didComplete(request: self, response: response, data: data as Data)
		}
	}
}
