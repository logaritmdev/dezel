//
//  CancelGesture.swift
//  Dezel
//
//  Created by Jean-Philippe Déry on 2019-04-24.
//  Copyright © 2019 Jean-Philippe Déry. All rights reserved.
//

import Foundation
/**
	 * @class TouchCancelDetector
	 * @since 0.6.0
	 * @hidden
	 */
	private class TouchCancelDetector: UIGestureRecognizer, UIGestureRecognizerDelegate {

		/**
		 * @property application
		 * @since 0.6.0
		 * @hidden
		 */
		public weak var application: DezelApplicationController?

		/**
		 * @property touches
		 * @since 0.6.0
		 * @hidden
		 */
		private var touches: Set<UITouch> = Set()

		/**
		 * @property started
		 * @since 0.6.0
		 * @hidden
		 */
		private var started: Bool = false

		/**
		 * @property canceled
		 * @since 0.6.0
		 * @hidden
		 */
		private var canceled: Bool = false

		/**
		 * @constructor
		 * @since 0.6.0
		 */
		public required init(application: DezelApplicationController, scrollView: UIScrollView) {

			super.init(target: nil, action: nil)

			self.delegate = self
			self.application = application

			scrollView.panGestureRecognizer.addTarget(self, action: #selector(scrollViewDidPan))

			// probably memory leak here
		}

		/**
		 * @inherited
		 * @method gestureRecognizerShouldRecognizeSimultaneouslyWith
		 * @since 0.6.0
		 */
		public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
			return true
		}

		/**
		 * @inherited
		 * @method touchesBegan
		 * @since 0.6.0
		 */
		override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
			for touch in touches {
				self.touches.insert(touch)
			}
		}

		/**
		 * @inherited
		 * @method touchesEnded
		 * @since 0.6.0
		 */
		override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {

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
		override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {

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
				self.application?.dispatchTouchCancel(self.touches)
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
	}
