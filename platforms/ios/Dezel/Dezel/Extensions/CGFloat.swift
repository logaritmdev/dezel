/**
 * @extension CGFloat
 * @since 0.1.0
 * @hidden
 */
internal extension CGFloat {

	/**
	 * @property min
	 * @since 0.1.0
	 * @hidden
	 */
	static internal var min: CGFloat {
		return -CGFloat.greatestFiniteMagnitude
	}

	/**
	 * @property max
	 * @since 0.1.0
	 * @hidden
	 */
	static internal var max: CGFloat {
		return +CGFloat.greatestFiniteMagnitude
	}
		/**
	 * @method sround
	 * @since 0.1.0
	 * @hidden
	 */
	static internal func sround(_ value: CGFloat) -> CGFloat {
		return UIScreen.main.scale > 1 ? (Foundation.round((value) * UIScreen.main.scale) / UIScreen.main.scale) : Foundation.round(value);
	}

	/**
	 * @method clamp
	 * @since 0.1.0
	 * @hidden
	 */
	internal func clamp(_ min: CGFloat, _ max: CGFloat) -> CGFloat {
		return self < min ? min : self > max ? max : self
	}

	/**
	 * @method clamp
	 * @since 0.1.0
	 * @hidden
	 */
	internal func deg() -> CGFloat {
		return self * CGFloat(Double.pi) / 180
	}

	/**
	 * @method clamp
	 * @since 0.1.0
	 * @hidden
	 */
	internal func rad() -> CGFloat {
		return self / CGFloat(Double.pi) * 180
	}

	/**
	 * @method alignCenter
	 * @since 0.5.0
	 * @hidden
	 */
	internal func alignCenter(_ value: CGFloat) -> CGFloat {
		return self / 2 - value / 2
	}

	/**
	 * @method alignRight
	 * @since 0.5.0
	 * @hidden
	 */
	internal func alignRight(_ value: CGFloat) -> CGFloat {
		return self - value
	}
}
