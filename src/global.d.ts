import { Device } from './device/Device'
import { Platform } from './platform/Platform'
import { Storage } from './storage/Storage'
import { t } from './translation/TranslationManager'

/*
 * Dezel
 */

interface Dezel {

	imports: (classname: string) => any
	exports: (classname: string, klass: object) => void

	transition: (
		duration: number,
		cp1: number, cp2: number,
		cp3: number, cp4: number,
		delay: number,
		complete: Function,
		runner: Function
	) => void
}

/*
 * Global
 */

declare global {

	const _DEV_: boolean
	const _SIM_: boolean

	/**
	 * The global dezel object.
	 * @const dezel
	 * @since 0.1.0
	 */
	const dezel: Dezel

	/**
	 * The device.
	 * @const device
	 * @since 0.4.0
	 */
	const device: Device

	/**
	 * The application storage
	 * @const storage
	 * @since 0.1.0
	 */
	const storage: Storage

	const locale: any // TODO

	/**
	 * The application platform.
	 * @const platform
	 * @since 0.1.0
	 */
	const platform: Platform

	function t(message: string, context?: string): string
	function __(message: string): string
	function _x(message: string, context: string): string

	/**
	 * It would be nice if this could work better with elements.
	 * @since 0.1.0
	 */
	namespace JSX {
		type Element = any
		type ElementClass = any
		interface ElementAttributesProperty {
			__jsxProps: Partial<this>
		}
	}

	/*
	 * This is required to make JSX play nice otherwise the shorthand syntax
	 * for fragments would not work.
	 * @since 0.3.0
	 */
	namespace React {
		function createElement(...args: Array<any>): any
	}
}
