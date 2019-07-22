import { bridge } from '../decorator/bridge'
import { native } from '../decorator/native'
import { Event } from './Event'
import { MessageEvent } from './Event'
import { ProgressEvent } from './Event'
import { EventTarget } from './EventTarget'
import { Exception } from './Exception'

/**
 * @symbol URL
 * @since 0.7.0
 */
export const URL = Symbol('url')

/**
 * @symbol PROTOCOL
 * @since 0.7.0
 */
export const PROTOCOL = Symbol('protocol')

/**
 * @symbol EXTENSIONS
 * @since 0.7.0
 */
export const EXTENSIONS = Symbol('extensions')

/**
 * @symbol READY_STATE
 * @since 0.7.0
 */
export const READY_STATE = Symbol('readyState')

/**
 * @symbol BINARY_TYPE
 * @since 0.7.0
 */
export const BINARY_TYPE = Symbol('binaryType')

/**
 * @symbol BUFFERED_AMOUNT
 * @since 0.7.0
 */
export const BUFFERED_AMOUNT = Symbol('bufferedAmount')

@bridge('dezel.global.WebSocket')

/**
 * TODO
 * @class WebSocket
 * @super EventTarget
 * @since 0.7.0
 */
export class WebSocket extends EventTarget {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	/**
	 * TODO
	 * @const CONNECTING
	 * @since 0.7.0
	 */
	public static readonly CONNECTING = 0

	/**
	 * TODO
	 * @const OPEN
	 * @since 0.7.0
	 */
	public static readonly OPEN = 1

	/**
	 * TODO
	 * @const CLOSING
	 * @since 0.7.0
	 */
	public static readonly CLOSING = 2

	/**
	 * TODO
	 * @const CLOSED
	 * @since 0.7.0
	 */
	public static readonly CLOSED = 3

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The WebSocket connection's url.
	 * @property url
	 * @since 0.7.0
	 */
	public get url(): string {
		return this[URL]
	}

	/**
	 * The WebSocket connection's protocol.
	 * @property protocol
	 * @since 0.7.0
	 */
	public get protocol(): string {
		return this[PROTOCOL]
	}

	/**
	 * The WebSocket connection's protocol.
	 * @property extensions
	 * @since 0.7.0
	 */
	public get extensions(): string {
		return this[EXTENSIONS]
	}

	/**
	 * The WebSocket connection's state.
	 * @property protocol
	 * @since 0.7.0
	 */
	public get readyState(): number {
		return this[READY_STATE]
	}

	/**
	 * The WebSocket connection's binary type.
	 * @property binaryType
	 * @since 0.7.0
	 */
	public get binaryType(): string {
		return this[BINARY_TYPE]
	}

	/**
	 * The WebSocket connection's binary type.
	 * @property binaryType
	 * @since 0.7.0
	 */
	public set binaryType(value: string) {
		this[BINARY_TYPE] = value
	}

	/**
	 * The WebSocket connection's binary type.
	 * @property bufferedAmount
	 * @since 0.7.0
	 */
	public get bufferedAmount(): number {
		return this[BUFFERED_AMOUNT]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Todo
	 * @constructor
	 * @since 0.7.0
	 */
	public constructor(url: string, protocols: string | Array<string> = '') {

		super()

		console.log('WS: open ?')
		if (protocols) {
			protocols = Array.isArray(protocols) ? protocols : [protocols]
		}

		if (url.startsWith('ws') == false &&
			url.startsWith('wss') == false) {
			this[READY_STATE] = WebSocket.CLOSED
			throw Exception.create(Exception.Code.SyntaxError)
		}
		console.log('WS: open ', url)
		this.native.open(url, protocols)
	}

	/**
	 * Todo
	 * @method send
	 * @since 0.7.0
	 */
	public send(data: string) {
		console.log('WS: Send ?')
		if (this.readyState == WebSocket.CONNECTING) {
			throw Exception.create(Exception.Code.InvalidStateError)
		}

		if (this.readyState == WebSocket.CLOSING ||
			this.readyState == WebSocket.CLOSED) {
			return
		}
		console.log('WS: Send', data)
		this.native.send(data)
	}

	/**
	 * Todo
	 * @method send
	 * @since 0.7.0
	 */
	public close(code?: number, reason?: number) {
		console.log('WS: Close ?')
		if (this.readyState == WebSocket.CLOSING ||
			this.readyState == WebSocket.CLOSED) {
			return
		}

		if (this[READY_STATE] == WebSocket.CONNECTING) {
			this[READY_STATE] = WebSocket.CLOSING
			return
		}

		this[READY_STATE] = WebSocket.CLOSING
		console.log('WS: Close')
		this.native.close(code, reason)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property URL
	 * @since 0.7.0
	 * @hidden
	 */
	private [URL]: string = ''

	/**
	 * @property PROTOCOL
	 * @since 0.7.0
	 * @hidden
	 */
	private [PROTOCOL]: string = ''

	/**
	 * @property EXTENSIONS
	 * @since 0.7.0
	 * @hidden
	 */
	private [EXTENSIONS]: string = ''

	/**
	 * @property READY_STATE
	 * @since 0.7.0
	 * @hidden
	 */
	private [READY_STATE]: number = 0

	/**
	 * @property BINARY_TYPE
	 * @since 0.7.0
	 * @hidden
	 */
	private [BINARY_TYPE]: string = ''

	/**
	 * @property BUFFERED_AMOUNT
	 * @since 0.7.0
	 * @hidden
	 */
	private [BUFFERED_AMOUNT]: number = 0

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

	/**
	 * @property native
	 * @since 0.1.0
	 * @hidden
	 */
	private native: any

	/**
	 * @method nativeOnConnect
	 * @sine 0.7.0
	 * @hidden
	 */
	private nativeOnConnect(protocol: string, extensions: string) {

		if (this.readyState != WebSocket.CONNECTING) {
			this.nativeOnDisconnect()
			return
		}

		this[READY_STATE] = WebSocket.OPEN

		this[PROTOCOL] = protocol
		this[EXTENSIONS] = extensions

		this.dispatchEvent(new Event('open'))
	}

	/**
	 * @method nativeOnReceiveData
	 * @sine 0.7.0
	 * @hidden
	 */
	private nativeOnReceiveData(data: any) {

	}

	/**
	 * @method nativeOnMessage
	 * @sine 0.7.0
	 * @hidden
	 */
	private nativeOnReceiveMessage(message: string) {

		if (this.readyState != WebSocket.OPEN) {
			return
		}

		this.dispatchEvent(new MessageEvent('message', { data: message }))
	}

	/**
	 * @method nativeOnClose
	 * @sine 0.7.0
	 * @hidden
	 */
	private nativeOnDisconnect() {
		this[READY_STATE] = WebSocket.CLOSED
	}

	/**
	 * @method nativeOnError
	 * @sine 0.7.0
	 * @hidden
	 */
	private nativeOnError() {

	}
}