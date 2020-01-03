/**
 * @extension Array
 * @since 0.1.0
 * @hidden
 */
internal extension Array where Element: Equatable {

	/**
	 * @method remove
	 * @since 0.1.0
	 * @hidden
	 */
	mutating func remove(_ value: Element) {
		if let index = self.firstIndex(of: value) {
			self.remove(at: index)
		}
	}

	/**
	 * @method pop
	 * @since 0.1.0
	 * @hidden
	 */
	mutating func pop() -> Element?  {
		return self.popLast()
	}
}

/**
 * @extension Array
 * @since 0.1.0
 * @hidden
 */
internal extension Array where Element == SynchronizerCallback {

	/**
	 * @method remove
	 * @since 0.1.0
	 * @hidden
	 */
	mutating func remove(_ value: SynchronizerCallback) {
		if let index = self.firstIndex(where: { $0 === value }) {
			self.remove(at: index)
		}
	}
}

/**
 * @extension Array
 * @since 0.6.0
 * @hidden
 */
internal extension Array where Element == CALayer {

	/**
	 * @method add
	 * @since 0.7.0
	 * @hidden
	 */
	mutating func add(_ layer: CALayer) {
		if (self.contains(layer) == false) {
			self.append(layer)
		}
	}
}
