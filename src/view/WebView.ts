import { bridge } from '../decorator/bridge'
import { Event } from '../event/Event'
import { View } from './View'
import './WebView.ds'


@bridge('dezel.view.WebView')

/**
 * Displays a stripped down web browser.
 * @class WebView
 * @super View
 * @since 0.2.0
 */
export class WebView extends View {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes this view.
	 * @constructor
	 * @since 0.2.0
	 */
	constructor() {
		super()
		this.scrollable = true
		this.scrollbars = true
	}

	/**
	 * Loads an URL.
	 * @method load
	 * @since 0.2.0
	 */
	public load(url: string) {
		this.native.load(url)
		return this
	}

	/**
	 * Loads HTML.
	 * @method loadHTML
	 * @since 0.2.0
	 */
	public loadHTML(html: string) {
		this.native.loadHTML(html)
		return this
	}

	/**
	 * Reloads the webview.
	 * @method reload
	 * @since 0.2.0
	 */
	public reload() {
		this.native.reload()
		return this
	}

	/**
	 * Stops the webview's loading.
	 * @method stop
	 * @since 0.2.0
	 */
	public stop() {
		this.native.stop()
		return this
	}

	/**
	 * Go back in the webview's history.
	 * @method back
	 * @since 0.2.0
	 */
	public back() {
		this.native.back()
		return this
	}

	/**
	 * Go forward in the webview's history.
	 * @method forward
	 * @since 0.2.0
	 */
	public forward() {
		this.native.forward()
		return this
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onEmit
	 * @since 0.2.0
	 */
	public onEmit(event: Event) {

		switch (event.type) {

			case 'beforeload':
				this.onBeforeLoad(event)
				break

			case 'load':
				this.onLoad(event)
				break
		}

		super.onEmit(event)
	}

	/**
	 * @method onBeforeLoad
	 * @since 0.2.0
	 */
	public onBeforeLoad(event: Event) {

	}

	/**
	 * @method onLoad
	 * @since 0.2.0
	 */
	public onLoad(event: Event) {

	}

	//--------------------------------------------------------------------------
	// Native Methods
	//--------------------------------------------------------------------------

	/**
	 * @method private nativeBeforeLoad
	 * @since 0.2.0
	 * @hidden
	 */
	private nativeBeforeLoad(url: string) {

		let event = new Event('beforeload', {
			propagable: false,
			cancelable: true,
			data: {
				url
			}
		})

		this.emit(event)

		return event.canceled == false
	}

	/**
	 * @method private nativeLoad
	 * @since 0.2.0
	 * @hidden
	 */
	private nativeLoad() {
		this.emit('load')
	}
}