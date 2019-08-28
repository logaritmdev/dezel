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
	 * @property string
	 * @since 0.6.0
	 * @hidden
	 */
	var strdup: String { // TODO THIS IS A REALLY BAD NAME because it deallocates the raw point

		defer {
			self.deallocate()
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
