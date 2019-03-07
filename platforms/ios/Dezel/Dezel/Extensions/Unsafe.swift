/**
 * @extension UnsafePointer
 * @since 0.1.0
 * @hidden
 */
public extension UnsafePointer where Pointee == Int8 {
	public var string: String {
		return String(cString: self)
	}
}

/**
 * @extension UnsafeMutableRawPointer
 * @since 0.1.0
 * @hidden
 */
public extension UnsafeMutableRawPointer {

	public var value: AnyObject {
		return Unmanaged<AnyObject>.fromOpaque(self).takeUnretainedValue()
	}

	public init(value: AnyObject) {
    	self.init(Unmanaged.passRetained(value).toOpaque())
	}

	public init (unretained: AnyObject) {
		self.init(Unmanaged.passUnretained(unretained).toOpaque())
	}

	public func release() {
		Unmanaged<AnyObject>.fromOpaque(self).release()
	}
}
