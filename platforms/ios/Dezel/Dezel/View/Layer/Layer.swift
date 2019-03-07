import UIKit

/**
 * The base layer.
 * @class Layer
 * @super CAGradientLayer
 * @since 0.1.0
 */
open class Layer: CAGradientLayer, CALayerDelegate {

	//--------------------------------------------------------------------------
	// MARK: Class Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
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
	 * Called when the layer is resized.
	 * @method resize
	 * @since 0.1.0
	 */
	open func resize(_ bounds: CGRect) {
		self.frame = bounds
	}

	/**
	 * Called when the layer is about to update.
	 * @method update
	 * @since 0.1.0
	 */
	open func update() {

	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Animations
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method action
	 * @since 0.1.0
	 */
	override open func action(forKey key: String) -> CAAction? {
		return Transition.action(for: self, key: key)
	}
}
