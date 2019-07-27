import { Screen } from '../Screen'
import { ScreenTransition } from './ScreenTransition'
import { ScreenTransitionRegistry } from './ScreenTransition'

/**
 * Performs a transition that fades out then fades in the screen.
 * @class ScreenFadeTransition
 * @super ScreenTransition
 * @since 0.2.0
 */
export class ScreenFadeTransition extends ScreenTransition {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onBeforePresent
	 * @since 0.2.0
	 */
	protected onBeforePresent(enter?: Screen, leave?: Screen) {
		if (enter) enter.opacity = 0
		if (leave) leave.opacity = 1
	}

	/**
	 * @inherited
	 * @method onPresent
	 * @since 0.2.0
	 */
	protected onPresent(enter?: Screen, leave?: Screen) {
		return Promise.resolve()
			.then(() => this.transition(() => { if (leave) leave.opacity = 0 }))
			.then(() => this.transition(() => { if (enter) enter.opacity = 1 }))
	}

	/**
	 * @inherited
	 * @method onBeforeDismiss
	 * @since 0.2.0
	 */
	protected onBeforeDismiss(enter?: Screen, leave?: Screen) {
		if (enter) enter.opacity = 0
		if (leave) leave.opacity = 1
	}

	/**
	 * @inherited
	 * @method onDismiss
	 * @since 0.2.0
	 */
	protected onDismiss(enter?: Screen, leave?: Screen) {
		return Promise.resolve()
			.then(() => this.transition(() => { if (leave) leave.opacity = 0 }))
			.then(() => this.transition(() => { if (enter) enter.opacity = 1 }))
	}

	/**
	 * @inherited
	 * @method onAfterPresent
	 * @since 0.2.0
	 */
	protected onAfterPresent(enter?: Screen, leave?: Screen) {
		if (enter) enter.opacity = 1
		if (leave) leave.opacity = 1
	}

	/**
	 * @inherited
	 * @method onAfterDismiss
	 * @since 0.2.0
	 */
	protected onAfterDismiss(enter?: Screen, leave?: Screen) {
		if (enter) enter.opacity = 1
		if (leave) leave.opacity = 1
	}
}

ScreenTransitionRegistry.set('fade', ScreenFadeTransition)