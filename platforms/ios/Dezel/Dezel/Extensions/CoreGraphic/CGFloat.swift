/**
 * @extension CGFloat
 * @since 0.1.0
 * @hidden
 */
internal extension CGFloat {

	/**
	 * @property pi
	 * @since 0.7.0
	 * @hidden
	 */
	static var pi: CGFloat {
		return CGFloat(Double.pi)
	}

	/**
	 * @property min
	 * @since 0.1.0
	 * @hidden
	 */
	static var min: CGFloat {
		return -CGFloat.greatestFiniteMagnitude
	}

	/**
	 * @property max
	 * @since 0.1.0
	 * @hidden
	 */
	static var max: CGFloat {
		return +CGFloat.greatestFiniteMagnitude
	}
		/**
	 * @method sround
	 * @since 0.1.0
	 * @hidden
	 */
	static func sround(_ value: CGFloat) -> CGFloat {
		return UIScreen.main.scale > 1 ? (Foundation.round((value) * UIScreen.main.scale) / UIScreen.main.scale) : Foundation.round(value);
	}

	/**
	 * @method clamp
	 * @since 0.1.0
	 * @hidden
	 */
	func clamp(_ min: CGFloat, _ max: CGFloat) -> CGFloat {
		return self < min ? min : self > max ? max : self
	}

	/**
	 * @method toDeg
	 * @since 0.7.0
	 * @hidden
	 */
	func toDeg() -> CGFloat {
		return self * (180 / .pi)
	}

	/**
	 * @method rad
	 * @since 0.7.0
	 * @hidden
	 */
	func toRad() -> CGFloat {
		return self * (.pi / 180)
	}
}
