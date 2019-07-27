import { bridge } from '../decorator/bridge'
import { Event } from '../event/Event'
import { View } from './View'

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
	 * @method onEvent
	 * @since 0.7.0
	 */
	public onEvent(event: Event) {

		switch (event.type) {

			case 'beforeload':
				this.onBeforeLoad(event)
				break

			case 'load':
				this.onLoad(event)
				break
		}

		super.onEvent(event)
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
	 * @method nativeOnBeforeLoad
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnBeforeLoad(url: string) {

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
	 * @method nativeOnLoad
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnLoad() {
		this.emit('load')
	}
}