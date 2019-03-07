/**
 * The scrollable view's overscroll options.
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
	 * Parses the overscroll type from a property.
	 * @method get
	 * @since 0.2.0
	 */
	public static func get(_ value: Property) -> Overscroll {

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
	 * Parses the overscroll type from a string.
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
	 * Parses the overscroll type from a number.
	 * @method get
	 * @since 0.2.0
	 */
	public static func get(value: Double) -> Overscroll {
		return value == 0.0 ? .never : .auto
	}

	/**
	 * Parses the overscroll type from a boolean.
	 * @method get
	 * @since 0.2.0
	 */
	public static func get(value: Bool) -> Overscroll {
		return value == true ? .auto : .never
	}
}
