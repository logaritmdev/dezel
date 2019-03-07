import { ScreenSlideDismissGesture } from '../gesture/ScreenSlideDismissGesture'
import { Screen } from '../Screen'
import { ScreenTransition } from './ScreenTransition'
import { ScreenTransitionRegistry } from './ScreenTransition'

/**
 * Performs a transition that slides the screen horizontally.
 * @class ScreenSlideTransition
 * @super Transition
 * @since 0.2.0
 */
export class ScreenSlideTransition extends ScreenTransition {

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
			enter.translationX = '100%'
			enter.dismissGesture = new ScreenSlideDismissGesture
		}

		if (leave) {
			leave.translationX = '0%'
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
			enter.translationX = '0%'
		}

		if (leave) {
			leave.translationX = '-25%'
			leave.opacity = 0.5
		}
	}

	/**
	 * @inherited
	 * @method onBeforeDismiss
	 * @since 0.2.0
	 */
	public onBeforeDismiss(enter?: Screen, leave?: Screen) {

		if (enter) {
			enter.translationX = '-25%'
			enter.opacity = 0.5
		}

		if (leave) {
			leave.translationX = '0%'
		}
	}

	/**
	 * @inherited
	 * @method onDismiss
	 * @since 0.2.0
	 */
	public onDismiss(enter?: Screen, leave?: Screen) {

		if (enter) {
			enter.translationX = '0%'
			enter.opacity = 1
		}

		if (leave) {
			leave.translationX = '100%'
		}
	}

	/**
	 * @inherited
	 * @method onAfterPresent
	 * @since 0.2.0
	 */
	public onAfterPresent(enter?: Screen, leave?: Screen) {
		if (enter) enter.translationX = 0
		if (leave) {
			leave.translationX = 0
			leave.opacity = 1
		}
	}

	/**
	 * @inherited
	 * @method onAfterDismiss
	 * @since 0.2.0
	 */
	public onAfterDismiss(enter?: Screen, leave?: Screen) {
		if (enter) enter.translationX = 0
		if (leave) leave.translationX = 0
	}

	/**
	 * @inherited
	 * @method onProgress
	 * @since 0.5.0
	 */
	public onDismissProgress(progress: number, enter?: Screen, leave?: Screen) {
		if (leave) leave.translationX = (progress * 100) + '%'
		if (enter) {
			enter.opacity = this.getLeaveScreenOpacity(progress)
			enter.translationX = this.getLeaveScreenTranslation(progress)
		}
	}

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