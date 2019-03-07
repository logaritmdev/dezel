/**
 * @class LinearGradient
 * @since 0.1.0
 * @hidden
 */
public class LinearGradient: NSObject {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The gradient's color.
	 * @property colors
	 * @since 0.1.0
	 */
	private(set) public var colors: [CGColor] = []

	/**
	 * The gradient's color locations.
	 * @property points
	 * @since 0.1.0
	 */
	private(set) public var points: [CGFloat] = []

	/**
	 * The gradient's angle.
	 * @property angle
	 * @since 0.1.0
	 */
	private(set) public var angle: CGFloat = 0

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	public convenience init(value: String) {

		self.init()

		let scanner = Scanner(string: value)
		scanner.charactersToBeSkipped = CharacterSet(charactersIn: " ")
		scanner.scanString("linear-gradient(", into: nil)

		self.scanAngle(scanner)

		if (scanner.scanString(",", into: nil) == false) {
			return
		}

		while scanner.isAtEnd == false {
			self.scanColor(scanner)
			self.scanComma(scanner)
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method scanAngle
	 * @since 0.4.0
	 * @hidden
	 */
	private func scanAngle(_ scanner: Scanner) {

		var angle = 0.0

		scanner.scanDouble(&angle)

		var unit: String?
		if (unit == nil) { unit = scanner.scanString("rad") }
		if (unit == nil) { unit = scanner.scanString("deg") }

		if (unit == "deg") {
			self.angle = CGFloat(angle).deg()
		} else {
			self.angle = CGFloat(angle)
		}

		self.angle -= CGFloat.pi / 2
	}

	/**
	 * @method scanAngle
	 * @since 0.4.0
	 * @hidden
	 */
	private func scanColor(_ scanner: Scanner) {

		let color: CGColor

		switch (true) {

			case scanner.hasNext(string: "#"):
				color = CGColorScanHexString(scanner)
			case scanner.hasNext(string: "rgba"):
				color = CGColorScanRGBAString(scanner)
			case scanner.hasNext(string: "rgb"):
				color = CGColorScanRGBString(scanner)

			default:
				color = CGColorScanName(scanner)
		}

		guard var point = scanner.scanCGFloat() else {
			return
		}

		if scanner.scanString("%", into: nil) {
			point = point / 100
		}

		self.points.append(point)
		self.colors.append(color)
	}

	/**
	 * @method scanComma
	 * @since 0.4.0
	 * @hidden
	 */
	private func scanComma(_ scanner: Scanner) {
		scanner.scanCharacters(from: CharacterSet(charactersIn: ",)"), into: nil)
	}
}
