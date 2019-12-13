import { state } from '../decorator/state'
import { Image } from '../component/Image'
import { Label } from '../component/Label'
import { TouchEvent } from '../event/TouchEvent'
import { Reference } from '../view/Reference'
import { View } from '../view/View'
import { Component } from './Component'
import { Root } from './Root'
import './style/TabBarButton.style'
import './style/TabBarButton.style.android'
import './style/TabBarButton.style.ios'

/**
 * @class TabBarButton
 * @super Component
 * @since 0.1.0
 */
export class TabBarButton extends Component {

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
	 * The button's badge.
	 * @property badge
	 * @since 0.1.0
	 */
	public get badge(): Label {
		return this.refs.badge.get()
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
				<Label ref={this.refs.badge} id="badge" visible={false} />
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
		if (this.pressed == false && this.disabled == false) {
			this.pressed = true
		}
	}

	/**
	 * @inherited
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
	 * @inherited
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
		image: new Reference<Image>(),
		badge: new Reference<Label>(),
		label: new Reference<Label>()
	}

	/**
	 * @method press
	 * @since 0.7.0
	 * @hidden
	 */
	private press(event?: TouchEvent) {

		/*
		TODO
		if (event &&
			event.hits(this) == false) {
			return
		}
		*/

		this.emit('press')
	}
}