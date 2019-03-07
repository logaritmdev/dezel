/**
 * @class Sheet
 * @since 0.5.0
 * @hidden
 */
open class Sheet: JavaScriptClass, AlertControllerDelegate {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property alertController
	 * @since 0.5.0
	 * @hidden
	 */
	private var alertController: AlertController?

	/**
	 * @property imageLoader
	 * @since 0.5.0
	 * @hidden
	 */
	private var imageLoader: ImageLoader = ImageLoader()

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_present
	 * @since 0.5.0
	 * @hidden
	 */
	@objc open func jsFunction_present(callback: JavaScriptFunctionCallback) {

		self.protect()

		self.context.application.presentedViewController?.dismiss(animated: true, completion: nil)

		let title   = callback.argument(0).string
		let message = callback.argument(1).string
		let buttons = callback.argument(2)

		let alertController = AlertController.create(title: title, message: message, style: .actionSheet)

		buttons.forEach { index, value in

			if let button = value.cast(SheetButton.self) {

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

				if (button.image.type == .string ||
					button.image.type == .object) {

					self.imageLoader.load(button.image) { image in

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
	 * @since 0.5.0
	 * @hidden
	 */
	@objc open func jsFunction_dismiss(callback: JavaScriptFunctionCallback) {
		if let alertController = self.alertController {
			alertController.presentingViewController?.dismiss(animated: true, completion: nil)
		}
	}

	//--------------------------------------------------------------------------
	// Sheet Delegate
	//--------------------------------------------------------------------------

	/**
	 * @method alertDidPresent
	 * @since 0.5.0
	 * @hidden
	 */
	open func alertDidPresent(alert: AlertController) {
		self.holder.callMethod("nativePresent")
	}

	/**
	 * @method alertDidDismiss
	 * @since 0.5.0
	 * @hidden
	 */
	open func alertDidDismiss(alert: AlertController) {
		self.holder.callMethod("nativeDismiss")
		self.unprotect()
	}
}
