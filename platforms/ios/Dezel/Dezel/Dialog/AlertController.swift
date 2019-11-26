
/**
 * @class AlertController
 * @since 0.1.0
 */
open class AlertController: UIAlertController {

	//--------------------------------------------------------------------------
	// MARK: Static Methods
	//--------------------------------------------------------------------------

	/**
	 * @method create
	 * @since 0.1.0
	 */
	public static func create(style: String, title: String, message: String) -> AlertController {

		let preferredStyle: AlertController.Style

		switch (style) {

			case "alert":
				preferredStyle = .alert
			case "sheet":
				preferredStyle = .actionSheet

			default:
				preferredStyle = .alert
		}

		return AlertController(
			title: title.length > 0 ? title : nil,
			message: message.length > 0 ? message : nil,
			preferredStyle: preferredStyle
		)
	}

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property delegate
	 * @since 0.1.0
	 */
	open weak var delegate: AlertControllerDelegate?

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method viewDidAppear
	 * @since 0.1.0
	 * @hidden
	 */
	override open func viewDidAppear(_ animated: Bool) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
			self.delegate?.alertDidPresent(alert: self)
		}
	}

	/**
	 * @method viewDidDisappear
	 * @since 0.1.0
	 * @hidden
	 */
	override open func viewDidDisappear(_ animated: Bool) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
    		self.delegate?.alertDidDismiss(alert: self)
		}
	}
}
