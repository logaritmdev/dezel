/**
 * @class HttpResponse
 * @since 0.7.0
 */
open class HttpResponse {

	//--------------------------------------------------------------------------
	// MARK: Properties
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
	public var headers: [String: String] = [:]

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
	// MARK: Method
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public init(url: URL) {
		self.url = url
	}
}
