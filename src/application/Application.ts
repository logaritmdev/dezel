import '../index'
import { Dictionary } from 'lodash'
import { ScreenTransition } from '../screen/transition/ScreenTransition'
import { watch } from '../decorator/watch'
import { Emitter } from '../event/Emitter'
import { Event } from '../event/Event'
import { PanGesture } from '../gesture/PanGesture'
import { TapGesture } from '../gesture/TapGesture'
import { bridge } from '../native/bridge'
import { native } from '../native/native'
import { Enclosure } from '../screen/Enclosure'
import { Screen } from '../screen/Screen'
import { ScreenPresentationOptions } from '../screen/Screen'
import { Touch } from '../touch/Touch'
import { TouchEvent } from '../touch/TouchEvent'
import { TouchList } from '../touch/TouchList'
import { View } from '../view/View'
import { Window } from '../view/Window'

@bridge('dezel.application.Application')

/**
 * The starting point of a Dezel application.
 * @class Application
 * @super Emitter
 * @since 0.1.0
 */
export class Application extends Emitter {

	//--------------------------------------------------------------------------
	// Static Propertis
	//--------------------------------------------------------------------------

	/**
	 * The main application.
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
	 * The application's window.
	 * @property window
	 * @since 0.1.0
	 */
	public readonly window: Window

	/**
	 * The application's state.
	 * @property state
	 * @since 0.1.0
	 */
	@native public state!: 'foreground' | 'background'

	/**
	 * The application's badge number.
	 * @property badge
	 * @since 0.1.0
	 */
	@native public badge!: number

	/**
	 * The application's status bar visibility.
	 * @property statusBarVisible
	 * @since 0.1.0
	 */
	@native public statusBarVisible!: boolean

	/**
	 * The application's status bar foreground color.
	 * @property statusBarForegroundColor
	 * @since 0.1.0
	 */
	@native public statusBarForegroundColor!: 'white' | 'black'

	/**
	 * The application's status bar foreground color.
	 * @property statusBarBackgroundColor
	 * @since 0.1.0
	 */
	@native public statusBarBackgroundColor!: string

	/**
	 * The application's main screen.
	 * @property screen
	 * @since 0.3.0
	 */
	@watch public screen: Screen | null = null

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the application.
	 * @constructor
	 * @since 0.1.0
	 */
	constructor() {

		super()

		// if (main) {
		// 	throw new Error(`
		// 		Application error:
		// 		There is already an application instance running.
		// 	`)
		// }

		main = this

		this.window = new Window()
		native(this).window = native(this.window)
		return this
	}

	/**
	 * Prepares the application for garbage collection.
	 * @method destroy
	 * @since 0.2.0
	 */
	public destroy() {

		this.emit('destroy')

		let screen = this.screen
		if (screen) {
			screen.destroy()
		}

		this.window.destroy()
	}

	/**
	 * @method openURL
	 * @since 0.1.0
	 */
	public openURL(url: string) {
		native(this).openURL(url)
	}

	/**
	 * Convenience method to present a screen from the latest presented screen.
	 * @method present
	 * @since 0.6.0
	 */
	public present(screen: Screen, transition?: ScreenTransition | string, options: ScreenPresentationOptions = {}) {

		if (this.screen == null) {
			this.screen = screen
			return this
		}

		let node = this.screen

		while (true) {

			let presentee = node.presentee
			if (presentee == null) {
				break
			}

			node = presentee
		}

		if (node) {
			node.present(screen, transition, options)
		}

		return this
	}

	/**
	 * Convenience method to prompt a screen from the latest presented screen.
	 * @method prompt
	 * @since 0.6.0
	 */
	public prompt<T>(screen: Screen<T>, transition?: ScreenTransition | string, options: ScreenPresentationOptions = {}): Promise<T | undefined | null> {

		if (this.screen == null) {
			this.screen = screen
			return Promise.resolve(null)
		}

		let node = this.screen

		while (true) {

			let presentee = node.presentee
			if (presentee == null) {
				break
			}

			node = presentee
		}

		if (node) {
			return node.prompt(screen, transition, options)
		}

		return Promise.resolve(null)
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
	 * Called when the application is created.
	 * @method onCreate
	 * @since 0.4.0
	 */
	protected onCreate(event: Event) {

	}

	/**
	 * Called when the application is destroyed.
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

	/**
	 * @inherited
	 * @method onPropertyChange
	 * @since 0.4.0
	 */
	protected onPropertyChange(property: string, newValue: any, oldValue: any) {

		if (property == 'screen') {

			let newScreen = newValue as Screen
			let oldScreen = oldValue as Screen

			if (oldScreen) {

				let enclosure = newScreen.enclosure
				if (enclosure == null) {
					throw new Error(`
						Application error:
						The screen does not have an enclosure.
					`)
				}

				this.window.remove(enclosure)

				oldScreen.emit('beforedismiss')
				oldScreen.emit('beforeleave')
				oldScreen.emit('dismiss')
				oldScreen.emit('leave')

				oldScreen.destroy()
			}

			if (newScreen) {

				let enclosure = newScreen.enclosure
				if (enclosure == null) {
					enclosure = new Enclosure(newScreen)
				}

				this.window.append(enclosure)

				this.statusBarVisible = newScreen.statusBarVisible
				this.statusBarForegroundColor = newScreen.statusBarForegroundColor
				this.statusBarBackgroundColor = newScreen.statusBarBackgroundColor

				newScreen.emit('beforepresent')
				newScreen.emit('beforeenter')
				newScreen.emit('present')
				newScreen.emit('enter')

				newScreen.setActive(true)
				newScreen.setPresented(true)
			}

			return
		}

		super.onPropertyChange(property, newValue, oldValue)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property touches
	 * @since 0.1.0
	 * @hidden
	 */
	private readonly touches: Dictionary<Touch> = {}

	/**
	 * @method captureTouchEvent
	 * @since 0.5.0
	 * @hidden
	 */
	private captureTouchEvent(event: TouchEvent) {

		let receiver = event.receiver
		if (receiver == null) {
			throw new Error(`
				Application Error:
				The touch event to capture does not have a receiver.
			`)
		}

		/*
		 * The touchcancel event that we're about to dispatch will receive the
		 * original touch event as its dispatcher. This way we'll be able to
		 * track the provenance of this touchcancel event and ignore it if
		 * necessary.
		 */

		let cancel = new TouchEvent('touchcancel', {
			propagable: true,
			cancelable: false,
			dispatcher: event,
			touches: event.touches,
			activeTouches: event.activeTouches,
			targetTouches: event.targetTouches
		})

		event.target.emit(cancel)

		/*
		 * Finally update the touch target for each touch from this event. This
		 * will make all future touch event using these touch start directly
		 * from the object that initiated the capture.
		 */

		for (let identifier in this.touches) {

			let touch = this.touches[identifier]
			if (touch == null ||
				touch.target != event.target) {
				continue
			}

			touch.setTarget(receiver as View)
		}
	}

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

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
	private nativeOnTouchCancel(raw: Array<Touch>, all: Array<Touch>) {

		let targets = new Map()

		for (let t of raw) {

			let touch = this.touches[t.identifier]
			if (touch === undefined) {
				continue
			}

			delete this.touches[t.identifier]

			mapTargetTouch(targets, touch)
		}

		for (let [target, touches] of targets) {

			let event = new TouchEvent('touchcancel', {
				propagable: true,
				cancelable: false,
				dispatcher: this,
				touches: getTouchList(touches),
				activeTouches: getActiveTouchList(this.touches),
				targetTouches: getTargetTouchList(this.touches, target)
			})

			target.emit(event)
		}
	}

	/**
	 * @method nativeOnTouchStart
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeOnTouchStart(raw: Array<Touch>, all: Array<Touch>) {

		let targets = new Map()

		for (let t of raw) {

			let k = t.identifier
			let x = t.x
			let y = t.y

			let target = this.window.viewFromPoint(x, y)
			if (target) {

				if (this.touches[t.identifier] == null) {
					this.touches[t.identifier] = new Touch(k, target, x, y)
				} else {

					throw new Error(`
						Application Error:
						A touch with identifier ${t.identifier} has already been registered.
					`)

				}

				mapTargetTouch(targets, this.touches[t.identifier])
			}

			global.$0 = target
		}

		for (let [target, touches] of targets) {

			let event = new TouchEvent('touchstart', {
				propagable: true,
				cancelable: true,
				dispatcher: this,
				touches: getTouchList(touches),
				activeTouches: getActiveTouchList(this.touches),
				targetTouches: getTargetTouchList(this.touches, target)
			})

			target.emit(event)

			if (event.captured) {
				this.captureTouchEvent(event)
			}
		}
	}

	/**
	 * @method nativeOnTouchMove
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnTouchMove(raw: Array<Touch>, all: Array<Touch>) {

		let targets = new Map()

		for (let t of raw) {

			let touch = this.touches[t.identifier]
			if (touch == null) {
				continue
			}

			touch.setX(t.x)
			touch.setY(t.y)

			mapTargetTouch(targets, touch)
		}

		for (let [target, touches] of targets) {

			let event = new TouchEvent('touchmove', {
				propagable: true,
				cancelable: true,
				dispatcher: this,
				touches: getTouchList(touches),
				activeTouches: getActiveTouchList(this.touches),
				targetTouches: getTargetTouchList(this.touches, target)
			})

			target.emit(event)

			if (event.captured) {
				this.captureTouchEvent(event)
			}
		}
	}

	/**
	 * @method nativeOnTouchEnd
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnTouchEnd(raw: Array<Touch>, all: Array<Touch>) {

		let targets = new Map()

		for (let t of raw) {

			let touch = this.touches[t.identifier]
			if (touch == null) {
				continue
			}

			delete this.touches[t.identifier]

			mapTargetTouch(targets, touch)
		}

		for (let [target, touches] of targets) {

			let event = new TouchEvent('touchend', {
				propagable: true,
				cancelable: true,
				dispatcher: this,
				touches: getTouchList(touches),
				activeTouches: getActiveTouchList(this.touches),
				targetTouches: getTargetTouchList(this.touches, target)
			})

			target.emit(event)
		}
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
 * The main application
 * @var main
 * @since 0.5.0
 */
let main: Application | null = null

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

/**
 * @function mapTargetTouch
 * @since 0.5.0
 * @hidden
 */
function mapTargetTouch(targets: Map<any, any>, touch: Touch) {

	let changes = targets.get(touch.target)
	if (changes == null) {
		changes = []
		targets.set(touch.target, changes)
	}

	changes.push(touch)
}

/**
 * @function getTouchList
 * @since 0.5.0
 * @hidden
 */
function getTouchList(touches: Dictionary<Touch>) {
	return new TouchList(Object.keys(touches).map(key => touches[key]))
}

/**
 * @function getActiveTouchList
 * @since 0.5.0
 * @hidden
 */
function getActiveTouchList(touches: Dictionary<Touch>) {
	return new TouchList(Object.keys(touches).map(key => touches[key]))
}

/**
 * @function getTargetTouchList
 * @since 0.4.0
 * @hidden
 */
function getTargetTouchList(touches: Dictionary<Touch>, target: any) {
	return new TouchList(Object.keys(touches).map(key => touches[key]).filter(touch => touch.target == target))
}