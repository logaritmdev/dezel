/**
 * @class JavaScriptAlert
 * @since 0.1.0
 * @hidden
 */
open class JavaScriptAlert: JavaScriptClass, AlertControllerDelegate {

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

		let style   = callback.argument(0).string
		let title   = callback.argument(1).string.trim()
		let message = callback.argument(2).string.trim()
		let buttons = callback.argument(3)

		let alertController = AlertController.create(style: style, title: title, message: message)

		buttons.forEach { index, value in

			if let button = value.cast(JavaScriptAlertButton.self) {

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
					button.holder.callMethod("nativeOnPress")
				}

				if (button.image.type == .string ||
					button.image.type == .object) {

					ImageLoader.main.load(button.image) { image in

						guard let image = image else {
							return
						}

						let size = CGSize(width: 32, height: 32)

						UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

						image.draw(in: CGRect(
							x: 0,
							y: 0,
							width: size.width,
							height: size.height
						))

						if let image = UIGraphicsGetImageFromCurrentImageContext() {
							action.setValue(image, forKey: "image")
						}

						UIGraphicsEndImageContext()
					}
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
		self.holder.callMethod("nativeOnPresent")
	}

	/**
	 * @method alertDidDismiss
	 * @since 0.1.0
	 * @hidden
	 */
	open func alertDidDismiss(alert: AlertController) {
		self.holder.callMethod("nativeOnDismiss")
		self.unprotect()
	}
}
