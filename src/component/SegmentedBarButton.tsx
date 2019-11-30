import { state } from '../decorator/state'
import { Event } from '../event/Event'
import { TouchEvent } from '../touch/TouchEvent'
import { Reference } from '../view/Reference'
import { View } from '../view/View'
import { Component } from './Component'
import { Label } from './Label'
import './style/SegmentedBarButton.style'
import './style/SegmentedBarButton.style.android'
import './style/SegmentedBarButton.style.ios'

/**
 * @class SegmentedBarButton
 * @super Component
 * @since 0.1.0
 */
export class SegmentedBarButton extends Component {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property label
	 * @since 0.1.0
	 */
	public get label(): Label {
		return this.refs.label.get()
	}

	/**
	 * @property pressed
	 * @since 0.1.0
	 */
	@state public pressed: boolean = false

	/**
	 * @property selected
	 * @since 0.1.0
	 */
	@state public selected: boolean = false

	/**
	 * @property disabled
	 * @since 0.1.0
	 */
	@state public disabled: boolean = false

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method render
	 * @since 0.3.0
	 */
	public render() {
		return (
			<View>
				<Label ref={this.refs.label} id="label" />
			</View>
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
	protected onTouchStart(event: TouchEvent) {
		if (this.pressed == false && this.disabled == false) {
			this.pressed = true
		}
	}

	/**
	 * @method onTouchEnd
	 * @since 0.1.0
	 */
	protected onTouchEnd(event: TouchEvent) {
		if (this.pressed && event.targetTouches.length == 0) {
			this.pressed = false
			this.press(event)
		}
	}

	/**
	 * @method onTouchCancel
	 * @since 0.1.0
	 */
	protected onTouchCancel(event: TouchEvent) {
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
		label: new Reference<Label>()
	}

	/**
	 * @method press
	 * @since 0.7.0
	 * @hidden
	 */
	private press(event?: TouchEvent) {

		if (event &&
			event.hits(this) == false) {
			return
		}

		this.emit('press')

		return this
	}
}