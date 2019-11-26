import Foundation

/**
 * @class ApplicationWindow
 * @super UIWindow
 * @since 0.7.0
 */
open class ApplicationWindow: UIWindow {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
     * @method sendEvent
     * @since 0.7.0
     */
	override open func sendEvent(_ event: UIEvent) {

		if (event.type == .touches) {
			self.dispatchTouchEvent(event.allTouches!, with: event)
			return
		}

		super.sendEvent(event)
	}

	//--------------------------------------------------------------------------
	// MARK: Touch Management
	//--------------------------------------------------------------------------

	/**
     * @method dispatchTouchEvent
     * @since 0.7.0
     */
	open func dispatchTouchEvent(_ touches: Set<UITouch>, with event: UIEvent) {

		guard let root = self.rootViewController?.view else {
			return
		}

		var began: Set<UITouch> = Set<UITouch>()
		var moved: Set<UITouch> = Set<UITouch>()
		var ended: Set<UITouch> = Set<UITouch>()
		var canceled: Set<UITouch> = Set<UITouch>()

		for touch in touches {

			switch (touch.phase) {

				case .began:
					began.insert(touch)
				case .moved:
					moved.insert(touch)
				case .ended:
					ended.insert(touch)
				case .cancelled:
					canceled.insert(touch)

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

		if (canceled.count > 0) {
			self.dispatchTouchCanceled(canceled)
		}

		super.sendEvent(event)

		for touch in touches where touch.touchCanceled == false {

			touch.touchCanceled = true

			if (touch.canceled) {
				touch.view?.dispatchTouchCancel(touch, with: event)
				continue
			}

			if (touch.captured) {
				touch.view?.dispatchTouchCancel(touch, with: event, skip: touch.receiver)
				continue
			}
		}
	}

	/**
     * @method dispatchTouchBegan
     * @since 0.7.0
     */
	open func dispatchTouchBegan(_ touches: Set<UITouch>) {
		NotificationCenter.default.post(name: ApplicationDelegate.touchesBeganNotification, object: self, userInfo: ["touches": touches])
	}

	/**
     * @method dispatchTouchMoved
     * @since 0.7.0
     */
	open func dispatchTouchMoved(_ touches: Set<UITouch>) {
		NotificationCenter.default.post(name: ApplicationDelegate.touchesMovedNotification, object: self, userInfo: ["touches": touches])
	}

	/**
     * @method dispatchTouchEnded
     * @since 0.7.0
     */
	open func dispatchTouchEnded(_ touches: Set<UITouch>) {
		NotificationCenter.default.post(name: ApplicationDelegate.touchesEndedNotification, object: self, userInfo: ["touches": touches])
	}

	/**
     * @method dispatchTouchCanceled
     * @since 0.7.0
     */
	open func dispatchTouchCanceled(_ touches: Set<UITouch>) {
		NotificationCenter.default.post(name: ApplicationDelegate.touchesCanceledNotification, object: self, userInfo: ["touches": touches])
	}
}
