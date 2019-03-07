/**
 * @class Alert
 * @since 0.1.0
 * @hidden
 */
open class Alert: JavaScriptClass, AlertControllerDelegate {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property alertController
	 * @since 0.1.0
	 * @hidden
	 */
	private var alertController: AlertController?

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_present
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_present(callback: JavaScriptFunctionCallback) {

		self.protect()

		self.context.application.presentedViewController?.dismiss(animated: true, completion: nil)

		let title   = callback.argument(0).string
		let message = callback.argument(1).string
		let buttons = callback.argument(2)

		let alertController = AlertController.create(title: title, message: message)

		buttons.forEach { index, value in

			if let button = value.cast(AlertButton.self) {

				var style: UIAlertAction.Style = .default

				switch (button.style.string) {

					case "normal":
						style = .default
					case "cancel":
						style = .cancel
					case "destructive":
						style = .destructive

					default: break
				}

				let action = UIAlertAction(title: button.label.string, style: style) { action in
					button.holder.callMethod("nativePress")
				}

				alertController.addAction(action)
			}
		}

		if (alertController.actions.count == 0) {
			alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		}

		alertController.delegate = self

		self.context.application.present(alertController, animated: true, completion: nil)
	}

	/**
	 * @method jsFunction_dismiss
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_dismiss(callback: JavaScriptFunctionCallback) {
		if let alertController = self.alertController {
			alertController.presentingViewController?.dismiss(animated: true, completion: nil)
		}
	}

	//--------------------------------------------------------------------------
	// Alert Delegate
	//--------------------------------------------------------------------------

	/**
	 * @method alertDidPresent
	 * @since 0.1.0
	 * @hidden
	 */
	open func alertDidPresent(alert: AlertController) {
		self.holder.callMethod("nativePresent")
	}

	/**
	 * @method alertDidDismiss
	 * @since 0.1.0
	 * @hidden
	 */
	open func alertDidDismiss(alert: AlertController) {
		self.holder.callMethod("nativeDismiss")
		self.unprotect()
	}
}
