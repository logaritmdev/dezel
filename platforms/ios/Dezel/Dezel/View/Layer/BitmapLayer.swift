import UIKit

/**
 * The layer that renders the view's background color and image.
 * @class BitmapLayer
 * @super Layer
 * @since 0.1.0
 */
public class BitmapLayer: Layer {

	//--------------------------------------------------------------------------
	// MARK: Enums
	//--------------------------------------------------------------------------

	public enum Mode {
		case fit
		case fill
	}

	//--------------------------------------------------------------------------
	// MARK: Static
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method needsDisplay
	 * @since 0.1.0
	 */
	override open class func needsDisplay(forKey key: String) -> Bool {

		if (key == "backgroundImageTop" ||
			key == "backgroundImageLeft" ||
			key == "backgroundImageWidth" ||
			key == "backgroundImageHeight" ||
			key == "backgroundImageTint") {
			return true
		}

		return super.needsDisplay(forKey: key)
	}

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property backgroundImage
	 * @since 0.1.0
	 * @hidden
	 */
	public var backgroundImage: UIImage? {
		didSet {
			self.setNeedsDisplay()
		}
	}

	/**
	 * @property backgroundImageTop
	 * @since 0.1.0
	 * @hidden
	 */
	@NSManaged public var backgroundImageTop: CGFloat

	/**
	 * @property backgroundImageLeft
	 * @since 0.1.0
	 * @hidden
	 */
	@NSManaged public var backgroundImageLeft: CGFloat

	/**
	 * @property backgroundImageWidth
	 * @since 0.1.0
	 * @hidden
	 */
	@NSManaged public var backgroundImageWidth: CGFloat

	/**
	 * @property backgroundImageHeight
	 * @since 0.1.0
	 * @hidden
	 */
	@NSManaged public var backgroundImageHeight: CGFloat

	/**
	 * @property backgroundLinearGradient
	 * @since 0.1.0
	 * @hidden
	 */
	open var backgroundLinearGradient: LinearGradient? {
		willSet {
			if (self.backgroundLinearGradient != newValue) {
				self.setNeedsDisplay()
			}
		}
	}

	/**
	 * @property backgroundRadialGradient
	 * @since 0.1.0
	 * @hidden
	 */
	open var backgroundRadialGradient: RadialGradient? {
		willSet {
			if (self.backgroundRadialGradient != newValue) {
				self.setNeedsDisplay()
			}
		}
	}

	/**
	 * @property backgroundImageTint
	 * @since 0.1.0
	 * @hidden
	 */
	public var backgroundImageTint: CGColor = CGColor.transparent {
		willSet {
			if (self.backgroundImageTint != newValue) {
				self.backgroundImageLayer.color = newValue
			}
		}
	}

	/**
	 * @property backgroundImageLayer
	 * @since 0.1.0
	 * @hidden
	 */
	private var backgroundImageLayer: ImageLayer = ImageLayer()

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	required public init() {
		super.init()
		self.masksToBounds = true
		self.needsDisplayOnBoundsChange = true
		self.addSublayer(self.backgroundImageLayer)
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	override init(layer: Any) {

		super.init(layer: layer as AnyObject)

		if let layer = layer as? BitmapLayer {
			self.backgroundImageTop = layer.backgroundImageTop
			self.backgroundImageLeft = layer.backgroundImageLeft
			self.backgroundImageWidth = layer.backgroundImageWidth
			self.backgroundImageHeight = layer.backgroundImageHeight
		}
	}

	/**
	 * @inherited
	 * @method display
	 * @since 0.1.0
	 */
	public override func display() {

		if let backgroundImage = self.backgroundImage {

			let backgroundImageT: CGFloat
			let backgroundImageL: CGFloat
			let backgroundImageW: CGFloat
			let backgroundImageH: CGFloat

			if let presentationLayer = self.presentation() {
				backgroundImageT = presentationLayer.backgroundImageTop
				backgroundImageL = presentationLayer.backgroundImageLeft
				backgroundImageW = presentationLayer.backgroundImageWidth
				backgroundImageH = presentationLayer.backgroundImageHeight
			} else {
				backgroundImageT = self.backgroundImageTop
				backgroundImageL = self.backgroundImageLeft
				backgroundImageW = self.backgroundImageWidth
				backgroundImageH = self.backgroundImageHeight
			}

			self.backgroundImageLayer.isHidden = false
			self.backgroundImageLayer.image = backgroundImage.cgImage
			self.backgroundImageLayer.frame = CGRect(
				x: backgroundImageL,
				y: backgroundImageT,
				width: backgroundImageW,
				height: backgroundImageH
			)

		} else {
			self.backgroundImageLayer.isHidden = true
		}

		if (self.backgroundLinearGradient == nil &&
			self.backgroundRadialGradient == nil) {
			self.locations = nil
			self.colors = nil
		}

		if let gradient = self.backgroundLinearGradient {
			self.displayLinearGradient(gradient)
			return
		}

		if let gradient = self.backgroundRadialGradient {
			self.displayRadialGradient(gradient)
			return
		}
	}

	/**
	 * TODO
	 * @method displayLinearGradient
	 * @since 0.1.0
	 */
	open func displayLinearGradient(_ gradient: LinearGradient) {

		let pi = CGFloat(Double.pi)

		self.colors = gradient.colors
		self.locations = gradient.points as [NSNumber]

		let x = (gradient.angle + pi / 2) / (2 * pi)

		let a = pow(sin((2 * pi * ((x + 0.75) / 2))), 2)
		let b = pow(sin((2 * pi * ((x + 0.00) / 2))), 2)
		let c = pow(sin((2 * pi * ((x + 0.25) / 2))), 2)
		let d = pow(sin((2 * pi * ((x + 0.50) / 2))), 2)

		self.startPoint = CGPoint(x: a, y: b)
		self.endPoint = CGPoint(x: c, y: d)
	}

	/**
	 * TODO
	 * @method displayRadialGradient
	 * @since 0.1.0
	 */
	open func displayRadialGradient(_ gradient: RadialGradient) {

	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Animations
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method action
	 * @since 0.1.0
	 */
	public override func action(forKey key: String) -> CAAction? {

		if let transition = Transition.current {

			var current = self.presentation()
			if (current == nil || self.animation(forKey: key) == nil) {
				current = self
			}

			let animation = CABasicAnimation(keyPath: key)

			switch (key) {

				case "backgroundColor":
					animation.fromValue = current!.backgroundColor
				case "backgroundImageTop":
					animation.fromValue = current!.backgroundImageTop
				case "backgroundImageLeft":
					animation.fromValue = current!.backgroundImageLeft
				case "backgroundImageWidth":
					animation.fromValue = current!.backgroundImageWidth
				case "backgroundImageHeight":
					animation.fromValue = current!.backgroundImageHeight

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
}
