/**
 * The unit of the property.
 * @enum PropertyUnit
 * @since 0.1.0
 */
public enum PropertyUnit: Int {

	case none = 0
	case px = 1
	case pc = 2
	case vw = 3
	case vh = 4
	case pw = 5
	case ph = 6
	case cw = 7
	case ch = 8
	case deg = 9
	case rad = 10

	public func isRelativeToParent() -> Bool {
		return (
			self == .pc ||
			self == .pw ||
			self == .ph ||
			self == .cw ||
			self == .ch
		)
	}

	public func isRelativeToWindow() -> Bool {
		return (
			self == .vw ||
			self == .vh
		)
	}

	public static func of(_ value: Int) -> PropertyUnit {

		switch (value) {
			case 0: return .none
			case 1: return .px
			case 2: return .pc
			case 3: return .vw
			case 4: return .vh
			case 5: return .pw
			case 6: return .ph
			case 7: return .cw
			case 8: return .ch
			case 9: return .deg
			case 10: return .rad
			default: break
		}

		return .none
	}

	public static func of(_ value: UInt32) -> PropertyUnit {
		return self.of(Int(value))
	}

	public static func of(_ value: UInt64) -> PropertyUnit {
		return self.of(Int(value))
	}
}
