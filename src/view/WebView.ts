import { bridge } from '../native/bridge'
import { native } from '../native/native'
import { Event } from '../event/Event'
import { View } from './View'

@bridge('dezel.view.WebView')

/**
 * @class WebView
 * @super View
 * @since 0.2.0
 */
export class WebView extends View {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.2.0
	 */
	constructor() {
		super()
		this.scrollable = true
		this.scrollbars = true
	}

	/**
	 * Loads the specified URL.
	 * @method loadURL
	 * @since 0.7.0
	 */
	public loadURL(url: string) {
		native(this).load(url)
		return this
	}

	/**
	 * Loads the specified HTML.
	 * @method loadHTML
	 * @since 0.2.0
	 */
	public loadHTML(html: string) {
		native(this).loadHTML(html)
		return this
	}

	/**
	 * Reloads the page.
	 * @method reload
	 * @since 0.2.0
	 */
	public reload() {
		native(this).reload()
		return this
	}

	/**
	 * Stops the page from loading.
	 * @method stop
	 * @since 0.2.0
	 */
	public stop() {
		native(this).stop()
		return this
	}

	/**
	 * Go back.
	 * @method back
	 * @since 0.2.0
	 */
	public back() {
		native(this).back()
		return this
	}

	/**
	 * Go forward.
	 * @method forward
	 * @since 0.2.0
	 */
	public forward() {
		native(this).forward()
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
	 * Called before the page attempts to load.
	 * @method onBeforeLoad
	 * @since 0.2.0
	 */
	public onBeforeLoad(event: Event) {

	}

	/**
	 * Called after the page is loaded.
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