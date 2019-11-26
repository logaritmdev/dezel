import '../index'
import { Dictionary } from 'lodash'
import { setEmitterResponder } from '../event/private/Emitter'
import { setEventTarget } from '../event/private/Event'
import { setScreenActive } from '../screen/private/Screen'
import { setScreenPresented } from '../screen/private/Screen'
import { setTouchCanceled } from '../touch/private/Touch'
import { setTouchCaptured } from '../touch/private/Touch'
import { setTouchIdentifier } from '../touch/private/Touch'
import { setTouchLocationX } from '../touch/private/Touch'
import { setTouchLocationY } from '../touch/private/Touch'
import { setTouchTarget } from '../touch/private/Touch'
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
import { cancelTouchMove } from './private/Application'
import { cancelTouchStart } from './private/Application'
import { captureTouchMove } from './private/Application'
import { captureTouchStart } from './private/Application'
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
	 * @method dispatchTouchStart
	 * @since 0.7.0
	 */
	public dispatchTouchStart(inputs: Array<InputTouch>) {

		let targets = new Map()

		for (let input of inputs) {

			let target = this.window.findViewAt(
				input.x,
				input.y
			)

			if (target == null) {
				continue
			}

			let touch = new Touch(target)

			mapTouchTarget(targets, touch)

			setTouchIdentifier(touch, input.pointer)
			setTouchLocationX(touch, input.x)
			setTouchLocationY(touch, input.y)

			setTouch(this, input, touch)
		}

		for (let [target, touches] of targets) {

			let event = new TouchEvent('touchstart', {
				propagable: true,
				capturable: true,
				cancelable: true,
				touches: getTouchList(touches),
				activeTouches: getActiveTouchList(this[$touches]),
				targetTouches: getTargetTouchList(this[$touches], target)
			})

			target.emit(event)

			if (event.canceled ||
				event.captured) {

				updateInputTouches(event, inputs)

				switch (true) {
					case event.canceled: cancelTouchStart(event); break
					case event.captured: captureTouchStart(event); break
				}

				setEventTarget(event, event.sender)

				for (let touch of event.touches) {
					setTouchTarget(touch, event.sender)
				}
			}
		}
	}

	/**
	 * @method dispatchTouchMove
	 * @since 0.7.0
	 */
	public dispatchTouchMove(inputs: Array<InputTouch>) {

		let targets = new Map<View, Array<Touch>>()

		for (let input of inputs) {

			let touch = getTouch(this, input)
			if (touch == null) {
				continue
			}

			mapTouchTarget(targets, touch)
			setTouchLocationX(touch, input.x)
			setTouchLocationY(touch, input.y)
		}

		for (let [target, touches] of targets) {

			let captured = touches.some(touch => {
				return touch.captured
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

				updateInputTouches(event, inputs)

				switch (true) {
					case event.canceled: cancelTouchMove(event); break
					case event.captured: captureTouchMove(event); break
				}

				setEventTarget(event, event.sender)

				for (let touch of event.touches) {
					setTouchTarget(touch, event.sender)
				}
			}
		}
	}

	/**
	 * @method dispatchTouchEnd
	 * @since 0.7.0
	 */
	public dispatchTouchEnd(inputs: Array<InputTouch>) {

		let targets = new Map<View, Array<Touch>>()

		for (let input of inputs) {

			let touch = getTouch(this, input)
			if (touch == null) {
				continue
			}

			mapTouchTarget(targets, touch)
			setTouchLocationX(touch, input.x)
			setTouchLocationY(touch, input.y)
		}

		for (let [target, touches] of targets) {

			let captured = touches.some(touch => {
				return touch.captured
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

		removeInputTouches(inputs, this)
	}

	/**
	 * @method dispatchTouchCancel
	 * @since 0.7.0
	 */
	public dispatchTouchCancel(inputs: Array<InputTouch>) {

		let targets = new Map<View, Array<Touch>>()

		for (let input of inputs) {

			let touch = getTouch(this, input)
			if (touch == null) {
				continue
			}

			mapTouchTarget(targets, touch)
			setTouchLocationX(touch, input.x)
			setTouchLocationY(touch, input.y)
		}

		for (let [target, touches] of targets) {

			let captured = touches.some(touch => {
				return touch.captured
			})

			let event = new TouchEvent('touchcancel', {
				propagable: captured == false,
				capturable: false,
				cancelable: false,
				touches: getTouchList(touches),
				activeTouches: getActiveTouchList(this[$touches]),
				targetTouches: getTargetTouchList(this[$touches], target)
			})

			target.emit(event)
		}

		removeInputTouches(inputs, this)
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

				this.statusBarVisible = newScreen.statusBarVisible
				this.statusBarForegroundColor = newScreen.statusBarForegroundColor
				this.statusBarBackgroundColor = newScreen.statusBarBackgroundColor

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
 * @function setTouch
 * @since 0.7.0
 * @hidden
 */
function setTouch(application: Application, input: InputTouch, touch: Touch) {

	if (application[$touches][input.pointer] == null) {
		application[$touches][input.pointer] = touch
		return
	}

	throw new Error(
		`Application error: ` +
		`The touch ${input.pointer} has already been registered.`
	)
}

/**
 * @function getTouch
 * @since 0.7.0
 * @hidden
 */
function getTouch(application: Application, input: InputTouch) {

	let touch = application[$touches][input.pointer]

	if (touch &&
		touch.canceled) {
		return null
	}

	return touch
}

/**
 * @function getTouchList
 * @since 0.5.0
 * @hidden
 */
function getTouchList(touches: Array<Touch>) {
	return new TouchList(touches)
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
function getTargetTouchList(touches: Dictionary<Touch>, target: View) {
	return new TouchList(Object.keys(touches).map(key => touches[key]).filter(touch => touch.target == target))
}

/**
 * @method updateInputTouches
 * @since 0.7.0
 * @hidden
 */
function updateInputTouches(event: TouchEvent, inputs: Array<InputTouch>) {

	let map: Dictionary<InputTouch> = {}

	for (let input of inputs) {
		if (map[input.pointer] == null) {
			map[input.pointer] = input
		}
	}

	for (let touch of event.touches) {

		let input = map[touch.identifier]
		if (input == null) {
			continue
		}

		if (input.canceled ||
			input.captured) {
			continue
		}

		input.canceled = touch.canceled
		input.captured = touch.captured

		if (input.captured) {
			input.receiver = native(event.sender)
		}
	}
}

/**
 * @method removeInputTouches
 * @since 0.7.0
 * @hidden
 */
function removeInputTouches(inputs: Array<InputTouch>, application: Application) {
	for (let input of inputs) {
		delete application[$touches][input.pointer]
	}
}
