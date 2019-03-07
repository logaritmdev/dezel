import { Dictionary } from 'lodash'
import { bridge } from '../decorator/bridge'
import { native } from '../decorator/native'
import { watch } from '../decorator/watch'
import { Emitter } from '../event/Emitter'
import { Event } from '../event/Event'
import { PanGesture } from '../gesture/PanGesture'
import { TapGesture } from '../gesture/TapGesture'
import { Enclosure } from '../screen/Enclosure'
import { Screen } from '../screen/Screen'
import { Touch } from '../touch/Touch'
import { TouchEvent } from '../touch/TouchEvent'
import { TouchList } from '../touch/TouchList'
import { Window } from '../view/Window'
import '../index'

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
	@watch public screen?: Screen | null = null

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

		if (main) {
			throw new Error(`
				Application error:
				There is already an application instance running.
			`)
		}

		main = this

		this.window = new Window()
		this.native.window = this.window.native

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
		this.native.openURL(url)
		return this
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onEmit
	 * @since 0.1.0
	 */
	public onEmit(event: Event) {

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

			case 'handlelink':
				this.onHandleLink(event)
				break

			case 'receiveremotenotificationstoken':
				this.onReceiveRemoteNotificationsToken(event)
				break
		}

		return super.onEmit(event)
	}

	/**
	 * Called when the application is created.
	 * @method onCreate
	 * @since 0.4.0
	 */
	public onCreate(event: Event) {

	}

	/**
	 * Called when the application is destroyed.
	 * @method onDestroy
	 * @since 0.4.0
	 */
	public onDestroy(event: Event) {

	}

	/**
	 * @method onEnterBackground
	 * @since 0.4.0
	 */
	public onEnterBackground(event: Event) {

	}

	/**
	 * @method onEnterForeground
	 * @since 0.4.0
	 */
	public onEnterForeground(event: Event) {

	}

	/**
	 * @method onBeforeKeyboardShow
	 * @since 0.1.0
	 */
	public onBeforeKeyboardShow(event: Event<ApplicationKeyboardEvent>) {

	}

	/**
	 * @method onKeyboardShow
	 * @since 0.1.0
	 */
	public onKeyboardShow(event: Event<ApplicationKeyboardEvent>) {

	}

	/**
	 * @method onBeforeKeyboardHide
	 * @since 0.1.0
	 */
	public onBeforeKeyboardHide(event: Event<ApplicationKeyboardEvent>) {

	}

	/**
	 * @method onKeyboardHide
	 * @since 0.1.0
	 */
	public onKeyboardHide(event: Event<ApplicationKeyboardEvent>) {

	}

	/**
	 * @method onKeyboardResize
	 * @since 0.1.0
	 */
	public onKeyboardResize(event: Event<ApplicationKeyboardEvent>) {

	}

	/**
	 * @method ApplicationHandleLinkEvent
	 * @since 0.1.0
	 */
	public onHandleLink(event: Event<ApplicationHandleLinkEvent>) {

	}

	/**
	 * @method onReceiveRemoteNotificationsToken
	 * @since 0.1.0
	 */
	public onReceiveRemoteNotificationsToken(event: Event<ApplicationReceiveRemoteNotificationsTokenEvent>) {

	}

	/**
	 * @inherited
	 * @method onPropertyChange
	 * @since 0.4.0
	 */
	public onPropertyChange(property: string, newValue: any, oldValue: any) {

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
	 * @method dispatchTouchCancel
	 * @since 0.1.0
	 * @hidden
	 */
	private dispatchTouchCancel(raw: Array<Touch>, all: Array<Touch>) {

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
	 * @method dispatchTouchStart
	 * @since 0.1.0
	 * @hidden
	 */
	private dispatchTouchStart(raw: Array<Touch>, all: Array<Touch>) {

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

			(window as any).$0 = target
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
	 * @method dispatchTouchMove
	 * @since 0.1.0
	 * @hidden
	 */
	private dispatchTouchMove(raw: Array<Touch>, all: Array<Touch>) {

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
	 * @method dispatchTouchEnd
	 * @since 0.1.0
	 * @hidden
	 */
	private dispatchTouchEnd(raw: Array<Touch>, all: Array<Touch>) {

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

			touch.setTarget(receiver)
		}
	}

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

	/**
	 * @property native
	 * @since 0.1.0
	 * @hidden
	 */
	public native: any

	/**
	 * @method nativeLoad
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeLoad() {
		dispatchEvent(new Event('load') as any)
	}

	/**
	 * @method nativeUnload
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeUnload() {
		dispatchEvent(new Event('unload') as any)
	}

	/**
	 * @method nativeDestroy
	 * @since 0.2.0
	 * @hidden
	 */
	private nativeDestroy() {
		this.destroy()
	}

	/**
	 * @method nativeBeforeKeyboardShow
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeBeforeKeyboardShow(height: number, duration: number, equation: string) {
		this.emit<ApplicationKeyboardEvent>('beforekeyboardshow', { data: { height, duration, equation } })
	}

	/**
	 * @method nativeBeforeKeyboardHide
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeBeforeKeyboardHide(height: number, duration: number, equation: string) {
		this.emit<ApplicationKeyboardEvent>('beforekeyboardhide', { data: { height, duration, equation } })
	}

	/**
	 * @method nativeKeyboardShow
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeKeyboardShow(height: number, duration: number, equation: string) {
		this.emit<ApplicationKeyboardEvent>('keyboardshow', { data: { height, duration, equation } })
	}

	/**
	 * @method nativeKeyboardHide
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeKeyboardHide(height: number, duration: number, equation: string) {
		this.emit<ApplicationKeyboardEvent>('keyboardhide', { data: { height, duration, equation } })
	}

	/**
	 * @method nativeBeforeKeyboardResize
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeBeforeKeyboardResize(height: number, duration: number, equation: string) {
		this.emit<ApplicationKeyboardEvent>('beforekeyboardresize', { data: { height, duration, equation } })
	}

	/**
	 * @method nativeKeyboardResize
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeKeyboardResize(height: number, duration: number, equation: string) {
		this.emit<ApplicationKeyboardEvent>('keyboardresize', { data: { height, duration, equation } })
	}

	/**
	 * @method nativeReceiveRemoteNotificationsToken
	 * @since 0.5.0
	 * @hidden
	 */
	private nativeReceiveRemoteNotificationsToken(token: string) {
		this.emit<ApplicationReceiveRemoteNotificationsTokenEvent>('receiveremotenotificationstoken', { data: { token } })
	}

	/**
	 * @method nativeHandleLink
	 * @since 0.5.0
	 * @hidden
	 */
	private nativeHandleLink(url: string) {
		this.emit<ApplicationHandleLinkEvent>('handlelink', { data: { url } })
	}

	/**
	 * @method nativeEnterBackground
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeEnterBackground() {
		this.emit('enterbackground')
	}

	/**
	 * @method nativeEnterForeground
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeEnterForeground() {
		this.emit('enterforeground')
	}

	/**
	 * @method nativeBack
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeBack() {

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
 * @type ApplicationHandleLinkEvent
 * @since 0.5.0
 */
export type ApplicationHandleLinkEvent = {
	url: string
}

/**
 * @type ApplicationReceiveRemoteNotificationsTokenEvent
 * @since 0.5.0
 */
export type ApplicationReceiveRemoteNotificationsTokenEvent = {
	token: string
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