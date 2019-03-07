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

@bridge("dezel.web.XMLHttpRequest")

/**
 * @class XMLHttpRequest
 * @since 0.1.0
 */
class XMLHttpRequest extends EventTarget {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property readyState
	 * @since 0.1.0
	 */
	@native public readyState!: number

	/**
	 * @property response
	 * @since 0.1.0
	 */
	@native public response!: any

	/**
	 * @property responseText
	 * @since 0.1.0
	 */
	@native public responseText!: any

	/**
	 * @property responseType
	 * @since 0.1.0
	 */
	@native public responseType!: XMLHttpRequestResponseType

	/**
	 * @property responseURL
	 * @since 0.1.0
	 */
	@native public responseURL!: string

	/**
	 * @property responseXML
	 * @since 0.1.0
	 */
	@native public responseXML!: Document

	/**
	 * @property status
	 * @since 0.1.0
	 */
	@native public status!: number

	/**
	 * @property statusText
	 * @since 0.1.0
	 */
	@native public statusText!: number

	/**
	 * @property timeout
	 * @since 0.1.0
	 */
	@native public timeout!: number

	/**
	 * @property upload
	 * @since 0.1.0
	 */
	@native public upload!: XMLHttpRequestUpload

	/**
	 * @property withCredentials
	 * @since 0.1.0
	 */
	@native public withCredentials!: boolean

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	constructor() {
		super()
	}

	/**
	 * @method open
	 * @since 0.1.0
	 */
	public open(method: string, url: string, async?: boolean, username?: string, password?: string): void {
		this.native.open(method, url, async, username, password)
	}

	/**
	 * @method send
	 * @since 0.1.0
	 */
	public send(data?: string | Document | any) {
		this.native.send(data)
	}

	/**
	 * @method abort
	 * @since 0.1.0
	 */
	public abort() {
		this.native.abort()
	}

	/**
	 * @method overrideMimeType
	 * @since 0.1.0
	 */
	public overrideMimeType(mime: string): void {
		this.native.overrideMimeType(mime)
	}

	/**
	 * @method setRequestHeader
	 * @since 0.1.0
	 */
	public setRequestHeader(header: string, value: string) {
		this.native.setRequestHeader(header, value)
	}

	/**
	 * @method getAllResponseHeaders
	 * @since 0.1.0
	 */
	public getAllResponseHeaders(): string {
		return this.native.getAllResponseHeaders()
	}

	/**
	 * @method getResponseHeader
	 * @since 0.1.0
	 */
	public getResponseHeader(): string | null {
		return this.native.getResponseHeader()
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property native
	 * @since 0.1.0
	 */
	public native: any

}

/**
 * @global XMLHttpRequest
 * @since 0.1.0
 */
Object.defineProperty(self, "XMLHttpRequest", {
	value: XMLHttpRequest,
	writable: false,
	enumerable: false,
	configurable: true
})
