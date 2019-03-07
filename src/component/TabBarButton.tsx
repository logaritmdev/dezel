import { isObject } from 'lodash'
import { ref } from '../decorator/ref'
import { state } from '../decorator/state'
import { TouchEvent } from '../touch/TouchEvent'
import { Fragment } from '../view/Fragment'
import { TextView } from '../view/TextView'
import { ImageView } from '../view/ImageView'
import { Component } from './Component'

import './TabBarButton.ds'
import './TabBarButton.ds.ios'
import './TabBarButton.ds.android'

/**
 * Displays a pressable element that performs an action in a tab bar.
 * @class TabBarButton
 * @super Component
 * @since 0.1.0
 */
export class TabBarButton extends Component {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The tab bar button image.
	 * @property image
	 * @since 0.1.0
	 */
	@ref public image!: ImageView

	/**
	 * The tab bar button label.
	 * @property label
	 * @since 0.1.0
	 */
	@ref public label!: TextView

	/**
	 * The tab bar badge.
	 * @property badge
	 * @since 0.1.0
	 */
	@ref public badge!: TextView

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
			<Fragment>
				<ImageView id="image" style="image" />
				<TextView id="label" style="label" />
				<TextView id="badge" style="badge" />
			</Fragment>
		)
	}

	/**
	 * @inherited
	 * @method onCreate
	 * @since 0.3.0
	 */
	public onCreate() {
		this.badge.visible = false
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onTouchCancel
	 * @since 0.1.0
	 */
	public onTouchCancel(event: TouchEvent) {

		super.onTouchCancel(event)

		if (this.pressed && event.activeTouches.length == 0) {
			this.pressed = false
		}
	}

	/**
	 * @inherited
	 * @method onTouchStart
	 * @since 0.1.0
	 */
	public onTouchStart(event: TouchEvent) {

		super.onTouchStart(event)

		if (this.pressed === false && this.disabled == false) {
			this.pressed = true
		}
	}

	/**
	 * @inherited
	 * @method onTouchEnd
	 * @since 0.1.0
	 */
	public onTouchEnd(event: TouchEvent) {

		super.onTouchEnd(event)

		if (this.pressed && event.activeTouches.length === 0) {
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