import { $screen } from './Segue'
import { getCurrentScreen } from '../../view/private/Window'
import { getRegisteredSegue } from './Segue'
import { Screen } from '../Screen'
import { ScreenBeforeDismissEvent } from '../Screen'
import { ScreenBeforeEnterEvent } from '../Screen'
import { ScreenBeforeLeaveEvent } from '../Screen'
import { ScreenBeforePresentEvent } from '../Screen'
import { ScreenDismissOptions } from '../Screen'
import { ScreenEnterEvent } from '../Screen'
import { ScreenLeaveEvent } from '../Screen'
import { ScreenPresentEvent } from '../Screen'
import { ScreenPresentOptions } from '../Screen'
import { Segue } from '../Segue'

/**
 * @symbol presenter
 * @since 0.7.0
 * @hidden
 */
export const $presenter = Symbol('presenter')

/**
 * @symbol presentee
 * @since 0.7.0
 */
export const $presentee = Symbol('presentee')

/**
 * @symbol presented
 * @since 0.7.0
 * @hidden
 */
export const $presented = Symbol('presented')

/**
 * @symbol presenting
 * @since 0.7.0
 * @hidden
 */
export const $presenting = Symbol('presenting')

/**
 * @symbol dismissing
 * @since 0.7.0
 * @hidden
 */
export const $dismissing = Symbol('dismissing')

/**
 * @symbol segue
 * @since 0.7.0
 * @hidden
 */
export const $segue = Symbol('segue')

/**
 * @symbol modal
 * @since 0.7.0
 * @hidden
 */
export const $modal = Symbol('modal')

/**
 * @symbol style
 * @since 0.7.0
 * @hidden
 */
export const $style = Symbol('style')

/**
 * @symbol frame
 * @since 0.7.0
 * @hidden
 */
export const $frame = Symbol('frame')

/**
 * @function isModal
 * @since 0.7.0
 * @hidden
 */
export function isModal(screen: Screen) {
	return screen[$modal]
}

/**
 * @function isOverlay
 * @since 0.7.0
 * @hidden
 */
export function isOverlay(screen: Screen) {
	return screen[$style] == 'overlay'
}

/**
 * @function isPopover
 * @since 0.7.0
 * @hidden
 */
export function isPopover(screen: Screen) {
	return screen[$style] == 'popover'
}

/**
 * @function getSegue
 * @since 0.7.0
 * @hidden
 */
export function getSegue(screen: Screen, segue: Segue | string | null) {
	return typeof segue == 'string' ? getRegisteredSegue(segue) : segue
}

/**
 * @function getPresentSegue
 * @since 0.7.0
 * @hidden
 */
export function getPresentSegue(screen: Screen, using: Segue | string | null) {

	let segue = getSegue(screen, using) || screen.segue
	if (segue == null) {
		throw new Error(`Screen error: This screen does not have a segue.`)
	}

	if (segue.screen == screen) {
		return segue
	}

	/*
	 * It's possible to assign a segue that is used by a screen. Throw an
	 * error immediately to prevent undefined behavior.
	 */

	if (segue.screen) {
		throw new Error(`Screen error: This segue is already bound to a screen.`)
	}

	segue[$screen] = screen
	segue.configure()

	return segue
}

/**
 * @function getDismissSegue
 * @since 0.7.0
 * @hidden
 */
export function getDismissSegue(screen: Screen, using: Segue | string | null) {

	let segue = getSegue(screen, using) || screen.segue
	if (segue == null) {
		throw new Error(`Screen error: This screen does not have a segue.`)
	}

	if (segue.screen == screen) {
		return segue
	}

	if (segue.screen) {
		throw new Error(`Screen error: This segue is already bound to a screen.`)
	}

	segue[$screen] = screen
	segue.configure()

	return segue

}




/**
 * @method insertScreen
 * @since 0.7.0
 * @hidden
 */
export function insertScreen(screen: Screen, presentedScreen: Screen, dismissedScreen: Screen, modal: boolean) {

	let dismissedScreenFrame = dismissedScreen[$frame]!
	let presentedScreenFrame = presentedScreen[$frame]!

	if (modal) {

		screen.window?.insertAfter(
			presentedScreenFrame,
			dismissedScreenFrame
		)

	} else {

		screen.parent?.insertAfter(
			presentedScreenFrame,
			dismissedScreen
		)

	}
}

/**
 * @method presentScreenAsync
 * @since 0.7.0
 * @hidden
 */
export function presentScreenAsync(screen: Screen, target: Screen, segue: Segue, options: ScreenPresentOptions): Promise<void> {
	return new Promise(success => {
		requestAnimationFrame(() => presentScreen(screen, target, segue, options, success))
	})
}

/**
 * @method dismissScreenAsync
 * @since 0.7.0
 * @hidden
 */
export function dismissScreenAsync(screen: Screen, target: Screen, segue: Segue, options: ScreenDismissOptions): Promise<void> {
	return new Promise(success => {
		requestAnimationFrame(() => dismissScreen(screen, target, segue, options, success))
	})
}

/**
 * @method presentScreen
 * @since 0.7.0
 * @hidden
 */
export async function presentScreen(screen: Screen, target: Screen, segue: Segue, options: ScreenPresentOptions, done: () => void) {

	try {

		let window = screen.window!

		window.touchable = false

		let presenterScreen = screen
		let presentedScreen = target
		let dismissedScreen = screen

		presenterScreen[$presentee] = presentedScreen
		presentedScreen[$presenter] = presenterScreen

		let modal = isModal(presentedScreen)
		if (modal) {
			dismissedScreen = getCurrentScreen(window)
		}

		insertScreen(
			presenterScreen,
			presentedScreen,
			dismissedScreen,
			modal
		)

		presentedScreen.visible = true
		presentedScreen.resolve()

		segue.onBeforePresent(
			presentedScreen,
			dismissedScreen
		)

		await emitBeforeLeave(dismissedScreen, segue)
		await emitBeforePresent(presentedScreen, segue)
		await emitBeforeEnter(presentedScreen, segue)

		presentedScreen.updateStatusBar()

		await segue.present(
			presentedScreen,
			dismissedScreen
		)

		segue.onAfterPresent(
			presentedScreen,
			dismissedScreen
		)

		dismissedScreen.visible = isOverlay(presentedScreen)

		await emitLeave(dismissedScreen, segue)
		await emitPresent(presentedScreen, segue)
		await emitEnter(presentedScreen, segue)

		presentedScreen[$presented] = true
		dismissedScreen[$presented] = false
		presentedScreen[$presenting] = false
		dismissedScreen[$presenting] = false

		window.touchable = true

		done()

	} catch (e) {
		console.error(e)
	}
}

/**
 * @method dismissScreen
 * @since 0.7.0
 * @hidden
 */
export async function dismissScreen(screen: Screen, target: Screen, segue: Segue, options: ScreenDismissOptions, done: () => void) {

	try {

		let window = screen.window!

		window.touchable = false

		target = getDismissTarget(target)

		let dismisserScreen = screen
		let dismissedScreen = target
		let presentedScreen = screen.presenter

		if (presentedScreen == null) {
			throw new Error(`Screen error: This screen has no presenter screen.`)
		}

		let destroy = options.destroy || false

		presentedScreen.visible = true
		presentedScreen.resolve()

		segue.onBeforeDismiss(
			presentedScreen,
			dismissedScreen
		)

		await emitBeforeLeave(dismissedScreen, segue)
		await emitBeforeEnter(presentedScreen, segue)

		emitBeforeLeaveChain(
			dismissedScreen,
			dismisserScreen,
			segue
		)

		dismissedScreen.emit('done')
		presentedScreen.updateStatusBar()

		await segue.dismiss(
			presentedScreen,
			dismissedScreen
		)

		segue.onAfterDismiss(
			presentedScreen,
			dismissedScreen
		)

		await emitLeave(dismissedScreen, segue)
		await emitDismiss(dismissedScreen, segue)
		await emitEnter(presentedScreen, segue)

		emitLeaveChain(
			dismissedScreen,
			dismisserScreen,
			segue
		)

		emitDismissChain(
			dismissedScreen,
			dismisserScreen,
			segue
		)

		dismissedScreen.dispose(destroy)

		disposeChain(
			dismissedScreen,
			dismisserScreen,
			destroy
		)

		presentedScreen[$presented] = true
		dismissedScreen[$presented] = false
		presentedScreen[$presenting] = false
		dismissedScreen[$presenting] = false

		dismissedScreen.emit('left')

		window.touchable = true

		done()

	} catch (e) {
		console.error(e)
	}
}

/**
 * @function presentScreenAfter
 * @since 0.7.0
 * @hidden
 */
export function presentScreenAfter(screen: Screen, target: Screen, segue: Segue, options: ScreenPresentOptions): Promise<void> {

	if (screen.presentee &&
		screen.presentee.dismissing) {

		return new Promise(success => {

			const present = () => {
				screen.present(target, segue, options).then(success)
			}

			if (screen.presentee) {
				screen.presentee.once('left', present)
				return
			}

			present()
		})
	}

	throw new Error(`Screen error: This screen is already presenting another screen.`)
}

/**
 * @function promptScreenAfter
 * @since 0.7.0
 * @hidden
 */
export function promptScreenAfter(screen: Screen, target: Screen, segue: Segue, options: ScreenPresentOptions): Promise<any> {

	if (screen.presentee &&
		screen.presentee.dismissing) {

		return new Promise(success => {

			const prompt = () => {
				screen.prompt(target, segue, options).then(success)
			}

			if (screen.presentee) {
				screen.presentee.once('left', prompt)
				return
			}

			prompt()
		})
	}

	throw new Error(`Screen error: This screen is already presenting another screen.`)
}

/**
 * @function getDismissTarget
 * @since 0.7.0
 * @hidden
 */
export function getDismissTarget(screen: Screen): Screen {
	return screen.presentee ? getDismissTarget(screen.presentee) : screen
}

/**
 * @method emitBeforePresent
 * @since 0.7.0
 * @hidden
 */
export async function emitBeforePresent(screen: Screen, segue: Segue) {
	screen.emit<ScreenBeforePresentEvent>('beforepresent', { data: { segue } })
	await segue.ready()
}

/**
 * @method emitPresent
 * @since 0.3.0
 * @hidden
 */
export async function emitPresent(screen: Screen, segue: Segue) {
	screen.emit<ScreenPresentEvent>('present', { data: { segue } })
	await segue.ready()
}

/**
 * @method emitDismiss
 * @since 0.3.0
 * @hidden
 */
export async function emitDismiss(screen: Screen, segue: Segue) {
	screen.emit<ScreenBeforeDismissEvent>('dismiss', { data: { segue } })
	await segue.ready()
}

/**
 * @method emitBeforeEnter
 * @since 0.3.0
 * @hidden
 */
export async function emitBeforeEnter(screen: Screen, segue: Segue) {
	screen.emit<ScreenBeforeEnterEvent>('beforeenter', { data: { segue } })
	await segue.ready()
}

/**
 * @method emitEnter
 * @since 0.3.0
 * @hidden
 */
export async function emitEnter(screen: Screen, segue: Segue) {
	screen.emit<ScreenEnterEvent>('enter', { data: { segue } })
	await segue.ready()
}

/**
 * @method emitBeforeLeave
 * @since 0.3.0
 * @hidden
 */
export async function emitBeforeLeave(screen: Screen, segue: Segue) {
	screen.emit<ScreenBeforeLeaveEvent>('beforeleave', { data: { segue } })
	await segue.ready()
}

/**
 * @method emitLeave
 * @since 0.3.0
 * @hidden
 */
export async function emitLeave(screen: Screen, segue: Segue) {
	screen.emit<ScreenLeaveEvent>('leave', { data: { segue } })
	await segue.ready()
}

/**
 * @method emitBeforeLeaveChain
 * @since 0.7.0
 * @hidden
 */
export function emitBeforeLeaveChain(tail: Screen, head: Screen, segue: Segue) {

	emitBeforeLeave(tail, segue)

	if (tail == head) {
		return
	}

	let presenter = tail.presenter
	if (presenter) {
		emitBeforeLeaveChain(presenter, head, segue)
	}
}

/**
 * @method emitLeaveChain
 * @since 0.7.0
 * @hidden
 */
export function emitLeaveChain(tail: Screen, head: Screen, segue: Segue) {

	emitLeave(tail, segue)

	if (tail == head) {
		return
	}

	let presenter = tail.presenter
	if (presenter) {
		emitLeaveChain(presenter, head, segue)
	}
}

/**
 * @method emitDismissChain
 * @since 0.7.0
 * @hidden
 */
export function emitDismissChain(tail: Screen, head: Screen, segue: Segue) {

	emitDismiss(tail, segue)

	if (tail == head) {
		return
	}

	let presenter = tail.presenter
	if (presenter) {
		emitDismissChain(presenter, head, segue)
	}
}

/**
 * @method disposeChain
 * @since 0.7.0
 * @hidden
 */
export function disposeChain(tail: Screen, head: Screen, destroy: boolean) {

	tail.dispose(destroy)

	if (tail == head) {
		return
	}

	let presenter = tail.presenter
	if (presenter) {
		disposeChain(presenter, head, destroy)
	}
}
