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
			self.beginTime = CACurrentMediaTime() + newValue
			self.fillMode = CAMediaTimingFillMode.both
		}

		get {
			return self.beginTime
		}
	}

}
