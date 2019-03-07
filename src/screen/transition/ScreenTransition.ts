import { Emitter } from '../../event/Emitter'
import { Event } from '../../event/Event'
import { View } from '../../view/View'
import { Screen } from '../Screen'

/**
 * The base class for screen transitions.
 * @class ScreenTransition
 * @super Emitter
 * @since 0.2.0
 */
export class ScreenTransition extends Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The transition's animation duration.
	 * @property duration
	 * @since 0.2.0
	 */
	public duration: number = 350

	/**
	 * The transition's animation equation.
	 * @property equation
	 * @since 0.2.0
	 */
	public equation: string = 'default'

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Prepares the presentation animation.
	 * @method onBeforePresent
	 * @since 0.2.0
	 */
	public onBeforePresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * Prepares the dismissal animation.
	 * @method onBeforeDismiss
	 * @since 0.2.0
	 */
	public onBeforeDismiss(enter?: Screen, leave?: Screen) {

	}

	/**
	 * Executes the presentation animation.
	 * @method onPresent
	 * @since 0.2.0
	 */
	public onPresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * Executes the dismissal animation.
	 * @method onDismiss
	 * @since 0.2.0
	 */
	public onDismiss(enter?: Screen, leave?: Screen) {

	}

	/**
	 * Finishes the presentation animation.
	 * @method onAfterPresent
	 * @since 0.2.0
	 */
	public onAfterPresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * Finishes the dismissal animation.
	 * @method onAfterDismiss
	 * @since 0.2.0
	 */
	public onAfterDismiss(enter?: Screen, leave?: Screen) {

	}

	/**
	 * Called when the dismiss transition needs to go to a specific state.
	 * @method onDismissProgress
	 * @since 0.5.0
	 */
	public onDismissProgress(progress: number, enter?: Screen, leave?: Screen) {

	}

	/**
	 * Plays the presentation animation.
	 * @method present
	 * @since 0.2.0
	 */
	public present(enter?: Screen, leave?: Screen): Promise<void> {
		return this.transition(() => {
			this.onPresent(enter, leave)
		})
	}

	/**
	 * Plays the dismissal animation.
	 * @method dismiss
	 * @since 0.2.0
	 */
	public dismiss(enter?: Screen, leave?: Screen): Promise<void> {
		return this.transition(() => {
			this.onDismiss(enter, leave)
		})
	}

	/**
	 * Executes the transition with the current values.
	 * @method transition
	 * @since 0.2.0
	 */
	public transition(animator: any): Promise<void> {
		return View.transition({
			duration: this.duration,
			equation: this.equation
		}, () => {
			animator()
		})
	}

	/**
	 * Informs the transition needs to wait a little.
	 * @method wait
	 * @since 0.2.0
	 */
	public wait() {

		if (this.deferred) {
			return this
		}

		let deferred: any = {}

		deferred.promise = new Promise((resolve, reject) => {
			deferred.resolve = resolve
			deferred.reject = reject
		})

		this.deferred = deferred as Deferred

		return this
	}

	/**
	 * Informs the transition the waiting is done and it can play.
	 * @method resume
	 * @since 0.5.0
	 */
	public resume() {

		if (this.deferred) {
			this.deferred.resolve()
			this.deferred = null
		}

		return this
	}

	/**
	 * Returns a promise that resolves when the transition can begin.
	 * @method standby
	 * @since 0.2.0
	 */
	public standby() {
		return this.deferred ? this.deferred.promise : Promise.resolve()
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property deferred
	 * @since 0.2.0
	 * @hidden
	 */
	private deferred?: Deferred | null
}

/**
 * @interface Deferred
 * @since 0.2.0
 * @hidden
 */
interface Deferred {
	promise: Promise<void>
	resolve: () => void
	reject: () => void
}

/**
 * @const TransitionRegistry
 * @since 0.2.0
 * @hidden
 */
export const ScreenTransitionRegistry: Map<string, typeof ScreenTransition> = new Map()