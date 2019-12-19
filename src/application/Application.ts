import { $canceled } from '../event/private/Touch'
import { $captured } from '../event/private/Touch'
import { $id } from '../event/private/Touch'
import { $x } from '../event/private/Touch'
import { $y } from '../event/private/Touch'
import { $frame } from '../screen/private/Screen'
import { $presented } from '../screen/private/Screen'
import { $presenting } from '../screen/private/Screen'
import { $segue } from '../screen/private/Screen'
import { $screen } from './private/Application'
import { $touches } from './private/Application'
import { updateTouchTarget } from '../event/private/TouchEvent'
import { bridge } from '../native/bridge'
import { native } from '../native/native'
import { emitBeforeEnter } from '../screen/private/Screen'
import { emitBeforePresent } from '../screen/private/Screen'
import { emitEnter } from '../screen/private/Screen'
import { emitPresent } from '../screen/private/Screen'
import { cancelTouchMove } from './private/Application'
import { cancelTouchStart } from './private/Application'
import { captureTouchMove } from './private/Application'
import { captureTouchStart } from './private/Application'
import { getRegisteredTouch } from './private/Application'
import { mapTarget } from './private/Application'
import { registerTouch } from './private/Application'
import { toActiveTouchList } from './private/Application'
import { toTargetTouchList } from './private/Application'
import { toTouchList } from './private/Application'
import { updateEventInputs } from './private/Application'
import { Emitter } from '../event/Emitter'
import { Event } from '../event/Event'
import { Touch } from '../event/Touch'
import { TouchEvent } from '../event/TouchEvent'
import { Screen } from '../screen/Screen'
import { NoneSegue } from '../screen/Segue.None'
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
	public static get main(): Application {

		if (main == null) {
			throw new Error(`Application error: Application has not been started.`)
		}

		return main
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The application window.
	 * @property window
	 * @since 0.1.0
	 */
	@native public readonly window: Window

	/**
	 * The application state.
	 * @property state
	 * @since 0.1.0
	 */
	@native public readonly state!: 'foreground' | 'background'

	/**
	 * Whether the status bar is visible.
	 * @property statusBarVisible
	 * @since 0.1.0
	 */
	@native public statusBarVisible!: boolean

	/**
	 * The application status bar foreground color.
	 * @property statusBarForegroundColor
	 * @since 0.1.0
	 */
	@native public statusBarForegroundColor!: 'white' | 'black'

	/**
	 * The application statis bar background color
	 * @property statusBarBackgroundColor
	 * @since 0.1.0
	 */
	@native public statusBarBackgroundColor!: string

	/**
	 * The application badge
	 * @property badge
	 * @since 0.1.0
	 */
	@native public badge!: number

	/**
	 * The application main screen.
	 * @property screen
	 * @since 0.1.0
	 */
	public get screen(): Screen {

		let screen = this[$screen]
		if (screen == null) {
			throw new Error(`Application error: The application has no presented screen.`)
		}

		return screen
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initialize the application
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
	 * Presents the application screen.
	 * @method present
	 * @since 0.7.0
	 */
	public present(screen: Screen) {

		if (this[$screen]) {
			throw new Error(`Application error: The application already has a screen.`)
		}

		screen.updateStatusBar()

		this[$screen] = screen

		this.window.append(screen[$frame])

		let segue = new NoneSegue()

		screen[$segue] = segue
		screen[$presented] = true
		screen[$presenting] = true

		emitBeforePresent(screen, segue)
		emitBeforeEnter(screen, segue)
		emitPresent(screen, segue)
		emitEnter(screen, segue)

		screen[$presenting] = false

		return this
	}

	/**
	 * Terminates the application.
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
	 * Opens an url from the application.
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
	 * Dispatches a touchstart event to the proper view.
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

			(global as any).$0 = target

			let touch = new Touch(target)

			touch[$x] = input.x
			touch[$y] = input.y
			touch[$id] = input.id

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

				updateEventInputs(event, inputs)

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
					updateTouchTarget(event, event.sender as View)
				}
			}
		}

		return this
	}

	/**
	 * Dispatches a touchmove event to the proper view.
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

			let touch = getRegisteredTouch(this, input)
			if (touch == null) {
				continue
			}

			touch[$x] = input.x
			touch[$y] = input.y

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

				updateEventInputs(event, inputs)

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
					updateTouchTarget(event, event.sender as View)
				}
			}
		}

		return this
	}

	/**
	 * Dispatches a touchend event to the proper view.
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

		for (let input of inputs) {

			let touch = getRegisteredTouch(this, input)
			if (touch == null) {
				continue
			}

			touch[$x] = input.x
			touch[$y] = input.y

			mapTarget(touch, targets)

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

		for (let input of inputs) {

			let touch = getRegisteredTouch(this, input)
			if (touch == null) {
				continue
			}

			touch[$x] = 0
			touch[$y] = 0
			touch[$id] = 0
			touch[$canceled] = false
			touch[$captured] = false
		}

		return this
	}

	/**
	 * Dispatches a touchcancel event to the proper view.
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

		for (let input of inputs) {

			let touch = getRegisteredTouch(this, input)
			if (touch == null) {
				continue
			}

			touch[$x] = input.x
			touch[$y] = input.y

			mapTarget(touch, targets)
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

		for (let input of inputs) {

			let touch = getRegisteredTouch(this, input)
			if (touch == null) {
				continue
			}

			touch[$x] = 0
			touch[$y] = 0
			touch[$id] = 0
			touch[$canceled] = false
			touch[$captured] = false
		}

		return this
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onEvent
	 * @since 0.7.0
	 */
	public onEvent(event: Event) {

		switch (event.type) {

			case 'create':
				this.onCreate()
				break

			case 'destroy':
				this.onDestroy()
				break

			case 'enterbackground':
				this.onEnterBackground()
				break

			case 'enterforeground':
				this.onEnterForeground()
				break

			case 'beforekeyboardshow':
				this.onBeforeKeyboardShow(event.data.height, event.data.duration, event.data.equation)
				break

			case 'beforekeyboardhide':
				this.onBeforeKeyboardHide(event.data.height, event.data.duration, event.data.equation)
				break

			case 'keyboardshow':
				this.onKeyboardShow(event.data.height, event.data.duration, event.data.equation)
				break

			case 'keyboardhide':
				this.onKeyboardHide(event.data.height, event.data.duration, event.data.equation)
				break

			case 'keyboardresize':
				this.onKeyboardResize(event.data.height, event.data.duration, event.data.equation)
				break

			case 'memorywarning':
				this.onMemoryWarning()
				break

			case 'openuniversalurl':
				this.onOpenUniversalURL(event.data.url)
				break

			case 'openresourceurl':
				this.onOpenResourceURL(event.data.url)
				break
		}

		return super.onEvent(event)
	}

	/**
	 * Called when the application is created.
	 * @method onCreate
	 * @since 0.4.0
	 */
	public onCreate() {

	}

	/**
	 * Called when the application is destroyed.
	 * @method onDestroy
	 * @since 0.4.0
	 */
	public onDestroy() {

	}

	/**
	 * Called when the application goes to the background state.
	 * @method onEnterBackground
	 * @since 0.4.0
	 */
	public onEnterBackground() {

	}

	/**
	 * Called when the application goes to the foreground state.
	 * @method onEnterForeground
	 * @since 0.4.0
	 */
	public onEnterForeground() {

	}

	/**
	 * Called before the software keyboard is displayed.
	 * @method onBeforeKeyboardShow
	 * @since 0.3.0
	 */
	public onBeforeKeyboardShow(height: number, duration: number, equation: string) {

	}

	/**
	 * Called after the software keyboard is displayed.
	 * @method onKeyboardShow
	 * @since 0.3.0
	 */
	public onKeyboardShow(height: number, duration: number, equation: string) {

	}

	/**
	 * Called before the software keyboard is hidden.
	 * @method onBeforeKeyboardHide
	 * @since 0.3.0
	 */
	public onBeforeKeyboardHide(height: number, duration: number, equation: string) {

	}

	/**
	 * Called after the software keyboard is hidden.
	 * @method onKeyboardHide
	 * @since 0.3.0
	 */
	public onKeyboardHide(height: number, duration: number, equation: string) {

	}

	/**
	 * Called when the software keyboard changes is size.
	 * @method onKeyboardResize
	 * @since 0.3.0
	 */
	public onKeyboardResize(height: number, duration: number, equation: string) {

	}

	/**
	 * Called when the application gets low on memory.
	 * @method onMemoryWarning
	 * @since 0.7.0
	 */
	public onMemoryWarning() {

	}

	/**
	 * Called when an universal url is opened.
	 * @method onOpenUniversalURL
	 * @since 0.7.0
	 */
	public onOpenUniversalURL(url: string) {

	}

	/**
	 * Called when a file or resource url is opened.
	 * @method onOpenResourceURL
	 * @since 0.7.0
	 */
	public onOpenResourceURL(url: string) {

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
	 * @method nativeOnMemoryWarning
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnMemoryWarning() {
		this.emit('memorywarning')
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
