package ca.logaritm.dezel.networking

import java.net.URL

/**
 * An HTTP request response.
 * @class HttpResponse
 * @since 0.7.0
 */
open class HttpResponse {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The response url.
	 * @property url
	 * @since 0.7.0
	 */
	public var url: URL? = null

	/**
	 * The response data.
	 * @property data
	 * @since 0.7.0
	 */
	public var data: String = ""

	/**
	 * The response headers.
	 * @property headers
	 * @since 0.7.0
	 */
	public var headers: MutableMap<String, String> = mutableMapOf()

	/**
	 * The response status code.
	 * @property statusCode
	 * @since 0.7.0
	 */
	public var statusCode: Int = 0

	/**
	 * The response status text.
	 * @property statusText
	 * @since 0.7.0
	 */
	public var statusText: String = ""

}