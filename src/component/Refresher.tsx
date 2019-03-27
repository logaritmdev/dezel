import { bound } from '../decorator/bound'
import { ref } from '../decorator/ref'
import { state } from '../decorator/state'
import { watch } from '../decorator/watch'
import { Event } from '../event/Event'
import { Touch } from '../touch/Touch'
import { TouchEvent } from '../touch/TouchEvent'
import { Fragment } from '../view/Fragment'
import { SpinnerView } from '../view/SpinnerView'
import { View } from '../view/View'
import { Component } from './Component'
import './Refresher.ds.android'
import './Refresher.ds.ios'
import './Refresher.ds'


/**
 * Displays a refresh indicator within a scrollable element.
 * @class Refresher
 * @super Component
 * @since 0.2.0
 */
export class Refresher extends Component {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The refresher's spinner.
	 * @property spinner
	 * @since 0.2.0
	 */
	@ref public spinner!: SpinnerView

	/**
	 * The view that contains the refresh indicator.
	 * @property view
	 * @since 0.2.0
	 */
	@watch public view?: View | null = null

	/**
	 * Whether the can be refreshed.
	 * @property refreshable
	 * @since 0.2.0
	 */
	@state public refreshable: boolean = false

	/**
	 * Whether the indicator is refreshing.
	 * @property refreshing
	 * @since 0.2.0
	 */
	@state public refreshing: boolean = false

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
				<SpinnerView id="spinner" style="spinner" />
			</Fragment>
		)
	}

	/**
	 * Indicates to the indicator that refreshing is completed.
	 * @method done
	 * @since 0.2.0
	 */
	public done() {

		if (this.view == null) {
			return
		}

		return View.transition(() => {

			this.translationY = 0
			this.translationX = 0
			this.view!.contentInsetTop = 0

		}).then(() => {

			this.spinner.active = false

		}).then(() => {

			this.refreshing = false

		})
	}

	/**
	 * @method onPropertyChange
	 * @since 0.4.0
	 * @hidden
	 */
	public onPropertyChange(property: string, newValue: any, oldValue: any) {

		if (property == 'view') {

			let newView = newValue as View
			let oldView = oldValue as View

			if (oldView) {

				if (platform.name == 'ios') {
					oldView.off('drag', this.onViewDrag)
					oldView.off('dragend', this.onViewDragEnd)
				}

				if (platform.name == 'android') {
					oldView.off('touchstart', this.onViewTouchStart)
					oldView.off('touchmove', this.onViewTouchMove)
					oldView.off('touchend', this.onViewTouchEnd)
				}
			}

			if (newView) {

				if (platform.name == 'ios') {
					newView.on('drag', this.onViewDrag)
					newView.on('dragend', this.onViewDragEnd)
				}

				if (platform.name == 'android') {
					newView.on('touchstart', this.onViewTouchStart)
					newView.on('touchmove', this.onViewTouchMove)
					newView.on('touchend', this.onViewTouchEnd)
				}
			}

			return
		}

		super.onPropertyChange(property, newValue, oldValue)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property trackedTouch
	 * @since 0.2.0
	 * @hidden
	 */
	private trackedTouch?: Touch | null

	/**
	 * @property trackedTouchStartX
	 * @since 0.2.0
	 * @hidden
	 */
	private trackedTouchStartX: number = 0

	/**
	 * @property trackedTouchStartY
	 * @since 0.2.0
	 * @hidden
	 */
	private trackedTouchStartY: number = 0

	/* iOS Specific */

	/**
	 * @method onViewDrag
	 * @since 0.2.0
	 * @hidden
	 */
	@bound private onViewDrag(event: Event) {

		if (this.view == null || this.refreshing) {
			return
		}

		let threshold = this.measuredHeight
		if (threshold == null) {
			return
		}

		threshold = -threshold

		let scroll = this.view.scrollTop
		if (scroll > threshold) {

			if (this.refreshable) {
				this.refreshable = false
			}

		} else {

			if (this.refreshable == false) {
				this.refreshable = true
			}

		}
	}

	/**
	 * @method onViewDragEnd
	 * @since 0.2.0
	 * @hidden
	 */
	@bound private onViewDragEnd(event: Event) {

		if (this.view == null || this.refreshing) {
			return
		}

		if (this.refreshable) {
			this.refreshable = false

			this.spinner.active = true
			this.view.contentInsetTop = this.measuredHeight
			this.emit('refresh')

			this.refreshing = true
		}
	}

	/* Android Specific */

	/**
	 * @method onViewTouchStart
	 * @since 0.2.0
	 * @hidden
	 */
	@bound private onViewTouchStart(event: TouchEvent) {
		let touch = event.touches.item(0)
		this.trackedTouch = touch
		this.trackedTouchStartX = touch.x
		this.trackedTouchStartY = touch.y
	}

	/**
	 * @method onViewTouchMove
	 * @since 0.2.0
	 * @hidden
	 */
	@bound private onViewTouchMove(event: TouchEvent) {

		let tracked = this.trackedTouch
		if (tracked == null) {
			return
		}

		let scrollT = this.scrollTop
		if (scrollT > 0) {
			return
		}

		let startX = this.trackedTouchStartX
		let startY = this.trackedTouchStartY

		for (let i = 0; i < event.touches.length; i++) {

			let touch = event.touches.item(i)

			if (touch.identifier == tracked.identifier) {

				let diff = touch.y - (startY - scrollT)
				if (diff > this.measuredHeight) {
					diff = this.measuredHeight
				}

				this.translationY = diff

				if (diff < this.measuredHeight) {
					continue
				}

				this.spinner.active = true
			}
		}
	}

	/**
	 * @method onViewTouchEnd
	 * @since 0.2.0
	 * @hidden
	 */
	@bound private onViewTouchEnd(event: TouchEvent) {

		let tracked = this.trackedTouch
		if (tracked == null) {
			return
		}

		let scrollT = this.scrollTop
		if (scrollT > 0) {
			return
		}

		let startX = this.trackedTouchStartX
		let startY = this.trackedTouchStartY

		for (let i = 0; i < event.touches.length; i++) {

			let touch = event.touches.item(i)

			if (touch.identifier == tracked.identifier) {

				this.trackedTouch = null
				this.trackedTouchStartX = 0
				this.trackedTouchStartY = 0

				let diff = touch.y - (startY - scrollT)
				if (diff > this.measuredHeight) {
					diff = this.measuredHeight
				}

				if (diff < this.measuredHeight) {

					View.transition(() => {
						this.translationY = 0
						this.translationX = 0
					})

					continue
				}

				this.emit('refresh')
			}
		}
	}
}
