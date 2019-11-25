import { Screen } from './Screen'
import { ScreenTransition } from './ScreenTransition'
import { ScreenTransitionRegistry } from './ScreenTransitionRegistry'

/**
 * @class ScreenCoverTransition
 * @super ScreenTransition
 * @since 0.2.0
 */
export class ScreenCoverTransition extends ScreenTransition {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method onBeforePresent
	 * @since 0.2.0
	 */
	protected onBeforePresent(enter?: Screen, leave?: Screen) {

		if (enter) {
			enter.translationY = '100%'
		}

		if (leave) {
			leave.opacity = 1
		}
	}

	/**
	 * @method onPresent
	 * @since 0.2.0
	 */
	protected onPresent(enter?: Screen, leave?: Screen) {

		if (enter) {
			enter.translationY = '0%'
		}

		if (leave) {
			leave.opacity = 0.75
		}
	}

	/**
	 * @method onAfterPresent
	 * @since 0.2.0
	 */
	protected onAfterPresent(enter?: Screen, leave?: Screen) {

		if (enter) {
			enter.translationY = 0
		}

		if (leave) {
			leave.opacity = 1
		}
	}

	/**
	 * @method onBeforeDismiss
	 * @since 0.2.0
	 */
	protected onBeforeDismiss(enter?: Screen, leave?: Screen) {

		if (enter) {
			enter.opacity = 0.75
		}

		if (leave) {
			leave.translationY = '0%'
		}
	}

	/**
	 * @method onDismiss
	 * @since 0.2.0
	 */
	protected onDismiss(enter?: Screen, leave?: Screen) {

		if (enter) {
			enter.opacity = 1
		}

		if (leave) {
			leave.translationY = '100%'
		}
	}

	/**
	 * @method onAfterDismiss
	 * @since 0.2.0
	 */
	protected onAfterDismiss(enter?: Screen, leave?: Screen) {
		if (enter) enter.translationY = 0
		if (leave) leave.translationY = 0
	}
}

ScreenTransitionRegistry.set('cover', ScreenCoverTransition)