import { View } from '../../view/View'
import { $captured } from '../symbol/GestureDetector'
import { $resolved } from '../symbol/GestureDetector'
import { $view } from '../symbol/GestureDetector'
import { GestureDetector } from '../GestureDetector'

/**
 * @function setGestureView
 * @since 0.7.0
 * @hidden
 */
export function setGestureView(gesture: GestureDetector, view: View | null) {
	gesture[$view] = view
}