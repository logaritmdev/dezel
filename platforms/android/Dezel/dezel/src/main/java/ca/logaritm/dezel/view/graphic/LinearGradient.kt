package ca.logaritm.dezel.view.graphic

import ca.logaritm.dezel.extension.toDeg
import ca.logaritm.dezel.string.Scanner

/**
 * @class LinearGradient
 * @since 0.1.0
 * @hidden
 */
open class LinearGradient(value: String) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The gradient's color.
	 * @property colors
	 * @since 0.1.0
	 */
	public var colors: MutableList<Int> = mutableListOf()
		private set

	/**
	 * The gradient's color locations.
	 * @property points
	 * @since 0.1.0
	 */
	public var points: MutableList<Float> = mutableListOf()
		private set

	/**
	 * The gradient's angle.
	 * @property angle
	 * @since 0.1.0
	 */
	public var angle: Float = 0f
		private set

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	init {
		this.parse(value)
	}

	/**
	 * Parses the linear gradient string.
	 * @method parse
	 * @since 0.1.0
	 */
	open fun parse(value: String) {

		val scanner = Scanner(value)
		scanner.scan("linear-gradient(")

		this.scanAngle(scanner)

		if (scanner.scan(",") == null) {
			return
		}

		while (scanner.isAtEnd == false) {
			this.scanColor(scanner)
			this.scanComma(scanner)
		}

		val required = 2 - this.colors.size
		if (required > 0) {
			for (i in 0 until required) {
				this.colors.add(Color.BLACK)
				this.points.add(1f)
			}
		}
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method scanAngle
	 * @since 0.4.0
	 * @hidden
	 */
	private fun scanAngle(scanner: Scanner) {

		var angle = scanner.scanDouble()
		if (angle == null) {
			angle = 0.0
		}

		var unit: String? = null
		if (unit == null) unit = scanner.scan("rad")
		if (unit == null) unit = scanner.scan("deg")

		if (unit == "deg") {
			this.angle = angle.toFloat().toDeg()
		} else {
			this.angle = angle.toFloat()
		}

		this.angle -= Math.PI.toFloat() / 2
	}

	/**
	 * @method scanColor
	 * @since 0.4.0
	 * @hidden
	 */
	private fun scanColor(scanner: Scanner) {

		val color = when (true) {
			scanner.hasNext("#")    -> Color.scanHexString(scanner)
			scanner.hasNext("rgba") -> Color.scanRGBAString(scanner)
			scanner.hasNext("rgb")  -> Color.scanRGBString(scanner)
			else                    -> Color.scanName(scanner)
		}

		var point = scanner.scanFloat()
		if (point == null) {
			return
		}

		if (scanner.scan("%") != null) {
			point /= 100
		}

		this.points.add(point)
		this.colors.add(color)
	}

	/**
	 * @method scanComma
	 * @since 0.4.0
	 * @hidden
	 */
	private fun scanComma(scanner: Scanner) {
		scanner.scan(arrayOf(',', ')'))
	}
}
