import '../index'
import { $frame } from '../screen/symbol/Screen'
import { $screen } from './symbol/Application'
import { $touches } from './symbol/Application'
import { watch } from '../decorator/watch'
import { bridge } from '../native/bridge'
import { native } from '../native/native'
import { createScreenFrame } from '../screen/private/Screen'
import { emitBeforeEnter } from '../screen/private/Screen'
import { emitBeforePresent } from '../screen/private/Screen'
import { emitEnter } from '../screen/private/Screen'
import { emitPresent } from '../screen/private/Screen'
import { getScreenSegue } from '../screen/private/Screen'
import { setScreenPresented } from '../screen/private/Screen'
import { setScreenSegue } from '../screen/private/Screen'
import { setTouchCanceled } from '../touch/private/Touch'
import { setTouchCaptured } from '../touch/private/Touch'
import { setTouchId } from '../touch/private/Touch'
import { setTouchTarget } from '../touch/private/Touch'
import { setTouchX } from '../touch/private/Touch'
import { setTouchY } from '../touch/private/Touch'
import { cancelTouchMove } from './private/Application'
import { cancelTouchStart } from './private/Application'
import { captureTouchMove } from './private/Application'
import { captureTouchStart } from './private/Application'
import { getTouch } from './private/Application'
import { mapTarget } from './private/Application'
import { registerTouch } from './private/Application'
import { toActiveTouchList } from './private/Application'
import { toTargetTouchList } from './private/Application'
import { toTouchList } from './private/Application'
import { updateEventTarget } from './private/Application'
import { updateInputTouches } from './private/Application'
import { Emitter } from '../event/Emitter'
import { Event } from '../event/Event'
import { Frame } from '../screen/Frame'
import { Screen } from '../screen/Screen'
import { NoneSegue } from '../screen/Segue.None'
import { Touch } from '../touch/Touch'
import { TouchEvent } from '../touch/TouchEvent'
import { View } from '../view/View'
import { Window } from '../view/Window'

@bridge('dezel.application.Application')

/**
 * @class Application
 * @super Emitter
 * @since 0.1.0
 */
export class Application extends Emitter {

	//--------------------------------------------------------------------------
	// Static Propertis
	//--------------------------------------------------------------------------

	/**
	 * @property main
	 * @since 0.5.0
	 */
	public static get main(): Application | null {
		return main
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property window
	 * @since 0.1.0
	 */
	@native public readonly window: Window

	/**
	 * @property state
	 * @since 0.1.0
	 */
	@native public readonly state!: 'foreground' | 'background'

	/**
	 * @property statusBarVisible
	 * @since 0.1.0
	 */
	@native public statusBarVisible!: boolean

	/**
	 * @property statusBarForegroundColor
	 * @since 0.1.0
	 */
	@native public statusBarForegroundColor!: 'white' | 'black'

	/**
	 * @property statusBarBackgroundColor
	 * @since 0.1.0
	 */
	@native public statusBarBackgroundColor!: string

	/**
	 * @property badge
	 * @since 0.1.0
	 */
	@native public badge!: number

	/**
	 * @property screen
	 * @since 0.1.0
	 */
	public get screen(): Screen {

		let screen = this[$screen]
		if (screen == null) {
			throw new Error(`
				Application error: The application has no screen, did to forget to call present() ?
			`)
		}

		return screen
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	constructor() {

		super()

		if (main) {
			main.destroy()
			main = null
		}

		main = this

		this.window = new Window()

		return this
	}

	/**
	 * @method present
	 * @since 0.7.0
	 */
	public present(screen: Screen) {

		if (this[$screen]) {
			throw new Error(`
				Application error: The application already has a screen.
			`)
		}

		createScreenFrame(screen)

		this.window.append(screen[$frame]!)

		screen.updateStatusBar()

		let segue = new NoneSegue()

		setScreenSegue(screen, segue)

		emitBeforePresent(screen, segue)
		emitBeforeEnter(screen, segue)
		emitPresent(screen, segue)
		emitEnter(screen, segue)

		setScreenPresented(screen, true)

		return this
	}

	/**
	 * @method destroy
	 * @since 0.2.0
	 */
	public destroy() {

		this.emit('destroy')

		if (this.window) {
			this.window.destroy()
		}

		return this
	}

	/**
	 * @method openURL
	 * @since 0.1.0
	 */
	public openURL(url: string) {
		native(this).openURL(url)
		return this
	}

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method dispatchTouchStart
	 * @since 0.7.0
	 */
	public dispatchTouchStart(inputs: Array<InputTouch>) {

		let targets = new Map()

		/*
		 * Registers the new touches, find and assign their target and map
		 * these touches by target so each group of touches with the same
		 * target will become an event.
		 */

		for (let input of inputs) {

			let target = this.window.findViewAt(
				input.x,
				input.y
			)

			if (target == null) {
				continue
			}

			let touch = new Touch(target)

			setTouchId(touch, input.id)
			setTouchX(touch, input.x)
			setTouchY(touch, input.y)
			mapTarget(touch, targets)

			registerTouch(this, input, touch)
		}

		/*
		 * Dispatches a touchstart event for each group of touches in the
		 * same target. Updates the touch data on the native side if the
		 * event has been captured or canceled.
		 */

		for (let [target, touches] of targets) {

			let event = new TouchEvent('touchstart', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: toTouchList(touches),
				activeTouches: toActiveTouchList(this[$touches]),
				targetTouches: toTargetTouchList(this[$touches], target)
			})

			target.emit(event)

			if (event.canceled ||
				event.captured) {

				updateInputTouches(event, inputs)

				switch (true) {
					case event.canceled: cancelTouchStart(event); break
					case event.captured: captureTouchStart(event); break
				}

				/*
				 * When captured, all subsequents touch events will be sent
				 * directly to the target that captured the touch and no one
				 * else. Update the event target to ensure the next touch
				 * events are sent to this new target.
				 */

				if (event.captured) {
					updateEventTarget(event, event.sender)
				}
			}
		}

		return this
	}

	/**
	 * @method dispatchTouchMove
	 * @since 0.7.0
	 */
	public dispatchTouchMove(inputs: Array<InputTouch>) {

		let targets = new Map<View, Array<Touch>>()

		/*
		 * Update the touches position for each inputs. Map these touches by
		 * targets so each group of touches with the same target will become
		 * an event.
		 */

		for (let input of inputs) {

			let touch = getTouch(this, input)
			if (touch == null) {
				continue
			}

			setTouchX(touch, input.x)
			setTouchY(touch, input.y)
			mapTarget(touch, targets)
		}

		/*
		 * Dispatches a touchmove event for each group of touches in the
		 * same target. Updates the touch data on the native side if the
		 * event has been captured or canceled.
		 */

		for (let [target, touches] of targets) {

			let captured = touches.some(touch => {
				return touch.captured
			})

			let event = new TouchEvent('touchmove', {
				propagable: captured == false,
				capturable: captured == false,
				cancelable: true,
				touches: toTouchList(touches),
				activeTouches: toActiveTouchList(this[$touches]),
				targetTouches: toTargetTouchList(this[$touches], target)
			})

			target.emit(event)

			if (event.canceled ||
				event.captured) {

				updateInputTouches(event, inputs)

				switch (true) {
					case event.canceled: cancelTouchMove(event); break
					case event.captured: captureTouchMove(event); break
				}

				/*
				 * When captured, all subsequents touch events will be sent
				 * directly to the target that captured the touch and no one
				 * else. Update the event target to ensure the next touch
				 * events are sent to this new target.
				 */

				if (event.captured) {
					updateEventTarget(event, event.sender)
				}
			}
		}

		return this
	}

	/**
	 * @method dispatchTouchEnd
	 * @since 0.7.0
	 */
	public dispatchTouchEnd(inputs: Array<InputTouch>) {

		let targets = new Map<View, Array<Touch>>()

		/*
		 * Update the touches position for each inputs. Map these touches by
		 * targets so each group of touches with the same target will become
		 * an event.
		 */

		let ended: Array<Touch> = []

		for (let input of inputs) {

			let touch = getTouch(this, input)
			if (touch == null) {
				continue
			}

			setTouchX(touch, input.x)
			setTouchY(touch, input.y)
			mapTarget(touch, targets)

			ended.push(touch)

			delete this[$touches][input.id]
		}

		/*
		 * Dispatches a touchend event for each group of touches in the
		 * same target then reset each touches in case they were stored
		 * elsewhere.
		 */

		for (let [target, touches] of targets) {

			let captured = touches.some(touch => {
				return touch.captured
			})

			let event = new TouchEvent('touchend', {
				propagable: captured == false,
				capturable: false,
				cancelable: true,
				touches: toTouchList(touches),
				activeTouches: toActiveTouchList(this[$touches]),
				targetTouches: toTargetTouchList(this[$touches], target)
			})

			target.emit(event)
		}

		/*
		 * Reset the touches that were ended just in case the're stored
		 * somewhere else.
		 */

		for (let touch of ended) {
			setTouchTarget(touch, null)
			setTouchCanceled(touch, false)
			setTouchCaptured(touch, false)
			setTouchId(touch, 0)
			setTouchX(touch, 0)
			setTouchY(touch, 0)
		}

		return this
	}

	/**
	 * @method dispatchTouchCancel
	 * @since 0.7.0
	 */
	public dispatchTouchCancel(inputs: Array<InputTouch>) {

		let targets = new Map<View, Array<Touch>>()

		/*
		 * Update the touches position for each inputs. Map these touches by
		 * targets so each group of touches with the same target will become
		 * an event.
		 */

		let ended: Array<Touch> = []

		for (let input of inputs) {

			let touch = getTouch(this, input)
			if (touch == null) {
				continue
			}

			setTouchX(touch, input.x)
			setTouchY(touch, input.y)
			mapTarget(touch, targets)

			ended.push(touch)
		}

		/*
		 * Dispatches a touchend event for each group of touches in the
		 * same target then reset each touches in case they were stored
		 * elsewhere.
		 */

		for (let [target, touches] of targets) {

			let captured = touches.some(touch => {
				return touch.captured
			})

			let event = new TouchEvent('touchcancel', {
				propagable: captured == false,
				capturable: false,
				cancelable: false,
				touches: toTouchList(touches),
				activeTouches: toActiveTouchList(this[$touches]),
				targetTouches: toTargetTouchList(this[$touches], target)
			})

			target.emit(event)
		}

		/*
		 * Reset the touches that were ended just in case the're stored
		 * somewhere else.
		 */

		for (let touch of ended) {
			setTouchTarget(touch, null)
			setTouchCanceled(touch, false)
			setTouchCaptured(touch, false)
			setTouchId(touch, 0)
			setTouchX(touch, 0)
			setTouchY(touch, 0)
		}

		return this
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @method onEvent
	 * @since 0.7.0
	 */
	public onEvent(event: Event) {

		switch (event.type) {

			case 'create':
				this.onCreate(event)
				break

			case 'destroy':
				this.onDestroy(event)
				break

			case 'enterbackground':
				this.onEnterBackground(event)
				break

			case 'enterforeground':
				this.onEnterForeground(event)
				break

			case 'beforekeyboardshow':
				this.onBeforeKeyboardShow(event)
				break

			case 'beforekeyboardhide':
				this.onBeforeKeyboardHide(event)
				break

			case 'keyboardshow':
				this.onKeyboardShow(event)
				break

			case 'keyboardhide':
				this.onKeyboardHide(event)
				break

			case 'keyboardresize':
				this.onKeyboardResize(event)
				break

			case 'openuniversalurl':
				this.onOpenUniversalURL(event)
				break

			case 'openresourceurl':
				this.onOpenResourceURL(event)
				break
		}

		return super.onEvent(event)
	}

	/**
	 * @method onCreate
	 * @since 0.4.0
	 */
	protected onCreate(event: Event) {

	}

	/**
	 * @method onDestroy
	 * @since 0.4.0
	 */
	protected onDestroy(event: Event) {

	}

	/**
	 * @method onEnterBackground
	 * @since 0.4.0
	 */
	protected onEnterBackground(event: Event) {

	}

	/**
	 * @method onEnterForeground
	 * @since 0.4.0
	 */
	protected onEnterForeground(event: Event) {

	}

	/**
	 * @method onBeforeKeyboardShow
	 * @since 0.1.0
	 */
	protected onBeforeKeyboardShow(event: Event<ApplicationKeyboardEvent>) {

	}

	/**
	 * @method onKeyboardShow
	 * @since 0.1.0
	 */
	protected onKeyboardShow(event: Event<ApplicationKeyboardEvent>) {

	}

	/**
	 * @method onBeforeKeyboardHide
	 * @since 0.1.0
	 */
	protected onBeforeKeyboardHide(event: Event<ApplicationKeyboardEvent>) {

	}

	/**
	 * @method onKeyboardHide
	 * @since 0.1.0
	 */
	protected onKeyboardHide(event: Event<ApplicationKeyboardEvent>) {

	}

	/**
	 * @method onKeyboardResize
	 * @since 0.1.0
	 */
	protected onKeyboardResize(event: Event<ApplicationKeyboardEvent>) {

	}

	/**
	 * @method onOpenUniversalURL
	 * @since 0.7.0
	 */
	protected onOpenUniversalURL(event: Event<ApplicationOpenUniversalURLEvent>) {

	}

	/**
	 * @method onOpenResourceURL
	 * @since 0.7.0
	 */
	protected onOpenResourceURL(event: Event<ApplicationOpenResourceURLEvent>) {

	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $screen
	 * @since 0.7.0
	 * @hidden
	 */
	private [$screen]: Screen | null

	/**
	 * @property $touches
	 * @since 0.7.0
	 * @hidden
	 */
	private [$touches]: Dictionary<Touch> = {}

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

	/**
	 * @method nativeOnCreate
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnCreate() {
		this.emit('create')
	}

	/**
	 * @method nativeOnDestroy
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnDestroy() {
		this.destroy()
	}

	/**
	 * @method nativeOnTouchCancel
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnTouchCancel(touches: Array<InputTouch>) {
		this.dispatchTouchCancel(touches)
	}

	/**
	 * @method nativeOnTouchStart
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeOnTouchStart(touches: Array<InputTouch>) {
		this.dispatchTouchStart(touches)
	}

	/**
	 * @method nativeOnTouchMove
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnTouchMove(raw: Array<InputTouch>) {
		this.dispatchTouchMove(raw)
	}

	/**
	 * @method nativeOnTouchEnd
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnTouchEnd(touches: Array<InputTouch>) {
		this.dispatchTouchEnd(touches)
	}

	/**
	 * @method nativeOnBeforeKeyboardShow
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnBeforeKeyboardShow(height: number, duration: number, equation: string) {
		this.emit<ApplicationKeyboardEvent>('beforekeyboardshow', { data: { height, duration, equation } })
	}

	/**
	 * @method nativeOnBeforeKeyboardHide
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnBeforeKeyboardHide(height: number, duration: number, equation: string) {
		this.emit<ApplicationKeyboardEvent>('beforekeyboardhide', { data: { height, duration, equation } })
	}

	/**
	 * @method nativeOnKeyboardShow
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnKeyboardShow(height: number, duration: number, equation: string) {
		this.emit<ApplicationKeyboardEvent>('keyboardshow', { data: { height, duration, equation } })
	}

	/**
	 * @method nativeOnKeyboardHide
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnKeyboardHide(height: number, duration: number, equation: string) {
		this.emit<ApplicationKeyboardEvent>('keyboardhide', { data: { height, duration, equation } })
	}

	/**
	 * @method nativeOnBeforeKeyboardResize
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnBeforeKeyboardResize(height: number, duration: number, equation: string) {
		this.emit<ApplicationKeyboardEvent>('beforekeyboardresize', { data: { height, duration, equation } })
	}

	/**
	 * @method nativeOnKeyboardResize
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnKeyboardResize(height: number, duration: number, equation: string) {
		this.emit<ApplicationKeyboardEvent>('keyboardresize', { data: { height, duration, equation } })
	}

	/**
	 * @method nativeOnOpenUniversalURL
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnOpenUniversalURL(url: string) {
		this.emit<ApplicationOpenUniversalURLEvent>('openuniversalurl', { data: { url } })
	}

	/**
	 * @method nativeOnOpenResourceURL
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnOpenResourceURL(url: string) {
		this.emit<ApplicationOpenResourceURLEvent>('openresourceurl', { data: { url } })
	}

	/**
	 * @method nativeOnEnterBackground
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnEnterBackground() {
		this.emit('enterbackground')
	}

	/**
	 * @method nativeOnEnterForeground
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnEnterForeground() {
		this.emit('enterforeground')
	}

	/**
	 * @method nativeOnBack
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnBack() {

		let event = new Event('back', {
			cancelable: true,
			propagable: false
		})

		let screen = this.screen
		if (screen) {
			screen.emit(event)
		}

		return event.canceled
	}
}

/**
 * @const main
 * @since 0.5.0
 * @hidden
 */
let main: Application | null = null

/**
 * @type InputTouch
 * @since 0.7.0
 */
export interface InputTouch {
	id: number
	x: number
	y: number
	canceled: boolean
	captured: boolean
	receiver?: any
}

/**
 * @type ApplicationKeyboardEvent
 * @since 0.1.0
 */
export type ApplicationKeyboardEvent = {
	height: number
	duration: number
	equation: string
}

/**
 * @type ApplicationOpenUniversalURLEvent
 * @since 0.5.0
 */
export type ApplicationOpenUniversalURLEvent = {
	url: string
}

/**
 * @type ApplicationOpenResourceURLEvent
 * @since 0.5.0
 */
export type ApplicationOpenResourceURLEvent = {
	url: string
}
