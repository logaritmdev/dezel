import { $active } from '../symbol/Screen'
import { $presented } from '../symbol/Screen'
import { $presentee } from '../symbol/Screen'
import { $presenter } from '../symbol/Screen'
import { $presenting } from '../symbol/Screen'
import { $transition } from '../symbol/Screen'
import { Screen } from '../Screen'
import { ScreenTransition } from '../ScreenTransition'

/**
 * @function setScreenActive
 * @since 0.3.0
 * @hidden
 */
export function setScreenActive(screen: Screen, active: boolean) {
	screen[$active] = active
}

/**
 * @function setScreenPresenter
 * @since 0.3.0
 * @hidden
 */
export function setScreenPresenter(screen: Screen, presenter: Screen | null) {
	screen[$presenter] = presenter
}

/**
 * @function setScreenPresentee
 * @since 0.3.0
 * @hidden
 */
export function setScreenPresentee(screen: Screen, presentee: Screen | null) {
	screen[$presentee] = presentee
}

/**
 * @function setScreenPresented
 * @since 0.5.0
 * @hidden
 */
export function setScreenPresented(screen: Screen, presented: boolean) {
	screen[$presented] = presented
}

/**
 * @function setScreenTransition
 * @since 0.4.0
 * @hidden
 */
export function setScreenTransition(screen: Screen, transition: ScreenTransition | null) {
	screen[$transition] = transition
}