/**
 * @class ImageLayer
 * @since 0.1.0
 * @hidden
 */
open class ImageLayer: Layer, TransitionListener {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property tint
	 * @since 0.1.0
	 * @hidden
	 */
	open var tint: CGColor = .clear {
		willSet {
			self.setNeedsDisplay()
		}
	}

	/**
	 * @property image
	 * @since 0.1.0
	 */
	open var image: CGImage? {
		willSet {
			self.setNeedsDisplay()
		}
	}

	/**
	 * @property imageFit
	 * @since 0.7.0
	 */
	open var imageFit: ImageFit = .contain {
		willSet {
			self.setNeedsLayout()
		}
	}

	/**
	 * @property imagePosition
	 * @since 0.7.0
	 */
	open var imagePosition: ImagePosition = .middleCenter {
		willSet {
			self.setNeedsLayout()
		}
	}

	/**
	 * @property contentLayer
	 * @since 0.7.0
	 * @hidden
	 */
	private var contentLayer: Layer = Layer()

	/**
	 * @property contourLayer
	 * @since 0.7.0
	 * @hidden
	 */
	private var contourLayer: Layer = Layer()

	//----------------------------------------------------------------------
	// MARK: Methods
	//----------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	required public init?(coder:NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	public required init() {

		super.init()

		self.masksToBounds = true
		self.contentLayer.listener = self
		self.contourLayer.listener = self

		self.needsDisplayOnBoundsChange = true

		self.addSublayer(self.contentLayer)
	}
	/**
	 * @constructor
	 * @since 0.1.0
	 */
	public override init(layer: Any) {
		super.init(layer: layer)
	}

	/**
	 * @method layoutSublayers
	 * @since 0.1.0
	 * @hidden
	 */
	open override func layoutSublayers() {

		guard let image = self.image else {
			return
		}

		var imageW = CGFloat(0.0)
		var imageH = CGFloat(0.0)
		var imageT = CGFloat(0.0)
		var imageL = CGFloat(0.0)

		let naturalImageW = CGFloat(image.width)
		let naturalImageH = CGFloat(image.height)

		let frameW = self.bounds.width
		let frameH = self.bounds.height
		let scaleX = frameW / naturalImageW
		let scaleY = frameH / naturalImageH

		switch (self.imageFit) {

			case .cover:
				let scale = max(scaleX, scaleY)
				imageW = naturalImageW * scale
				imageH = naturalImageH * scale

			case .contain:
				let scale = min(scaleX, scaleY)
				imageW = naturalImageW * scale
				imageH = naturalImageH * scale
		}

		switch (self.imagePosition) {

			case .topLeft:
				imageT = 0
				imageL = 0

			case .topRight:
				imageT = 0
				imageL = frameW - imageW

			case .topCenter:
				imageT = 0
				imageL = frameW / 2 - imageW / 2

			case .middleLeft:
				imageT = frameH / 2 - imageH / 2
				imageL = 0

			case .middleRight:
				imageT = frameH / 2 - imageH / 2
				imageL = frameW - imageW

			case .middleCenter:
				imageT = frameH / 2 - imageH / 2
				imageL = frameW / 2 - imageW / 2

			case .bottomLeft:
				imageT = frameH - imageH
				imageL = 0

			case .bottomRight:
				imageT = frameH - imageH
				imageL = frameW - imageW

			case .bottomCenter:
				imageT = frameH - imageH
				imageL = frameW / 2 - imageW / 2
		}

		let frame = CGRect(
			x: imageL,
			y: imageT,
			width: imageW,
			height: imageH
		)

		self.contentLayer.frame = frame
		self.contourLayer.frame = frame
	}

	/**
	 * @method display
	 * @since 0.1.0
	 * @hidden
	 */
	override open func display() {

		self.contentLayer.contents = nil
		self.contourLayer.contents = nil

		self.maskColor = nil
		self.maskShape = nil

		guard let image = self.image else {
			return
		}

		if (self.tint.alpha == 0) {

			self.contentLayer.contents = image

		} else {

			self.contourLayer.contents = image

			self.maskColor = self.tint
			self.maskShape = self.contourLayer
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Animations Protocol
	//--------------------------------------------------------------------------

	/**
	 * @method shouldBeginTransitionAnimation
	 * @since 0.2.0
	 */
	open func shouldBeginTransitionAnimation(animation: CABasicAnimation, for property: String, of layer: CALayer) -> Bool {

		if (property == "bounds" ||
			property == "position") {
			return (self.listener as? ImageView)?.hasFrame ?? true
		}

		return true
	}

	/**
	 * @method willBeginTransitionAnimation
	 * @since 0.2.0
	 */
	open func willBeginTransitionAnimation(animation: CABasicAnimation, for property: String, of layer: CALayer) {

	}

	/**
	 * @method didCommitTransition
	 * @since 0.6.0
	 */
	open func didCommitTransition() {

	}

	/**
	 * @method didFinishTransition
	 * @since 0.2.0
	 */
	open func didFinishTransition() {

	}
}
