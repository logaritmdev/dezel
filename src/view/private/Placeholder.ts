import { $children } from '../symbol/Placeholder'
import { Placeholder } from '../Placeholder'
import { View } from '../View'

//------------------------------------------------------------------------------
// Private API
//------------------------------------------------------------------------------

/**
 * @function insertItem
 * @since 0.7.0
 * @hidden
 */
export function insertItem(placeholder: Placeholder, child: View, index: number) {
	placeholder[$children].splice(index, 0, child)
}

/**
 * @function removeItem
 * @since 0.7.0
 * @hidden
 */
export function removeItem(placeholder: Placeholder, child: View, index: number) {
	placeholder[$children].splice(index, 1)
}

/**
 * @function insertView
 * @since 0.7.0
 * @hidden
 */
export function insertView(placeholder: Placeholder, child: View, index: number) {
	if (placeholder.parent) {
		placeholder.parent.insert(child, index + placeholder.offset)
	}
}

/**
 * @function removeView
 * @since 0.7.0
 * @hidden
 */
export function removeView(placeholder: Placeholder, child: View, index: number) {
	if (placeholder.parent) {
		placeholder.parent.remove(child)
	}
}