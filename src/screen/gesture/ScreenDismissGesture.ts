import { bound } from '../../decorator/bound'
import { TouchEvent } from '../../touch/TouchEvent'
import { ScreenTransition } from '../transition/ScreenTransition'
import { DISMISSING } from '../Screen'
import { Screen } from '../Screen'
import { TRANSITION } from '../Screen'

/**
 * @symbol SCREEN
 * @since 0.5.0
 */
export const SCREEN = Symbol('screen')

/**
 * The base class to implement dismiss gestures.
 * @class ScreenDismissGesture
 * @since 0.5.0
 */
export class ScreenDismissGesture {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The screen who's gesture is attached to.
	 * @property screen
	 * @since 0.5.0
	 */
	public get screen(): Screen {
		return this[SCREEN]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Indicate that the gesture has begun.
	 * @method begin
	 * @since 0.5.0
	 */
	public async begin() {

		try {

			let screen = this.screen
			if (screen == null) {
				return
			}

			let dismissedScreen = screen
			let presentedScreen = screen.presenter
			if (presentedScreen == null) {
				return
			}

			dismissedScreen[DISMISSING] = true

			presentedScreen.visible = true
			presentedScreen.resolve()

			let transition = this.transition
			if (transition == null) {
				return
			}

			transition.onBeforeDismiss(
				presentedScreen,
				dismissedScreen
			)

			await dismissedScreen.emitBeforeLeave(transition)
			await presentedScreen.emitBeforeEnter(transition)

			presentedScreen.updateStatusBar()

		} catch (e) {
			console.error(e)
		}
	}

	/**
	 * Indicates the gesture current progress.
	 * @method cancel
	 * @since 0.5.0
	 */
	public async progress(progress: number) {

		try {

			let screen = this.screen
			if (screen == null) {
				return
			}

			let dismissedScreen = screen
			let presentedScreen = screen.presenter
			if (presentedScreen == null) {
				return
			}

			let transition = this.transition
			if (transition == null) {
				return
			}

			transition.onDismissProgress(
				progress,
				presentedScreen,
				dismissedScreen
			)

		} catch (e) {
			console.error(e)
		}
	}

	/**
	 * Indicate that the gesture has been canceled.
	 * @method cancel
	 * @since 0.5.0
	 */
	public async cancel() {

		try {

			let screen = this.screen
			if (screen == null) {
				return
			}

			let window = screen.window
			if (window == null) {
				return
			}

			let dismissedScreen = screen
			let presentedScreen = screen.presenter
			if (presentedScreen == null) {
				return
			}

			let transition = this.transition
			if (transition == null) {
				return
			}

			window.touchable = false

			/*
			 * The parameters are inversed because we simply want to animate
			 * the current presented screen back into its place.
			 */

			await transition.present(
				dismissedScreen,
				presentedScreen
			)

			await dismissedScreen.emitEnter(transition)
			await presentedScreen.emitLeave(transition)

			dismissedScreen.updateStatusBar()

			dismissedScreen[DISMISSING] = false

			presentedScreen.visible = false

			window.touchable = true

		} catch (e) {
			console.error(e)
		}
	}

	/**
	 * Indicate that the gesture has finished successfully.
	 * @method finish
	 * @since 0.5.0
	 */
	public async finish() {

		try {

			let screen = this.screen
			if (screen == null) {
				return
			}

			let window = screen.window
			if (window == null) {
				return
			}

			let dismissedScreen = screen
			let presentedScreen = screen.presenter
			if (presentedScreen == null) {
				return
			}

			let transition = this.transition
			if (transition == null) {
				return
			}

			window.touchable = false

			await transition.dismiss(
				presentedScreen,
				dismissedScreen
			)

			transition.onAfterDismiss(
				presentedScreen,
				dismissedScreen
			)

			await dismissedScreen.emitLeave(transition)
			await presentedScreen.emitEnter(transition)
			await dismissedScreen.emitDismiss(transition)

			dismissedScreen.setActive(false)
			presentedScreen.setActive(true)

			presentedScreen.updateStatusBar()

			dismissedScreen[DISMISSING] = false

			dismissedScreen.dispose()

			if (dismissedScreen.enclosure) {
				dismissedScreen.enclosure.destroy()
				dismissedScreen.enclosure = null
			}

			window.touchable = true

		} catch (e) {
			console.error(e)
		}
	}

	//--------------------------------------------------------------------------
	// Methods to override
	//--------------------------------------------------------------------------

	/**
	 * Called when the gesture is attached to the screen.
	 * @method onAttach
	 * @sine 0.5.0
	 */
	public onAttach() {

	}

	/**
	 * Called when the gesture is detached from the screen.
	 * @method onDetach
	 * @sine 0.5.0
	 */
	public onDetach() {

	}

	/**
	 * Called when a touch cancel event occurs.
	 * @method onTouchCancel
	 * @since 0.5.0
	 */
	public onTouchCancel(event: TouchEvent) {

	}

	/**
	 * Called when a touch start event occurs.
	 * @method onTouchStart
	 * @since 0.5.0
	 */
	public onTouchStart(event: TouchEvent) {

	}

	/**
	 * Called when a touch move event occurs.
	 * @method onTouchMove
	 * @since 0.5.0
	 */
	public onTouchMove(event: TouchEvent) {

	}

	/**
	 * Called when a touch end event occurs.
	 * @method onTouchEnd
	 * @since 0.5.0
	 */
	public onTouchEnd(event: TouchEvent) {

	}

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * Attach the gesture to the specified screen.
	 * @method attach
	 * @since 0.5.0
	 */
	public attach(screen: Screen) {

		this[SCREEN] = screen
		this[SCREEN].on('touchcancel', this.onTouchCancelDefault)
		this[SCREEN].on('touchstart', this.onTouchStartDefault)
		this[SCREEN].on('touchmove', this.onTouchMoveDefault)
		this[SCREEN].on('touchend', this.onTouchEndDefault)

		this.onAttach()

		return this
	}

	/**
	 * Detach the gesture from the specified screen.
	 * @method attach
	 * @since 0.5.0
	 */
	public detach() {

		this[SCREEN].off('touchcancel', this.onTouchCancelDefault)
		this[SCREEN].off('touchstart', this.onTouchStartDefault)
		this[SCREEN].off('touchmove', this.onTouchMoveDefault)
		this[SCREEN].off('touchend', this.onTouchEndDefault)

		this.onDetach()

		return this
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property [SCREEN]
	 * @since 0.5.0
	 * @hidden
	 */
	private [SCREEN]: Screen

	/**
	 * @property transition
	 * @since 0.5.0
	 * @hidden
	 */
	private get transition(): ScreenTransition | null | undefined {

		let screen = this.screen
		if (screen) {
			return screen[TRANSITION]
		}

		return null
	}

	/**
	 * @method onTouchEvent
	 * @since 0.5.0
	 * @hidden
	 */
	private onTouchEvent(event: TouchEvent) {

		switch (event.type) {

			case 'touchcancel':
				this.onTouchCancel(event)
				break

			case 'touchstart':
				this.onTouchStart(event)
				break

			case 'touchmove':
				this.onTouchMove(event)
				break

			case 'touchend':
				this.onTouchEnd(event)
				break
		}
	}

	/**
	 * @method onTouchCancelDefault
	 * @since 0.5.0
	 * @hidden
	 */
	@bound private onTouchCancelDefault(event: TouchEvent) {
		this.onTouchEvent(event)
	}

	/**
	 * @method onTouchStartDefault
	 * @since 0.5.0
	 * @hidden
	 */
	@bound private onTouchStartDefault(event: TouchEvent) {
		this.onTouchEvent(event)
	}

	/**
	 * @method onTouchMoveDefault
	 * @since 0.5.0
	 * @hidden
	 */
	@bound private onTouchMoveDefault(event: TouchEvent) {
		this.onTouchEvent(event)
	}

	/**
	 * @method onTouchEndDefault
	 * @since 0.5.0
	 * @hidden
	 */
	@bound private onTouchEndDefault(event: TouchEvent) {
		this.onTouchEvent(event)
	}
}