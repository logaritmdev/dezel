/**
 * @extension UnsafePointer
 * @since 0.1.0
 * @hidden
 */
internal extension UnsafePointer where Pointee == Int8 {

	/**
	 * @property string
	 * @since 0.1.0
	 * @hidden
	 */
	var string: String {
		return String(cString: self)
	}

	/**
	 * @method string
	 * @since 0.7.0
	 * @hidden
	 */
	func string(release: Bool) -> String {

		defer {
			if (release) {
				self.deallocate()
			}
		}

		return String(cString: self)
	}
}

/**
 * @extension UnsafeMutableRawPointer
 * @since 0.1.0
 * @hidden
 */
internal extension UnsafeMutableRawPointer {

	var value: AnyObject {
		return Unmanaged<AnyObject>.fromOpaque(self).takeUnretainedValue()
	}

	init(value: AnyObject) {
    	self.init(Unmanaged.passRetained(value).toOpaque())
	}

	init (unretained: AnyObject) {
		self.init(Unmanaged.passUnretained(unretained).toOpaque())
	}

	func release() {
		Unmanaged<AnyObject>.fromOpaque(self).release()
	}
}
