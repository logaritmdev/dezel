/**
 * @extension JavaScriptPropertyNumberValue
 * @since 0.7.0
 * @hidden
 */
internal extension JavaScriptPropertyNumberValue {

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	convenience init(value: Double, unit: ValueUnit) {

		switch (unit) {

			case kValueUnitNone:
				self.init(value: value, unit: .none)
			case kValueUnitPX:
				self.init(value: value, unit: .px)
			case kValueUnitPC:
				self.init(value: value, unit: .pc)
			case kValueUnitVW:
				self.init(value: value, unit: .vw)
			case kValueUnitVH:
				self.init(value: value, unit: .vh)
			case kValueUnitPW:
				self.init(value: value, unit: .pw)
			case kValueUnitPH:
				self.init(value: value, unit: .ph)
			case kValueUnitCW:
				self.init(value: value, unit: .cw)
			case kValueUnitCH:
				self.init(value: value, unit: .ch)
			case kValueUnitDeg:
				self.init(value: value, unit: .deg)
			case kValueUnitRad:
				self.init(value: value, unit: .rad)

			default:
				self.init(value: value, unit: .none)
		}
	}
}
