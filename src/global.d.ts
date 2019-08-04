//------------------------------------------------------------------------------
// Dezel
//------------------------------------------------------------------------------

/**
 * The global object.
 * @const global
 * @sine 0.1.0
 */
declare var global: any

/**
 * Whether the application is in development mode.
 * @const _DEV_
 * @since 0.1.0
 */
declare const _DEV_: boolean

/**
 * Whether the application is running on the simulator.
 * @const _DEV_
 * @since 0.1.0
 */
declare const _SIM_: boolean

/**
 * Use Dezel.importClass instead.
 * @method importClass
 * @since 0.7.0
 */
declare function importClass(uid: string): any

/**
 * Use Dezel.importClass instead.
 * @method importClass
 * @since 0.7.0
 */
declare function importObject(uid: string): any

/**
 * Use Dezel.registerApplication instead.
 * @method registerApplication
 * @since 0.7.0
 */
declare function registerApplication(application: any, id: string): void

//------------------------------------------------------------------------------
// JSX
//------------------------------------------------------------------------------

/**
 * JSX definitions.
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
 * Play nicer with JSX.
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
