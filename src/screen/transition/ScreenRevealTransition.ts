import { Screen } from '../Screen'
import { ScreenTransition } from './ScreenTransition'
import { ScreenTransitionRegistry } from './ScreenTransition'

/**
 * @class ScreenRevealTransition
 * @super ScreenTransition
 * @since 0.2.0
 */
export class ScreenRevealTransition extends ScreenTransition {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onBeforePresent
	 * @since 0.2.0
	 */
	public onBeforePresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @inherited
	 * @method onPresent
	 * @since 0.2.0
	 */
	public onPresent(enter?: Screen, leave?: Screen) {
		if (enter) enter.translationY = '0%'
	}

	/**
	 * @inherited
	 * @method onBeforeDismiss
	 * @since 0.2.0
	 */
	public onBeforeDismiss(enter?: Screen, leave?: Screen) {
		if (leave) leave.translationY = '0%'
	}

	/**
	 * @inherited
	 * @method onDismiss
	 * @since 0.2.0
	 */
	public onDismiss(enter?: Screen, leave?: Screen) {
		if (leave) leave.translationY = '100%'
	}

	/**
	 * @inherited
	 * @method onAfterPresent
	 * @since 0.2.0
	 */
	public onAfterPresent(enter?: Screen, leave?: Screen) {
		if (enter) enter.translationY = 0
		if (leave) leave.translationY = 0
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

ScreenTransitionRegistry.set('cover', ScreenRevealTransition)