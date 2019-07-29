/**
 * @class SpinnerView
 * @since 0.7.0
 * @hidden
 */
open class SpinnerView: UIActivityIndicatorView {

	//----------------------------------------------------------------------
	// MARK: Properties
	//----------------------------------------------------------------------

	/**
	 * Determines whether the activity view is animated.
	 * @property active
	 * @since 0.7.0
	 */
	open var active: Bool = false {
		willSet {
			if (newValue) {
				self.startAnimating()
			} else {
				self.stopAnimating()
			}
		}
	}

	//----------------------------------------------------------------------
	// MARK: Methods
	//----------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	required public init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public override init(frame: CGRect) {
		super.init(frame: frame)
		self.style = .gray
		self.hidesWhenStopped = false
	}

	/**
	 * @inherited
	 * @method action
	 * @since 0.7.0
	 */
	override open func action(for layer: CALayer, forKey event: String) -> CAAction? {
		return Transition.action(for: layer, key: event)
	}
}
