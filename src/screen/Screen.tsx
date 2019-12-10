import { $dismissing } from './symbol/Screen'
import { $frame } from './symbol/Screen'
import { $modal } from './symbol/Screen'
import { $presented } from './symbol/Screen'
import { $presentee } from './symbol/Screen'
import { $presenter } from './symbol/Screen'
import { $presenting } from './symbol/Screen'
import { $segue } from './symbol/Screen'
import { $style } from './symbol/Screen'
import { bound } from '../decorator/bound'
import { destroyScreenFrame } from './private/Screen'
import { destroyScreenSegue } from './private/Screen'
import { dismissScreenAsync } from './private/Screen'
import { getScreenDismissSegue } from './private/Screen'
import { getScreenPresentSegue } from './private/Screen'
import { getScreenSegue } from './private/Screen'
import { presentScreenAsync } from './private/Screen'
import { removeScreenFrame } from './private/Screen'
import { setScreenDismissing } from './private/Screen'
import { setScreenModal } from './private/Screen'
import { setScreenPresentee } from './private/Screen'
import { setScreenPresenter } from './private/Screen'
import { setScreenPresenting } from './private/Screen'
import { setScreenSegue } from './private/Screen'
import { setScreenStyle } from './private/Screen'
import { Application } from '../application/Application'
import { Component } from '../component/Component'
import { Event } from '../event/Event'
import { ViewMoveToWindowEvent } from '../view/View'
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
	 * @property statusBarVisible
	 * @since 0.1.0
	 */
	public statusBarVisible: boolean = true

	/**
	 * @property statusBarForegroundColor
	 * @since 0.1.0
	 */
	public statusBarForegroundColor: 'white' | 'black' = 'black'

	/**
	 * @property statusBarBackgroundColor
	 * @since 0.1.0
	 */
	public statusBarBackgroundColor: string = 'transparent'

	/**
	 * @property presenter
	 * @since 0.1.0
	 */
	public get presenter(): Screen | null {
		return this[$presenter]
	}

	/**
	 * @property presentee
	 * @since 0.1.0
	 */
	public get presentee(): Screen | null {
		return this[$presentee]
	}

	/**
	 * @property presented
	 * @since 0.5.0
	 */
	public get presented(): boolean {
		return this[$presented]
	}

	/**
	 * @property presenting
	 * @since 0.4.0
	 */
	public get presenting(): boolean {
		return this[$presenting]
	}

	/**
	 * @property dismissing
	 * @since 0.4.0
	 */
	public get dismissing(): boolean {
		return this[$dismissing]
	}

	/**
	 * @property segue
	 * @since 0.7.0
	 */
	public get segue(): Segue | null {
		return this[$segue]
	}

	/**
	 * @property result
	 * @since 0.1.0
	 */
	public result: TResult | null = null

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method present
	 * @since 0.3.0
	 */
	public present(screen: Screen, using: Segue | string, options: ScreenPresentOptions = {}): Promise<void> {

		if (screen.presenting ||
			screen.dismissing) {
			return Promise.resolve()
		}

		if (this.presenting) {
			return Promise.resolve()
		}

		if (this.presentee) {

			if (this.presentee.dismissing ||
				this.presentee.presenting) {
				return this.presentee.presentAfter(screen, using, options)
			}

			throw new Error(
				`Screen error: This screen is already presenting another screen.`
			)
		}

		setScreenModal(this, options.modal || false)
		setScreenStyle(this, options.style || 'normal')

		let dismissedScreen = this
		let presenterScreen = this
		let presentedScreen = screen

		let presentedScreenSegue = getScreenPresentSegue(screen, using)

		setScreenPresenting(presenterScreen, true)
		setScreenDismissing(dismissedScreen, true)

		setScreenSegue(presentedScreen, presentedScreenSegue)

		return presentScreenAsync(
			this,
			presentedScreen,
			presentedScreenSegue,
			options
		)
	}

	/**
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

		let presentedScreen = this.presenter!
		let dismissedScreen = this

		let dismissedScreenSegue = getScreenDismissSegue(this, using)

		setScreenDismissing(dismissedScreen, true)
		setScreenDismissing(presentedScreen, true)

		return dismissScreenAsync(
			this,
			dismissedScreen,
			dismissedScreenSegue,
			options
		)
	}

	/**
	 * @method prompt
	 * @since 0.3.0
	 */
	public prompt<R = any>(screen: Screen<R>, using: Segue | string, options: ScreenPresentOptions = {}): Promise<R | undefined | null> {

		if (screen.presenting ||
			screen.dismissing) {
			return Promise.reject()
		}

		if (this.presenting) {
			return Promise.reject()
		}

		if (this.presentee) {

			if (this.presentee.dismissing ||
				this.presentee.presenting) {
				return this.presentee.promptAfter(screen, using, options)
			}

			throw new Error(
				`Screen error: This screen is already presenting another screen.`
			)
		}

		return new Promise(success => {
			this.present(screen.one('done', () => success(screen.result)), using, options)
		})
	}

	/**
	 * @method presentAfter
	 * @since 0.3.0
	 */
	public presentAfter(screen: Screen, using: Segue | string, options: ScreenPresentOptions = {}): Promise<void> {

		/*
		 * Returns a promise that will resolve once this screen is disposed
		 * and the presented screen transition ends.
		 */

		return new Promise(success => {
			this.one('exit', () => this.present(screen, using, options).then(success))
		})
	}

	/**
	 * @method promptAfter
	 * @since 0.3.0
	 */
	public promptAfter<R = any>(screen: Screen<R>, using: Segue | string, options: ScreenPresentOptions = {}): Promise<R | undefined | null> {

		/*
		 * Returns a promise that will resolve once this screen is disposed
		 * and the presented screen is also disposed.
		 */

		return new Promise(success => {
			this.one('exit', () => this.prompt(screen, using, options).then(success))
		})
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @method onDestroy
	 * @since 0.4.0
	 */
	protected onDestroy() {
		destroyScreenFrame(this)
		destroyScreenSegue(this)
		super.onDestroy()
	}

	/**
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
		}

		return super.onEvent(event)
	}

	/**
	 * @method onBeforePresent
	 * @since 0.3.0
	 */
	protected onBeforePresent(segue: Segue) {

	}

	/**
	 * @method onPresent
	 * @since 0.3.0
	 */
	protected onPresent(segue: Segue) {

	}

	/**
	 * @method onBeforeDismiss
	 * @since 0.3.0
	 */
	protected onBeforeDismiss(segue: Segue) {

	}

	/**
	 * @method onDismiss
	 * @since 0.3.0
	 */
	protected onDismiss(segue: Segue) {

	}

	/**
	 * @method onBeforeEnter
	 * @since 0.3.0
	 */
	protected onBeforeEnter(segue: Segue) {

	}

	/**
	 * @method onEnter
	 * @since 0.3.0
	 */
	protected onEnter(segue: Segue) {

	}

	/**
	 * @method onBeforeLeave
	 * @since 0.3.0
	 */
	protected onBeforeLeave(segue: Segue) {

	}

	/**
	 * @method onLeave
	 * @since 0.3.0
	 */
	protected onLeave(segue: Segue) {

	}

	/**
	 * @method onBack
	 * @since 0.3.0
	 */
	protected onBack(event: Event) {

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
	 * @method onBeforeKeyboardShow
	 * @since 0.3.0
	 */
	protected onBeforeKeyboardShow(height: number, duration: number, equation: string) {

	}

	/**
	 * @method onKeyboardShow
	 * @since 0.3.0
	 */
	protected onKeyboardShow(height: number, duration: number, equation: string) {

	}

	/**
	 * @method onBeforeKeyboardHide
	 * @since 0.3.0
	 */
	protected onBeforeKeyboardHide(height: number, duration: number, equation: string) {

	}

	/**
	 * @method onKeyboardHide
	 * @since 0.3.0
	 */
	protected onKeyboardHide(height: number, duration: number, equation: string) {

	}

	/**
	 * @method onKeyboardResize
	 * @since 0.3.0
	 */
	protected onKeyboardResize(height: number, duration: number, equation: string) {

	}

	/**
	 * @method onMoveToWindowDefault
	 * @since 0.4.0
	 */
	protected onMoveToWindowDefault(event: Event<ViewMoveToWindowEvent>) {

		let application = Application.main
		if (application == null) {
			return
		}

		if (event.data.window) {
			application.on('beforekeyboardshow', this.onBeforeApplicationKeyboardShow)
			application.on('beforekeyboardhide', this.onBeforeApplicationKeyboardHide)
			application.on('keyboardshow', this.onApplicationKeyboardShow)
			application.on('keyboardhide', this.onApplicationKeyboardHide)
			application.on('keyboardresize', this.onApplicationKeyboardResize)
			return
		}

		if (event.data.window == null) {
			application.off('beforekeyboardshow', this.onBeforeApplicationKeyboardShow)
			application.off('beforekeyboardhide', this.onBeforeApplicationKeyboardHide)
			application.off('keyboardshow', this.onApplicationKeyboardShow)
			application.off('keyboardhide', this.onApplicationKeyboardHide)
			application.off('keyboardresize', this.onApplicationKeyboardResize)
			return
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

		removeScreenFrame(this)

		if (destroy) {
			this.destroy()
		}

		if (this.presenter) {
			setScreenPresentee(this.presenter, null)
		}

		setScreenPresenter(this, null)
		setScreenPresentee(this, null)
		setScreenModal(this, false)
		setScreenSegue(this, null)

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
	 * @property $segue
	 * @since 0.7.0
	 * @hidden
	 */
	private [$segue]: Segue | null = null

	/**
	 * @property $frame
	 * @since 0.7.0
	 * @hidden
	 */
	public [$frame]: Frame | null = null

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
