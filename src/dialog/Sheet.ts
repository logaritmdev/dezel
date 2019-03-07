import { bound } from '../decorator/bound'
import { bridge } from '../decorator/bridge'
import { native } from '../decorator/native'
import { Event } from '../event/Event'
import { Emitter } from '../event/Emitter'
import { SheetButton } from './SheetButton'

/**
 * @symbol SELECTION
 * @since 0.4.0
 */
export const SELECTION = Symbol('button')

/**
 * @symbol PRESENTED
 * @since 0.4.0
 */
export const PRESENTED = Symbol('presented')

/**
 * @interface SheetOptions
 * @super Emitter
 * @since 0.5.0
 */
export interface SheetOptions {
	title?: string
	message?: string
	buttons?: Array<SheetButton>
}

@bridge('dezel.dialog.Sheet')

/**
 * Displays a sheet.
 * @class Sheet
 * @super Emitter
 * @since 0.5.0
 */
export class Sheet extends Emitter {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The sheet's title.
	 * @property title
	 * @since 0.5.0
	 */
	public readonly title: string

	/**
	 * The sheet's message.
	 * @property message
	 * @since 0.5.0
	 */
	public readonly message: string

	/**
	 * The sheet's buttons.
	 * @property buttons
	 * @since 0.5.0
	 */
	public readonly buttons: Array<SheetButton>

	/**
	 * Whether the sheet is presented.
	 * @property presented
	 * @since 0.4.0
	 */
	public get presented(): boolean {
		return this[PRESENTED]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the sheet.
	 * @constructor
	 * @since 0.5.0
	 */
	constructor(options: SheetOptions = {}) {

		super()

		this.title = options.title || ''
		this.message = options.message || ''
		this.buttons = options.buttons || []

		this.buttons.forEach(button => button.on('press', this.onButtonPress))
	}

	/**
	 * Presents the sheet.
	 * @method present
	 * @since 0.5.0
	 */
	public present() {

		if (this.presented) {

			console.error(`
				Sheet error:
				This sheet is already presented.
			`)

			return this
		}

		this[SELECTION] = 'ok'

		this.native.present(
			this.title,
			this.message,
			this.buttons.map(button => button.native)
		)

		return this
	}

	/**
	 * Dismisses the sheet.
	 * @method dismiss
	 * @since 0.5.0
	 */
	public dismiss() {

		if (this.presented) {

			console.error(`
				Sheet error:
				This sheet is not presented.
			`)

			return this
		}

		this.native.dismiss()

		return this
	}

	/**
	 * Presents the sheet.
	 * @method present
	 * @since 0.3.0
	 */
	public prompt(): Promise<string> {

		if (this.presented) {

			console.error(`
				Sheet error:
				This sheet is already presented.
			`)

			return Promise.resolve('')
		}

		return new Promise((success) => {
			this.present().once('dismiss', (event: Event<SheetDismissEvent>) => success(event.data.button))
		})
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onEmit
	 * @since 0.5.0
	 */
	public onEmit(event: Event) {

		switch (event.type) {

			case 'present':
				this.onPresent(event)
				break

			case 'dismiss':
				this.onDismiss(event)
				break
		}

		return super.onEmit(event)
	}

	/**
	 * Called when the sheet is presented.
	 * @method onPresent
	 * @since 0.5.0
	 */
	public onPresent(event: Event) {

	}

	/**
	 * Called when the sheet is dismissed.
	 * @method onDismiss
	 * @since 0.5.0
	 */
	public onDismiss(event: Event<SheetDismissEvent>) {

	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property [PRESENTED]
	 * @since 0.3.0
	 * @hidden
	 */
	private [PRESENTED]: boolean = false

	/**
	 * @property [SELECTION]
	 * @since 0.4.0
	 * @hidden
	 */
	private [SELECTION]: string = 'ok'

	/**
	 * @method onButtonPress
	 * @since 0.3.0
	 * @hidden
	 */
	@bound private onButtonPress(event: Event) {
		this[SELECTION] = (event.sender as SheetButton).id
	}

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

	/**
	 * @property native
	 * @since 0.5.0
	 * @hidden
	 */
	public native: any

	/**
	 * @method nativePresent
	 * @since 0.5.0
	 * @hidden
	 */
	private nativePresent() {
		this[PRESENTED] = true
		this.emit('present')
	}

	/**
	 * @method nativeDismiss
	 * @since 0.5.0
	 * @hidden
	 */
	private nativeDismiss() {
		this[PRESENTED] = false
		this.emit<SheetDismissEvent>('dismiss', { data: { button: this[SELECTION] } })
	}
}

/**
 * @type SheetDismissEvent
 * @since 0.3.0
 */
export type SheetDismissEvent = {
	button: string
}