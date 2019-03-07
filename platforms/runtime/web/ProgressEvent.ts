/**
 * @class ProgressEvent
 * @since 0.1.0
 */
export class ProgressEvent extends Event {

}

/**
 * @global ProgressEvent
 * @since 0.1.0
 */
Object.defineProperty(self, "ProgressEvent", {
	value: ProgressEvent,
	writable: false,
	enumerable: false,
	configurable: true
})
