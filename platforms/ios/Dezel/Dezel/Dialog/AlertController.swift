
/**
 * @class AlertController
 * @since 0.1.0
 */
open class AlertController: UIAlertController {

	//--------------------------------------------------------------------------
	// MARK: Static Methods
	//--------------------------------------------------------------------------

	/**
	 * Convenience method to create an alert controller.
	 * @method create
	 * @since 0.1.0
	 */
	public static func create(title: String, message: String, style: UIAlertController.Style = .alert) -> AlertController {

		let title = title.trim()
		let message = message.trim()

		return AlertController(
			title: title.length > 0 ? title : nil,
			message: message.length > 0 ? message : nil,
			preferredStyle: style
		)
	}

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The alert controller delegate.
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
