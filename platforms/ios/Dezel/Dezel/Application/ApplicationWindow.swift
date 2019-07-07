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
					self.handleTouchBegan(began, event: event)
				}

				if (moved.count > 0) {
					self.handleTouchMoved(moved, event: event)
				}

				if (ended.count > 0) {
					self.handleTouchEnded(ended, event: event)
				}

				if (cancelled.count > 0) {
					self.handleTouchCancelled(cancelled, event: event)
				}
			}
		}
	}

	/**
     * @method handleTouchBegan
     * @since 0.7.0
     * @hidden
     */
	private func handleTouchBegan(_ touches: Set<UITouch>, event: UIEvent) {
		NotificationCenter.default.post(name: Notification.Name("touchesbegan"), object: self, userInfo: ["touches": touches, "event": event])
	}

	/**
     * @method handleTouchMoved
     * @since 0.7.0
     * @hidden
     */
	private func handleTouchMoved(_ touches: Set<UITouch>, event: UIEvent) {
		NotificationCenter.default.post(name: Notification.Name("touchesmoved"), object: self, userInfo: ["touches": touches, "event": event])
	}

	/**
     * @method handleTouchEnded
     * @since 0.7.0
     * @hidden
     */
	private func handleTouchEnded(_ touches: Set<UITouch>, event: UIEvent) {
		NotificationCenter.default.post(name: Notification.Name("touchesended"), object: self, userInfo: ["touches": touches, "event": event])
	}

	/**
     * @method handleTouchCancelled
     * @since 0.7.0
     * @hidden
     */
	private func handleTouchCancelled(_ touches: Set<UITouch>, event: UIEvent) {
		NotificationCenter.default.post(name: Notification.Name("touchescancelled"), object: self, userInfo: ["touches": touches, "event": event])
	}
}
