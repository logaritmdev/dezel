import { Emitter } from '../event/Emitter'
import { View } from '../view/View'
import { Screen } from './Screen'

/**
 * @class ScreenTransition
 * @super Emitter
 * @since 0.2.0
 */
export class ScreenTransition extends Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property equation
	 * @since 0.2.0
	 */
	public equation: string = 'default'

	/**
	 * @property duration
	 * @since 0.2.0
	 */
	public duration: number = 350

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method onBeforePresent
	 * @since 0.2.0
	 */
	protected onBeforePresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onBeforeDismiss
	 * @since 0.2.0
	 */
	protected onBeforeDismiss(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onPresent
	 * @since 0.2.0
	 */
	protected onPresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onDismiss
	 * @since 0.2.0
	 */
	protected onDismiss(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onAfterPresent
	 * @since 0.2.0
	 */
	protected onAfterPresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onAfterDismiss
	 * @since 0.2.0
	 */
	protected onAfterDismiss(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onDismissProgress
	 * @since 0.5.0
	 */
	protected onDismissProgress(progress: number, enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method present
	 * @since 0.2.0
	 */
	public present(enter?: Screen, leave?: Screen): Promise<void> {
		return this.transition(() => {
			this.onPresent(enter, leave)
		})
	}

	/**
	 * @method dismiss
	 * @since 0.2.0
	 */
	public dismiss(enter?: Screen, leave?: Screen): Promise<void> {
		return this.transition(() => {
			this.onDismiss(enter, leave)
		})
	}

	/**
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
