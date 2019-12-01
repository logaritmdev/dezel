package ca.logaritm.dezel.networking

/**
 * @interface HttpRequestListener
 * @since 0.7.0
 */
public interface HttpRequestListener {

	/**
	 * @method onError
	 * @since 0.7.0
	 */
	fun onError(request: HttpRequest, response: HttpResponse)

	/**
	 * @method onError
	 * @since 0.7.0
	 */
	fun onTimeout(request: HttpRequest, response: HttpResponse)


	/**
	 * @method onProgress
	 * @since 0.7.0
	 */
	fun onProgress(request: HttpRequest, loaded: Int, length: Int)

	/**
	 * @method onComplete
	 * @since 0.7.0
	 */
	fun onComplete(request: HttpRequest, response: HttpResponse)


}