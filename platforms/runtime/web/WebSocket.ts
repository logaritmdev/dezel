import { bound } from '../../../src/decorator/bound'
import { bridge } from '../../../src/decorator/bridge'
import { native } from '../../../src/decorator/native'

/**
 * @const Ready States
 * @since 0.1.0
 */
export enum ReadyState {
	Connecting = 0,
	Open = 1,
	Closing = 2,
	Closed = 3
}

@bridge("dezel.web.WebSocket")

/**
 * @class WebSocket
 * @since 0.1.0
 */
class WebSocket extends EventTarget {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The URL as resolved by the constructor.
	 * @property url
	 * @since 0.1.0
	 */
	public get url(): string {
		return this.native.url
	}

	/**
	 * The protocol selected by the server.
	 * @property protocol
	 * @since 0.1.0
	 */
	public get protocol(): string {
		return this.native.protocol
	}

	/**
	 * The extensions selected by the server.
	 * @property extensions
	 * @since 0.1.0
	 */
	public get extensions(): string {
		return this.native.extensions
	}

	/**
	 * The current state of the connection.
	 * @property readyState
	 * @since 0.1.0
	 */
	public get readyState(): number {
		return this.native.readyState
	}

	/**
	 * @property bufferedAmount
	 * @since 0.1.0
	 */
	public get bufferedAmount(): number {
		return this.native.bufferedAmount
	}

	/**
	 * @property binaryType
	 * @since 0.1.0
	 */
	@native public binaryType = 'blob'

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	constructor(url: string, protocols?: string | Array<string>) {

		super()

		if (protocols) {
			protocols = Array.isArray(protocols) ? protocols : [protocols]
		}

		this.native.open(url, protocols)
	}

	/**
	 * Enqueues the specified data to be transmitted to the server.
	 * @method send
	 * @since 0.1.0
	 */
	public send(data: string) {
		this.native.send(data)
	}

	/**
	 * Closes the WebSocket connection or connection attempt, if any.
	 * @method close
	 * @since 0.1.0
	 */
	public close(code?: number, reason?: string) {
		this.native.close(code, reason)
	}

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

	/**
	 * @property native
	 * @since 0.1.0
	 */
	public native: any
}

/**
 * @global WebSocket
 * @since 0.1.0
 */
Object.defineProperty(self, "WebSocket", {
	value: WebSocket,
	writable: false,
	enumerable: false,
	configurable: true
})
