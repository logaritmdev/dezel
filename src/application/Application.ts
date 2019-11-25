import '../index'
import { Dictionary } from 'lodash'
import { setEmitterResponder } from '../event/private/Emitter'
import { setScreenActive } from '../screen/private/Screen'
import { setScreenPresented } from '../screen/private/Screen'
import { setTouchTarget } from '../touch/private/Touch'
import { setTouchX } from '../touch/private/Touch'
import { setTouchY } from '../touch/private/Touch'
import { watch } from '../decorator/watch'
import { Emitter } from '../event/Emitter'
import { Event } from '../event/Event'
import { bridge } from '../native/bridge'
import { native } from '../native/native'
import { Enclosure } from '../screen/Enclosure'
import { Screen } from '../screen/Screen'
import { Touch } from '../touch/Touch'
import { TouchEvent } from '../touch/TouchEvent'
import { TouchList } from '../touch/TouchList'
import { View } from '../view/View'
import { Window } from '../view/Window'
import { $canceledTouches } from './symbol/Application'
import { $capturedTargets } from './symbol/Application'
import { $capturedTouches } from './symbol/Application'
import { $touches } from './symbol/Application'

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
	 * @since 0.3.0
	 */
	@watch public screen: Screen | null = null

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
	 * @method destroy
	 * @since 0.2.0
	 */
	public destroy() {

		this.emit('destroy')

		this.window.destroy()

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
	// Touches
	//--------------------------------------------------------------------------

	/**
	 * @method dispatchTouchCancel
	 * @since 0.7.0
	 */
	public dispatchTouchCancel(inputs: Array<InputTouch>) {

		let targets = new Map()

		for (let input of inputs) {

			if (isCanceled(this, input)) {
				continue
			}

			let touch = this[$touches][input.pointer]
			if (touch) {
				mapTouchTarget(targets, touch)
			}
		}

		/*
		 * At this point, canceled touches are removed.
		 */

		for (let [target, touches] of targets) {

			let event = new TouchEvent('touchcancel', {
				propagable: true,
				capturable: false,
				cancelable: false,
				touches: getTouchList(touches),
				activeTouches: getActiveTouchList(this[$touches]),
				targetTouches: getTargetTouchList(this[$touches], target)
			})

			target.emit(event)
		}

		for (let input of inputs) {
			delete this[$touches][input.pointer]
			delete this[$canceledTouches][input.pointer]
			delete this[$capturedTouches][input.pointer]
		}
	}

	/**
	 * @method dispatchTouchStart
	 * @since 0.7.0
	 */
	public dispatchTouchStart(inputs: Array<InputTouch>) {

		let targets = new Map()

		for (let input of inputs) {

			if (isCanceled(this, input)) {
				continue
			}

			let x = input.x
			let y = input.y

			let target = this.window.findViewAt(x, y)
			if (target) {

				if (this[$touches][input.pointer] == null) {
					this[$touches][input.pointer] = new Touch(input.pointer, target, x, y)
				} else {

					throw new Error(
						`Application error: ` +
						`A touch with pointer ${input.pointer} has already been registered.`
					)

				}

				mapTouchTarget(targets, this[$touches][input.pointer])
			}

			global.$0 = target
		}

		/*
		 * At this point, canceled touches are removed.
		 */

		for (let [target, touches] of targets) {

			let captured = touches.some((touch: Touch) => {
				return isCaptured(this, touch)
			})

			let event = new TouchEvent('touchstart', {
				propagable: captured == false,
				capturable: captured == false,
				cancelable: true,
				touches: getTouchList(touches),
				activeTouches: getActiveTouchList(this[$touches]),
				targetTouches: getTargetTouchList(this[$touches], target)
			})

			target.emit(event)

			if (event.canceled ||
				event.captured) {

				let map = getInputTouchMap(inputs)

				if (event.canceled) {
					cancelTouchEvent(this, map, event)
				}

				if (event.captured) {
					captureTouchEvent(this, map, event)
				}

				dispatchTouchCancel(event)
			}
		}
	}

	/**
	 * @method dispatchTouchMove
	 * @since 0.7.0
	 */
	public dispatchTouchMove(inputs: Array<InputTouch>) {

		let targets = new Map()

		for (let input of inputs) {

			if (isCanceled(this, input)) {
				continue
			}

			let touch = this[$touches][input.pointer]
			if (touch) {
				setTouchX(touch, input.x)
				setTouchY(touch, input.y)
				mapTouchTarget(targets, touch)
			}
		}

		/*
		 * At this point, canceled touches are removed.
		 */

		for (let [target, touches] of targets) {

			let captured = touches.some((touch: Touch) => {
				return isCaptured(this, touch)
			})

			let event = new TouchEvent('touchmove', {
				propagable: captured == false,
				capturable: captured == false,
				cancelable: true,
				touches: getTouchList(touches),
				activeTouches: getActiveTouchList(this[$touches]),
				targetTouches: getTargetTouchList(this[$touches], target)
			})

			target.emit(event)

			if (event.canceled ||
				event.captured) {

				let map = getInputTouchMap(inputs)

				if (event.canceled) {
					cancelTouchEvent(this, map, event)
				}

				if (event.captured) {
					captureTouchEvent(this, map, event)
				}

				dispatchTouchCancel(event)
			}
		}
	}

	/**
	 * @method dispatchTouchEnd
	 * @since 0.7.0
	 */
	public dispatchTouchEnd(inputs: Array<InputTouch>) {

		let targets = new Map()

		for (let input of inputs) {

			if (isCanceled(this, input)) {
				continue
			}

			let touch = this[$touches][input.pointer]
			if (touch) {
				mapTouchTarget(targets, touch)
			}
		}

		/*
		 * At this point, canceled touches are removed.
		 */

		for (let [target, touches] of targets) {

			let captured = touches.some((touch: Touch) => {
				return isCaptured(this, touch)
			})

			let event = new TouchEvent('touchend', {
				propagable: captured == false,
				capturable: false,
				cancelable: true,
				touches: getTouchList(touches),
				activeTouches: getActiveTouchList(this[$touches]),
				targetTouches: getTargetTouchList(this[$touches], target)
			})

			target.emit(event)
		}

		for (let input of inputs) {
			delete this[$touches][input.pointer]
			delete this[$canceledTouches][input.pointer]
			delete this[$capturedTouches][input.pointer]
		}
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

	/**
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
					throw new Error(
						`Application error: ` +
						`The screen is missing its enclosure.`
					)
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

				this.statusBarForegroundColor = newScreen.statusBarForegroundColor
				this.statusBarBackgroundColor = newScreen.statusBarBackgroundColor
				this.statusBarVisible = newScreen.statusBarVisible

				newScreen.emit('beforepresent')
				newScreen.emit('beforeenter')
				newScreen.emit('present')
				newScreen.emit('enter')

				setScreenActive(newScreen, true)
				setScreenPresented(newScreen, true)
			}
		}
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $touches
	 * @since 0.7.0
	 * @hidden
	 */
	private [$touches]: Dictionary<Touch> = {}

	/**
	 * @property $canceledTouches
	 * @since 0.1.0
	 * @hidden
	 */
	private [$canceledTouches]: Dictionary<Touch> = {}

	/**
	 * @property $capturedTouches
	 * @since 0.1.0
	 * @hidden
	 */
	private [$capturedTouches]: Dictionary<Touch> = {}

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
	pointer: number
	x: number
	y: number
	canceled?: boolean
	captured?: boolean
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

/**
 * @function mapTouchTarget
 * @since 0.7.0
 * @hidden
 */
function mapTouchTarget(targets: Map<any, any>, touch: Touch) {

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

/**
 * @method getInputTouchMap
 * @since 0.7.0
 * @hidden
 */
function getInputTouchMap(inputs: Array<InputTouch>) {

	let map: Dictionary<InputTouch> = {}

	for (let input of inputs) {
		if (map[input.pointer] == null) {
			map[input.pointer] = input
		}
	}

	return map
}

/**
 * @method isCanceled
 * @since 0.7.0
 * @hidden
 */
function isCanceled(application: Application, touch: InputTouch | Touch) {
	return application[$canceledTouches][touch.pointer] != null
}

/**
 * @method isCaptured
 * @since 0.7.0
 * @hidden
 */
function isCaptured(application: Application, touch: InputTouch | Touch) {
	return application[$capturedTouches][touch.pointer] != null
}

/**
 * @method cancelTouchEvent
 * @since 0.7.0
 * @hidden
 */
function cancelTouchEvent(application: Application, inputs: Dictionary<InputTouch>, event: TouchEvent) {

	for (let touch of event.touches) {

		if (isCanceled(application, touch)) {
			continue
		}

		let input = inputs[touch.pointer]
		if (input) {
			input.canceled = true
			input.captured = false
			input.receiver = null
		}

		application[$canceledTouches][touch.pointer] = touch
	}
}

/**
 * @function captureTouchEvent
 * @since 0.7.0
 * @hidden
 */
function captureTouchEvent(application: Application, inputs: Dictionary<InputTouch>, event: TouchEvent) {

	let receiver = event.sender

	for (let touch of event.touches) {

		if (isCaptured(application, touch)) {
			continue
		}

		let input = inputs[touch.pointer]
		if (input) {
			input.captured = true
			input.receiver = receiver
		}

		application[$capturedTouches][touch.pointer] = touch

		/*
		 * The touch target is set once on the touch start event. By resetting
		 * the target, we can change the receiver.
		 */

		setTouchTarget(touch, receiver as View)
	}
}

/**
 * @function dispatchTouchCancel
 * @since 0.7.0
 * @hidden
 */
function dispatchTouchCancel(event: TouchEvent) {

	let responder = event.sender.responder

	/*
	 * This touch cancel event needs to be dispatched to the targets that have
	 * received the original touch start or touch move event. The easiest way
	 * is to emit an even to the original target while the object that
	 * triggered the cancel has no responder.
	 */

	setEmitterResponder(event.sender, null)

	event.target.emit(
		new TouchEvent('touchcancel', {
			propagable: true,
			cancelable: false,
			touches: event.touches,
			activeTouches: event.activeTouches,
			targetTouches: event.targetTouches
		})
	)

	setEmitterResponder(event.sender, responder)
}
