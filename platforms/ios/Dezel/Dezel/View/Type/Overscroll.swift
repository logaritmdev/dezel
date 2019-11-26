/**
 * @enum Overscroll
 * @since 0.2.0
 */
public enum Overscroll {

	case auto
	case never
	case always
	case alwaysX
	case alwaysY

	/**
	 * @method get
	 * @since 0.2.0
	 */
	public static func get(_ value: JavaScriptProperty) -> Overscroll {

		switch (value.type) {

			case .number:
				return self.get(value: value.number)
			case .string:
				return self.get(value: value.string)
			case .boolean:
				return self.get(value: value.boolean)

			default:
				return .auto
		}
	}

	/**
	 * @method get
	 * @since 0.2.0
	 */
	public static func get(value: String) -> Overscroll {

		switch (value) {

			case "auto":
				return .auto
			case "never":
				return .never
			case "always":
				return .always
			case "always-x":
				return .alwaysX
			case "always-y":
				return .alwaysY

			default:
				return .auto
		}
	}

	/**
	 * @method get
	 * @since 0.2.0
	 */
	public static func get(value: Double) -> Overscroll {
		return value == 0.0 ? .never : .auto
	}

	/**
	 * @method get
	 * @since 0.2.0
	 */
	public static func get(value: Bool) -> Overscroll {
		return value == true ? .auto : .never
	}
}
