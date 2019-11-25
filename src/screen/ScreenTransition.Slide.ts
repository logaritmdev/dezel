import { Screen } from './Screen'
import { ScreenTransition } from './ScreenTransition'
import { ScreenTransitionRegistry } from './ScreenTransitionRegistry'

/**
 * @class ScreenSlideTransition
 * @super Transition
 * @since 0.2.0
 */
export class ScreenSlideTransition extends ScreenTransition {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method onBeforePresent
	 * @since 0.2.0
	 */
	protected onBeforePresent(enter?: Screen, leave?: Screen) {

		if (enter) {
			enter.translationX = '100%'
			//enter.dismissGesture = new ScreenSlideDismissGesture
		}

		if (leave) {
			leave.translationX = '0%'
			leave.opacity = 1
		}
	}

	/**
	 * @method onPresent
	 * @since 0.2.0
	 */
	protected onPresent(enter?: Screen, leave?: Screen) {

		if (enter) {
			enter.translationX = '0%'
		}

		if (leave) {
			leave.translationX = '-25%'
			leave.opacity = 0.5
		}
	}

	/**
	 * @method onBeforeDismiss
	 * @since 0.2.0
	 */
	protected onBeforeDismiss(enter?: Screen, leave?: Screen) {

		if (enter) {
			enter.translationX = '-25%'
			enter.opacity = 0.5
		}

		if (leave) {
			leave.translationX = '0%'
		}
	}

	/**
	 * @method onDismiss
	 * @since 0.2.0
	 */
	protected onDismiss(enter?: Screen, leave?: Screen) {

		if (enter) {
			enter.translationX = '0%'
			enter.opacity = 1
		}

		if (leave) {
			leave.translationX = '100%'
		}
	}

	/**
	 * @method onAfterPresent
	 * @since 0.2.0
	 */
	protected onAfterPresent(enter?: Screen, leave?: Screen) {
		if (enter) enter.translationX = 0
		if (leave) {
			leave.translationX = 0
			leave.opacity = 1
		}
	}

	/**
	 * @method onAfterDismiss
	 * @since 0.2.0
	 */
	protected onAfterDismiss(enter?: Screen, leave?: Screen) {
		if (enter) enter.translationX = 0
		if (leave) leave.translationX = 0
	}

	/**
	 * @method onProgress
	 * @since 0.5.0
	 */
	protected onDismissProgress(progress: number, enter?: Screen, leave?: Screen) {
		if (leave) leave.translationX = (progress * 100) + '%'
		if (enter) {
			enter.opacity = this.getLeaveScreenOpacity(progress)
			enter.translationX = this.getLeaveScreenTranslation(progress)
		}
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method getLeaveScreenOpacity
	 * @since 0.5.0
	 * @hidden
	 */
	private getLeaveScreenOpacity(progress: number) {
		return 0.5 + (0.5 * progress)
	}

	/**
	 * @method getLeaveScreenOpacity
	 * @since 0.5.0
	 * @hidden
	 */
	private getLeaveScreenTranslation(progress: number) {
		return (25 * (1 - progress) * -1) + '%'
	}
}

ScreenTransitionRegistry.set('slide', ScreenSlideTransition)