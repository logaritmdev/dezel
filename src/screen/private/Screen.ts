import { $dismissing } from '../symbol/Screen'
import { $frame } from '../symbol/Screen'
import { $modal } from '../symbol/Screen'
import { $presented } from '../symbol/Screen'
import { $presentee } from '../symbol/Screen'
import { $presenter } from '../symbol/Screen'
import { $presenting } from '../symbol/Screen'
import { $segue } from '../symbol/Screen'
import { $style } from '../symbol/Screen'
import { $screen } from '../symbol/Segue'
import { getCurrentScreen } from '../../view/private/Window'
import { getRegisteredSegue } from './Segue'
import { setSegueScreen } from './Segue'
import { Frame } from '../Frame'
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
 * @function setScreenPresenter
 * @since 0.7.0
 * @hidden
 */
export function setScreenPresenter(screen: Screen, presenter: Screen | null) {
	screen[$presenter] = presenter
}

/**
 * @function setScreenPresentee
 * @since 0.7.0
 * @hidden
 */
export function setScreenPresentee(screen: Screen, presentee: Screen | null) {
	screen[$presentee] = presentee
}

/**
 * @function setScreenPresented
 * @since 0.7.0
 * @hidden
 */
export function setScreenPresented(screen: Screen, presented: boolean) {
	screen[$presented] = presented
}

/**
 * @function setScreenPresenting
 * @since 0.7.0
 * @hidden
 */
export function setScreenPresenting(screen: Screen, presenting: boolean) {
	screen[$presenting] = presenting
}

/**
 * @function setScreenDismissing
 * @since 0.7.0
 * @hidden
 */
export function setScreenDismissing(screen: Screen, dismissing: boolean) {
	screen[$dismissing] = dismissing
}

/**
 * @function setScreenSegue
 * @since 0.7.0
 * @hidden
 */
export function setScreenSegue(screen: Screen, segue: Segue | null) {
	screen[$segue] = segue
}

/**
 * @function setScreenModal
 * @since 0.7.0
 * @hidden
 */
export function setScreenModal(screen: Screen, modal: boolean) {
	screen[$modal] = modal
}

/**
 * @function setScreenStyle
 * @since 0.7.0
 * @hidden
 */
export function setScreenStyle(screen: Screen, style: 'normal' | 'overlay') {
	screen[$style] = style
}

/**
 * @function isScreenModal
 * @since 0.7.0
 * @hidden
 */
export function isScreenModal(screen: Screen) {
	return screen[$modal]
}

/**
 * @function isScreenOverlay
 * @since 0.7.0
 * @hidden
 */
export function isScreenOverlay(screen: Screen) {
	return screen[$style] == 'overlay'
}

/**
 * @function isScreenPopover
 * @since 0.7.0
 * @hidden
 */
export function isScreenPopover(screen: Screen) {
	return screen[$style] == 'popover'
}

/**
 * @function getScreenSegue
 * @since 0.7.0
 * @hidden
 */
export function getScreenSegue(screen: Screen, segue: Segue | string | null) {
	return typeof segue == 'string' ? getRegisteredSegue(segue) : segue
}

/**
 * @function getScreenPresentSegue
 * @since 0.7.0
 * @hidden
 */
export function getScreenPresentSegue(screen: Screen, using: Segue | string | null) {

	let segue = getScreenSegue(screen, using) || screen.segue
	if (segue) {

		/*
		 * The segue does not need to be configured if he's already bound
		 * to a screen.
		 */

		if (segue.screen == screen) {
			return segue
		}

		/*
		 * It's possible to assign a segue that is used by a screen. Throw an
		 * error immediately to prevent undefined behavior.
		 */

		if (segue.screen) {
			throw new Error(
				`Screen error: This segue is already bound to a screen.`
			)
		}

		setSegueScreen(segue, screen)

		segue.configure()

		return segue
	}

	throw new Error(
		`Screen error: This screen does not have a segue.`
	)
}

/**
 * @function getScreenDismissSegue
 * @since 0.7.0
 * @hidden
 */
export function getScreenDismissSegue(screen: Screen, using: Segue | string | null) {

	let segue = getScreenSegue(screen, using) || screen.segue
	if (segue) {

		/*
		 * The segue does not need to be configured if he's already bound
		 * to a screen.
		 */

		if (segue.screen == screen) {
			return segue
		}

		/*
		 * It's possible to assign a segue that is used by a screen. Throw an
		 * error immediately to prevent undefined behavior.
		 */

		if (segue.screen) {
			throw new Error(
				`Screen error: This segue is already bound to a screen.`
			)
		}

		setSegueScreen(segue, screen)

		segue.configure()

		return segue
	}

	throw new Error(
		`Screen error: This screen does not have a segue.`
	)
}

/**
 * @function getScreenDismissTarget
 * @since 0.7.0
 * @hidden
 */
export function getScreenDismissTarget(screen: Screen): Screen {
	return screen.presentee ? getScreenDismissTarget(screen.presentee) : screen
}

/**
 * @method createScreenFrame
 * @since 0.7.0
 * @hidden
 */
export function createScreenFrame(screen: Screen) {
	if (screen[$frame] == null) {
		screen[$frame] = new Frame(screen)
	}
}

/**
 * @method removeScreenFrame
 * @since 0.7.0
 * @hidden
 */
export function removeScreenFrame(screen: Screen) {
	screen[$frame]?.removeFromParent()
}

/**
 * @method destroyScreenFrame
 * @since 0.7.0
 * @hidden
 */
export function destroyScreenFrame(screen: Screen) {
	screen[$frame]?.destroy()
	screen[$frame] = null
}

/**
 * @method destroyFrame
 * @since 0.7.0
 * @hidden
 */
export function destroyScreenSegue(screen: Screen) {

	let segue = screen[$segue]
	if (segue == null) {
		return
	}

	segue.dispose()

	setSegueScreen(segue, null)

	screen[$segue] = null
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

	let window = screen.window!

	try {

		window.touchable = false

		let presenterScreen = screen
		let presentedScreen = target
		let dismissedScreen = screen

		setScreenPresentee(presenterScreen, presentedScreen)
		setScreenPresenter(presentedScreen, presenterScreen)

		createScreenFrame(presentedScreen)

		let modal = isScreenModal(presentedScreen)

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

		segue.invokeBeforePresent(
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

		segue.invokeAfterPresent(
			presentedScreen,
			dismissedScreen
		)

		dismissedScreen.visible = isScreenOverlay(presentedScreen) ? false : false

		await emitLeave(dismissedScreen, segue)
		await emitPresent(presentedScreen, segue)
		await emitEnter(presentedScreen, segue)

		setScreenPresented(presentedScreen, true)
		setScreenPresented(dismissedScreen, false)
		setScreenPresenting(presentedScreen, false)
		setScreenDismissing(dismissedScreen, false)

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

	let window = screen.window!

	try {

		window.touchable = false

		target = getScreenDismissTarget(target)

		let dismisserScreen = screen
		let dismissedScreen = target
		let presentedScreen = screen.presenter

		if (presentedScreen == null) {
			throw new Error(
				`Screen error: This screen has no presenter screen.`
			)
		}

		let destroy = options.destroy || false

		presentedScreen.visible = true
		presentedScreen.resolve()

		segue.invokeBeforeDismiss(
			presentedScreen,
			dismissedScreen
		)

		dismissedScreen.emit('done')

		await emitBeforeLeave(dismissedScreen, segue)
		await emitBeforeEnter(presentedScreen, segue)

		emitBeforeLeaveChain(
			dismissedScreen,
			dismisserScreen,
			segue
		)

		presentedScreen.updateStatusBar()

		await segue.dismiss(
			presentedScreen,
			dismissedScreen
		)

		segue.invokeAfterDismiss(
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

		setScreenPresented(presentedScreen, true)
		setScreenPresented(dismissedScreen, false)
		setScreenPresenting(presentedScreen, false)
		setScreenDismissing(dismissedScreen, false)

		dismissedScreen.emit('exit')

		window.touchable = true

		done()

	} catch (e) {
		console.error(e)
	}
}

/**
 * @method emitBeforePresent
 * @since 0.7.0
 * @hidden
 */
export async function emitBeforePresent(screen: Screen, segue: Segue) {
	screen.emit<ScreenBeforePresentEvent>('beforepresent', { data: { segue } })
	await segue.standby()
}

/**
 * @method emitPresent
 * @since 0.3.0
 * @hidden
 */
export async function emitPresent(screen: Screen, segue: Segue) {
	screen.emit<ScreenPresentEvent>('present', { data: { segue } })
	await segue.standby()
}

/**
 * @method emitDismiss
 * @since 0.3.0
 * @hidden
 */
export async function emitDismiss(screen: Screen, segue: Segue) {
	screen.emit<ScreenBeforeDismissEvent>('dismiss', { data: { segue } })
	await segue.standby()
}

/**
 * @method emitBeforeEnter
 * @since 0.3.0
 * @hidden
 */
export async function emitBeforeEnter(screen: Screen, segue: Segue) {
	screen.emit<ScreenBeforeEnterEvent>('beforeenter', { data: { segue } })
	await segue.standby()
}

/**
 * @method emitEnter
 * @since 0.3.0
 * @hidden
 */
export async function emitEnter(screen: Screen, segue: Segue) {
	screen.emit<ScreenEnterEvent>('enter', { data: { segue } })
	await segue.standby()
}

/**
 * @method emitBeforeLeave
 * @since 0.3.0
 * @hidden
 */
export async function emitBeforeLeave(screen: Screen, segue: Segue) {
	screen.emit<ScreenBeforeLeaveEvent>('beforeleave', { data: { segue } })
	await segue.standby()
}

/**
 * @method emitLeave
 * @since 0.3.0
 * @hidden
 */
export async function emitLeave(screen: Screen, segue: Segue) {
	screen.emit<ScreenLeaveEvent>('leave', { data: { segue } })
	await segue.standby()
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
