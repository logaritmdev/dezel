/**
 * @extension NSData
 * @since 0.7.0
 * @hidden
 */
internal extension NSData {

	/**
	 * @property string
	 * @since 0.7.0
	 * @hidden
	 */
	var string: String {
		return String(data: self as Data, encoding: .utf8)!
	}
}
