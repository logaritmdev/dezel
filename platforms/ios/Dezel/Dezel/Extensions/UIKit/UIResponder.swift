import Foundation

/**
* @extension UIResponder
* @since 0.7.0
* @hidden
*/
extension UIResponder {

	/**
	 * @method dispatchTouchCancel
	 * @since 0.7.0
	 * @hidden
	 */
	func dispatchTouchCancel(_ touch: UITouch, with event: UIEvent, skip: UIResponder?) {
		self.invokeTouchCancel(touch, with: event, skip: skip)
		self.next?.dispatchTouchCancel(touch, with: event, skip: skip)
	}

	/**
	 * @method dispatchTouchCancel
	 * @since 0.7.0
	 * @hidden
	 */
	func dispatchTouchCancel(_ touch: UITouch, with event: UIEvent) {
		self.invokeTouchCancel(touch, with: event)
		self.next?.dispatchTouchCancel(touch, with: event)
	}

	/**
	 * @method invokeTouchCancel
	 * @since 0.7.0
	 * @hidden
	 */
	func invokeTouchCancel(_ touch: UITouch, with event: UIEvent, skip: UIResponder?) {

		if (self == skip) {
			return
		}

		self.invokeTouchCancel(touch, with: event)
	}

	/**
	 * @method invokeTouchCancel
	 * @since 0.7.0
	 * @hidden
	 */
	func invokeTouchCancel(_ touch: UITouch, with event: UIEvent) {

		let touches: Set<UITouch> = [touch]

		if let view = self as? UIView {

			view.gestureRecognizers?.forEach { gesture in

				if (gesture.isEnabled) {
					gesture.isEnabled = false
					gesture.isEnabled = true
					gesture.touchesCancelled(touches, with: event)
				}
			}
		}

		self.touchesCancelled(touches, with: event)
	}
}
