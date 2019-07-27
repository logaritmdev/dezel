import { state } from '../decorator/state'
import { Event } from '../event/Event'
import { TouchEvent } from '../touch/TouchEvent'
import { Component } from './Component'
import { Host } from './Host'
import { Image } from './Image'
import { Label } from './Label'
import './Button.ds'
import './Button.ds.android'
import './Button.ds.ios'

/**
 * The internal references.
 * @interface Refs
 * @since 0.7.0
 */
interface Refs {
	label: Label
	image: Image
}

/**
 * Displays a pressable element that performs an action.
 * @class Button
 * @super Component
 * @since 0.1.0
 */
export class Button extends Component<Refs> {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The button's label.
	 * @property label
	 * @since 0.1.0
	 */
	public get label(): Label {
		return this.refs.label
	}

	/**
	 * The button's image.
	 * @property image
	 * @since 0.1.0
	 */
	public get image(): Image {
		return this.refs.image
	}

	/**
	 * Whether the state of this button is pressed.
	 * @property pressed
	 * @since 0.1.0
	 */
	@state public pressed: boolean = false

	/**
	 * Whether the state of this button is selected.
	 * @property selected
	 * @since 0.1.0
	 */
	@state public selected: boolean = false

	/**
	 * Whether the state of this button is disabled.
	 * @property disabled
	 * @since 0.1.0
	 */
	@state public disabled: boolean = false

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method render
	 * @since 0.3.0
	 */
	public render() {
		return (
			<Host>
				<Image for={this} id="image" style="image" />
				<Label for={this} id="label" style="label" />
			</Host>
		)
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

		if (this.disabled) switch (event.type) {
			case 'touchcancel':
			case 'touchstart':
			case 'touchmove':
			case 'touchend':
				event.cancel()
				break
		}

		super.onEvent(event)
	}

	/**
	 * @inherited
	 * @method onTouchCancel
	 * @since 0.1.0
	 */
	protected onTouchCancel(event: TouchEvent) {

		super.onTouchCancel(event)

		if (this.pressed && event.targetTouches.length == 0) {
			this.pressed = false
		}
	}

	/**
	 * @inherited
	 * @method onTouchStart
	 * @since 0.1.0
	 */
	protected onTouchStart(event: TouchEvent) {

		super.onTouchStart(event)

		if (this.pressed == false && this.disabled == false) {
			this.pressed = true
		}
	}

	/**
	 * @inherited
	 * @method onTouchEnd
	 * @since 0.1.0
	 */
	protected onTouchEnd(event: TouchEvent) {

		super.onTouchEnd(event)

		if (this.pressed && event.targetTouches.length == 0) {
			this.pressed = false
			this.emitPress(event)
		}
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method emitPress
	 * @since 0.2.0
	 * @hidden
	 */
	private emitPress(event: TouchEvent) {
		event.touches.hits(this) && this.emit('press')
	}
}