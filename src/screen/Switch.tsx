import { watch } from '../decorator/watch'
import { Event } from '../event/Event'
import { ScreenQuickTransition } from './transition/ScreenQuickTransition'
import { ScreenTransition } from './transition/ScreenTransition'
import { ScreenTransitionRegistry } from './transition/ScreenTransition'
import { Enclosure } from './Enclosure'
import { PRESENTING } from './Screen'
import { Screen } from './Screen'
import './Switch.ds'
import './Switch.ds.android'
import './Switch.ds.ios'

/**
 * Manages the display of several screens only showing one.
 * @class Switch
 * @super Emitter
 * @since 0.3.0
 */
export class Switch extends Screen {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The screen switch's managed screens
	 * @property screens
	 * @since 0.3.0
	 */
	@watch public screens: Array<Screen> = []

	/**
	 * The screen switch's selected index.
	 * @property selectedIndex
	 * @since 0.3.0
	 */
	public get selectedIndex(): number {
		return this.selectedScreen ? this.screens.indexOf(this.selectedScreen) : -1
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Selects the specified screen.
	 * @method select
	 * @since 0.3.0
	 */
	public select(index: number, transition?: ScreenTransition | string) {

		if (index == this.selectedIndex) {
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

		let event = new Event<SwitchBeforeSelectEvent>('beforeselect', {
			cancelable: true,
			propagable: false,
			data: {
				index
			}
		})

		this.emit(event)

		if (event.canceled) {
			return this
		}

		let screen = this.screens[index]
		if (screen == null) {
			throw new Error(`
				Switch error:
				The index ${index} does not match any screens.
			`)
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

		if (presentedScreen) {
			presentedScreen.setPresenter(presenterScreen)
			presentedScreen.setTransition(presentedTransition)
			presentedScreen[PRESENTING] = true
		}

		return new Promise(success => {

			if (presentedTransition == null) {

				this.performSelect(
					presentedScreen,
					presentedTransition,
					success
				)

				return
			}

			requestAnimationFrame(() => this.performSelect(
				presentedScreen,
				presentedTransition,
				success
			))
		})
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onEmit
	 * @since 0.3.0
	 */
	public onEmit(event: Event) {

		switch (event.type) {

			case 'select':
				this.onSelect(event)
				break

			case 'deselect':
				this.onDeselect(event)
				break
		}

		super.onEmit(event)

		if (this.presented) {

			let screen = this.selectedScreen
			if (screen == null) {
				return
			}

			switch (event.type) {
				case 'beforepresent':
				case 'beforedismiss':
				case 'present':
				case 'dismiss':
				case 'beforeenter':
				case 'beforeleave':
				case 'enter':
				case 'leave':
					screen.onEmit(event)
					break
			}
		}
	}

	/**
	 * Called when a screen is selected.
	 * @method onSelect
	 * @since 0.3.0
	 */
	public onSelect(event: Event<SwitchSelectEvent>) {

	}

	/**
	 * Called when a screen is deselected.
	 * @method onDeselect
	 * @since 0.3.0
	 */
	public onDeselect(event: Event<SwitchDeselectEvent>) {

	}

	/**
	 * @inherited
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

		let selectedScreen = this.selectedScreen
		if (selectedScreen &&
			selectedScreen.presentee) {
			selectedScreen.presentee.emit(event)
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
	 * @inherited
	 * @method onPropertyChange
	 * @since 0.3.0
	 */
	public onPropertyChange(property: string, newValue: any, oldValue: any) {

		if (property == 'screens') {

			let oldScreens = oldValue as Array<Screen>
			let newScreens = newValue as Array<Screen>

			if (oldScreens) for (let screen of oldScreens) {

				if (screen.enclosure) {
					screen.enclosure.removeFromParent()
					screen.enclosure.destroy()
					screen.enclosure = null
				}

				screen.setPresenter(null)
				screen.setTransition(null)
				screen.removeFromParent()
			}

			if (newScreens) for (let screen of newScreens) {
				screen.setPresenter(this)
				screen.setTransition(null)
			}

			return
		}

		super.onPropertyChange(property, newValue, oldValue)
	}

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method updateStatusBar
	 * @since 0.5.0
	 */
	public updateStatusBar() {

		if (this.selectedScreen) {
			this.selectedScreen.updateStatusBar()
			return
		}

		super.updateStatusBar()
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property selectedScreen
	 * @since 0.3.0
	 * @hidden
	 */
	private selectedScreen?: Screen | null

	/**
	 * @method performSelect
	 * @since 0.5.0
	 * @hidden
	 */
	private async performSelect(screen: Screen | null | undefined, transition: ScreenTransition | null | undefined, done: () => void) {

		try {

			//let content = this.content || this
			let content = this // TODO Fix this

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
				transition = new ScreenQuickTransition()
			}

			let presentedScreen = screen
			let dismissedScreen = this.selectedScreen

			let present = false

			if (presentedScreen) {
				if (presentedScreen.enclosure == null) {
					presentedScreen.enclosure = new Enclosure(presentedScreen)
					presentedScreen.enclosure.inject(content)
					present = true
				}
			}

			if (presentedScreen == null &&
				dismissedScreen == null) {
				return
			}

			let presentedScreenEnclosure = presentedScreen && presentedScreen.enclosure
			let dismissedScreenEnclosure = dismissedScreen && dismissedScreen.enclosure

			if (presentedScreenEnclosure &&
				dismissedScreenEnclosure) {

				content.insertAfter(
					presentedScreenEnclosure,
					dismissedScreenEnclosure
				)

			} else if (presentedScreenEnclosure) {

				content.append(presentedScreenEnclosure)

			}

			if (presentedScreenEnclosure) {
				presentedScreenEnclosure.visible = true
				presentedScreenEnclosure.resolve()
			}

			transition.onBeforePresent(
				presentedScreen || undefined,
				dismissedScreen || undefined
			)

			if (dismissedScreen) {
				this.emit<SwitchDeselectEvent>('deselect', { data: { index: this.screens.indexOf(dismissedScreen) } })
			}

			this.selectedScreen = presentedScreen

			if (presentedScreen) {
				this.emit<SwitchSelectEvent>('select', { data: { index: this.screens.indexOf(presentedScreen) } })
			}
			if (dismissedScreen) await dismissedScreen.emitBeforeLeave(transition)
			if (presentedScreen && present) await presentedScreen.emitBeforePresent(transition)
			if (presentedScreen) await presentedScreen.emitBeforeEnter(transition)

			if (presentedScreen) {
				presentedScreen.updateStatusBar()
			}

			await transition.present(
				presentedScreen || undefined,
				dismissedScreen || undefined
			)

			transition.onAfterPresent(
				presentedScreen || undefined,
				dismissedScreen || undefined
			)

			if (dismissedScreenEnclosure) {
				dismissedScreenEnclosure.visible = false
			}

			if (dismissedScreen) await dismissedScreen.emitLeave(transition)
			if (presentedScreen && present) await presentedScreen.emitPresent(transition)
			if (presentedScreen) await presentedScreen.emitEnter(transition)

			if (dismissedScreen) dismissedScreen.setActive(false)
			if (presentedScreen) presentedScreen.setActive(true)

			if (presentedScreen) {
				presentedScreen[PRESENTING] = false
			}

			window.touchable = true

			done()

		} catch (e) {
			console.error(e)
		}
	}
}

/**
 * @interface SwitchSelectionEvent
 * @since 0.3.0
 */
export type ScreenConstructor = {
	new(): Screen
}

/**
 * @type SwitchBeforeSelectEvent
 * @since 0.5.0
 */
export type SwitchBeforeSelectEvent = {
	index?: number | null
}

/**
 * @type SwitchSelectEvent
 * @since 0.5.0
 */
export type SwitchSelectEvent = {
	index: number
}

/**
 * @type SwitchSelectEvent
 * @since 0.5.0
 */
export type SwitchDeselectEvent = {
	index: number
}
