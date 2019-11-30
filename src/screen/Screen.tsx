import { Application } from '../application/Application'
import { ApplicationKeyboardEvent } from '../application/Application'
import { Component } from '../component/Component'
import { bound } from '../decorator/bound'
import { watch } from '../decorator/watch'
import { Event } from '../event/Event'
import { ViewMoveToWindowEvent } from '../view/View'
import { setScreenActive } from './private/Screen'
import { setScreenPresented } from './private/Screen'
import { setScreenPresentee } from './private/Screen'
import { setScreenPresenter } from './private/Screen'
import { setScreenTransition } from './private/Screen'
import { $active } from './symbol/Screen'
import { $dismissing } from './symbol/Screen'
import { $modal } from './symbol/Screen'
import { $presented } from './symbol/Screen'
import { $presentee } from './symbol/Screen'
import { $presenter } from './symbol/Screen'
import { $presenting } from './symbol/Screen'
import { $transition } from './symbol/Screen'
import { Enclosure } from './Enclosure'
import { ScreenDismissGesture } from './ScreenDismissGesture'
import { ScreenTransition } from './ScreenTransition'
import { ScreenTransitionRegistry } from './ScreenTransitionRegistry'
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
	 * @property dismissGesture
	 * @since 0.5.0
	 */
	@watch public dismissGesture: ScreenDismissGesture | null = null

	/**
	 * @property presentee
	 * @since 0.1.0
	 */
	public get presentee(): Screen | undefined | null {
		return this[$presentee]
	}

	/**
	 * @property presenter
	 * @since 0.1.0
	 */
	public get presenter(): Screen | undefined | null {
		return this[$presenter]
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
	 * @property active
	 * @since 0.1.0
	 */
	public get active(): boolean {
		return this[$active]
	}

	/**
	 * @property active
	 * @since 0.1.0
	 */
	public get modal(): boolean {
		return this[$modal]
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
	 * @method destroy
	 * @since 0.3.0
	 */
	public destroy() {

		// TODO
		// I used to call beforedismiss and dismiss here but that makes
		// these events called twice. See what can be done about that
		// in the case where the view is destroyed without being
		// dismissed first (like when multiple screen are dismissed at once)

		return super.destroy()
	}

	/**
	 * @method present
	 * @since 0.3.0
	 */
	public present(screen: Screen, transition?: ScreenTransition | string, options: ScreenPresentationOptions = {}): Promise<void> {

		if (screen.presenting) {
			return Promise.reject()
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

			throw new Error(
				`Screen error: ` +
				`Screen has already a presented screen.`
			)
		}

		if (this.window == null ||
			this.parent == null) {
			throw new Error(
				`Screen error: ` +
				`Screen is not within a hierarchy.`
			)
		}

		if (typeof transition == 'string') {

			let constructor = ScreenTransitionRegistry.get(transition)
			if (constructor == null) {
				throw new Error(
					`Screen error: ` +
					`Screen transition ${transition} does not exists. Has it been registered ?`
				)
			}

			transition = new constructor()
		}

		let presenterScreen = this
		let presentedScreen = screen
		let presentedTransition = transition || null

		presentedScreen[$presenting] = true

		setScreenPresentee(presenterScreen, presentedScreen)
		setScreenPresenter(presentedScreen, presenterScreen)
		setScreenTransition(presentedScreen, presentedTransition)

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

			throw new Error(
				`Screen error: ` +
				`Screen has already a presented screen.`
			)
		}

		if (this.window == null ||
			this.parent == null) {

			console.error(
				`Screen error: ` +
				`The screen is not within a hierarchy.`
			)

			return Promise.resolve(null)
		}

		return new Promise(success => {
			this.present(screen.one('dispose', () => success(screen.result)), transition, options)
		})
	}

	/**
	 * @method dismiss
	 * @since 0.3.0
	 */
	public dismiss(transition?: ScreenTransition | string | null): Promise<void> {

		if (this.dismissing) {
			return Promise.reject()
		}

		if (this.presenter == null) {

			console.error(
				`Screen error: ` +
				`This screen is the root screen and cannot be dismissed.`
			)

			return Promise.resolve()
		}

		if (typeof transition == 'string') {

			let constructor = ScreenTransitionRegistry.get(transition)
			if (constructor == null) {
				throw new Error(
					`Screen error: ` +
					`The transition ${transition} does not exists. Has it been registered ?`
				)
			}

			transition = new constructor()
		}

		if (transition == null) {
			transition = this[$transition]
		}

		let dismissedScreen = this
		let dismissedTransition = transition

		dismissedScreen[$dismissing] = true

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
	}

	/**
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
	 * @method onBeforePresent
	 * @since 0.3.0
	 */
	protected onBeforePresent(event: Event<ScreenBeforePresentEvent>) {

	}

	/**
	 * @method onPresent
	 * @since 0.3.0
	 */
	protected onPresent(event: Event<ScreenPresentEvent>) {

	}

	/**
	 * @method onBeforeDismiss
	 * @since 0.3.0
	 */
	protected onBeforeDismiss(event: Event<ScreenBeforeDismissEvent>) {

	}

	/**
	 * @method onDismiss
	 * @since 0.3.0
	 */
	protected onDismiss(event: Event<ScreenDismissEvent>) {

	}

	/**
	 * @method onDismissCancel
	 * @since 0.4.0
	 */
	protected onDismissCancel(event: Event) {

	}

	/**
	 * @method onBeforeEnter
	 * @since 0.3.0
	 */
	protected onBeforeEnter(event: Event<ScreenBeforeEnterEvent>) {

	}

	/**
	 * @method onEnter
	 * @since 0.3.0
	 */
	protected onEnter(event: Event<ScreenEnterEvent>) {

	}

	/**
	 * @method onBeforeLeave
	 * @since 0.3.0
	 */
	protected onBeforeLeave(event: Event<ScreenBeforeLeaveEvent>) {

	}

	/**
	 * @method onLeave
	 * @since 0.3.0
	 */
	protected onLeave(event: Event<ScreenLeaveEvent>) {

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
	protected onBeforeKeyboardShow(event: Event<ApplicationKeyboardEvent>) {

	}

	/**
	 * @method onKeyboardShow
	 * @since 0.3.0
	 */
	protected onKeyboardShow(event: Event) {

	}

	/**
	 * @method onBeforeKeyboardHide
	 * @since 0.3.0
	 */
	protected onBeforeKeyboardHide(event: Event) {

	}

	/**
	 * @method onKeyboardHide
	 * @since 0.3.0
	 */
	protected onKeyboardHide(event: Event) {

	}

	/**
	 * @method onKeyboardResize
	 * @since 0.3.0
	 */
	protected onKeyboardResize(event: Event) {

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
	 * @property enclosure
	 * @since 0.3.0
	 * @hidden
	 */
	public enclosure: Enclosure | null = null

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

		let application = Application.main
		if (application == null) {
			return
		}

		application.statusBarVisible = this.statusBarVisible
		application.statusBarForegroundColor = this.statusBarForegroundColor
		application.statusBarBackgroundColor = this.statusBarBackgroundColor
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
			setScreenPresentee(this.presenter, null)
		}

		setScreenPresenter(this, null)
		setScreenPresentee(this, null)
		setScreenTransition(this, null)

		this.removeFromParent()

		this[$modal] = false

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
	 * @property $transition
	 * @since 0.7.0
	 * @hidden
	 */
	private [$transition]: ScreenTransition | null = null

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
	 * @property $modal
	 * @since 0.7.0
	 * @hidden
	 */
	private [$modal]: boolean = false

	/**
	 * @property $active
	 * @since 0.7.0
	 * @hidden
	 */
	private [$active]: boolean = false

	/**
	 * @method performPresent
	 * @since 0.5.0
	 * @hidden
	 */
	private async performPresent(screen: Screen, transition: ScreenTransition | null, options: ScreenPresentationOptions, done: () => void) {

		try {

			let window = this.window
			let parent = this.parent

			if (window == null ||
				parent == null) {
				throw new Error(
					`Screen error: ` +
					`The screen screen is not part of valid a hierarchy.`
				)
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
					throw new Error(
						`Screen error: ` +
						`Unable to retrieve the window's last presented screen.`
					)
				}

				dismissedScreen = dismissedScreenEnclosure.screen

				window.insert(
					presentedScreenEnclosure,
					window.children.indexOf(dismissedScreenEnclosure)
				)

				presentedScreen[$modal] = true

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

			setScreenActive(dismissedScreen, false)
			setScreenActive(presentedScreen, true)
			setScreenPresented(presentedScreen, true)

			presentedScreen[$presenting] = false

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
	private async performDismiss(screen: Screen, transition: ScreenTransition | null, done: () => void) {

		try {

			let window = this.window
			if (window == null) {
				throw new Error(
					`Screen error: ` +
					`The screen screen is not part of valid a hierarchy.`
				)
			}

			window.touchable = false

			if (transition == null) {
				transition = new ScreenTransition()
			}

			let dismissedScreen: Screen = this
			let presentedScreen: Screen = this.presenter!
			let presentedScreenEnclosure = presentedScreen.enclosure
			let dismissedScreenEnclosure = dismissedScreen.enclosure

			// TODO
			// Make this better
			let dismissed = this.getPresenteeList()
			if (dismissed.length) {

				dismissedScreen[$dismissing] = false
				dismissedScreen = dismissed[0]
				dismissedScreen[$dismissing] = true

				dismissed.push(this)
				dismissed.shift()

				for (let screen of dismissed) {
					screen[$dismissing] = true
				}
			}

			if (this[$modal]) {

				if (dismissedScreenEnclosure == null) {
					throw new Error(
						`Screen error: ` +
						`The dismissed screen is missing its enclosure.`
					)
				}

				let index = window.children.indexOf(dismissedScreenEnclosure)
				if (index == -1) {
					throw new Error(
						`Screen error: ` +
						`The modal screen is not found within the hierarchy.`
					)
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

				dismissedScreen[$dismissing] = false

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

			dismissedScreen[$active] = false
			presentedScreen[$active] = true
			dismissedScreen[$presented] = false

			for (let screen of dismissed) {
				screen[$active] = false
				screen[$presented] = false
			}

			dismissedScreen[$dismissing] = false

			dismissedScreen.dispose()

			for (let screen of dismissed) {

				screen[$dismissing] = false

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
				throw new Error(
					`Screen error: ` +
					`Cannot dismiss a screen while another screen is being dismissed.`
				)
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
