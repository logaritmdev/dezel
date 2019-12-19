/**
 * @class SpinnerView
 * @super UIActivityIndicatorView
 * @since 0.7.0
 */
open class SpinnerView: UIActivityIndicatorView {

	//----------------------------------------------------------------------
	// MARK: Properties
	//----------------------------------------------------------------------

	/**
	 * @property spin
	 * @since 0.7.0
	 */
	open var spin: Bool = false {
		willSet {
			if (newValue) {
				self.startAnimating()
			} else {
				self.stopAnimating()
			}
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

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
}
