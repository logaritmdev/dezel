/**
 * @protocol HttpRequestDelegate
 * @since 0.1.0
 */
public protocol HttpRequestDelegate: AnyObject {
	func didSend(request: HttpRequest, data: Data?)
	func didProgress(request: HttpRequest, value: Int64, total: Int64)
	func didTimeout(request: HttpRequest, error: Error)
	func didFail(request: HttpRequest, error: Error)
	func didAbort(request: HttpRequest)
	func didComplete(request: HttpRequest, response: URLResponse, data: Data)
}
