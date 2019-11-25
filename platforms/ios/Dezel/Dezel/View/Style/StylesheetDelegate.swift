/**
 * @protocol StylesheetDelegate
 * @since 0.7.0
 */
public protocol StylesheetDelegate: AnyObject {

	/**
	 * @method didThrowError
	 * @since 0.7.0
	 */
	func didThrowError(stylesheet: Stylesheet, error: String, col: Int, row: Int, url: String)

}
