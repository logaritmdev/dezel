package ca.logaritm.dezel.networking

import java.net.URL

/**
 * @class HttpResponse
 * @since 0.7.0
 */
open class HttpResponse(url: URL) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property url
	 * @since 0.7.0
	 */
	public var url: URL

	/**
	 * @property data
	 * @since 0.7.0
	 */
	public var data: String = ""

	/**
	 * @property headers
	 * @since 0.7.0
	 */
	public var headers: MutableMap<String, String> = mutableMapOf()

	/**
	 * @property statusCode
	 * @since 0.7.0
	 */
	public var statusCode: Int = 0

	/**
	 * @property statusText
	 * @since 0.7.0
	 */
	public var statusText: String = ""

	//--------------------------------------------------------------------------
	// Method
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	init {
		this.url = url
	}
}