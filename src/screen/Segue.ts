import { $frame } from './symbol/Screen'
import { $dismissGestureState } from './symbol/Segue'
import { $screen } from './symbol/Segue'
import { $waiter } from './symbol/Segue'
import { emitBeforeEnter } from './private/Screen'
import { emitBeforeLeave } from './private/Screen'
import { emitDismiss } from './private/Screen'
import { emitEnter } from './private/Screen'
import { emitLeave } from './private/Screen'
import { isScreenOverlay } from './private/Screen'
import { setScreenDismissing } from './private/Screen'
import { setScreenPresented } from './private/Screen'
import { setScreenPresenting } from './private/Screen'
import { setDismissGestureState } from './private/Segue'
import { Emitter } from '../event/Emitter'
import { State } from '../gesture/GestureDetector'
import { View } from '../view/View'
import { Waiter } from './private/Waiter'
import { Screen } from './Screen'

/**
 * @class Segue
 * @super Emitter
 * @since 0.7.0
 */
export class Segue extends Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property screen
	 * @since 0.7.0
	 */
	public get screen(): Screen {
		return this[$screen]!
	}

	/**
	 * @property equation
	 * @since 0.7.0
	 */
	public equation: string = 'default'

	/**
	 * @property duration
	 * @since 0.7.0
	 */
	public duration: number = 350

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method configure
	 * @since 0.7.0
	 */
	public configure() {

	}

	/**
	 * @method dispose
	 * @since 0.7.0
	 */
	public dispose() {

	}

	/**
	 * @method present
	 * @since 0.7.0
	 */
	public present(enter?: Screen, leave?: Screen): Promise<void> {
		return this.transition(() => {
			this.onPresent(enter, leave)
		})
	}

	/**
	 * @method dismiss
	 * @since 0.7.0
	 */
	public dismiss(enter?: Screen, leave?: Screen): Promise<void> {
		return this.transition(() => {
			this.onDismiss(enter, leave)
		})
	}

	/**
	 * @method transition
	 * @since 0.7.0
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
	 * @since 0.7.0
	 */
	public wait() {

		if (this[$waiter] = null) {
			this[$waiter] = new Waiter()
		}

		return this
	}

	/**
	 * @method resume
	 * @since 0.5.0
	 */
	public resume() {

		if (this[$waiter]) {
			this[$waiter]?.clear()
			this[$waiter] = null
		}

		return this
	}

	/**
	 * @method standby
	 * @since 0.7.0
	 */
	public standby() {

		let waiter = this[$waiter]
		if (waiter == null) {
			return Promise.resolve()
		}

		return waiter.promise
	}

	//--------------------------------------------------------------------------
	// Protected API
	//--------------------------------------------------------------------------

	/**
	 * @method detectDismissGesture
	 * @since 0.7.0
	 */
	protected async detectDismissGesture() {

		try {

			let dismissedScreen = this.screen
			let presentedScreen = this.screen.presenter

			if (presentedScreen == null) {
				throw new Error(
					`Segue error: Missing presenter screen.`
				)
			}

			setDismissGestureState(this, State.Detected)

			setScreenDismissing(dismissedScreen, true)
			setScreenPresenting(presentedScreen, true)

			presentedScreen.visible = true
			presentedScreen.resolve()

			this.onDismissGestureDetect(
				presentedScreen,
				dismissedScreen
			)

			presentedScreen.updateStatusBar()

			this.invokeBeforeDismiss(
				presentedScreen,
				dismissedScreen
			)

			await emitBeforeLeave(dismissedScreen, this)
			await emitBeforeEnter(presentedScreen, this)

		} catch (e) {
			console.error(e)
		}
	}

	/**
	 * @method updateDismissGesture
	 * @since 0.7.0
	 */
	protected async updateDismissGesture() {

		try {

			let dismissedScreen = this.screen
			let presentedScreen = this.screen.presenter

			if (presentedScreen == null) {
				throw new Error(
					`Segue error: Missing presenter screen.`
				)
			}

			setDismissGestureState(this, State.Updated)

			this.onDismissGestureUpdate(
				presentedScreen,
				dismissedScreen
			)

		} catch (e) {
			console.error(e)
		}
	}

	/**
	 * @method cancelDismmissGesture
	 * @since 0.7.0
	 */
	protected async cancelDismmissGesture() {

		try {

			let window = this.screen.window!

			let dismissedScreen = this.screen
			let presentedScreen = this.screen.presenter

			if (presentedScreen == null) {
				throw new Error(
					`Segue error: Missing presenter screen.`
				)
			}

			setDismissGestureState(this, State.Canceled)

			window.touchable = false

			this.onDismissGestureCancel(
				presentedScreen,
				dismissedScreen
			)

			dismissedScreen.updateStatusBar()

			await this.present(
				dismissedScreen,
				presentedScreen
			)

			await emitEnter(dismissedScreen, this)
			await emitLeave(presentedScreen, this)

			presentedScreen.visible = isScreenOverlay(presentedScreen) ? true : false

			setScreenDismissing(dismissedScreen, false)
			setScreenPresenting(presentedScreen, false)

			window.touchable = true

			this.resetDismissGesture()

		} catch (e) {
			console.error(e)
		}
	}

	/**
	 * @method finishDismissGesture
	 * @since 0.7.0
	 */
	protected async finishDismissGesture() {

		try {

			let window = this.screen.window!

			let dismissedScreen = this.screen
			let presentedScreen = this.screen.presenter

			if (presentedScreen == null) {
				throw new Error(
					`Segue error: Missing presenter screen.`
				)
			}

			window.touchable = false

			await this.dismiss(
				presentedScreen,
				dismissedScreen
			)

			this.invokeAfterDismiss(
				presentedScreen,
				dismissedScreen
			)

			emitLeave(dismissedScreen, this)
			emitDismiss(dismissedScreen, this)
			emitEnter(presentedScreen, this)

			dismissedScreen.dispose()

			setScreenPresented(dismissedScreen, false)
			setScreenPresented(presentedScreen, true)
			setScreenDismissing(dismissedScreen, false)
			setScreenPresenting(presentedScreen, false)

			window.touchable = true

			this.resetDismissGesture()

		} catch (e) {
			console.error(e)
		}
	}

	/**
	 * @method resetDismissGesture
	 * @since 0.7.0
	 */
	protected resetDismissGesture() {
		this[$dismissGestureState] = State.Allowed
		return this
	}

	/**
	 * @method onBeforePresent
	 * @since 0.7.0
	 */
	protected onBeforePresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onBeforeDismiss
	 * @since 0.7.0
	 */
	protected onBeforeDismiss(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onPresent
	 * @since 0.7.0
	 */
	protected onPresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onDismiss
	 * @since 0.7.0
	 */
	protected onDismiss(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onAfterPresent
	 * @since 0.7.0
	 */
	protected onAfterPresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onAfterDismiss
	 * @since 0.7.0
	 */
	protected onAfterDismiss(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onDismissGestureDetect
	 * @since 0.7.0
	 */
	protected onDismissGestureDetect(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onDismissGestureUpdate
	 * @since 0.7.0
	 */
	protected onDismissGestureUpdate(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onDismissGestureCancel
	 * @since 0.7.0
	 */
	protected onDismissGestureCancel(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onDismissGestureFinish
	 * @since 0.7.0
	 */
	protected onDismissGestureFinish(enter?: Screen, leave?: Screen) {

	}

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method invokeBeforePresent
	 * @since 0.7.0
	 * @hidden
	 */
	public invokeBeforePresent(enter?: Screen, leave?: Screen) {
		this.onBeforePresent(enter, leave)
	}

	/**
	 * @method invokeBeforeDismiss
	 * @since 0.7.0
	 * @hidden
	 */
	public invokeBeforeDismiss(enter?: Screen, leave?: Screen) {
		this.onBeforeDismiss(enter, leave)
	}

	/**
	 * @method invokePresent
	 * @since 0.7.0
	 * @hidden
	 */
	public invokePresent(enter?: Screen, leave?: Screen) {
		this.present(enter, leave)
	}

	/**
	 * @method invokeDismiss
	 * @since 0.7.0
	 * @hidden
	 */
	public invokeDismiss(enter?: Screen, leave?: Screen) {
		this.onDismiss(enter, leave)
	}

	/**
	 * @method invokeAfterPresent
	 * @since 0.7.0
	 * @hidden
	 */
	public invokeAfterPresent(enter?: Screen, leave?: Screen) {
		this.onAfterPresent(enter, leave)
	}

	/**
	 * @method invokeAfterDismiss
	 * @since 0.7.0
	 * @hidden
	 */
	public invokeAfterDismiss(enter?: Screen, leave?: Screen) {
		this.onAfterDismiss(enter, leave)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $screen
	 * @since 0.7.0
	 * @hidden
	 */
	private [$screen]: Screen | null = null

	/**
	 * @property $waiter
	 * @since 0.7.0
	 * @hidden
	 */
	private [$waiter]: Waiter | null = null

	/**
	 * @property $dismissGestureState
	 * @since 0.7.0
	 * @hidden
	 */
	private [$dismissGestureState]: State = State.Allowed
}
