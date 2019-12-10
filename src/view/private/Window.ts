import { Frame } from '../../screen/Frame'
import { Window } from '../Window'

/**
 * @method getScreenModalEnclosure
 * @since 0.7.0
 * @hidden
 */
export function getCurrentScreen(window: Window) {

	let index = window.children.length

	while (index--) {

		let view = window.children[index]
		if (view instanceof Frame) {
			return view.screen
		}

	}

	throw new Error(
		`Window error: Window does not have a screen.`
	)
}