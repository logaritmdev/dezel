import Foundation

/**
 * Detect scroll view touch cancel event.
 * @class ScrollViewTouchCancelGesture
 * @since 0.6.0
 * @hidden
 */
public class ScrollViewTouchCancelGesture: UIGestureRecognizer, UIGestureRecognizerDelegate {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property touches
	 * @since 0.6.0
	 * @hidden
	 */
	private(set) public var touches: Set<UITouch> = Set()

	/**
	 * @property started
	 * @since 0.6.0
	 * @hidden
	 */
	private(set) public var started: Bool = false

	/**
	 * @property canceled
	 * @since 0.6.0
	 * @hidden
	 */
	private(set) public var canceled: Bool = false

	/**
	 * @property target
	 * @since 0.6.0
	 * @hidden
	 */
	private weak var target: AnyObject?

	/**
	 * @property action
	 * @since 0.6.0
	 * @hidden
	 */
	private var action: Selector?

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.6.0
	 */
	public required init(scrollView: UIScrollView, target: AnyObject, action: Selector) {

		super.init(
			target: nil,
			action: nil
		)

		self.target = target
		self.action = action
		self.delegate = self

		scrollView.panGestureRecognizer.addTarget(self, action: #selector(scrollViewDidPan))
	}

	/**
	 * @inherited
	 * @method touchesBegan
	 * @since 0.6.0
	 */
	override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
		for touch in touches {
			self.touches.insert(touch)
		}
	}

	/**
	 * @inherited
	 * @method touchesEnded
	 * @since 0.6.0
	 */
	override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {

		for touch in touches {
			self.touches.remove(touch)
		}

		if (self.touches.count == 0) {
			self.restart()
		}
	}

	/**
	 * @inherited
	 * @method touchesCancelled
	 * @since 0.6.0
	 */
	override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {

		for touch in touches {
			self.touches.remove(touch)
		}

		if (self.touches.count == 0) {
			self.restart()
		}
	}

	/**
	 * @method scrollViewDidPan
	 * @since 0.6.0
	 * @hidden
	 */
	@objc private func scrollViewDidPan(gesture: UIGestureRecognizer) {
		if (self.canceled == false) {
			self.canceled = true
			_ = self.target?.perform(self.action, with: self)
		}
	}

	/**
	 * @method restart
	 * @since 0.6.0
	 * @hidden
	 */
	private func restart() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
			self.canceled = false
		}
	}

	/**
	 * @inherited
	 * @method gestureRecognizerShouldRecognizeSimultaneouslyWith
	 * @since 0.6.0
	 */
	public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		return true
	}
}
