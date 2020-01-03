/**
 * @class BackgroundColorLayer
 * @since 0.7.0
 * @hidden
 */
open class BackgroundColorLayer: Layer {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property linearGradient
	 * @since 0.7.0
	 */
	open var linearGradient: LinearGradient? {

		didSet {

			guard let gradient = self.linearGradient else {
				self.clearGradient()
				return
			}

			let pi = CGFloat(Double.pi)

			let x = (gradient.angle + pi / 2) / (2 * pi)

			let a = pow(sin((2 * pi * ((x + 0.75) / 2))), 2)
			let b = pow(sin((2 * pi * ((x + 0.00) / 2))), 2)
			let c = pow(sin((2 * pi * ((x + 0.25) / 2))), 2)
			let d = pow(sin((2 * pi * ((x + 0.50) / 2))), 2)

			self.setGradient(
				type: .axial,
				colors: gradient.colors,
				points: gradient.points,
				start: CGPoint(x: a, y: b),
				end:   CGPoint(x: c, y: d)
			)
		}
	}

	/**
	 * @property radialGradient
	 * @since 0.7.0
	 */
	open var radialGradient: RadialGradient? {
		didSet {

		}
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method setGradient
	 * @since 0.7.0
	 * @hidden
	 */
	private func setGradient(type: CAGradientLayerType, colors: [CGColor], points: [CGFloat], start: CGPoint, end: CGPoint) {
		self.type = type
		self.colors = colors
		self.locations = points as [NSNumber]
		self.startPoint = start
		self.endPoint = end
	}

	/**
	 * @method clearGradient
	 * @since 0.7.0
	 * @hidden
	 */
	private func clearGradient() {
		self.colors = nil
		self.locations = nil
	}
}
