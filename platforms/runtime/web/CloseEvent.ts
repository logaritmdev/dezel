/**
 * @class CloseEvent
 * @since 0.1.0
 */
export class CloseEvent extends Event {

}

/**
 * @global CloseEvent
 * @since 0.1.0
 */
Object.defineProperty(self, "CloseEvent", {
	value: CloseEvent,
	writable: false,
	enumerable: false,
	configurable: true
})
