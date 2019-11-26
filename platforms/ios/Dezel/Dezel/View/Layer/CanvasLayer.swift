import UIKit

/**
 * @class CanvasLayer
 * @super Layer
 * @since 0.4.0
 */
public class CanvasLayer: Layer {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property drawCanvas
	 * @since 0.4.0
	 */
	open var drawCanvas: ((CGContext) -> Void)?

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.4.0
	 * @hidden
	 */
	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/**
	 * @constructor
	 * @since 0.4.0
	 * @hidden
	 */
	required public init() {
		super.init()
	}

	/**
	 * @method draw
	 * @since 0.4.0
	 */
	public override func draw(in ctx: CGContext) {
		self.drawCanvas?(ctx)
	}
}
