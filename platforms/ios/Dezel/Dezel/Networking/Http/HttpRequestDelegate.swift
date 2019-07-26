/**
 * @protocol HttpRequestDelegate
 * @since 0.1.0
 */
public protocol HttpRequestDelegate: AnyObject {
	func didError(request: HttpRequest, response: HttpResponse)
	func didTimeout(request: HttpRequest, response: HttpResponse)
	func didProgress(request: HttpRequest, loaded: Int64, length: Int64)
	func didComplete(request: HttpRequest, response: HttpResponse)
}
