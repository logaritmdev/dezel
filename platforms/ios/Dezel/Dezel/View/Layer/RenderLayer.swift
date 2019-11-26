import UIKit

/**
 * @class RenderLayer
 * @super Layer
 * @since 0.1.0
 */
public class RenderLayer: Layer, TransitionListener {

	//--------------------------------------------------------------------------
	// MARK: Class Methods
	//--------------------------------------------------------------------------

	/**
	 * @method needsDisplay
	 * @since 0.1.0
	 */
	override open class func needsDisplay(forKey key: String) -> Bool {

		if (key == "borderTopLeftRadius" ||
			key == "borderTopRightRadius" ||
			key == "borderBottomLeftRadius" ||
			key == "borderBottomRightRadius") {
			return true
		}

		return super.needsDisplay(forKey: key)
	}

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property borderTopLeftRadius
	 * @since 0.1.0
	 */
	@NSManaged public var borderTopLeftRadius: CGFloat

	/**
	 * @property borderTopRightRadius
	 * @since 0.1.0
	 */
	@NSManaged public var borderTopRightRadius: CGFloat

	/**
	 * @property borderBottomLeftRadius
	 * @since 0.1.0
	 */
	@NSManaged public var borderBottomLeftRadius: CGFloat

	/**
	 * @property borderBottomRightRadius
	 * @since 0.1.0
	 */
	@NSManaged public var borderBottomRightRadius: CGFloat

	/**
	 * @property shape
	 * @since 0.1.0
	 * @hidden
	 */
	private var shape: ShapeLayer = ShapeLayer()

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

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
	required public init() {
		super.init()
		self.needsDisplayOnBoundsChange = true
		self.shape.listener = self
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	override init(layer: Any) {

		super.init(layer: layer)

		if let layer = layer as? RenderLayer {
			self.borderTopLeftRadius = layer.borderTopLeftRadius
			self.borderTopRightRadius = layer.borderTopRightRadius
			self.borderBottomLeftRadius = layer.borderBottomLeftRadius
			self.borderBottomRightRadius = layer.borderBottomRightRadius
		}
	}

	/**
	 * @method update
	 * @since 0.1.0
	 */
	override open func update() {

		if (self.needsDisplay() == false) {
			return
		}

		let layerW = self.bounds.size.width
		let layerH = self.bounds.size.height

		let borderRadiusTL = self.borderTopLeftRadius
		let borderRadiusTR = self.borderTopRightRadius
		let borderRadiusBL = self.borderBottomLeftRadius
		let borderRadiusBR = self.borderBottomRightRadius

		if (borderRadiusTL > 0 || borderRadiusTR > 0 ||
			borderRadiusBL > 0 || borderRadiusBR > 0) {

			self.shape.path = CGOuterRoundedRectPath(
				layerW,
				layerH,
				borderRadiusTL,
				borderRadiusTR,
				borderRadiusBL,
				borderRadiusBR
			)

			self.mask = self.shape
			self.shouldRasterize = true

		} else {

			self.mask = nil
			self.shouldRasterize = false

			/*
			 * The shape path must be set after the mask is cleared. Setting
			 * the path during an animation will trigger the
			 * willBeginShapeAnimation method that might set a mask that will
			 * be active for the duration of the animation only.
			 */

			self.shape.path = CGOuterRoundedRectPath(
				layerW,
				layerH,
				0.001,
				0.001,
				0.001,
				0.001
			)
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
		return true
	}

	/**
	 * @method willBeginTransitionAnimation
	 * @since 0.2.0
	 */
	open func willBeginTransitionAnimation(animation: CABasicAnimation, for property: String, of layer: CALayer) {
		if (property == "path") {
			self.mask = self.shape
			self.shouldRasterize = false
		}
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

		if (self.borderTopLeftRadius > 0 ||
			self.borderTopRightRadius > 0 ||
			self.borderBottomLeftRadius > 0 ||
			self.borderBottomRightRadius > 0) {
			self.shouldRasterize = true
			return
		}

		/*
		 * Rasterization suring animation was turned off for performance
		 * reasons so it can be turned on now. Also, a mask was applied even
		 * if the radius was zero (to animate to 0) so it can be removed.
		 */

		self.mask = nil
		self.shouldRasterize = false
	}
}
