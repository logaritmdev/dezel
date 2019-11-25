import { ImageView } from '../ImageView'
import { View } from '../View'

/**
 * @function viewInsertBefore
 * @since 0.7.0
 * @hidden
 */
export function viewInsertBefore(view: View, child: View, before: View) {
	let index = view.children.indexOf(before)
	if (index > -1) {
		view.insert(view, index)
	}
}

/**
 * @function viewInsertAfter
 * @since 0.7.0
 * @hidden
 */
export function viewInsertAfter(view: View, child: View, after: View) {
	let index = view.children.indexOf(after)
	if (index > -1) {
		view.insert(view, index + 1)
	}
}