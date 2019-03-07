/**
 * @class ContentImageView
 * @since 0.1.0
 * @hidden
 */
open class ContentImageView: UIView, Updatable, Clippable, TransitionListener {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @property frame
	 * @since 0.2.0
	 */
	override open var frame: CGRect {
		willSet {
			self.imageLayerInvalidFrame = true
		}
	}

	/**
	 * @property clipsToBounds
	 * @since 0.1.0
	 * @hidden
	 */
	override open var clipsToBounds: Bool {
		set { }
		get { return true }
	}

	/**
	 * The image view's image.
	 * @property image
	 * @since 0.1.0
	 */
	open var image: UIImage? {
		willSet {
			self.imageLayer.image = newValue?.cgImage
		}
	}

	/**
	 * The image view's image top position.
	 * @property imageTop
	 * @since 0.1.0
	 */
	open var imageTop: CGFloat = 0 {
		willSet {
			self.imageLayerInvalidFrame = true
		}
	}

	/**
	 * The image view's image left position.
	 * @property imageLeft
	 * @since 0.1.0
	 */
	open var imageLeft: CGFloat = 0 {
		willSet {
			self.imageLayerInvalidFrame = true
		}
	}

	/**
	 * The image view's image width.
	 * @property imageWidth
	 * @since 0.1.0
	 */
	open var imageWidth: CGFloat = 0 {
		willSet {
			self.imageLayerInvalidFrame = true
		}
	}

	/**
	 * The image view's image height.
	 * @property imageHeight
	 * @since 0.1.0
	 */
	open var imageHeight: CGFloat = 0 {
		willSet {
			self.imageLayerInvalidFrame = true
		}
	}

	/**
	 * The image view's image filter.
	 * @property imageFilter
	 * @since 0.5.0
	 */
	open var imageFilter: ImageFilter = .none {
		willSet {
			self.imageLayer.filter = newValue
		}
	}

	/**
	 * The image view's image tint.
	 * @property imageTint
	 * @since 0.1.0
	 */
	open var imageTint: CGColor = .transparent {
		willSet {
			self.imageLayer.color = newValue
		}
	}

	/**
	 * Indicates whether this view has a valid frame.
	 * @property hasFrame
	 * @since 0.2.0
	 */
	open var hasFrame: Bool = false

	/**
	 * @property imageLayer
	 * @since 0.1.0
	 * @hidden
	 */
	private var imageLayer: ImageLayer = ImageLayer()

	/**
	 * @property imageLayerInvalidFrame
	 * @since 0.2.0
	 * @hidden
	 */
	private var imageLayerInvalidFrame: Bool = false

	//----------------------------------------------------------------------
	// MARK: Methods
	//----------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	public override init(frame: CGRect) {

		super.init(frame: frame)

		self.layer.masksToBounds = true
		self.layer.contentsScale = UIScreen.main.scale
		self.layer.rasterizationScale = UIScreen.main.scale

		self.imageLayer.frame = frame
		self.imageLayer.listener = self
		
		self.layer.addSublayer(self.imageLayer)
	}

	/**
	 * @inherited
	 * @method update
	 * @since 0.2.0
	 */
	open func update() {
		if (self.imageLayerInvalidFrame) {
			self.imageLayerInvalidFrame = false
			self.updateImageLayerFrame()
		}
	}

	/**
	 * Updates the image layer frame.
	 * @method updateImageLayerFrame
	 * @since 0.2.0
	 */
	open func updateImageLayerFrame() {
		self.imageLayer.frame = CGRect(
			x: self.imageLeft,
			y: self.imageTop,
			width: self.imageWidth,
			height: self.imageHeight
		)
	}

	/**
	 * Measures the natural image view size.
	 * @method measure
	 * @since 0.1.0
	 */
	open func measure(in bounds: CGSize, min: CGSize, max: CGSize) -> CGSize {

		guard let image = self.image else {
			return .zero
		}

		let frameW = bounds.width
		let frameH = bounds.height
		let imageW = image.size.width
		let imageH = image.size.height

		let scaleW = imageW / imageH
		let scaleH = imageH / imageW

		if (frameW == 0 &&
			frameH == 0) {
			return CGSize(width: imageW, height: imageH).clamped(min: min, max: max)
		}

		if (frameW == 0) { return CGSize(width: frameH * scaleW, height: frameH).clamped(min: min, max: max) }
		if (frameH == 0) { return CGSize(width: frameW, height: frameW * scaleH).clamped(min: min, max: max) }

		return bounds
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Animations
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method action
	 * @since 0.1.0
	 */
	override open func action(for layer: CALayer, forKey event: String) -> CAAction? {
		return Transition.action(for: layer, key: event)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Animations Protocol
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method shouldBeginTransitionAnimation
	 * @since 0.2.0
	 */
	open func shouldBeginTransitionAnimation(animation: CABasicAnimation, for property: String, of layer: CALayer) -> Bool {

		if (property == "bounds" ||
			property == "position") {
			return self.hasFrame
		}

		return true
	}

	/**
	 * @inherited
	 * @method willBeginTransitionAnimation
	 * @since 0.2.0
	 */
	open func willBeginTransitionAnimation(animation: CABasicAnimation, for property: String, of layer: CALayer) {

	}

	/**
	 * @inherited
	 * @method didBeginTransition
	 * @since 0.2.0
	 */
	open func didBeginTransition() {

	}

	/**
	 * @inherited
	 * @method didFinishTransition
	 * @since 0.2.0
	 */
	open func didFinishTransition() {

	}
}
