/**
 * @extension Date
 * @since 0.7.0
 * @hidden
 */
internal extension Data {

	var string: String {
		return String(data: self as Data, encoding: .utf8)!
	}

}

internal extension NSMutableData {

	var string: String {
		return String(data: self as Data, encoding: .utf8)!
	}

}


