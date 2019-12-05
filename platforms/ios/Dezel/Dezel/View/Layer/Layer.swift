import UIKit

/**
 * @class Layer
 * @super CAGradientLayer
 * @since 0.1.0
 */
open class Layer: CAGradientLayer, CALayerDelegate {

	//--------------------------------------------------------------------------
	// MARK: Class Methods
	//--------------------------------------------------------------------------

	/**
	 * @method defaultAction
	 * @since 0.1.0
	 */
	override open class func defaultAction(forKey event: String) -> CAAction? {
		return nil
	}

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

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
	public required override init() {
		super.init()
		self.actions = nil
		self.contentsScale = UIScreen.main.scale
		self.rasterizationScale = UIScreen.main.scale
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	public override init(layer: Any) {
		super.init(layer: layer)
		self.actions = nil
		self.contentsScale = UIScreen.main.scale
		self.rasterizationScale = UIScreen.main.scale
	}

	/**
	 * @method resize
	 * @since 0.1.0
	 */
	open func resize(_ bounds: CGRect) {
		self.frame = bounds
	}

	/**
	 * @method update
	 * @since 0.1.0
	 */
	open func update() {

	}

	/**
	 * @method applyGradient
	 * @since 0.7.0
	 */
	open func applyGradient(colors: [CGColor], points: [CGFloat], start: CGPoint, end: CGPoint) {
		self.colors = colors
		self.locations = points as [NSNumber]
		self.startPoint = start
		self.endPoint = end
	}

	/**
	 * @method clearGradient
	 * @since 0.7.0
	 */
	open func clearGradient() {
		self.colors = nil
		self.locations = nil
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Animations
	//--------------------------------------------------------------------------

	/**
	 * @method action
	 * @since 0.1.0
	 */
	override open func action(forKey key: String) -> CAAction? {
		return Transition.action(for: self, key: key)
	}
}
