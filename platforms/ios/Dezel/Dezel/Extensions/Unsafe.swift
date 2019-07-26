/**
 * @extension UnsafePointer
 * @since 0.1.0
 * @hidden
 */
public extension UnsafePointer where Pointee == Int8 {

	var string: String {
		return String(cString: self)
	}

	var strdup: String { // TODO THIS IS A REALLY BAD NAME

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
public extension UnsafeMutableRawPointer {

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
