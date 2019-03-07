/**
 * @extension Array
 * @since 0.1.0
 */
internal extension Array where Element: Equatable {

	/**
	 * @method remove
	 * @since 0.1.0
	 * @hidden
	 */
	mutating internal func remove(_ object: Element) {
		if let index = self.index(of: object) {
			self.remove(at: index)
		}
	}

	/**
	 * @method shift
	 * @since 0.1.0
	 * @hidden
	 */
	mutating internal func shift() -> Element? {
		return self.count > 0 ? self.remove(at: 0) : nil
	}

	/**
	 * @method pop
	 * @since 0.1.0
	 * @hidden
	 */
	mutating internal func pop() -> Element?  {
		return self.popLast()
	}
}

/**
 * @extension Array
 * @since 0.1.0
 */
internal extension Array where Element == UpdateDisplayCallback {
	/**
	 * @method remove
	 * @since 0.1.0
	 * @hidden
	 */
	mutating internal func remove(_ callback: UpdateDisplayCallback) {
		if let index = self.index(where: { $0 === callback }) {
			self.remove(at: index)
		}
	}
}
