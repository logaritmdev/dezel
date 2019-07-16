import Foundation

/**
 * The application window needed to handle touch events.
 * @class ApplicationWindow
 * @since 0.7.0
 */
open class ApplicationWindow: UIWindow {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
     * @method sendEvent
     * @since 0.7.0
     */
	override open func sendEvent(_ event: UIEvent) {

		super.sendEvent(event)

		guard let root = self.rootViewController?.view else {
			return
		}

		if (event.type == .touches) {

			var began: Set<UITouch> = Set<UITouch>()
			var moved: Set<UITouch> = Set<UITouch>()
			var ended: Set<UITouch> = Set<UITouch>()
			var cancelled: Set<UITouch> = Set<UITouch>()

			if let touches = event.allTouches {

				for touch in touches {

					switch (touch.phase) {

						case .began: began.insert(touch)
						case .moved: moved.insert(touch)
						case .ended: ended.insert(touch)
						case .cancelled: cancelled.insert(touch)

						default:
							break
					}
				}

				let filter = { (touch: UITouch) -> Bool in

					let target = self.hitTest(touch.location(in: self), with: event)

					if (touch.phase == .ended) {

						/*
						 * The touch has probaby moved outside of the bounds
						 * of the simulator.
						 */

						if (target == nil) {
							return true
						}
					}

					if let view = target {
						return view == root || view.isDescendant(of: root)
					}

					return false
				}

				began = began.filter(filter)
				moved = moved.filter(filter)
				ended = ended.filter(filter)

				if (began.count > 0) {
					self.dispatchTouchBegan(began)
				}

				if (moved.count > 0) {
					self.dispatchTouchMoved(moved)
				}

				if (ended.count > 0) {
					self.dispatchTouchEnded(ended)
				}

				if (cancelled.count > 0) {
					self.dispatchTouchCancelled(cancelled)
				}
			}
		}
	}

	/**
	 * Dispatches a touch began event.
     * @method dispatchTouchBegan
     * @since 0.7.0
     */
	open func dispatchTouchBegan(_ touches: Set<UITouch>) {
		NotificationCenter.default.post(name: ApplicationDelegate.touchesBeganNotification, object: self, userInfo: ["touches": touches])
	}

	/**
	 * Dispatches a touch moved event.
     * @method dispatchTouchMoved
     * @since 0.7.0
     */
	open func dispatchTouchMoved(_ touches: Set<UITouch>) {
		NotificationCenter.default.post(name: ApplicationDelegate.touchesMovedNotification, object: self, userInfo: ["touches": touches])
	}

	/**
	 * Dispatches a touch ended event.
     * @method dispatchTouchEnded
     * @since 0.7.0
     */
	open func dispatchTouchEnded(_ touches: Set<UITouch>) {
		NotificationCenter.default.post(name: ApplicationDelegate.touchesEndedNotification, object: self, userInfo: ["touches": touches])
	}

	/**
	 * Dispatches a touch cancelled event.
     * @method dispatchTouchCancelled
     * @since 0.7.0
     */
	open func dispatchTouchCancelled(_ touches: Set<UITouch>) {
		NotificationCenter.default.post(name: ApplicationDelegate.touchesCancelledNotification, object: self, userInfo: ["touches": touches])
	}
}
