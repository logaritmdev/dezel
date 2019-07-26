/**
 * @extension NSMutableData
 * @since 0.7.0
 * @hidden
 */
internal extension NSMutableData {

	/**
	 * @property string
	 * @since 0.7.0
	 * @hidden
	 */
	var string: String {
		return String(data: self as Data, encoding: .utf8)!
	}
}
