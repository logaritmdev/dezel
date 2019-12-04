/**
 * @class ImageLayer
 * @since 0.1.0
 * @hidden
 */
open class ImageLayer: Layer, TransitionListener {

	//--------------------------------------------------------------------------
	// MARK: Class Methods
	//--------------------------------------------------------------------------

	/**
	 * @method needsDisplay
	 * @since 0.1.0
	 * @hidden
	 */
	override open class func needsDisplay(forKey key: String) -> Bool {

		if (key == "color") {
			return true
		}

		return super.needsDisplay(forKey: key)
	}

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property color
	 * @since 0.1.0
	 * @hidden
	 */
	@NSManaged public var tint: CGColor

	/**
	 * @property frame
	 * @since 0.1.0
	 */
	override open var frame: CGRect {
		didSet {
			self.shape.frame = self.bounds
		}
	}

	/**
	 * @property image
	 * @since 0.1.0
	 */
	open var image: CGImage? {
		didSet {
			self.filteredImage = nil
			self.setNeedsDisplay()
		}
	}

	/**
	 * @property filter
	 * @since 0.5.0
	 */
	open var filter: ImageFilter = .none {
		didSet {
			self.filteredImage = nil
			self.setNeedsDisplay()
		}
	}

	/**
	 * @property shape
	 * @since 0.1.0
	 * @hidden
	 */
	private var shape: ShapeLayer = ShapeLayer()

	/**
	 * @property filteredImage
	 * @since 0.5.0
	 * @hidden
	 */
	private var filteredImage: CGImage?

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
		self.tint = .clear
		self.shape.listener = self
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	public override init(layer: Any) {

		super.init(layer: layer)

		if let layer = layer as? ImageLayer {
			self.tint = layer.tint
		}
	}

	/**
	 * @method display
	 * @since 0.1.0
	 * @hidden
	 */
	override open func display() {

		self.mask = nil
		self.contents = nil
		self.backgroundColor = nil

		guard var image = self.image else {
			return
		}

		if (self.filter != .none) {

			if (self.filteredImage == nil) {
				self.filteredImage = self.createFilteredImage(image, filter: self.filter)
			}

			if let filtered = self.filteredImage {
				image = filtered
			}
		}

		let tint: CGColor

		if let presentationLayer = self.presentation() {
			tint = presentationLayer.tint
		} else {
			tint = self.tint
		}

		if (tint.alpha > 0) {
			self.backgroundColor = tint
			self.shape.contents = image
			self.mask = self.shape
		} else {
			self.contents = image
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Animations
	//--------------------------------------------------------------------------

	/**
	 * @method action
	 * @since 0.1.0
	 * @hidden
	 */
	override open func action(forKey key: String) -> CAAction? {

		if let transition = Transition.current {

			var current = self.presentation()
			if (current == nil || self.animation(forKey: key) == nil) {
				current = self
			}

			let animation = CABasicAnimation(keyPath: key)

			switch (key) {

				case "color":
					animation.fromValue = current!.tint

				default:
					break
			}

			if (animation.fromValue != nil) {

				if (transition.delay > 0) {
					animation.beginTime = CACurrentMediaTime() + transition.delay
					animation.fillMode = CAMediaTimingFillMode.both
				}

				if let listener = self.listener as? TransitionListener {
					if (listener.shouldBeginTransitionAnimation(animation: animation, for: key, of: self)) {
						listener.willBeginTransitionAnimation(animation: animation, for: key, of: self)
						transition.register(listener)
					} else {
						return NSNull()
					}
				}

				return animation
			}
		}

		return super.action(forKey: key)
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

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method createFilteredImage
	 * @since 0.5.0
	 * @hidden
	 */
	private func createFilteredImage(_ source: CGImage, filter: ImageFilter) -> CGImage? {

		switch (filter) {

			case .grayscale:
				return ImageEffect.grayscale(source)

			default:
				break
		}

		return nil
	}
}
