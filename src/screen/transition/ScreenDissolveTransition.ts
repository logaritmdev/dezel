import { Screen } from '../Screen'
import { ScreenTransition } from './ScreenTransition'
import { ScreenTransitionRegistry } from './ScreenTransition'

/**
 * Performs a transition that fades in the screen.
 * @class ScreenDissolveTransition
 * @super TransitScreenTransitionon
 * @since 0.2.0
 */
export class ScreenDissolveTransition extends ScreenTransition {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onBeforePresent
	 * @since 0.2.0
	 */
	public onBeforePresent(enter?: Screen, leave?: Screen) {
		if (enter) enter.opacity = 0
	}

	/**
	 * @inherited
	 * @method onPresent
	 * @since 0.2.0
	 */
	public onPresent(enter?: Screen, leave?: Screen) {
		if (enter) enter.opacity = 1
	}

	/**
	 * @inherited
	 * @method onAfterPresent
	 * @since 0.2.0
	 */
	public onAfterPresent(enter?: Screen, leave?: Screen) {
		if (enter) enter.opacity = 1
		if (leave) leave.opacity = 1
	}

	/**
	 * @inherited
	 * @method onBeforeDismiss
	 * @since 0.2.0
	 */
	public onBeforeDismiss(enter?: Screen, leave?: Screen) {
		if (leave) leave.opacity = 1
	}

	/**
	 * @inherited
	 * @method onDismiss
	 * @since 0.2.0
	 */
	public onDismiss(enter?: Screen, leave?: Screen) {
		if (leave) leave.opacity = 0
	}

	/**
	 * @inherited
	 * @method onAfterDismiss
	 * @since 0.2.0
	 */
	public onAfterDismiss(enter?: Screen, leave?: Screen) {
		if (leave) leave.opacity = 1
	}
}

ScreenTransitionRegistry.set('dissolve', ScreenDissolveTransition)