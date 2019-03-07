import UIKit

/**
 * The layer that renders the view's border.
 * @class CanvasLayer
 * @super Layer
 * @since 0.4.0
 */
public class CanvasLayer: Layer {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The callback to execute when the canvas needs to be draw.
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
	 * @inherited
	 * @method draw
	 * @since 0.4.0
	 */
	public override func draw(in ctx: CGContext) {
		self.drawCanvas?(ctx)
	}
}
