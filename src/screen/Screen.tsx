import { $dismissing } from './private/Screen'
import { $frame } from './private/Screen'
import { $modal } from './private/Screen'
import { $presented } from './private/Screen'
import { $presentee } from './private/Screen'
import { $presenter } from './private/Screen'
import { $presenting } from './private/Screen'
import { $segue } from './private/Screen'
import { $style } from './private/Screen'
import { bound } from '../decorator/bound'
import { dismissScreenAsync } from './private/Screen'
import { getDismissSegue } from './private/Screen'
import { getPresentSegue } from './private/Screen'
import { presentScreenAsync } from './private/Screen'
import { Application } from '../application/Application'
import { Component } from '../component/Component'
import { Event } from '../event/Event'
import { Window } from '../view/Window'
import { Frame } from './Frame'
import { Segue } from './Segue'
import './style/Screen.style'
import './style/Screen.style.android'
import './style/Screen.style.ios'

/**
 * @class Screen
 * @super View
 * @since 0.1.0
 */
export abstract class Screen<TResult = any> extends Component {

	//--------------------------------------------------------------------------
	// Propertis
	//--------------------------------------------------------------------------

	/**
	 * The status bar visibility status.
	 * @property statusBarVisible
	 * @since 0.1.0
	 */
	public statusBarVisible: boolean = true

	/**
	 * The status bar foreground color.
	 * @property statusBarForegroundColor
	 * @since 0.1.0
	 */
	public statusBarForegroundColor: 'white' | 'black' = 'black'

	/**
	 * The status bar background color.
	 * @property statusBarBackgroundColor
	 * @since 0.1.0
	 */
	public statusBarBackgroundColor: string = 'transparent'

	/**
	 * The screen that presents this screen.
	 * @property presenter
	 * @since 0.1.0
	 */
	public get presenter(): Screen | null {
		return this[$presenter]
	}

	/**
	 * This screen that is presented by this screen.
	 * @property presentee
	 * @since 0.1.0
	 */
	public get presentee(): Screen | null {
		return this[$presentee]
	}

	/**
	 * Whether this screen being presented.
	 * @property presented
	 * @since 0.5.0
	 */
	public get presented(): boolean {
		return this[$presented]
	}

	/**
	 * Whether this screen is presenting.
	 * @property presenting
	 * @since 0.4.0
	 */
	public get presenting(): boolean {
		return this[$presenting]
	}

	/**
	 * Whether this screen is dismissing.
	 * @property dismissing
	 * @since 0.4.0
	 */
	public get dismissing(): boolean {
		return this[$dismissing]
	}

	/**
	 * The screen segue.
	 * @property segue
	 * @since 0.7.0
	 */
	public get segue(): Segue | null {
		return this[$segue]
	}

	/**
	 * The screen result.
	 * @property result
	 * @since 0.1.0
	 */
	public result: TResult | null = null

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the screen.
	 * @constructor
	 * @since 0.3.0
	 */
	constructor() {
		super()
		this[$frame] = new Frame()
		this[$frame].append(this)
	}

	/**
	 * Presents the specified screen with a segue.
	 * @method present
	 * @since 0.3.0
	 */
	public present(screen: Screen, using: Segue | string, options: ScreenPresentOptions = {}): Promise<void> {

		if (screen.presenting ||
			screen.dismissing) {
			return Promise.resolve()
		}

		if (this.presenting) {
			throw new Error(`Screen error: This screen is being presented.`)
		}

		if (this.presentee) {
			throw new Error(`Screen error: This screen is already presenting another screen.`)
		}

		let opts = Object.assign(
			{},
			OPTIONS,
			options
		)

		let dismissedScreen = this
		let presenterScreen = this
		let presentedScreen = screen

		let presentedScreenSegue = getPresentSegue(screen, using)

		presentedScreen[$modal] = opts.modal
		presentedScreen[$style] = opts.style
		presentedScreen[$segue] = presentedScreenSegue
		presenterScreen[$presenting] = true
		dismissedScreen[$dismissing] = true

		return presentScreenAsync(
			this,
			presentedScreen,
			presentedScreenSegue,
			options
		)
	}

	/**
	 * Dismisses this screen.
	 * @method dismiss
	 * @since 0.3.0
	 */
	public dismiss(using: Segue | string | null = null, options: ScreenDismissOptions = {}): Promise<void> {

		if (this.presenting ||
			this.dismissing) {
			return Promise.resolve()
		}

		if (this.presenter == null) {
			return Promise.resolve()
		}

		let dismissedScreen = this
		let presentedScreen = this.presenter

		if (presentedScreen == null) {
			return Promise.resolve()
		}

		let dismissedScreenSegue = getDismissSegue(this, using)

		dismissedScreen[$dismissing] = true
		presentedScreen[$dismissing] = true

		return dismissScreenAsync(
			this,
			dismissedScreen,
			dismissedScreenSegue,
			options
		)
	}

	/**
	 * Present a screen and wait for its result.
	 * @method prompt
	 * @since 0.3.0
	 */
	public prompt<R = any>(screen: Screen<R>, using: Segue | string, options: ScreenPresentOptions = {}): Promise<R | undefined | null> {

		if (screen.presenting ||
			screen.dismissing) {
			return Promise.reject()
		}

		if (this.presenting) {
			throw new Error(`Screen error: This screen is being presented.`)
		}

		if (this.presentee) {
			throw new Error(`Screen error: This screen is already presenting another screen.`)
		}

		return new Promise(success => {
			this.present(screen.one('done', () => success(screen.result)), using, options)
		})
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

			case 'beforepresent':
				this.onBeforePresent(event.data.segue)
				break

			case 'beforedismiss':
				this.onBeforeDismiss(event.data.segue)
				break

			case 'present':
				this.onPresent(event.data.segue)
				break

			case 'dismiss':
				this.onDismiss(event.data.segue)
				break

			case 'beforeenter':
				this.onBeforeEnter(event.data.segue)
				break

			case 'beforeleave':
				this.onBeforeLeave(event.data.segue)
				break

			case 'enter':
				this.onEnter(event.data.segue)
				break

			case 'leave':
				this.onLeave(event.data.segue)
				break

			case 'back':
				this.onBack(event)
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

			case 'movetowindow':
				this.onMoveToWindowInternal(event.data.window, event.data.former)
				break
		}

		return super.onEvent(event)
	}

	/**
	 * Called before this screen is presented.
	 * @method onBeforePresent
	 * @since 0.3.0
	 */
	public onBeforePresent(segue: Segue) {

	}

	/**
	 * Called after this screen is presented.
	 * @method onPresent
	 * @since 0.3.0
	 */
	public onPresent(segue: Segue) {

	}

	/**
	 * Called before this screen is dismissed.
	 * @method onBeforeDismiss
	 * @since 0.3.0
	 */
	public onBeforeDismiss(segue: Segue) {

	}

	/**
	 * Called after this screen is dismissed.
	 * @method onDismiss
	 * @since 0.3.0
	 */
	public onDismiss(segue: Segue) {

	}

	/**
	 * Called before this screen enters the main screen.
	 * @method onBeforeEnter
	 * @since 0.3.0
	 */
	public onBeforeEnter(segue: Segue) {

	}

	/**
	 * Called after this screen enters the main screen.
	 * @method onEnter
	 * @since 0.3.0
	 */
	public onEnter(segue: Segue) {

	}

	/**
	 * Called before this screen leaves the main screen.
	 * @method onBeforeLeave
	 * @since 0.3.0
	 */
	public onBeforeLeave(segue: Segue) {

	}

	/**
	 * Called after this screen leaves the main screen.
	 * @method onLeave
	 * @since 0.3.0
	 */
	public onLeave(segue: Segue) {

	}

	/**
	 * Called when the users presses a generic back button.
	 * @method onBack
	 * @since 0.3.0
	 */
	public onBack(event: Event) {

		let presentedScreen = this.presentee
		if (presentedScreen) {
			presentedScreen.emit(event)
			if (event.canceled) {
				return
			}
		}

		if (this.presenter == null) {
			return
		}

		event.cancel()

		this.dismiss()
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
	 * @method onMoveToWindowInternal
	 * @since 0.7.0
	 * @hidden
	 */
	private onMoveToWindowInternal(window: Window | null, former: Window | null) {

		let application = Application.main
		if (application == null) {
			return
		}

		if (window) {
			application.on('beforekeyboardshow', this.onBeforeApplicationKeyboardShow)
			application.on('beforekeyboardhide', this.onBeforeApplicationKeyboardHide)
			application.on('keyboardshow', this.onApplicationKeyboardShow)
			application.on('keyboardhide', this.onApplicationKeyboardHide)
			application.on('keyboardresize', this.onApplicationKeyboardResize)
		} else {
			application.off('beforekeyboardshow', this.onBeforeApplicationKeyboardShow)
			application.off('beforekeyboardhide', this.onBeforeApplicationKeyboardHide)
			application.off('keyboardshow', this.onApplicationKeyboardShow)
			application.off('keyboardhide', this.onApplicationKeyboardHide)
			application.off('keyboardresize', this.onApplicationKeyboardResize)
		}
	}

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method dispose
	 * @since 0.3.0
	 * @hidden
	 */
	public dispose(destroy: boolean = true) {

		this.removeFromParent()

		this.emit('dispose')

		let segue = this[$segue]
		if (segue) {
			segue.dispose()
		}

		this[$frame].removeFromParent()

		if (destroy) {
			this.destroy()
		}

		this[$modal] = false
		this[$segue] = null

		if (this.presenter) {
			this.presenter[$presentee] = null
		}

		this[$presenter] = null
		this[$presentee] = null

		this.result = null
	}

	/**
	 * @method updateStatusBar
	 * @since 0.5.0
	 * @hidden
	 */
	public updateStatusBar() {

		let application = Application.main
		if (application) {
			application.statusBarVisible = this.statusBarVisible
			application.statusBarForegroundColor = this.statusBarForegroundColor
			application.statusBarBackgroundColor = this.statusBarBackgroundColor
		}

		return this
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $presenter
	 * @since 0.7.0
	 * @hidden
	 */
	private [$presenter]: Screen | null = null

	/**
	 * @property $presentee
	 * @since 0.7.0
	 * @hidden
	 */
	private [$presentee]: Screen | null = null

	/**
	 * @property $presented
	 * @since 0.7.0
	 * @hidden
	 */
	private [$presented]: boolean = false

	/**
	 * @property $presenting
	 * @since 0.7.0
	 * @hidden
	 */
	private [$presenting]: boolean = false

	/**
	 * @property $dismissing
	 * @since 0.7.0
	 * @hidden
	 */
	private [$dismissing]: boolean = false

	/**
	 * @property $frame
	 * @since 0.7.0
	 * @hidden
	 */
	public [$frame]: Frame

	/**
	 * @property $segue
	 * @since 0.7.0
	 * @hidden
	 */
	private [$segue]: Segue | null = null

	/**
	 * @property $overlaid
	 * @since 0.7.0
	 * @hidden
	 */
	private [$style]: 'normal' | 'overlay' | 'popover' = 'normal'

	/**
	 * @property $modal
	 * @since 0.7.0
	 * @hidden
	 */
	private [$modal]: boolean = false

	/**
	 * @method onBeforeApplicationKeyboardShow
	 * @since 0.3.0
	 * @hidden
	 */
	@bound private onBeforeApplicationKeyboardShow(event: Event) {
		this.emit(event)
	}

	/**
	 * @method onApplicationKeyboardShow
	 * @since 0.3.0
	 * @hidden
	 */
	@bound private onApplicationKeyboardShow(event: Event) {
		this.emit(event)
	}

	/**
	 * @method onBeforeApplicationKeyboardHide
	 * @since 0.3.0
	 * @hidden
	 */
	@bound private onBeforeApplicationKeyboardHide(event: Event) {
		this.emit(event)
	}

	/**
	 * @method onApplicationKeyboardHide
	 * @since 0.3.0
	 * @hidden
	 */
	@bound private onApplicationKeyboardHide(event: Event) {
		this.emit(event)
	}

	/**
	 * @method onApplicationKeyboardResize
	 * @since 0.3.0
	 * @hidden
	 */
	@bound private onApplicationKeyboardResize(event: Event) {
		this.emit(event)
	}
}

/**
 * @const OPTIONS
 * @since 0.7.0
 * @hidden
 */
const OPTIONS: Required<ScreenPresentOptions> = {
	modal: false,
	style: 'normal'
}

/**
 * @interface ScreenPresentOptions
 * @since 0.4.0
 */
export interface ScreenPresentOptions {
	modal?: boolean
	style?: 'normal' | 'overlay'
}

/**
 * @interface ScreenDismissOptions
 * @since 0.4.0
 */
export interface ScreenDismissOptions {
	destroy?: boolean
}

/**
 * @type ScreenBeforePresentEvent
 * @since 0.3.0
 */
export type ScreenBeforePresentEvent = {
	segue: Segue
}

/**
 * @type ScreenPresentEvent
 * @since 0.1.0
 */
export type ScreenPresentEvent = {
	segue: Segue
}

/**
 * @type ScreenBeforeDismissEvent
 * @since 0.3.0
 */
export type ScreenBeforeDismissEvent = {
	segue: Segue
}

/**
 * @type ScreenDismissEvent
 * @since 0.1.0
 */
export type ScreenDismissEvent = {
	segue: Segue
}

/**
 * @type ScreenBeforeEnterEvent
 * @since 0.3.0
 */
export type ScreenBeforeEnterEvent = {
	segue: Segue
}

/**
 * @type ScreenEnterEvent
 * @since 0.3.0
 */
export type ScreenEnterEvent = {
	segue: Segue
}

/**
 * @type ScreenBeforeLeaveEvent
 * @since 0.3.0
 */
export type ScreenBeforeLeaveEvent = {
	segue: Segue
}

/**
 * @type ScreenLeaveEvent
 * @since 0.3.0
 */
export type ScreenLeaveEvent = {
	segue: Segue
}
