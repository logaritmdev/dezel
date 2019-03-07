import { bound } from '../../../src/decorator/bound'
import { bridge } from '../../../src/decorator/bridge'
import { native } from '../../../src/decorator/native'

/**
 * @const Ready States
 * @since 0.1.0
 */
export enum ReadyState {
	Unsent = 0,
	Opened = 1,
	HeadersReceived = 2,
	Loading = 3,
	Done = 4
}

@bridge("dezel.web.XMLHttpRequestUpload")

/**
 * @class XMLHttpRequest
 * @since 0.1.0
 */
class XMLHttpRequestUpload extends EventTarget {

}

/**
 * @global XMLHttpRequestUpload
 * @since 0.1.0
 */
Object.defineProperty(self, "XMLHttpRequestUpload", {
	value: XMLHttpRequest,
	writable: false,
	enumerable: false,
	configurable: true
})