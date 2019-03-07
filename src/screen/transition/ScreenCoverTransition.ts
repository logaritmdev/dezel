import { Screen } from '../Screen'
import { ScreenTransition } from './ScreenTransition'
import { ScreenTransitionRegistry } from './ScreenTransition'

/**
 * Performs a transition that slides the screen vertically.
 * @class ScreenCoverTransition
 * @super ScreenTransition
 * @since 0.2.0
 */
export class ScreenCoverTransition extends ScreenTransition {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onBeforePresent
	 * @since 0.2.0
	 */
	public onBeforePresent(enter?: Screen, leave?: Screen) {

		if (enter) {
			enter.translationY = '100%'
		}

		if (leave) {
			leave.opacity = 1
		}
	}

	/**
	 * @inherited
	 * @method onPresent
	 * @since 0.2.0
	 */
	public onPresent(enter?: Screen, leave?: Screen) {

		if (enter) {
			enter.translationY = '0%'
		}

		if (leave) {
			leave.opacity = 0.75
			leave.scaleX = 0.90
			leave.scaleY = 0.90
		}
	}

	/**
	 * @inherited
	 * @method onAfterPresent
	 * @since 0.2.0
	 */
	public onAfterPresent(enter?: Screen, leave?: Screen) {

		if (enter) {
			enter.translationY = 0
		}

		if (leave) {
			leave.opacity = 1
			leave.scaleX = 1
			leave.scaleY = 1
		}
	}

	/**
	 * @inherited
	 * @method onBeforeDismiss
	 * @since 0.2.0
	 */
	public onBeforeDismiss(enter?: Screen, leave?: Screen) {

		if (enter) {
			enter.opacity = 0.75
			enter.scaleX = 0.9
			enter.scaleY = 0.9
		}

		if (leave) {
			leave.translationY = '0%'
		}
	}

	/**
	 * @inherited
	 * @method onDismiss
	 * @since 0.2.0
	 */
	public onDismiss(enter?: Screen, leave?: Screen) {

		if (enter) {
			enter.opacity = 1
			enter.scaleX = 1
			enter.scaleY = 1
		}

		if (leave) {
			leave.translationY = '100%'
		}
	}

	/**
	 * @inherited
	 * @method onAfterDismiss
	 * @since 0.2.0
	 */
	public onAfterDismiss(enter?: Screen, leave?: Screen) {
		if (enter) enter.translationY = 0
		if (leave) leave.translationY = 0
	}
}

ScreenTransitionRegistry.set('cover', ScreenCoverTransition)