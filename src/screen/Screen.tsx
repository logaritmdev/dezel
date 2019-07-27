import { Application } from '../application/Application'
import { ApplicationKeyboardEvent } from '../application/Application'
import { Component } from '../component/Component'
import { bound } from '../decorator/bound'
import { watch } from '../decorator/watch'
import { Event } from '../event/Event'
import { ViewMoveToWindowEvent } from '../view/View'
import { ScreenDismissGesture } from './gesture/ScreenDismissGesture'
import { ScreenTransition } from './transition/ScreenTransition'
import { ScreenTransitionRegistry } from './transition/ScreenTransition'
import { Content } from './Content'
import { Enclosure } from './Enclosure'
import { Footer } from './Footer'
import { Header } from './Header'
import './Screen.ds'
import './Screen.ds.android'
import './Screen.ds.ios'

/**
 * @symbol PRESENTER
 * @since 0.1.0
 */
export const PRESENTER = Symbol('presenter')

/**
 * @symbol PRESENTEE
 * @since 0.1.0
 */
export const PRESENTEE = Symbol('presentee')

/**
 * @symbol PRESENTED
 * @since 0.1.0
 */
export const PRESENTED = Symbol('presented')

/**
 * @symbol TRANSITION
 * @since 0.4.0
 */
export const TRANSITION = Symbol('transition')

/**
 * @symbol MODAL
 * @since 0.4.0
 */
export const MODAL = Symbol('modal')

/**
 * @symbol PRESENTING
 * @since 0.4.0
 */
export const PRESENTING = Symbol('presenting')

/**
 * @symbol DISMISSING
 * @since 0.4.0
 */
export const DISMISSING = Symbol('dismissing')

/**
 * @symbol ACTIVE
 * @since 0.1.0
 */
export const ACTIVE = Symbol('active')

/**
 * @class Screen
 * @super View
 * @since 0.1.0
 */
export abstract class Screen<TRefs = any, TResult = any> extends Component<TRefs> {

	//--------------------------------------------------------------------------
	// Propertis
	//--------------------------------------------------------------------------

	/**
	 * The screen's status bar visibility.
	 * @property statusBarVisible
	 * @since 0.1.0
	 */
	public statusBarVisible: boolean = true

	/**
	 * The screen's status bar foreground color.
	 * @property statusBarForegroundColor
	 * @since 0.1.0
	 */
	public statusBarForegroundColor: 'white' | 'black' = 'black'

	/**
	 * The screen's status bar foreground color.
	 * @property statusBarBackgroundColor
	 * @since 0.1.0
	 */
	public statusBarBackgroundColor: string = 'transparent'

	/**
	 * The gesture used to dismiss this screen.
	 * @property dismissGesture
	 * @since 0.5.0
	 */
	@watch public dismissGesture?: ScreenDismissGesture | null = null

	/**
	 * Convenience property to get the current application.
	 * @property application
	 * @since 0.5.0
	 */
	public get application(): Application {

		let application = Application.main
		if (application == null) {
			throw new Error(`
				Screen error:
				Unable to retrieve the current application. Has it been launched ?
			`)
		}

		return application
	}

	/**
	 * The screen presented by this screen.
	 * @property presentee
	 * @since 0.1.0
	 */
	public get presentee(): Screen | undefined | null {
		return this[PRESENTEE]
	}

	/**
	 * The screen that presents this screen.
	 * @property presenter
	 * @since 0.1.0
	 */
	public get presenter(): Screen | undefined | null {
		return this[PRESENTER]
	}

	/**
	 * Whether the screen is currently presented.
	 * @property presented
	 * @since 0.5.0
	 */
	public get presented(): boolean {
		return this[PRESENTED]
	}

	/**
	 * Whether the screen is being presented.
	 * @property presenting
	 * @since 0.4.0
	 */
	public get presenting(): boolean {
		return this[PRESENTING]
	}

	/**
	 * Whether the screen is being dismissed.
	 * @property dismissing
	 * @since 0.4.0
	 */
	public get dismissing(): boolean {
		return this[DISMISSING]
	}

	/**
	 * Returns whether the screen is active on the screen.
	 * @property active
	 * @since 0.1.0
	 */
	public get active(): boolean {
		return this[ACTIVE]
	}

	/**
	 * Returns whether the screen is presented modally.
	 * @property active
	 * @since 0.1.0
	 */
	public get modal(): boolean {
		return this[MODAL]
	}

	/**
	 * The screen's result if any.
	 * @property result
	 * @since 0.1.0
	 */
	public result?: TResult | null

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method destroy
	 * @since 0.3.0
	 */
	public destroy() {

		// TODO
		// I used to call beforedismiss and dismiss here but that makes
		// these events called twice. See what can be done about that
		// in the case where the view is destroyed without being
		// dismissed first (like when multiple screen are dismissed at once)

		super.destroy()
	}

	/**
	 * Presents a screen.
	 * @method present
	 * @since 0.3.0
	 */
	public present(screen: Screen, transition?: ScreenTransition | string, options: ScreenPresentationOptions = {}): Promise<void> {

		if (screen.presenting) {

			console.error(`
				Screen error:
				This screen is being presented.
			`)

			return Promise.resolve()
		}

		if (this.presentee) {

			/*
			 * If this screen attemps to present a screen while its presented
			 * screen is being dismissed, for convenience we wait until the
			 * transition completes to present the new screen.
			 */

			if (this.presentee.dismissing) {

				return new Promise(success => {
					if (this.presentee) {
						this.presentee.one('dispose', () => this.present(screen, transition, options).then(success))
					}
				})

			}

			console.error(`
				Screen error:
				This screen already has a presented screen
			`)

			return Promise.resolve()
		}

		if (this.window == null ||
			this.parent == null) {

			console.error(`
				Screen error:
				The screen is not within a hierarchy
			`)

			return Promise.resolve()
		}

		if (typeof transition == 'string') {

			let constructor = ScreenTransitionRegistry.get(transition)
			if (constructor == null) {
				throw new Error(`
					Screen error:
					The transition ${transition} does not exists. Has it been registered ?
				`)
			}

			transition = new constructor()
		}

		let presenterScreen = this
		let presentedScreen = screen
		let presentedTransition = transition

		presentedScreen[PRESENTING] = true

		presenterScreen.setPresentee(presentedScreen)
		presentedScreen.setPresenter(presenterScreen)
		presentedScreen.setTransition(presentedTransition)

		return new Promise(success => {

			if (presentedTransition == null) {

				this.performPresent(
					presentedScreen,
					presentedTransition,
					options,
					success
				)

				return
			}

			requestAnimationFrame(() => this.performPresent(
				presentedScreen,
				presentedTransition,
				options,
				success
			))
		})
	}

	/**
	 * Presents a screen that returns a promise who's resolved when the screen returns.
	 * @method prompt
	 * @since 0.3.0
	 */
	public prompt<R = any>(screen: Screen<R>, transition?: ScreenTransition | string, options: ScreenPresentationOptions = {}): Promise<R | undefined | null> {

		if (this.presentee) {

			/*
			 * If this screen attemps to present a screen while its presented
			 * screen is being dismissed, for convenience we wait until the
			 * transition completes to present the new screen.
			 */

			if (this.presentee.dismissing) {

				return new Promise(success => {
					if (this.presentee) {
						this.presentee.one('dispose', () => this.prompt(screen, transition, options).then(success))
					}
				})

			}

			console.error(`
				Screen error:
				This screen already has a presented screen
			`)

			return Promise.resolve(null)
		}

		if (this.window == null ||
			this.parent == null) {

			console.error(`
				Screen error:
				The screen is not within a hierarchy
			`)

			return Promise.resolve(null)
		}

		return new Promise(success => {
			this.present(screen.one('dispose', () => success(screen.result)), transition, options)
		})
	}

	/**
	 * Dismiss this screen from its presenter.
	 * @method dismiss
	 * @since 0.3.0
	 */
	public dismiss(transition?: ScreenTransition | string | null): Promise<void> {

		if (this.dismissing) {

			console.error(`
				Screen error:
				This screen is being dismissed.
			`)

			return Promise.resolve()
		}

		if (this.presenter == null) {

			console.error(`
				Screen error:
				This screen is the root screen and cannot be dismissed.
			`)

			return Promise.resolve()
		}

		if (typeof transition == 'string') {

			let constructor = ScreenTransitionRegistry.get(transition)
			if (constructor == null) {
				throw new Error(`
					Screen error:
					The transition ${transition} does not exists. Has it been registered ?
				`)
			}

			transition = new constructor()
		}

		if (transition == null) {
			transition = this[TRANSITION]
		}

		let dismissedScreen = this
		let dismissedTransition = transition

		dismissedScreen[DISMISSING] = true

		return new Promise(success => {

			if (dismissedTransition == null) {

				this.performDismiss(
					dismissedScreen,
					dismissedTransition,
					success
				)

				return
			}

			requestAnimationFrame(() => this.performDismiss(
				dismissedScreen,
				dismissedTransition,
				success
			))
		})
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onPropertyChange
	 * @since 0.5.0
	 */
	protected onPropertyChange(property: string, newValue: any, oldValue: any) {

		if (property == 'dismissGesture') {

			let newScreenDismissGesture = newValue as ScreenDismissGesture
			let oldScreenDismissGesture = oldValue as ScreenDismissGesture

			if (oldScreenDismissGesture) {
				oldScreenDismissGesture.detach()
			}

			if (newScreenDismissGesture) {
				newScreenDismissGesture.attach(this)
			}
		}

		super.onPropertyChange(property, newValue, oldValue)
	}

	/**
	 * @inherited
	 * @method onEvent
	 * @since 0.7.0
	 */
	public onEvent(event: Event) {

		switch (event.type) {

			case 'beforepresent':
				this.onBeforePresent(event)
				break

			case 'beforedismiss':
				this.onBeforeDismiss(event)
				break

			case 'present':
				this.onPresent(event)
				break

			case 'dismiss':
				this.onDismiss(event)
				break

			case 'dismisscancel':
				this.onDismissCancel(event)
				break

			case 'beforeenter':
				this.onBeforeEnter(event)
				break

			case 'beforeleave':
				this.onBeforeLeave(event)
				break

			case 'enter':
				this.onEnter(event)
				break

			case 'leave':
				this.onLeave(event)
				break

			case 'back':
				this.onBack(event)
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
		}

		return super.onEvent(event)
	}

	/**
	 * Called before this screen is presented.
	 * @method onBeforePresent
	 * @since 0.3.0
	 */
	protected onBeforePresent(event: Event<ScreenBeforePresentEvent>) {

	}

	/**
	 * Called once this screen is presented.
	 * @method onPresent
	 * @since 0.3.0
	 */
	protected onPresent(event: Event<ScreenPresentEvent>) {

	}

	/**
	 * Called when this screen is dismissed before the animation occurs.
	 * @method onBeforeDismiss
	 * @since 0.3.0
	 */
	protected onBeforeDismiss(event: Event<ScreenBeforeDismissEvent>) {

	}

	/**
	 * Called when this screen is dismissed after the animation occurs.
	 * @method onDismiss
	 * @since 0.3.0
	 */
	protected onDismiss(event: Event<ScreenDismissEvent>) {

	}

	/**
	 * Called when this screen dismissal has been cancelled.
	 * @method onDismissCancel
	 * @since 0.4.0
	 */
	protected onDismissCancel(event: Event) {

	}

	/**
	 * Called before the entering view transition starts.
	 * @method onBeforeEnter
	 * @since 0.3.0
	 */
	protected onBeforeEnter(event: Event<ScreenBeforeEnterEvent>) {

	}

	/**
	 * Called once the entering view transition completes.
	 * @method onEnter
	 * @since 0.3.0
	 */
	protected onEnter(event: Event<ScreenEnterEvent>) {

	}

	/**
	 * Called before the leaving view transition starts.
	 * @method onBeforeLeave
	 * @since 0.3.0
	 */
	protected onBeforeLeave(event: Event<ScreenBeforeLeaveEvent>) {

	}

	/**
	 * Called once the leaving view transition completes.
	 * @method onLeave
	 * @since 0.3.0
	 */
	protected onLeave(event: Event<ScreenLeaveEvent>) {

	}

	/**
	 * Called when a back command is requested.
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
	 * Called before the on-screen keyboard appears.
	 * @method onBeforeKeyboardShow
	 * @since 0.3.0
	 */
	protected onBeforeKeyboardShow(event: Event<ApplicationKeyboardEvent>) {

	}

	/**
	 * Called when the on-screen keyboard appears.
	 * @method onKeyboardShow
	 * @since 0.3.0
	 */
	protected onKeyboardShow(event: Event) {

	}

	/**
	 * Called before the on-screen keyboard disappears.
	 * @method onBeforeKeyboardHide
	 * @since 0.3.0
	 */
	protected onBeforeKeyboardHide(event: Event) {

	}

	/**
	 * Called when the on-screen keyboard disappears.
	 * @method onKeyboardHide
	 * @since 0.3.0
	 */
	protected onKeyboardHide(event: Event) {

	}

	/**
	 * Called when the on-screen keyboard resizes.
	 * @method onKeyboardResize
	 * @since 0.3.0
	 */
	protected onKeyboardResize(event: Event) {

	}

	/**
	 * @inherited
	 * @method onMoveToWindowDefault
	 * @since 0.4.0
	 */
	protected onMoveToWindowDefault(event: Event<ViewMoveToWindowEvent>) {
		// TODO
		// Use pubsub ?
		//super.onMoveToWindowDefault(event)

		if (event.data.window) {
			this.application.on('beforekeyboardshow', this.onBeforeApplicationKeyboardShow)
			this.application.on('beforekeyboardhide', this.onBeforeApplicationKeyboardHide)
			this.application.on('keyboardshow', this.onApplicationKeyboardShow)
			this.application.on('keyboardhide', this.onApplicationKeyboardHide)
			this.application.on('keyboardresize', this.onApplicationKeyboardResize)
			return
		}

		if (event.data.window == null) {
			this.application.off('beforekeyboardshow', this.onBeforeApplicationKeyboardShow)
			this.application.off('beforekeyboardhide', this.onBeforeApplicationKeyboardHide)
			this.application.off('keyboardshow', this.onApplicationKeyboardShow)
			this.application.off('keyboardhide', this.onApplicationKeyboardHide)
			this.application.off('keyboardresize', this.onApplicationKeyboardResize)
			return
		}
	}

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @property enclosure
	 * @since 0.3.0
	 * @hidden
	 */
	public enclosure?: Enclosure | null

	/**
	 * @method setActive
	 * @since 0.3.0
	 * @hidden
	 */
	public setActive(active: boolean) {
		this[ACTIVE] = active
	}

	/**
	 * @method setPresenter
	 * @since 0.3.0
	 * @hidden
	 */
	public setPresenter(screen?: Screen | null) {
		this[PRESENTER] = screen
	}

	/**
	 * @method setPresentee
	 * @since 0.3.0
	 * @hidden
	 */
	public setPresentee(screen?: Screen | null) {
		this[PRESENTEE] = screen
	}

	/**
	 * @method setPresented
	 * @since 0.5.0
	 * @hidden
	 */
	public setPresented(presented: boolean) {
		this[PRESENTED] = presented
	}

	/**
	 * @method setTransition
	 * @since 0.4.0
	 * @hidden
	 */
	public setTransition(transition?: ScreenTransition | null) {
		this[TRANSITION] = transition
	}

	/**
	 * @method emitBeforePresent
	 * @since 0.3.0
	 * @hidden
	 */
	public async emitBeforePresent(transition: ScreenTransition) {
		this.emit<ScreenBeforePresentEvent>('beforepresent', { data: { transition } })
		await transition.standby()
	}

	/**
	 * @method emitPresent
	 * @since 0.3.0
	 * @hidden
	 */
	public async emitPresent(transition: ScreenTransition) {
		this.emit<ScreenPresentEvent>('present', { data: { transition } })
		await transition.standby()
	}

	/**
	 * @method emitDismiss
	 * @since 0.3.0
	 * @hidden
	 */
	public async emitDismiss(transition: ScreenTransition) {
		this.emit<ScreenBeforeDismissEvent>('dismiss', { data: { transition, result: this.result } })
		await transition.standby()
	}

	/**
	 * @method emitBeforeEnter
	 * @since 0.3.0
	 * @hidden
	 */
	public async emitBeforeEnter(transition: ScreenTransition) {
		this.emit<ScreenBeforeEnterEvent>('beforeenter', { data: { transition } })
		await transition.standby()
	}

	/**
	 * @method emitEnter
	 * @since 0.3.0
	 * @hidden
	 */
	public async emitEnter(transition: ScreenTransition) {
		this.emit<ScreenEnterEvent>('enter', { data: { transition } })
		await transition.standby()
	}

	/**
	 * @method emitBeforeLeave
	 * @since 0.3.0
	 * @hidden
	 */
	public async emitBeforeLeave(transition: ScreenTransition) {
		this.emit<ScreenBeforeLeaveEvent>('beforeleave', { data: { transition } })
		await transition.standby()
	}

	/**
	 * @method emitLeave
	 * @since 0.3.0
	 * @hidden
	 */
	public async emitLeave(transition: ScreenTransition) {
		this.emit<ScreenLeaveEvent>('leave', { data: { transition } })
		await transition.standby()
	}

	/**
	 * @method updateStatusBar
	 * @since 0.5.0
	 * @hidden
	 */
	public updateStatusBar() {
		this.application.statusBarVisible = this.statusBarVisible
		this.application.statusBarForegroundColor = this.statusBarForegroundColor
		this.application.statusBarBackgroundColor = this.statusBarBackgroundColor
	}

	/**
	 * @method dispose
	 * @since 0.3.0
	 * @hidden
	 */
	public dispose() {

		let event = new Event('beforedestroy', {
			propagable: false,
			cancelable: true
		})

		this.emit(event)

		let destroy = event.canceled == false

		if (this.presenter) {
			this.presenter.setPresentee(null)
		}

		this.setPresenter(null)
		this.setPresentee(null)
		this.setTransition(null)

		this.removeFromParent()

		this[MODAL] = false

		this.emit('dispose')

		if (destroy) {
			this.destroy()
		}

		this.result = null
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property [MODAL]
	 * @since 0.4.0
	 * @hidden
	 */
	private [MODAL]: boolean = false

	/**
	 * @property [ACTIVE]
	 * @since 0.3.0
	 * @hidden
	 */
	private [ACTIVE]: boolean = false

	/**
	 * @property [PRESENTER]
	 * @since 0.3.0
	 * @hidden
	 */
	private [PRESENTER]?: Screen | null

	/**
	 * @property [PRESENTEE]
	 * @since 0.3.0
	 * @hidden
	 */
	private [PRESENTEE]?: Screen | null

	/**
	 * @property [PRESENTED]
	 * @since 0.5.0
	 * @hidden
	 */
	private [PRESENTED]: boolean = false

	/**
	 * @property [TRANSITION]
	 * @since 0.4.0
	 * @hidden
	 */
	private [TRANSITION]?: ScreenTransition | null

	/**
	 * @property [PRESENTING]
	 * @since 0.4.0
	 * @hidden
	 */
	private [PRESENTING]: boolean = false

	/**
	 * @property [DISMISSING]
	 * @since 0.4.0
	 * @hidden
	 */
	private [DISMISSING]: boolean = false

	/**
	 * @method performPresent
	 * @since 0.5.0
	 * @hidden
	 */
	private async performPresent(screen: Screen, transition: ScreenTransition | null | undefined, options: ScreenPresentationOptions, done: () => void) {

		try {

			let window = this.window
			let parent = this.parent

			if (window == null ||
				parent == null) {
				throw new Error(`
					Screen error:
					The screen screen is not part of valid a hierarchy.
				`)
			}

			window.touchable = false

			if (transition == null) {
				transition = new ScreenTransition()
			}

			let presenterScreen: Screen<any> = this
			let dismissedScreen: Screen<any> = this
			let presentedScreen: Screen<any> = screen

			if (presentedScreen.enclosure == null) {
				presentedScreen.enclosure = new Enclosure(presentedScreen)
			}

			let presentedScreenEnclosure = presentedScreen.enclosure

			if (options.modal) {

				let dismissedScreenEnclosure = this.getModalEnclosure()
				if (dismissedScreenEnclosure == null) {
					throw new Error(`
						Screen error:
						Unable to retrieve the window's last presented screen.
					`)
				}

				dismissedScreen = dismissedScreenEnclosure.screen

				window.insertAfter(
					presentedScreenEnclosure,
					dismissedScreenEnclosure
				)

				presentedScreen[MODAL] = true

			} else {

				parent.insertAfter(
					presentedScreenEnclosure,
					presenterScreen
				)

			}

			presentedScreen.visible = true
			presentedScreen.resolve()

			presentedScreen.updateStatusBar()

			transition.emitBeforePresent(
				presentedScreen,
				dismissedScreen
			)

			await dismissedScreen.emitBeforeLeave(transition)
			await presentedScreen.emitBeforePresent(transition)
			await presentedScreen.emitBeforeEnter(transition)

			await transition.present(
				presentedScreen,
				dismissedScreen
			)

			transition.emitAfterPresent(
				presentedScreen,
				dismissedScreen
			)

			dismissedScreen.visible = false

			await dismissedScreen.emitLeave(transition)
			await presentedScreen.emitPresent(transition)
			await presentedScreen.emitEnter(transition)

			dismissedScreen.setActive(false)
			presentedScreen.setActive(true)
			presentedScreen.setPresented(true)

			presentedScreen[PRESENTING] = false

			window.touchable = true

			done()

		} catch (e) {
			console.error(e)
		}
	}

	/**
	 * @method performDismiss
	 * @since 0.5.0
	 * @hidden
	 */
	private async performDismiss(screen: Screen, transition: ScreenTransition | null | undefined, done: () => void) {

		try {

			let window = this.window
			if (window == null) {
				throw new Error(`
					Screen error:
					The screen screen is not part of valid a hierarchy.
				`)
			}

			window.touchable = false

			if (transition == null) {
				transition = new ScreenTransition()
			}

			let dismissedScreen: Screen = this
			let presentedScreen: Screen = this.presenter!

			let presentedScreenEnclosure = presentedScreen.enclosure
			let dismissedScreenEnclosure = dismissedScreen.enclosure

			let dismissed = this.getPresenteeList()
			if (dismissed.length) {

				dismissedScreen[DISMISSING] = false
				dismissedScreen = dismissed[0]
				dismissedScreen[DISMISSING] = true

				dismissed.push(this)
				dismissed.shift()

				for (let screen of dismissed) {
					screen[DISMISSING] = true
				}
			}

			if (this[MODAL]) {

				if (dismissedScreenEnclosure == null) {
					throw new Error(`
						Screen error:
						The dismissed screen is missing its enclosure.
					`)
				}

				let index = window.children.indexOf(dismissedScreenEnclosure)
				if (index == -1) {
					throw new Error(`
						Screen error:
						The modal screen is not found within the hierarchy.
					`)
				}

				presentedScreenEnclosure = window.children[index - 1] as Enclosure
				presentedScreen = presentedScreenEnclosure.screen
			}

			presentedScreen.visible = true
			presentedScreen.resolve()

			transition.emitBeforeDismiss(
				presentedScreen,
				dismissedScreen
			)

			let event = new Event<ScreenBeforeDismissEvent>('beforedismiss', {
				propagable: false,
				cancelable: true,
				data: {
					transition,
					result: this.result
				}
			})

			dismissedScreen.emit(event)

			if (event.canceled) {

				dismissedScreen[DISMISSING] = false

				presentedScreen.visible = false
				dismissedScreen.visible = true
				dismissedScreen.emit('dismisscancel')

				done()

				return
			}

			await transition.standby()
			await dismissedScreen.emitBeforeLeave(transition)
			await presentedScreen.emitBeforeEnter(transition)

			for (let screen of dismissed) {
				screen.emitBeforeLeave(transition)
			}

			presentedScreen.updateStatusBar()

			this.emit('beforedispose')

			await transition.dismiss(
				presentedScreen,
				dismissedScreen
			)

			transition.emitAfterDismiss(
				presentedScreen,
				dismissedScreen
			)

			await dismissedScreen.emitLeave(transition)
			await presentedScreen.emitEnter(transition)
			await dismissedScreen.emitDismiss(transition)

			for (let screen of dismissed) {
				screen.emitDismiss(transition)
			}

			dismissedScreen.setPresented(false)
			dismissedScreen.setActive(false)
			presentedScreen.setActive(true)

			for (let screen of dismissed) {
				screen.setActive(false)
				screen.setPresented(false)
			}

			dismissedScreen[DISMISSING] = false

			dismissedScreen.dispose()

			for (let screen of dismissed) {

				screen[DISMISSING] = false

				screen.dispose()

				if (screen.enclosure) {
					screen.enclosure.destroy()
					screen.enclosure = null
				}
			}

			if (this.enclosure) {
				this.enclosure.destroy()
				this.enclosure = null
			}

			window.touchable = true

			done()

		} catch (e) {
			console.error(e)
		}
	}

	/**
	 * @method getModalEnclosure
	 * @since 0.4.0
	 * @hidden
	 */
	private getModalEnclosure() {

		let window = this.window
		if (window == null) {
			return null
		}

		let index = window.children.length - 1

		while (index >= 0) {

			let view = window.children[index]
			if (view instanceof Enclosure) {
				return view
			}

			index--
		}

		return null
	}

	/**
	 * @method getPresenteeList
	 * @since 0.4.0
	 * @hidden
	 */
	private getPresenteeList() {

		let node = this.presentee
		if (node == null) {
			return []
		}

		let list: Array<Screen> = []

		while (node) {

			if (node.dismissing) {
				throw new Error(`
					Screen error:
					Cannot dismiss a screen while another screen is being dismissed.
				`)
			}

			list.unshift(node)

			node = node.presentee
		}

		return list
	}

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
 * @interface ScreenPresentationOptions
 * @since 0.4.0
 */
export interface ScreenPresentationOptions {
	modal?: boolean
}

/**
 * @type ScreenBeforePresentEvent
 * @since 0.3.0
 */
export type ScreenBeforePresentEvent = {
	transition: ScreenTransition
}

/**
 * @type ScreenPresentEvent
 * @since 0.1.0
 */
export type ScreenPresentEvent = {
	transition: ScreenTransition
}

/**
 * @type ScreenBeforeDismissEvent
 * @since 0.3.0
 */
export type ScreenBeforeDismissEvent = {
	transition: ScreenTransition
	result: any
}

/**
 * @type ScreenDismissEvent
 * @since 0.1.0
 */
export type ScreenDismissEvent = {
	transition: ScreenTransition
	result: any
}

/**
 * @type ScreenBeforeEnterEvent
 * @since 0.3.0
 */
export type ScreenBeforeEnterEvent = {
	transition: ScreenTransition
}

/**
 * @type ScreenEnterEvent
 * @since 0.3.0
 */
export type ScreenEnterEvent = {
	transition: ScreenTransition
}

/**
 * @type ScreenBeforeLeaveEvent
 * @since 0.3.0
 */
export type ScreenBeforeLeaveEvent = {
	transition: ScreenTransition
}

/**
 * @type ScreenLeaveEvent
 * @since 0.3.0
 */
export type ScreenLeaveEvent = {
	transition: ScreenTransition
}
