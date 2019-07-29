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
	protected onBeforePresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * Prepares the dismissal animation.
	 * @method onBeforeDismiss
	 * @since 0.2.0
	 */
	protected onBeforeDismiss(enter?: Screen, leave?: Screen) {

	}

	/**
	 * Executes the presentation animation.
	 * @method onPresent
	 * @since 0.2.0
	 */
	protected onPresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * Executes the dismissal animation.
	 * @method onDismiss
	 * @since 0.2.0
	 */
	protected onDismiss(enter?: Screen, leave?: Screen) {

	}

	/**
	 * Finishes the presentation animation.
	 * @method onAfterPresent
	 * @since 0.2.0
	 */
	protected onAfterPresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * Finishes the dismissal animation.
	 * @method onAfterDismiss
	 * @since 0.2.0
	 */
	protected onAfterDismiss(enter?: Screen, leave?: Screen) {

	}

	/**
	 * Called when the dismiss transition needs to go to a specific state.
	 * @method onDismissProgress
	 * @since 0.5.0
	 */
	protected onDismissProgress(progress: number, enter?: Screen, leave?: Screen) {

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
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method emitBeforePresent
	 * @since 0.7.0
	 * @hidden
	 */
	public emitBeforePresent(enter?: Screen, leave?: Screen) {
		this.onBeforePresent(enter, leave)
	}

	/**
	 * @method emitBeforeDismiss
	 * @since 0.7.0
	 * @hidden
	 */
	public emitBeforeDismiss(enter?: Screen, leave?: Screen) {
		this.onBeforeDismiss(enter, leave)
	}

	/**
	 * @method emitPresent
	 * @since 0.7.0
	 * @hidden
	 */
	public emitPresent(enter?: Screen, leave?: Screen) {
		this.present(enter, leave)
	}

	/**
	 * @method emitDismiss
	 * @since 0.7.0
	 * @hidden
	 */
	public emitDismiss(enter?: Screen, leave?: Screen) {
		this.onDismiss(enter, leave)
	}

	/**
	 * @method emitAfterPresent
	 * @since 0.7.0
	 * @hidden
	 */
	public emitAfterPresent(enter?: Screen, leave?: Screen) {
		this.onAfterPresent(enter, leave)
	}

	/**
	 * @method emitAfterDismiss
	 * @since 0.7.0
	 * @hidden
	 */
	public emitAfterDismiss(enter?: Screen, leave?: Screen) {
		this.onAfterDismiss(enter, leave)
	}

	/**
	 * @method emitDismissProgress
	 * @since 0.7.0
	 * @hidden
	 */
	public emitDismissProgress(progress: number, enter?: Screen, leave?: Screen) {
		this.onDismissProgress(progress, enter, leave)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property deferred
	 * @since 0.2.0
	 * @hidden
	 */
	private deferred: Deferred | null = null
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