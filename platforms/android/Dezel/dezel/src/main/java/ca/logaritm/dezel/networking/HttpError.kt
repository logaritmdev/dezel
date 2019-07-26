package ca.logaritm.dezel.networking

/**
 * @class HttpResponse
 * @since 0.7.0
 * @hidden
 */
open class HttpError(code: Int, message: String): HttpResponse() {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property code
	 * @since 0.7.0
	 * @hidden
	 */
	public var code: Int

	/**
	 * @property message
	 * @since 0.7.0
	 * @hidden
	 */
	public var message: String

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	init {
		this.code = code
		this.message = message
	}
}