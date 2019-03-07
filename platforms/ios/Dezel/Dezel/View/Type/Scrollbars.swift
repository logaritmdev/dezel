/**
 * The scrollable view's scrollbars options.
 * @enum Scrollbars
 * @since 0.2.0
 */
public enum Scrollbars {

	case none
	case both
	case vertical
	case horizontal

	/**
	 * Parses the scrollbars type from a property.
	 * @method get
	 * @since 0.2.0
	 */
	public static func get(_ value: Property) -> Scrollbars {

		switch (value.type) {

			case .number:
				return self.get(value: value.number)
			case .string:
				return self.get(value: value.string)
			case .boolean:
				return self.get(value: value.boolean)

			default:
				return .none
		}
	}

	/**
	 * Parses the scrollbars type from a string.
	 * @method get
	 * @since 0.2.0
	 */
	public static func get(value: String) -> Scrollbars {

		switch (value) {

			case "none":
				return .none
			case "both":
				return .both
			case "vertical":
				return .vertical
			case "horizontal":
				return .horizontal

			default:
				return .none
		}
	}

	/**
	 * Parses the scrollbars type from a number.
	 * @method get
	 * @since 0.2.0
	 */
	public static func get(value: Double) -> Scrollbars {
		return value == 0.0 ? .none : .both
	}

	/**
	 * Parses the scrollbars type from a boolean.
	 * @method get
	 * @since 0.2.0
	 */
	public static func get(value: Bool) -> Scrollbars {
		return value == true ? .both : .none
	}
}
