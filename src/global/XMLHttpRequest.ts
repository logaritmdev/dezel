import { Dictionary } from 'lodash'
import { bound } from '../decorator/bound'
import { bridge } from '../decorator/bridge'
import { Event } from './Event'
import { ProgressEvent } from './Event'
import { EventTarget } from './EventTarget'
import { Exception } from './Exception'

/**
 * @symbol READY_STATE
 * @since 0.7.0
 */
export const READY_STATE = Symbol('readyState')

/**
 * @symbol URL
 * @since 0.7.0
 */
export const URL = Symbol('url')

/**
 * @symbol METHOD
 * @since 0.7.0
 */
export const METHOD = Symbol('method')

/**
 * @symbol HEADERS
 * @since 0.7.0
 */
export const HEADERS = Symbol('headers')

/**
 * @symbol TIMEOUT
 * @since 0.7.0
 */
export const TIMEOUT = Symbol('timeout')

/**
 * @symbol USERNAME
 * @since 0.7.0
 */
export const USERNAME = Symbol('username')

/**
 * @symbol PASSWORD
 * @since 0.7.0
 */
export const PASSWORD = Symbol('password')

/**
 * @symbol RESPONSE
 * @since 0.7.0
 */
export const RESPONSE = Symbol('response')

/**
 * @symbol RESPONSE_TEXT
 * @since 0.7.0
 */
export const RESPONSE_TEXT = Symbol('responseText')

/**
 * @symbol RESPONSE_TYPE
 * @since 0.7.0
 */
export const RESPONSE_TYPE = Symbol('responseType')

/**
 * @symbol RESPONSE_HEADERS
 * @since 0.7.0
 */
export const RESPONSE_HEADERS = Symbol('responseHeader')

/**
 * @symbol RESPONSE_URL
 * @since 0.7.0
 */
export const RESPONSE_URL = Symbol('responseURL')

/**
 * @symbol STATUS_CODE
 * @since 0.7.0
 */
export const STATUS_CODE = Symbol('statusCode')

/**
 * @symbol STATUS_TEXT
 * @since 0.7.0
 */
export const STATUS_TEXT = Symbol('statusText')

/**
 * @symbol SENT
 * @since 0.7.0
 */
export const SENT = Symbol('sent')

/**
 * @symbol ERROR
 * @since 0.7.0
 */
export const ERROR = Symbol('error')

/**
 * @symbol ABORT
 * @since 0.7.0
 */
export const ABORT = Symbol('abort')

/**
 * @bridge dezel.global.XMLHttpRequest
 * @since 0.7.0
 */
@bridge('dezel.global.XMLHttpRequest')

/**
 * Manages Http requests.
 * @class XMLHttpRequest
 * @super EventTarget
 * @since 0.7.0
 */
export class XMLHttpRequest extends EventTarget {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	/**
	 * @const UNSENT
	 * @since 0.7.0
	 */
	public static readonly UNSENT = 0

	/**
	 * @const OPENED
	 * @since 0.7.0
	 */
	public static readonly OPENED = 1

	/**
	 * @const HEADERS_RECEIVED
	 * @since 0.7.0
	 */
	public static readonly HEADERS_RECEIVED = 2

	/**
	 * @const LOADING
	 * @since 0.7.0
	 */
	public static readonly LOADING = 3

	/**
	 * @const DONE
	 * @since 0.7.0
	 */
	public static readonly DONE = 4

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The state of the request.
	 * @property readyState
	 * @since 0.7.0
	 */
	public get readyState(): number {
		return this[READY_STATE]
	}

	/**
	 * The request's response.
	 * @property response
	 * @since 0.7.0
	 */
	public get response(): any {
		return this[RESPONSE]
	}

	/**
	 * The request's text response.
	 * @property responseText
	 * @since 0.7.0
	 */
	public get responseText(): string {

		if (this.responseType != '' &&
			this.responseType != 'text') {
			throw Exception.create(Exception.Code.InvalidStateError)
		}

		return this[RESPONSE_TEXT]
	}

	/**
	 * The request's response type.
	 * @property responseType
	 * @since 0.7.0
	 */
	public get responseType(): string {
		return this[RESPONSE_TYPE]
	}

	/**
	 * The request's response type.
	 * @property responseType
	 * @since 0.7.0
	 */
	public set responseType(value: string) {

		if (this.readyState >= XMLHttpRequest.LOADING) {
			throw Exception.create(Exception.Code.InvalidStateError)
		}

		this[RESPONSE_TYPE] = value
	}

	/**
	 * The request's response URL.
	 * @property responseURL
	 * @since 0.7.0
	 */
	public get responseURL(): string {
		return this[RESPONSE_URL]
	}

	/**
	 * The request's response XML document.
	 * @property responseXML
	 * @since 0.7.0
	 */
	public get responseXML(): string {
		throw new Error('Property "responseXML" is not supported.')
	}

	/**
	 * The request's status.
	 * @property status
	 * @since 0.7.0
	 */
	public get status(): number {

		if (this.readyState == XMLHttpRequest.UNSENT ||
			this.readyState == XMLHttpRequest.OPENED ||
			this.error) {
			return 0
		}

		return this[STATUS_CODE]
	}

	/**
	 * The request's status text.
	 * @property statusText
	 * @since 0.7.0
	 */
	public get statusText(): string {

		if (this.readyState == XMLHttpRequest.UNSENT ||
			this.readyState == XMLHttpRequest.OPENED ||
			this.error) {
			return ""
		}

		return this[STATUS_TEXT]
	}

	/**
	 * The requests's timeout.
	 * @property timeout
	 * @since 0.7.0
	 */
	public get timeout(): number {
		return this[TIMEOUT]
	}

	/**
	 * The requests's timeout.
	 * @property timeout
	 * @since 0.7.0
	 */
	public set timeout(value: number) {

		if (this.readyState != XMLHttpRequest.OPENED || this.sent) {
			throw Exception.create(Exception.Code.InvalidStateError)
		}

		this[TIMEOUT] = value
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes a request.
	 * @method open
	 * @since 0.7.0
	 */
	public open(method: string, url: string, async?: boolean, username?: string, password?: string) {

		method = method.toUpperCase()

		if (method != 'GET' &&
			method != 'PUT' &&
			method != 'POST' &&
			method != 'HEAD' &&
			method != 'DELETE' &&
			method != 'OPTIONS') {
			throw new SyntaxError('Invalid request method')
		}

		this[URL] = url
		this[METHOD] = method
		this[USERNAME] = username
		this[PASSWORD] = password

		this[SENT] = false
		this[ERROR] = false
		this[ABORT] = false

		this.clearRequest()
		this.clearResponse()

		this.changeState(XMLHttpRequest.OPENED)
	}

	/**
	 * Aborts the request if it has already been sent.
	 * @method open
	 * @since 0.7.0
	 */
	public abort() {

		this[ABORT] = true

		this.clearRequest()
		this.clearResponse()

		if (this[SENT] && this.readyState == XMLHttpRequest.OPENED || this.readyState == XMLHttpRequest.HEADERS_RECEIVED || this.readyState == XMLHttpRequest.LOADING) {
			this[SENT] = false
			this.changeState(XMLHttpRequest.DONE)
			this.dispatchEvent(new ProgressEvent('abort'))
		}

		if (this[READY_STATE] == XMLHttpRequest.DONE) {
			this[READY_STATE] = XMLHttpRequest.UNSENT
		}
	}

	/**
	 * Sends the request.
	 * @method open
	 * @since 0.7.0
	 */
	public send(data?: any) {

		if (this.readyState != XMLHttpRequest.OPENED || this.sent) {
			throw Exception.create(Exception.Code.InvalidStateError)
		}

		this[SENT] = true
		this[ERROR] = false

		this.native.request(
			this[URL],
			this[METHOD],
			this[HEADERS],
			this[TIMEOUT],
			this[USERNAME],
			this[PASSWORD],
			data
		)

		this.dispatchEvent(new ProgressEvent('loadstart'))
	}

	/**
	 * Overrides the MIME type returned by the server.
	 * @method overrideMimeType
	 * @since 0.7.0
	 */
	public overrideMimeType(override: string) {

		if (this.readyState == XMLHttpRequest.LOADING ||
			this.readyState == XMLHttpRequest.DONE) {
			throw Exception.create(Exception.Code.InvalidStateError)
		}

		throw new Error('Not supported.')
	}

	/**
	 * Returns all the response headers.
	 * @method getAllResponseHeaders
	 * @since 0.7.0
	 */
	public getAllResponseHeaders() {

		if (this.readyState < XMLHttpRequest.HEADERS_RECEIVED || this.error) {
			return ''
		}

		let headers = ''
		let entries = Object.entries(this[RESPONSE_HEADERS])

		for (let entry of entries) {

			let key = entry[0]
			let val = entry[1]

			headers += key
			headers += ': '
			headers += val
			headers += '\r\n'
		}

		return headers
	}

	/**
	 * Returns the string containing the text of the specified header.
	 * @method getResponseHeader
	 * @since 0.7.0
	 */
	public getResponseHeader(name: string) {

		if (this.readyState < XMLHttpRequest.HEADERS_RECEIVED || this.error) {
			return ''
		}

		return this[RESPONSE_HEADERS][name]
	}

	/**
	 * Sets the value of an HTTP request header.
	 * @method setRequestHeader
	 * @since 0.7.0
	 */
	public setRequestHeader(name: string, value: string) {

		if (this.readyState != XMLHttpRequest.OPENED || this.sent) {
			throw Exception.create(Exception.Code.InvalidStateError)
		}

		this[HEADERS][name] = value
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
	 * @property METHOD
	 * @since 0.7.0
	 * @hidden
	 */
	private [METHOD]: string = ''

	/**
	 * @property HEADERS
	 * @since 0.7.0
	 * @hidden
	 */
	private [HEADERS]: Dictionary<string> = {}

	/**
	 * @property TIMEOUT
	 * @since 0.7.0
	 * @hidden
	 */
	private [TIMEOUT]: number = 60000

	/**
	 * @property USERNAME
	 * @since 0.7.0
	 * @hidden
	 */
	private [USERNAME]?: string = ''

	/**
	 * @property PASSWORD
	 * @since 0.7.0
	 * @hidden
	 */
	private [PASSWORD]?: string = ''

	/**
	 * @property READY_STATE
	 * @since 0.7.0
	 * @hidden
	 */
	private [READY_STATE]: number = 0

	/**
	 * @property RESPONSE
	 * @since 0.7.0
	 * @hidden
	 */
	private [RESPONSE]: string = ''

	/**
	 * @property RESPONSE_TEXT
	 * @since 0.7.0
	 * @hidden
	 */
	private [RESPONSE_TEXT]: string = ''

	/**
	 * @property RESPONSE_TYPE
	 * @since 0.7.0
	 * @hidden
	 */
	private [RESPONSE_TYPE]: string = ''

	/**
	 * @property RESPONSE_HEADERS
	 * @since 0.7.0
	 * @hidden
	 */
	private [RESPONSE_HEADERS]: Dictionary<string> = {}

	/**
	 * @property RESPONSE_URL
	 * @since 0.7.0
	 * @hidden
	 */
	private [RESPONSE_URL]: string = ''

	/**
	 * @property STATUS
	 * @since 0.7.0
	 * @hidden
	 */
	private [STATUS_CODE]: number = 0

	/**
	 * @property STATUS_TEXT
	 * @since 0.7.0
	 * @hidden
	 */
	private [STATUS_TEXT]: string = ''

	/**
	 * @property SENT
	 * @since 0.7.0
	 * @hidden
	 */
	private [SENT]: boolean = false

	/**
	 * @property ERROR
	 * @since 0.7.0
	 * @hidden
	 */
	private [ERROR]: boolean = false

	/**
	 * @property ABORT
	 * @since 0.7.0
	 * @hidden
	 */
	private [ABORT]: boolean = false

	/**
	 * @property sent
	 * @since 0.7.0
	 * @hidden
	 */
	private get sent(): boolean {
		return this[SENT]
	}

	/**
	 * @property error
	 * @since 0.7.0
	 * @hidden
	 */
	private get error(): boolean {
		return this[ERROR]
	}

	/**
	 * @method changeState
	 * @since 0.7.0
	 * @hidden
	 */
	private changeState(state: number) {

		if (this.readyState == state) {
			return
		}

		this[READY_STATE] = state

		if (state <= XMLHttpRequest.OPENED ||
			state == XMLHttpRequest.DONE) {
			this.dispatchEvent(new Event('readystatechange'))
		}

		if (state == XMLHttpRequest.DONE || this.error) {
			this.dispatchEvent(new Event('load'))
			this.dispatchEvent(new Event('loadend'))
		}
	}

	/**
	 * @method open
	 * @since 0.7.0
	 * @hidden
	 */
	private clearRequest() {
		this[HEADERS] = {}
	}

	/**
	 * @method open
	 * @since 0.7.0
	 * @hidden
	 */
	private clearResponse() {
		this[RESPONSE] = ''
		this[RESPONSE_TEXT] = ''
	}

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

	/**
	 * @property native
	 * @since 0.7.0
	 * @hidden
	 */
	private native: any

	/**
	 * @method nativeOnProgress
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnProgress(loaded: number, total: number) {
		this.dispatchEvent(new ProgressEvent('progress', { lengthComputable: total > 0, loaded, total }))
	}

	/**
	 * @method nativeOnComplete
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnComplete(data: string, statusCode: number, statusText: string, headers: any, url: string) {

		if (this.error) {
			return
		}

		if (this.readyState < XMLHttpRequest.HEADERS_RECEIVED) {
			this.changeState(XMLHttpRequest.HEADERS_RECEIVED)
		}

		headers = Object.assign({}, headers)

		this[RESPONSE] = data
		this[RESPONSE_TEXT] = data
		this[RESPONSE_HEADERS] = headers
		this[RESPONSE_URL] = url

		this[STATUS_CODE] = statusCode
		this[STATUS_TEXT] = statusText

		this[SENT] = false

		this.changeState(XMLHttpRequest.DONE)
	}

	/**
	 * @method nativeOnTimeout
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnTimeout(event: Event) {

		this.clearRequest()
		this.clearResponse()

		this[SENT] = false
		this[ERROR] = true

		this.changeState(XMLHttpRequest.DONE)

		this.dispatchEvent(new Event('timeout'))
	}

	/**
	 * @method nativeOnError
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnError(error: Error) {

		if (this.error) {
			return
		}

		this.dispatchEvent(new Event('error'))
	}
}