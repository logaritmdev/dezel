/**
 * @class ImageView
 * @super UIView
 * @since 0.7.0
 */
open class ImageView: UIView, Updatable, Clippable {

	//--------------------------------------------------------------------------
	// MARK: Layer Class
	//--------------------------------------------------------------------------

	/**
	 * @property layerClass
	 * @since 0.7.0
	 */
	open override class var layerClass: AnyClass {
		return Layer.self
	}

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property bounds
	 * @since 0.6.0
	 */
	override open var bounds: CGRect {
		willSet {
			self.invalidImageLayer = true
		}
	}

	/**
	 * @property image
	 * @since 0.7.0
	 */
	open var image: UIImage? {
		willSet {
			self.imageLayer.image = newValue?.cgImage
		}
	}

	/**
	 * @property imageFit
	 * @since 0.7.0
	 */
	open var imageFit: ImageFit = .contain {
		willSet {
			self.imageLayer.imageFit = newValue
		}
	}

	/**
	 * @property imagePosition
	 * @since 0.7.0
	 */
	open var imagePosition: ImagePosition = .middleCenter {
		willSet {
			self.imageLayer.imagePosition = newValue
		}
	}

	/**
	 * @property paddingTop
	 * @since 0.7.0
	 */
	open var paddingTop: CGFloat = 0 {
		willSet {
			self.invalidImageLayer = true
		}
	}

	/**
	 * @property paddingLeft
	 * @since 0.7.0
	 */
	open var paddingLeft: CGFloat = 0 {
		willSet {
			self.invalidImageLayer = true
		}
	}

	/**
	 * @property paddingRight
	 * @since 0.7.0
	 */
	open var paddingRight: CGFloat = 0 {
		willSet {
			self.invalidImageLayer = true
		}
	}

	/**
	 * @property paddingBottom
	 * @since 0.7.0
	 */
	open var paddingBottom: CGFloat = 0 {
		willSet {
			self.invalidImageLayer = true
		}
	}

	/**
	 * @property tint
	 * @since 0.7.0
	 */
	open var tint: UIColor = .clear {
		willSet {
			self.imageLayer.tint = newValue.cgColor
		}
	}

	/**
	 * @property imageLayer
	 * @since 0.7.0
	 * @hidden
	 */
	private var imageLayer: ImageLayer = ImageLayer()

	/**
	 * @property invalidImageLayer
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidImageLayer: Bool = false

	//----------------------------------------------------------------------
	// MARK: Methods
	//----------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public override init(frame: CGRect) {
		super.init(frame: frame)
		self.imageLayer.frame = frame
		self.layer.addSublayer(self.imageLayer)
	}

	/**
	 * @method measure
	 * @since 0.7.0
	 */
	open func measure(bounds: CGSize, min: CGSize, max: CGSize) -> CGSize {

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
			return CGSize(width: imageW, height: imageH).clamp(min: min, max: max)
		}

		if (frameW == 0) { return CGSize(width: frameH * scaleW, height: frameH).clamp(min: min, max: max) }
		if (frameH == 0) { return CGSize(width: frameW, height: frameW * scaleH).clamp(min: min, max: max) }

		return bounds
	}

	/**
	 * @method update
	 * @since 0.7.0
	 */
	open func update() {

		if (self.invalidImageLayer) {
			self.invalidImageLayer = false
			self.updateImageLayer()
		}

		self.imageLayer.update()
	}

	/**
	 * @method updateImageLayer
	 * @since 0.7.0
	 */
	open func updateImageLayer() {

		let paddingT = self.paddingTop
		let paddingL = self.paddingLeft
		let paddingR = self.paddingRight
		let paddingB = self.paddingBottom

		var bounds = self.bounds
		bounds.size.width = bounds.size.width - paddingL - paddingR
		bounds.size.height = bounds.size.height - paddingT - paddingB
		bounds.origin.x = paddingL
		bounds.origin.y = paddingT

		self.imageLayer.frame = bounds
	}
}
