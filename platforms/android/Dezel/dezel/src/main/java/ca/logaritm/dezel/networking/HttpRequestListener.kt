package ca.logaritm.dezel.networking

/**
 * @interface HttpRequestListener
 * @since 0.1.0
 * @hidden
 */
interface HttpRequestListener {
	fun onSend(request: HttpRequest, data: String)
	fun onProgress(request: HttpRequest, value: Int, total: Int)
	fun onTimeout(request: HttpRequest)
	fun onFail(request: HttpRequest, code: Int)
	fun onAbort(request: HttpRequest)
	fun onComplete(request: HttpRequest)

}