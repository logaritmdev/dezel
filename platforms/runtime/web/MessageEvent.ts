/**
 * @class MessageEvent
 * @since 0.1.0
 */
export class MessageEvent extends Event {

}

/**
 * @global MessageEvent
 * @since 0.1.0
 */
Object.defineProperty(self, "MessageEvent", {
	value: MessageEvent,
	writable: false,
	enumerable: false,
	configurable: true
})
