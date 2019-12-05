/**
 * @class LinearGradient
 * @since 0.1.0
 */
public class LinearGradient {

	//--------------------------------------------------------------------------
	// MARK: Static
	//--------------------------------------------------------------------------

	/**
	 * @method extractAngle
	 * @since 0.7.0
	 * @hidden
	 */
	private static func extractAngle(_ value: JavaScriptPropertyValue, angle: inout CGFloat) {

		switch (value.unit) {

			case .deg: angle = CGFloat(-value.number).toRad()
			case .rad: angle = CGFloat(-value.number)

			default:
				angle = 0
		}

		angle -= .pi / 2
	}

	/**
	 * @method extractColor
	 * @since 0.7.0
	 * @hidden
	 */
	private static func extractColor(_ value: JavaScriptPropertyValue, color: inout CGColor, point: inout CGFloat) {

		guard let composite = value as? JavaScriptPropertyCompositeValue else {
			return
		}

		let c = composite.values[0]
		var p = composite.values[1].number

		if (composite.values[1].unit == .pc) {
			p = p / 100
		}

		color = UIColor(color: c).cgColor
		point = CGFloat(p)
	}

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property colors
	 * @since 0.1.0
	 */
	private(set) public var colors: [CGColor]

	/**
	 * @property points
	 * @since 0.1.0
	 */
	private(set) public var points: [CGFloat]

	/**
	 * @property angle
	 * @since 0.1.0
	 */
	private(set) public var angle: CGFloat

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	public init(colors: [CGColor], points: [CGFloat], angle: CGFloat) {
		self.colors = colors
		self.points = points
		self.angle = angle
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	public convenience init(property: JavaScriptProperty) {

		var colors: [CGColor] = []
		var points: [CGFloat] = []
		var angle: CGFloat = 0

		guard let function = property.function, function.arguments.count >= 3 else {

			self.init(
				colors: colors,
				points: points,
				angle: angle
			)

			return
		}

		for (i, argument) in function.arguments.enumerated() {

			if (i == 0) {

				LinearGradient.extractAngle(argument, angle: &angle)

			} else {

				var color: CGColor = .black
				var point: CGFloat = 0

				LinearGradient.extractColor(argument, color: &color, point: &point)

				colors.append(color)
				points.append(point)
			}
		}

		self.init(
			colors: colors,
			points: points,
			angle: angle
		)
	}
}
