import { createRef } from '../view/private/Reference'

/**
 * @function decorate
 * @since 0.7.0
 * @hidden
 */
function decorate(prototype: any, property: string) {
	createRef(prototype, property)
}

/**
 * @decorator ref
 * @since 0.7.0
 */
export function ref(target: object, property: string): void
export function ref(...args: Array<any>): any {
	decorate(args[0], args[1])
}