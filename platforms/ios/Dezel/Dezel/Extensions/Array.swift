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
	mutating func remove(_ object: Element) {
		if let index = self.firstIndex(of: object) {
			self.remove(at: index)
		}
	}

	/**
	 * @method shift
	 * @since 0.1.0
	 * @hidden
	 */
	mutating func shift() -> Element? {
		return self.count > 0 ? self.remove(at: 0) : nil
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
	mutating func remove(_ callback: SynchronizerCallback) {
		if let index = self.firstIndex(where: { $0 === callback }) {
			self.remove(at: index)
		}
	}
}

/**
 * @extension Array
 * @since 0.6.0
 * @hidden
 */
internal extension Array where Element == TransitionListener {

	/**
	 * @method register
	 * @since 0.6.0
	 * @hidden
	 */
	mutating func register(_ listener: TransitionListener) {
		if (self.firstIndex(where: { $0 === listener }) == nil) {
			self.append(listener)
		}
	}

	/**
	 * @method dispatchCommitEvent
	 * @since 0.6.0
	 * @hidden
	 */
	func dispatchCommitEvent() {
		self.forEach { listener in
			listener.didCommitTransition()
		}
	}

	/**
	 * @method dispatchFinishEvent
	 * @since 0.6.0
	 * @hidden
	 */
	func dispatchFinishEvent() {
		self.forEach { listener in
			listener.didFinishTransition()
		}
	}
}
