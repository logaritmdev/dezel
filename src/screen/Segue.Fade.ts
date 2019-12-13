import { Screen } from './Screen'
import { Segue } from './Segue'
import { SegueRegistry } from './SegueRegistry'

/**
 * @class FadeSegue
 * @super Segue
 * @since 0.7.0
 */
export class FadeSegue extends Segue {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method onBeforePresent
	 * @since 0.7.0
	 */
	public onBeforePresent(enter?: Screen, leave?: Screen) {
		if (enter) enter.opacity = 0
		if (leave) leave.opacity = 1
	}

	/**
	 * @method onPresent
	 * @since 0.7.0
	 */
	public onPresent(enter?: Screen, leave?: Screen) {
		return Promise.resolve()
			.then(() => this.transition(() => { if (leave) leave.opacity = 0 }))
			.then(() => this.transition(() => { if (enter) enter.opacity = 1 }))
	}

	/**
	 * @method onBeforeDismiss
	 * @since 0.7.0
	 */
	public onBeforeDismiss(enter?: Screen, leave?: Screen) {
		if (enter) enter.opacity = 0
		if (leave) leave.opacity = 1
	}

	/**
	 * @method onDismiss
	 * @since 0.7.0
	 */
	public onDismiss(enter?: Screen, leave?: Screen) {
		return Promise.resolve()
			.then(() => this.transition(() => { if (leave) leave.opacity = 0 }))
			.then(() => this.transition(() => { if (enter) enter.opacity = 1 }))
	}

	/**
	 * @method onAfterPresent
	 * @since 0.7.0
	 */
	public onAfterPresent(enter?: Screen, leave?: Screen) {
		if (enter) enter.opacity = 1
		if (leave) leave.opacity = 1
	}

	/**
	 * @method onAfterDismiss
	 * @since 0.7.0
	 */
	public onAfterDismiss(enter?: Screen, leave?: Screen) {
		if (enter) enter.opacity = 1
		if (leave) leave.opacity = 1
	}
}

SegueRegistry.set('fade', FadeSegue)