import { state } from '../decorator/state'
import { TouchEvent } from '../event/TouchEvent'
import { View } from '../view/View'
import { Component } from './Component'
import './style/ListItem.style'
import './style/ListItem.style.android'
import './style/ListItem.style.ios'

/**
 * @class ListItem
 * @super Component
 * @since 0.1.0
 */
export abstract class ListItem extends Component {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * Whether the list item is selectable.
	 * @property selectable
	 * @since 0.4.0
	 */
	@state public selectable: boolean = true

	/**
	 * Whether the list item is pressed.
	 * @property pressed
	 * @since 0.1.0
	 */
	@state public pressed: boolean = false

	/**
	 * Whether the list item is selected.
	 * @property selected
	 * @since 0.1.0
	 */
	@state public selected: boolean = false

	/**
	 * Whether the list item is disabled.
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
	 * @since 0.7.0
	 */
	public render() {
		return null
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
		if (this.pressed == false && this.disabled == false && this.selectable) {
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
