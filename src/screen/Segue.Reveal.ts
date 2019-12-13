import { Screen } from './Screen'
import { Segue } from './Segue'
import { SegueRegistry } from './SegueRegistry'

/**
 * @class RevealSegue
 * @super Segue
 * @since 0.7.0
 */
class RevealSegue extends Segue {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method onBeforePresent
	 * @since 0.7.0
	 */
	public onBeforePresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onPresent
	 * @since 0.7.0
	 */
	public onPresent(enter?: Screen, leave?: Screen) {
		if (enter) enter.translationY = '0%'
	}

	/**
	 * @method onBeforeDismiss
	 * @since 0.7.0
	 */
	public onBeforeDismiss(enter?: Screen, leave?: Screen) {
		if (leave) leave.translationY = '0%'
	}

	/**
	 * @method onDismiss
	 * @since 0.7.0
	 */
	public onDismiss(enter?: Screen, leave?: Screen) {
		if (leave) leave.translationY = '100%'
	}

	/**
	 * @method onAfterPresent
	 * @since 0.7.0
	 */
	public onAfterPresent(enter?: Screen, leave?: Screen) {
		if (enter) enter.translationY = 0
		if (leave) leave.translationY = 0
	}

	/**
	 * @method onAfterDismiss
	 * @since 0.7.0
	 */
	public onAfterDismiss(enter?: Screen, leave?: Screen) {
		if (enter) enter.translationY = 0
		if (leave) leave.translationY = 0
	}
}

SegueRegistry.set('cover', RevealSegue)