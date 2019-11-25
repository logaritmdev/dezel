import { ScreenTransition } from './ScreenTransition'

/**
 * @const ScreenTransitionRegistry
 * @since 0.6.0
 * @hidden
 */
export const ScreenTransitionRegistry: Map<string, typeof ScreenTransition> = new Map()