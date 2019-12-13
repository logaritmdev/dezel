import { bound } from '../decorator/bound'
import { state } from '../decorator/state'
import { watch } from '../decorator/watch'
import { Event } from '../event/Event'
import { Touch } from '../event/Touch'
import { TouchEvent } from '../event/TouchEvent'
import { Platform } from '../platform/Platform'
import { Reference } from '../view/Reference'
import { View } from '../view/View'
import { Component } from './Component'
import { Root } from './Root'
import { Spinner } from './Spinner'
import './style/Refresher.style'
import './style/Refresher.style.android'
import './style/Refresher.style.ios'

// TODO
// FIXME

/**
 * @class Refresher
 * @super Component
 * @since 0.2.0
 */
export class Refresher extends Component {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property spinner
	 * @since 0.2.0
	 */
	public get spinner(): Spinner {
		return this.refs.spinner.get()
	}

	/**
	 * @property view
	 * @since 0.2.0
	 */
	@watch public view: View | null = null

	/**
	 * @property refreshable
	 * @since 0.2.0
	 */
	@state public refreshable: boolean = false

	/**
	 * @property refreshing
	 * @since 0.2.0
	 */
	@state public refreshing: boolean = false

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method render
	 * @since 0.3.0
	 */
	public render() {
		return (
			<Root>
				<Spinner ref={this.refs.spinner} id="spinner" />
			</Root>
		)
	}

	/**
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

			this.spinner.spin = false

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

				if (Platform.current.name == 'ios') {
					oldView.off('drag', this.onViewDrag)
					oldView.off('dragend', this.onViewDragEnd)
				}

				if (Platform.current.name == 'android') {
					oldView.off('touchstart', this.onViewTouchStart)
					oldView.off('touchmove', this.onViewTouchMove)
					oldView.off('touchend', this.onViewTouchEnd)
				}
			}

			if (newView) {

				if (Platform.current.name == 'ios') {
					newView.on('drag', this.onViewDrag)
					newView.on('dragend', this.onViewDragEnd)
				}

				if (Platform.current.name == 'android') {
					newView.on('touchstart', this.onViewTouchStart)
					newView.on('touchmove', this.onViewTouchMove)
					newView.on('touchend', this.onViewTouchEnd)
				}
			}
		}
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property refs
	 * @since 0.2.0
	 * @hidden
	 */
	private refs = {
		spinner: new Reference<Spinner>()
	}

	/**
	 * @property trackedTouch
	 * @since 0.2.0
	 * @hidden
	 */
	private trackedTouch: Touch | null = null

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

			this.spinner.spin = true
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
		let touch = event.touches.get(0)
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

			let touch = event.touches.get(i)

			if (touch == tracked) {

				let diff = touch.y - (startY - scrollT)
				if (diff > this.measuredHeight) {
					diff = this.measuredHeight
				}

				this.translationY = diff

				if (diff < this.measuredHeight) {
					continue
				}

				this.spinner.spin = true
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

			let touch = event.touches.get(i)

			if (touch == tracked) {

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
