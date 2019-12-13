import { state } from '../decorator/state'
import { Event } from '../event/Event'
import { TouchEvent } from '../event/TouchEvent'
import { Reference } from '../view/Reference'
import { Component } from './Component'
import { Image } from './Image'
import { Label } from './Label'
import { Root } from './Root'
import './style/Button.style'
import './style/Button.style.android'
import './style/Button.style.ios'

/**
 * @class Button
 * @super Component
 * @since 0.1.0
 */
export class Button extends Component {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The button's label.
	 * @property label
	 * @since 0.1.0
	 */
	public get label(): Label {
		return this.refs.label.get()
	}

	/**
	 * The button's image.
	 * @property image
	 * @since 0.1.0
	 */
	public get image(): Image {
		return this.refs.image.get()
	}

	/**
	 * Whether the button is pressed.
	 * @property pressed
	 * @since 0.1.0
	 */
	@state public pressed: boolean = false

	/**
	 * Whether the button is selected.
	 * @property selected
	 * @since 0.1.0
	 */
	@state public selected: boolean = false

	/**
	 * Whether the button is disabled.
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
			<Root>
				<Image ref={this.refs.image} id="image" />
				<Label ref={this.refs.label} id="label" />
			</Root>
		)
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
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
	 * @method onTouchStart
	 * @since 0.1.0
	 */
	public onTouchStart(event: TouchEvent) {
		if (this.pressed == false && this.disabled == false) {
			this.pressed = true
		}
	}

	/**
	 * @method onTouchEnd
	 * @since 0.1.0
	 */
	public onTouchEnd(event: TouchEvent) {
		if (this.pressed && event.targetTouches.length == 0) {
			this.pressed = false
			this.press(event)
		}
	}

	/**
	 * @method onTouchCancel
	 * @since 0.1.0
	 */
	public onTouchCancel(event: TouchEvent) {
		if (this.pressed && event.targetTouches.length == 0) {
			this.pressed = false
		}
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property refs
	 * @since 0.7.0
	 * @hidden
	 */
	private refs = {
		label: new Reference<Label>(),
		image: new Reference<Image>()
	}

	/**
	 * @method press
	 * @since 0.7.0
	 * @hidden
	 */
	public press(event?: TouchEvent) {

		/*
		TODO
		if (event &&
			event.hits(this) == false) {
			return
		}
		*/

		this.emit('press')

		return this
	}
}