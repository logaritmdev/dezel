package ca.logaritm.dezel.networking

/**
 * The HTTP request listener.
 * @class HttpRequestListener
 * @since 0.7.0
 */
public interface HttpRequestListener {

	/**
	 * Called when an error occurs with the request.
	 * @method onError
	 * @since 0.7.0
	 */
	fun onError(request: HttpRequest, response: HttpResponse)

	/**
	 * Called when a timeout occurs with the request.
	 * @method onError
	 * @since 0.7.0
	 */
	fun onTimeout(request: HttpRequest, response: HttpResponse)


	/**
	 * Called when the request progresses.
	 * @method onProgress
	 * @since 0.7.0
	 */
	fun onProgress(request: HttpRequest, loaded: Int, length: Int)

	/**
	 * Called when the request finishes.
	 * @method onComplete
	 * @since 0.7.0
	 */
	fun onComplete(request: HttpRequest, response: HttpResponse)


}