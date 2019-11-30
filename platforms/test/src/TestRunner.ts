import '../../../src/global'
import * as io from 'socket.io-client'
import { bound } from '../../../src/decorator/bound'
import { Device } from '../../../src/device/Device'
import { Platform } from '../../../src/platform/Platform'

/**
 * @class TestRunner
 * @since 0.7.0
 */
export class TestRunner {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property socket
	 * @since 0.7.0
	 */
	protected socket: SocketIOClient.Socket

	/**
	 * @property host
	 * @since 0.7.0
	 */
	protected host: string

	/**
	 * @property host
	 * @since 0.7.0
	 */
	protected port: string

	/**
	 * @property socket
	 * @since 0.7.0
	 */
	protected config: any

	/**
	 * @since 0.7.0
	 * @hidden
	 */
	private started: boolean = false

	/**
	 * @since 0.7.0
	 * @hidden
	 */
	private running: boolean = false

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Establish connection with the server.
	 * @constructor
	 * @since 0.7.0
	 */
	constructor(host: string, port: string) {

		this.config = this.config || { args: [] }

		this.host = host
		this.port = port

		this.socket = io.connect(`http://${this.host}:${this.port}`, { forceBase64: true, transports: ['websocket'] })
		this.socket.on('connect', this.onConnect)
		this.socket.on('connect_error', this.onConnectError)
		this.socket.on('connect_failed', this.onConnectFailed)
		this.socket.on('disconnect', this.onDisconnect)
		this.socket.on('reconnect', this.onReconnect)
		this.socket.on('reconnect_failed', this.onReconnectFailed)
		this.socket.on('reconnecting', this.onReconnecting);
		this.socket.on('execute', this.onExecute)

		set(global, '__karma__', this)
	}

	/**
	 * TODO
	 * @method run
	 * @since 0.7.0
	 */
	protected async run(config: any) {

		this.running = true
		this.started = false
		this.config = config

		let data = await this.fetch(`http://${this.host}:${this.port}/context.json`)
		if (data == null) {
			return null
		}

		let context = JSON.parse(data)
		if (context == null) {
			return null
		}

		let failed = false

		/*
		 * call eval indirectly to execute
		 * the scripts in the global scope
		 */

		let evaluate = eval

		for (let file of context.files) {

			let url = `http://${this.host}:${this.port}${file}`

			let code = await this.fetch(url)
			if (code == null) {
				continue
			}

			try {
				evaluate(code)
			} catch (error) {
				this.error(error.toString(), url, error.lineNumber || 0)
				failed = true
			}
		}

		if (failed == false) {
			this.start(this.config)
		}
	}

	/**
	 * TODO
	 * @method emit
	 * @since 0.7.0
	 */
	private emit(...args: any[]) {
		this.socket.emit.apply(this.socket, arguments)
	}

	/**
	 * TODO
	 * @method emitStart
	 * @since 0.7.0
	 */
	private emitStart(data: any) {
		if (this.started == false) {
			this.started = true
			this.emit('start', data)
		}
	}

	/**
	 * TODO
	 * @method emitInfo
	 * @since 0.7.0
	 */
	private emitInfo(data: any) {
		if (this.started) {
			this.emit('info', data)
		}
	}

	/**
	 * TODO
	 * @method emitResult
	 * @since 0.7.0
	 */
	private emitResult(data: any) {
		if (this.started) {
			this.emit('result', data)
		}
	}

	//--------------------------------------------------------------------------
	// Karma
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method start
	 * @since 0.7.0
	 */
	public start(data: any) {
		this.error('Missing Karma adapter')
	}

	/**
	 * @inherited
	 * @method start
	 * @since 0.7.0
	 */
	public info(data: any) {
		this.emitStart(data)
		this.emitInfo(data)
	}

	/**
	 * @inherited
	 * @method start
	 * @since 0.7.0
	 */
	public result(data: any) {
		this.emitStart({ total: null })
		this.emitResult(data)
	}

	/**
	 * @inherited
	 * @method start
	 * @since 0.7.0
	 */
	public complete(data: any) {

		delete this.start

		this.running = false

		this.emit('complete', data || {}, () => {
			this.emit('disconnect')
		})
	}

	/**
	 * @inherited
	 * @method start
	 * @since 0.7.0
	 */
	public error(message: string, file?: string, line?: number) {

		this.result({
			id: file,
			description: `${file} at line ${line}` || "",
			log: [message],
			time: 0,
			success: false,
			suite: [],
		})

		this.complete(null)

		return false
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @method onConnect
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onConnect() {
		this.socket.emit('register', { id: `Dezel ${Device.current.uuid}`, name: `Dezel ${Platform.current.name} ${Platform.current.version}` })
	}

	/**
	 * @method onConnect
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onConnectError(error: any) {
		console.log('Connection error: ', error)
	}

	/**
	 * @method onConnect
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onConnectFailed(error: any) {
		console.log('Connection failed: ', error)
	}

	/**
	 * @method onConnect
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onDisconnect() {
		console.log('Disconnected')
	}

	/**
	 * @method onConnect
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onReconnect() {
		console.log('Reconnected')
	}

	/**
	 * @method onConnect
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onReconnectFailed() {
		console.log('Reconnect failed')
	}

	/**
	 * @method onConnect
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private onReconnecting() {
		console.log('Reconnecting')
	}

	/**
	 * @method onConnect
	 * @since 0.7.0
	 * @hidden
	 */
	@bound private async onExecute(config: any) {
		this.run(config)
	}

	/**
	 * @method fetch
	 * @since 0.7.0
	 * @hidden
	 */
	private fetch = (url: string) => new Promise<string>((success, failure) => {

		var xhr = new XMLHttpRequest()

		xhr.onload = function () {
			success(xhr.responseText)
		}

		xhr.open('GET', url, true)
		xhr.send()
	})
}

function set(object: any, key: string, val: any) {
	object[key] = val
}