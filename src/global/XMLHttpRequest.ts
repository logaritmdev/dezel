import { Dictionary } from 'lodash'
import { bound } from '../decorator/bound'
import { bridge } from '../native/bridge'
import { native } from '../native/native'
import { $abort } from './symbol/XMLHttpRequest'
import { $error } from './symbol/XMLHttpRequest'
import { $headers } from './symbol/XMLHttpRequest'
import { $method } from './symbol/XMLHttpRequest'
import { $password } from './symbol/XMLHttpRequest'
import { $readyState } from './symbol/XMLHttpRequest'
import { $response } from './symbol/XMLHttpRequest'
import { $responseHeaders } from './symbol/XMLHttpRequest'
import { $responseText } from './symbol/XMLHttpRequest'
import { $responseType } from './symbol/XMLHttpRequest'
import { $responseUrl } from './symbol/XMLHttpRequest'
import { $sent } from './symbol/XMLHttpRequest'
import { $statusCode } from './symbol/XMLHttpRequest'
import { $statusText } from './symbol/XMLHttpRequest'
import { $timeout } from './symbol/XMLHttpRequest'
import { $url } from './symbol/XMLHttpRequest'
import { $username } from './symbol/XMLHttpRequest'
import { Event } from './Event'
import { ProgressEvent } from './Event'
import { EventTarget } from './EventTarget'
import { Exception } from './Exception'

/**
 * @bridge dezel.global.XMLHttpRequest
 * @since 0.7.0
 */
@bridge('dezel.global.XMLHttpRequest')

/**
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
	 * @property readyState
	 * @since 0.7.0
	 */
	public get readyState(): number {
		return this[$readyState]
	}

	/**
	 * @property response
	 * @since 0.7.0
	 */
	public get response(): any {
		return this[$response]
	}

	/**
	 * @property responseText
	 * @since 0.7.0
	 */
	public get responseText(): string {

		if (this.responseType != '' &&
			this.responseType != 'text') {
			throw Exception.create(Exception.Code.InvalidStateError)
		}

		return this[$responseText]
	}

	/**
	 * @property responseType
	 * @since 0.7.0
	 */
	public get responseType(): string {
		return this[$responseType]
	}

	/**
	 * @property responseType
	 * @since 0.7.0
	 */
	public set responseType(value: string) {

		if (this.readyState >= XMLHttpRequest.LOADING) {
			throw Exception.create(Exception.Code.InvalidStateError)
		}

		this[$responseType] = value
	}

	/**
	 * @property responseURL
	 * @since 0.7.0
	 */
	public get responseURL(): string {
		return this[$responseUrl]
	}

	/**
	 * @property responseXML
	 * @since 0.7.0
	 */
	public get responseXML(): string {
		throw new Error('Property "responseXML" is not supported.')
	}

	/**
	 * @property status
	 * @since 0.7.0
	 */
	public get status(): number {

		if (this.readyState == XMLHttpRequest.UNSENT ||
			this.readyState == XMLHttpRequest.OPENED ||
			this.error) {
			return 0
		}

		return this[$statusCode]
	}

	/**
	 * @property statusText
	 * @since 0.7.0
	 */
	public get statusText(): string {

		if (this.readyState == XMLHttpRequest.UNSENT ||
			this.readyState == XMLHttpRequest.OPENED ||
			this.error) {
			return ""
		}

		return this[$statusText]
	}

	/**
	 * @property timeout
	 * @since 0.7.0
	 */
	public get timeout(): number {
		return this[$timeout]
	}

	/**
	 * @property timeout
	 * @since 0.7.0
	 */
	public set timeout(value: number) {

		if (this.readyState != XMLHttpRequest.OPENED || this.sent) {
			throw Exception.create(Exception.Code.InvalidStateError)
		}

		this[$timeout] = value
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
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

		this[$url] = url
		this[$method] = method
		this[$username] = username
		this[$password] = password

		this[$sent] = false
		this[$error] = false
		this[$abort] = false

		this.clearRequest()
		this.clearResponse()

		this.changeState(XMLHttpRequest.OPENED)
	}

	/**
	 * @method open
	 * @since 0.7.0
	 */
	public abort() {

		this[$abort] = true

		this.clearRequest()
		this.clearResponse()

		if (this[$sent] && this.readyState == XMLHttpRequest.OPENED || this.readyState == XMLHttpRequest.HEADERS_RECEIVED || this.readyState == XMLHttpRequest.LOADING) {
			this[$sent] = false
			this.changeState(XMLHttpRequest.DONE)
			this.dispatchEvent(new ProgressEvent('abort'))
		}

		if (this[$readyState] == XMLHttpRequest.DONE) {
			this[$readyState] = XMLHttpRequest.UNSENT
		}
	}

	/**
	 * @method open
	 * @since 0.7.0
	 */
	public send(data?: any) {

		if (this.readyState != XMLHttpRequest.OPENED || this.sent) {
			throw Exception.create(Exception.Code.InvalidStateError)
		}

		this[$sent] = true
		this[$error] = false

		native(this).request(
			this[$url],
			this[$method],
			this[$headers],
			this[$timeout],
			this[$username],
			this[$password],
			data
		)

		this.dispatchEvent(new ProgressEvent('loadstart'))
	}

	/**
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
	 * @method getAllResponseHeaders
	 * @since 0.7.0
	 */
	public getAllResponseHeaders() {

		if (this.readyState < XMLHttpRequest.HEADERS_RECEIVED || this.error) {
			return ''
		}

		let headers = ''
		let entries = Object.entries(this[$responseHeaders])

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
	 * @method getResponseHeader
	 * @since 0.7.0
	 */
	public getResponseHeader(name: string) {

		if (this.readyState < XMLHttpRequest.HEADERS_RECEIVED || this.error) {
			return ''
		}

		return this[$responseHeaders][name]
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

		this[$headers][name] = value
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $url
	 * @since 0.7.0
	 * @hidden
	 */
	private [$url]: string = ''

	/**
	 * @property $method
	 * @since 0.7.0
	 * @hidden
	 */
	private [$method]: string = ''

	/**
	 * @property $headers
	 * @since 0.7.0
	 * @hidden
	 */
	private [$headers]: Dictionary<string> = {}

	/**
	 * @property timeout
	 * @since 0.7.0
	 * @hidden
	 */
	private [$timeout]: number = 60000

	/**
	 * @property $username
	 * @since 0.7.0
	 * @hidden
	 */
	private [$username]?: string = ''

	/**
	 * @property $password
	 * @since 0.7.0
	 * @hidden
	 */
	private [$password]?: string = ''

	/**
	 * @property $readyState
	 * @since 0.7.0
	 * @hidden
	 */
	private [$readyState]: number = 0

	/**
	 * @property $response
	 * @since 0.7.0
	 * @hidden
	 */
	private [$response]: string = ''

	/**
	 * @property $responseText
	 * @since 0.7.0
	 * @hidden
	 */
	private [$responseText]: string = ''

	/**
	 * @property $responseType
	 * @since 0.7.0
	 * @hidden
	 */
	private [$responseType]: string = ''

	/**
	 * @property $responseHeaders
	 * @since 0.7.0
	 * @hidden
	 */
	private [$responseHeaders]: Dictionary<string> = {}

	/**
	 * @property responseUrl
	 * @since 0.7.0
	 * @hidden
	 */
	private [$responseUrl]: string = ''

	/**
	 * @property statusCode
	 * @since 0.7.0
	 * @hidden
	 */
	private [$statusCode]: number = 0

	/**
	 * @property statusText
	 * @since 0.7.0
	 * @hidden
	 */
	private [$statusText]: string = ''

	/**
	 * @property $sent
	 * @since 0.7.0
	 * @hidden
	 */
	private [$sent]: boolean = false

	/**
	 * @property $error
	 * @since 0.7.0
	 * @hidden
	 */
	private [$error]: boolean = false

	/**
	 * @property $abort
	 * @since 0.7.0
	 * @hidden
	 */
	private [$abort]: boolean = false

	/**
	 * @property sent
	 * @since 0.7.0
	 * @hidden
	 */
	private get sent(): boolean {
		return this[$sent]
	}

	/**
	 * @property error
	 * @since 0.7.0
	 * @hidden
	 */
	private get error(): boolean {
		return this[$error]
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

		this[$readyState] = state

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
		this[$headers] = {}
	}

	/**
	 * @method open
	 * @since 0.7.0
	 * @hidden
	 */
	private clearResponse() {
		this[$response] = ''
		this[$responseText] = ''
	}

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

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

		this[$response] = data
		this[$responseText] = data
		this[$responseHeaders] = headers
		this[$responseUrl] = url

		this[$statusCode] = statusCode
		this[$statusText] = statusText

		this[$sent] = false

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

		this[$sent] = false
		this[$error] = true

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