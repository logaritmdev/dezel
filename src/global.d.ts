//------------------------------------------------------------------------------
// Types
//------------------------------------------------------------------------------

// TODO
// REMOVE
declare var LOG: any

/**
 * @interface Dictionary
 * @since 0.7.0
 */
interface Dictionary<T> {
	[index: string]: T;
}


//------------------------------------------------------------------------------
// Dezel
//------------------------------------------------------------------------------

/**
 * @const global
 * @since 0.1.0
 */
declare var global: any

/**
 * @const _DEV_
 * @since 0.1.0
 */
declare const _DEV_: boolean

/**
 * @const _DEV_
 * @since 0.1.0
 */
declare const _SIM_: boolean

/**
 * @const $native
 * @since 0.7.0
 */
declare const $native: any

//------------------------------------------------------------------------------
// JSX
//------------------------------------------------------------------------------

/**
 * @namespace JSX
 * @since 0.1.0
 */
declare namespace JSX {
	type Element = any
	type ElementClass = any
	interface ElementAttributesProperty {
		__jsxProps: Partial<this>
	}
}

/**
 * @namespace React
 * @since 0.1.0
 */
declare namespace React {
	function createElement(...args: Array<any>): any
}

//------------------------------------------------------------------------------
// Global
//------------------------------------------------------------------------------

interface TimeRequestCallback {
	(): void
}

interface FrameRequestCallback {
	(time: number): void
}

declare function setTimeout(handler: TimeRequestCallback, timeout?: number): number
declare function setInterval(handler: TimeRequestCallback, timeout?: number): number
declare function clearTimeout(handle?: number): void
declare function clearInterval(handle?: number): void
declare function requestAnimationFrame(callback: FrameRequestCallback): number
declare function cancelAnimationFrame(handle: number): void

interface Console {
	memory: any
	assert(condition?: boolean, message?: string, ...data: any[]): void
	clear(): void
	count(label?: string): void
	debug(message?: any, ...optionalParams: any[]): void
	dir(value?: any, ...optionalParams: any[]): void
	dirxml(value: any): void
	error(message?: any, ...optionalParams: any[]): void
	exception(message?: string, ...optionalParams: any[]): void
	group(groupTitle?: string, ...optionalParams: any[]): void
	groupCollapsed(groupTitle?: string, ...optionalParams: any[]): void
	groupEnd(): void
	info(message?: any, ...optionalParams: any[]): void
	log(message?: any, ...optionalParams: any[]): void
	markTimeline(label?: string): void
	profile(reportName?: string): void
	profileEnd(reportName?: string): void
	table(...tabularData: any[]): void
	time(label?: string): void
	timeEnd(label?: string): void
	timeStamp(label?: string): void
	timeline(label?: string): void
	timelineEnd(label?: string): void
	trace(message?: any, ...optionalParams: any[]): void
	warn(message?: any, ...optionalParams: any[]): void
}

declare var Console: {
	prototype: Console
	new(): Console
}

declare var console: Console
