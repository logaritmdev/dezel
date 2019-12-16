import { ref } from '../decorator/ref'
import { state } from '../decorator/state'
import { TouchEvent } from '../event/TouchEvent'
import { Component } from './Component'
import { Image } from './Image'
import { Label } from './Label'
import { Root } from './Root'
import { Touch } from '..'
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
	@ref public label: Label

	/**
	 * The button's image.
	 * @property image
	 * @since 0.1.0
	 */
	@ref public image: Image

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
				<Image ref={this.image} id="image" />
				<Label ref={this.label} id="label" />
			</Root>
		)
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onTouchStart
	 * @since 0.1.0
	 */
	public onTouchStart(event: TouchEvent) {

		if (this.disabled) {
			return
		}

		if (this.tracker == null) {
			this.tracker = event.touches.get(0)
			this.pressed = true
		}
	}

	/**
	 * @inherited
	 * @method onTouchEnd
	 * @since 0.1.0
	 */
	public onTouchEnd(event: TouchEvent) {

		if (this.disabled) {
			return
		}

		for (let touch of event.touches) {
			if (this.tracker == touch) {
				this.tracker = null
				this.pressed = false
				this.touched(touch)
				break
			}
		}
	}

	/**
	 * @inherited
	 * @method onTouchCancel
	 * @since 0.1.0
	 */
	public onTouchCancel(event: TouchEvent) {

		if (this.disabled) {
			return
		}

		for (let touch of event.touches) {
			if (this.tracker == touch) {
				this.tracker = null
				this.pressed = false
				break
			}
		}
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method tracker
	 * @since 0.7.0
	 * @hidden
	 */
	private tracker: Touch | null = null

	/**
	 * @method touched
	 * @since 0.7.0
	 * @hidden
	 */
	private touched(touch: Touch) {

		let target = this.window?.findViewAt(
			touch.x,
			touch.y
		)

		if (target == null) {
			return this
		}

		let inside = this.contains(target)
		if (inside) {
			this.emit('press')
		}

		return this
	}
}