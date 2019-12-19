/**
 * @extension CADisplayLink
 * @since 0.7.0
 */
internal extension CADisplayLink {

	/**
	 * @method setup
	 * @since 0.7.0
	 * @hidden
	 */
	func setup() {
		self.add(to: .main, forMode: .common)
	}
}
