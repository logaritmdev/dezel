/**
* @extension CABasicAnimation
* @since 0.1.0
* @hidden
*/
internal extension CABasicAnimation {

	/**
	 * @property delay
	 * @since 0.7.0
	 */
	var delay: CFTimeInterval {

		set {
			if (newValue > 0) {
				self.beginTime = CACurrentMediaTime() + newValue
				self.fillMode = .both
			} else {
				self.beginTime = 0
			}
		}

		get {
			return self.beginTime
		}
	}

}
