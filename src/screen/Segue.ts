import { $dismissing } from './private/Screen'
import { $presented } from './private/Screen'
import { $presenting } from './private/Screen'
import { $dismissGestureState } from './private/Segue'
import { $screen } from './private/Segue'
import { $waiter } from './private/Segue'
import { emitBeforeEnter } from './private/Screen'
import { emitBeforeLeave } from './private/Screen'
import { emitDismiss } from './private/Screen'
import { emitEnter } from './private/Screen'
import { emitLeave } from './private/Screen'
import { isOverlay } from './private/Screen'
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
	// Static
	//--------------------------------------------------------------------------

	/**
	 * @method named
	 * @since 0.7.0
	 */
	public static named(name: string) {

	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property screen
	 * @since 0.7.0
	 */
	public get screen(): Screen {
		return this[$screen]
	}

	/**
	 * @property duration
	 * @since 0.7.0
	 */
	public duration: number = 350

	/**
	 * @property equation
	 * @since 0.7.0
	 */
	public equation: string = 'default'

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

		if (this[$waiter] == null) {
			this[$waiter] = new Waiter()
		}

		return this
	}

	/**
	 * @method done
	 * @since 0.5.0
	 */
	public done() {
		this[$waiter]?.done()
		this[$waiter] = null
		return this
	}

	/**
	 * @method ready
	 * @since 0.7.0
	 */
	public ready() {

		let waiter = this[$waiter]
		if (waiter) {
			return waiter.promise
		}

		return Promise.resolve()
	}

	//--------------------------------------------------------------------------
	// Protected API
	//--------------------------------------------------------------------------

	/**
	 * @method detectDismissGesture
	 * @since 0.7.0
	 */
	public async detectDismissGesture() {

		try {

			let dismissedScreen = this.screen
			let presentedScreen = this.screen.presenter

			if (presentedScreen == null) {
				throw new Error(`Segue error: Missing presenter screen.`)
			}

			setDismissGestureState(this, State.Detected)

			dismissedScreen[$dismissing] = true
			presentedScreen[$presenting] = true

			presentedScreen.visible = true
			presentedScreen.resolve()

			this.onDismissGestureDetect(
				presentedScreen,
				dismissedScreen
			)

			presentedScreen.updateStatusBar()

			this.onBeforeDismiss(
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
	public async updateDismissGesture() {

		try {

			let dismissedScreen = this.screen
			let presentedScreen = this.screen.presenter

			if (presentedScreen == null) {
				throw new Error(`Segue error: Missing presenter screen.`)
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
	public async cancelDismmissGesture() {

		try {

			let window = this.screen.window!

			let dismissedScreen = this.screen
			let presentedScreen = this.screen.presenter

			if (presentedScreen == null) {
				throw new Error(`Segue error: Missing presenter screen.`)
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

			presentedScreen.visible = isOverlay(presentedScreen) ? true : false

			dismissedScreen[$dismissing] = false
			presentedScreen[$presenting] = false

			this[$dismissGestureState] = State.Allowed

			window.touchable = true

		} catch (e) {
			console.error(e)
		}
	}

	/**
	 * @method finishDismissGesture
	 * @since 0.7.0
	 */
	public async finishDismissGesture() {

		try {

			let window = this.screen.window!

			let dismissedScreen = this.screen
			let presentedScreen = this.screen.presenter

			if (presentedScreen == null) {
				throw new Error(`Segue error: Missing presenter screen.`)
			}

			window.touchable = false

			await this.dismiss(
				presentedScreen,
				dismissedScreen
			)

			this.onAfterDismiss(
				presentedScreen,
				dismissedScreen
			)

			emitLeave(dismissedScreen, this)
			emitDismiss(dismissedScreen, this)
			emitEnter(presentedScreen, this)

			dismissedScreen.dispose()

			dismissedScreen[$presented] = false
			presentedScreen[$presented] = true
			dismissedScreen[$presenting] = false
			presentedScreen[$presenting] = false

			this[$dismissGestureState] = State.Allowed

			window.touchable = true

		} catch (e) {
			console.error(e)
		}
	}

	/**
	 * @method onBeforePresent
	 * @since 0.7.0
	 */
	public onBeforePresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onBeforeDismiss
	 * @since 0.7.0
	 */
	public onBeforeDismiss(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onPresent
	 * @since 0.7.0
	 */
	public onPresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onDismiss
	 * @since 0.7.0
	 */
	public onDismiss(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onAfterPresent
	 * @since 0.7.0
	 */
	public onAfterPresent(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onAfterDismiss
	 * @since 0.7.0
	 */
	public onAfterDismiss(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onDismissGestureDetect
	 * @since 0.7.0
	 */
	public onDismissGestureDetect(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onDismissGestureUpdate
	 * @since 0.7.0
	 */
	public onDismissGestureUpdate(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onDismissGestureCancel
	 * @since 0.7.0
	 */
	public onDismissGestureCancel(enter?: Screen, leave?: Screen) {

	}

	/**
	 * @method onDismissGestureFinish
	 * @since 0.7.0
	 */
	public onDismissGestureFinish(enter?: Screen, leave?: Screen) {

	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $screen
	 * @since 0.7.0
	 * @hidden
	 */
	private [$screen]: Screen

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
