import { bridge } from '../decorator/bridge'
import { native } from '../decorator/native'
import { Emitter } from '../event/Emitter'
import { Event } from '../event/Event'
import { EventListener } from '../event/Event'
import { Gesture } from '../gesture/Gesture'
import { GestureRegistry } from '../gesture/Gesture'
import { Canvas } from '../graphic/Canvas'
import { Image } from '../graphic/Image'
import { TouchEvent } from '../touch/TouchEvent'
import { Reference } from '../util/Reference'
import './View.ds'
import './Window.ds'

/**
 * @symbol BUILT
 * @since 0.5.0
 */
export const BUILT = Symbol('built')

/**
 * @symbol READY
 * @since 0.5.0
 */
export const READY = Symbol('ready')

/**
 * @symbol WINDOW
 * @since 0.1.0
 */
export const WINDOW = Symbol('window')

/**
 * @symbol PARENT
 * @since 0.1.0
 */
export const PARENT = Symbol('parent')

/**
 * @symbol CHILDREN
 * @since 0.1.0
 */
export const CHILDREN = Symbol('children')

/**
 * @symbol STYLES
 * @since 0.3.0
 */
export const STYLES = Symbol('styles')

/**
 * @symbol STATES
 * @since 0.3.0
 */
export const STATES = Symbol('states')

/**
 * @symbol GESTURES
 * @since 0.4.0
 */
export const GESTURES = Symbol('gestures')

/**
 * @const DEFAULT_DURATION
 * @since 0.4.0
 */
export const DEFAULT_DURATION = 350

/**
 * @const DEFAULT_EQUATION
 * @since 0.4.0
 */
export const DEFAULT_EQUATION = [0.25, 0.1, 0.25, 1.0]

/**
 * View animations options.
 * @interface ViewTransitionOptions
 * @since 0.1.0
 */
export interface ViewTransitionOptions {
	equation?: string | Array<number>
	duration?: string | number
	delay?: number
}

@bridge('dezel.view.View')

/**
 * Displays a rectangular element drawn onto the screen.
 * @class View
 * @super Emitter
 * @since 0.1.0
 */
export class View extends Emitter {

	//--------------------------------------------------------------------------
	// Static Methods
	//--------------------------------------------------------------------------

	/**
	 * Creates a transition for all properties and view updated in the callback.
	 * @method transition
	 * @since 0.1.0
	 */
	public static transition(animate: Function): Promise<void>
	public static transition(options: ViewTransitionOptions, animate: Function): Promise<void>
	public static transition(...args: Array<any>): Promise<void> {

		let animate: Function
		let options: ViewTransitionOptions = {
			duration: DEFAULT_DURATION,
			equation: DEFAULT_EQUATION,
			delay: 0
		}

		switch (args.length) {

			case 1:
				animate = args[0]
				break

			case 2:
				animate = args[1]
				options = args[0]
				break

		}

		let duration = DEFAULT_DURATION
		let equation = DEFAULT_EQUATION
		let delay = options.delay || 0

		if (typeof options.duration == 'string') {

			let value = AnimationDurationRegistry.get(options.duration)
			if (value) {
				duration = value
			} else {
				duration = DEFAULT_DURATION
			}

		} else {
			duration = options.duration || DEFAULT_DURATION
		}

		if (typeof options.equation == 'string') {

			let value = AnimationEquationRegistry.get(options.equation)
			if (value) {

				equation = value

			} else {

				let values = options.equation.replace(/\s+/g, '').match(/cubic-bezier\(([-.\d]+),([-.\d]+),([-.\d]+),([-.\d]+)\)/)
				if (values) {
					equation = [
						+values[1],
						+values[2],
						+values[3],
						+values[4]
					]

				} else {

					equation = DEFAULT_EQUATION

				}
			}
		}

		return new Promise(success => {
			dezel.transition(
				duration,
				equation[0],
				equation[1],
				equation[2],
				equation[3],
				delay,
				success,
				animate
			)
		})
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The view's window.
	 * @property window
	 * @since 0.1.0
	 */
	public get window(): Window | undefined {
		return this.native.window
	}

	/**
	 * The view's parent view.
	 * @property parent
	 * @since 0.1.0
	 */
	public get parent(): View | undefined {
		return this.native.parent
	}

	/**
	 * The view's children.
	 * @property children
	 * @since 0.1.0
	 */
	public get children(): Array<View> {
		return this[CHILDREN]
	}

	/**
	 * The view's identifier.
	 * @property id
	 * @since 0.1.0
	 */
	@native public id!: string

	/**
	 * The view's top position relative to its parent.
	 * @property top
	 * @since 0.1.0
	 */
	@native public top!: number | string

	/**
	 * The view's left position relative to its parent.
	 * @property left
	 * @since 0.1.0
	 */
	@native public left!: number | string

	/**
	 * The view's right position relative to its parent.
	 * @property right
	 * @since 0.1.0
	 */
	@native public right!: number | string

	/**
	 * The view's bottom position relative to its parent.
	 * @property bottom
	 * @since 0.1.0
	 */
	@native public bottom!: number | string

	/**
	 * The view's minimum top position relative to its parent.
	 * @property minTop
	 * @since 0.1.0
	 */
	@native public minTop!: number

	/**
	 * The view's maximum top position relative to its parent.
	 * @property maxTop
	 * @since 0.1.0
	 */
	@native public maxTop!: number

	/**
	 * The view's minimum left position relative to its parent.
	 * @property minLeft
	 * @since 0.1.0
	 */
	@native public minLeft!: number

	/**
	 * The view's maximum left position relative to its parent.
	 * @property maxLeft
	 * @since 0.1.0
	 */
	@native public maxLeft!: number

	/**
	 * The view's minimum right position relative to its parent.
	 * @property minRight
	 * @since 0.1.0
	 */
	@native public minRight!: number

	/**
	 * The view's maximum right position relative to its parent.
	 * @property maxRight
	 * @since 0.1.0
	 */
	@native public maxRight!: number

	/**
	 * The view's minimum bottom position relative to its parent.
	 * @property minBottom
	 * @since 0.1.0
	 */
	@native public minBottom!: number

	/**
	 * The view's maximum bottom position relative to its parent.
	 * @property maxBottom
	 * @since 0.1.0
	 */
	@native public maxBottom!: number

	/**
	 * The view's vertical point from which it will be positioned.
	 * @property anchorTop
	 * @since 0.1.0
	 */
	@native public anchorTop!: 'top' | 'center' | 'bottom' | number | string

	/**
	 * The view's horizontal point from which it will be positioned.
	 * @property anchorLeft
	 * @since 0.1.0
	 */
	@native public anchorLeft!: 'left' | 'center' | 'right' | number | string

	/**
	 * The view's width.
	 * @property width
	 * @since 0.1.0
	 */
	@native public width!: number | string | 'fill' | 'wrap'

	/**
	 * The view's height.
	 * @property height
	 * @since 0.1.0
	 */
	@native public height!: number | string | 'fill' | 'wrap'

	/**
	 * The view's minimum width.
	 * @property minWidth
	 * @since 0.1.0
	 */
	@native public minWidth!: number

	/**
	 * The view's maximum width.
	 * @property maxWidth
	 * @since 0.1.0
	 */
	@native public maxWidth!: number

	/**
	 * The view's minimum height.
	 * @property minHeight
	 * @since 0.1.0
	 */
	@native public minHeight!: number

	/**
	 * The view's maximum height.
	 * @property maxHeight
	 * @since 0.1.0
	 */
	@native public maxHeight!: number

	/**
	 * The view's top offset to layout its children.
	 * @property contentTop
	 * @since 0.1.0
	 */
	@native public contentTop!: number

	/**
	 * The view's left offset to layout its children.
	 * @property contentLeft
	 * @since 0.1.0
	 */
	@native public contentLeft!: number

	/**
	 * The view's horizontal size used to layout its children.
	 * @property contentWidth
	 * @since 0.1.0
	 */
	@native public contentWidth!: number | string | 'auto'

	/**
	 * The view's vertical size used to layout its children.
	 * @property contentHeight
	 * @since 0.1.0
	 */
	@native public contentHeight!: number | string | 'auto'

	/**
	 * The view's content top inset.
	 * @property contentInsetTop
	 * @since 0.1.0
	 */
	@native public contentInsetTop!: number

	/**
	 * The view's content left inset.
	 * @property contentInsetLeft
	 * @since 0.1.0
	 */
	@native public contentInsetLeft!: number

	/**
	 * The view's content right offset.
	 * @property contentInsetRight
	 * @since 0.1.0
	 */
	@native public contentInsetRight!: number

	/**
	 * The view's content bottom offset.
	 * @property contentInsetBottom
	 * @since 0.1.0
	 */
	@native public contentInsetBottom!: number

	/**
	 * The view's natural layout direction.
	 * @property contentOrientation
	 * @since 0.1.0
	 */
	@native public contentOrientation!: 'vertical' | 'horizontal'

	/**
	 * The view's content horizontal alignment.
	 * @property contentDisposition
	 * @since 0.1.0
	 */
	@native public contentDisposition!: 'start' | 'center' | 'end' | 'space-around' | 'space-between' | 'space-evenly'

	/**
	 * The view's content vertical alignment.
	 * @property contentArrangement
	 * @since 0.1.0
	 */
	@native public contentArrangement!: 'start' | 'center' | 'end'

	/**
	 * The view's margin.
	 * @property margin
	 * @since 0.2.0
	 */
	@native public margin!: any

	/**
	 * The view's top margin.
	 * @property marginTop
	 * @since 0.1.0
	 */
	@native public marginTop!: number

	/**
	 * The view's left margin.
	 * @property marginLeft
	 * @since 0.1.0
	 */
	@native public marginLeft!: number

	/**
	 * The view's right margin.
	 * @property marginRight
	 * @since 0.1.0
	 */
	@native public marginRight!: number

	/**
	 * The view's bottom margin.
	 * @property marginBottom
	 * @since 0.1.0
	 */
	@native public marginBottom!: number

	/**
	 * The view's minimum top margin.
	 * @property minMarginTop
	 * @since 0.1.0
	 */
	@native public minMarginTop!: number

	/**
	 * The view's maximum top margin.
	 * @property maxMarginTop
	 * @since 0.1.0
	 */
	@native public maxMarginTop!: number

	/**
	 * The view's minimum left margin.
	 * @property minMarginLeft
	 * @since 0.1.0
	 */
	@native public minMarginLeft!: number

	/**
	 * The view's maximum left margin.
	 * @property maxMarginLeft
	 * @since 0.1.0
	 */
	@native public maxMarginLeft!: number

	/**
	 * The view's minimum right margin.
	 * @property minMarginRight
	 * @since 0.1.0
	 */
	@native public minMarginRight!: number

	/**
	 * The view's maximum right margin.
	 * @property maxMarginRight
	 * @since 0.1.0
	 */
	@native public maxMarginRight!: number

	/**
	 * The view's minimum bottom margin.
	 * @property minMarginBottom
	 * @since 0.1.0
	 */
	@native public minMarginBottom!: number

	/**
	 * The view's maximum bottom margin.
	 * @property maxMarginBottom
	 * @since 0.1.0
	 */
	@native public maxMarginBottom!: number

	/**
	 * The view's border.
	 * @property border
	 * @since 0.2.0
	 */
	@native public border!: any

	/**
	 * The view's top border.
	 * @property borderTop
	 * @since 0.4.0
	 */
	@native public borderTop!: any

	/**
	 * The view's left border.
	 * @property borderLeft
	 * @since 0.4.0
	 */
	@native public borderLeft!: any

	/**
	 * The view's right border.
	 * @property borderRight
	 * @since 0.4.0
	 */
	@native public borderRight!: any

	/**
	 * The view's bottom border.
	 * @property borderBottom
	 * @since 0.4.0
	 */
	@native public borderBottom!: any

	/**
	 * The view's border width.
	 * @property borderWidth
	 * @since 0.2.0
	 */
	@native public borderWidth!: any

	/**
	 * The view's border color.
	 * @property borderColor
	 * @since 0.2.0
	 */
	@native public borderColor!: any

	/**
	 * The view's top border color.
	 * @property borderTopColor
	 * @since 0.1.0
	 */
	@native public borderTopColor!: string

	/**
	 * The view's left border color.
	 * @property borderLeftColor
	 * @since 0.1.0
	 */
	@native public borderLeftColor!: string

	/**
	 * The view's right border color.
	 * @property borderRightColor
	 * @since 0.1.0
	 */
	@native public borderRightColor!: string

	/**
	 * The view's bottom border color.
	 * @property borderBottomColor
	 * @since 0.1.0
	 */
	@native public borderBottomColor!: string

	/**
	 * The view's top border width.
	 * @property borderTopWidth
	 * @since 0.1.0
	 */
	@native public borderTopWidth!: number | string

	/**
	 * The view's left border width.
	 * @property borderLeftWidth
	 * @since 0.1.0
	 */
	@native public borderLeftWidth!: number | string

	/**
	 * The view's right border width.
	 * @property borderRightWidth
	 * @since 0.1.0
	 */
	@native public borderRightWidth!: number | string

	/**
	 * The view's bottom border width.
	 * @property borderBottomWidth
	 * @since 0.1.0
	 */
	@native public borderBottomWidth!: number | string

	/**
	 * The view's minimum top border width.
	 * @property minBorderTopWidth
	 * @since 0.1.0
	 */
	@native public minBorderTopWidth!: number

	/**
	 * The view's maximum top border width.
	 * @property maxBorderTopWidth
	 * @since 0.1.0
	 */
	@native public maxBorderTopWidth!: number

	/**
	 * The view's minimum left border width.
	 * @property minBorderLeftWidth
	 * @since 0.1.0
	 */
	@native public minBorderLeftWidth!: number

	/**
	 * The view's maximum left border width.
	 * @property maxBorderLeftWidth
	 * @since 0.1.0
	 */
	@native public maxBorderLeftWidth!: number

	/**
	 * The view's minimum right border width.
	 * @property minBorderRightWidth
	 * @since 0.1.0
	 */
	@native public minBorderRightWidth!: number

	/**
	 * The view's maximum right border width.
	 * @property maxBorderRightWidth
	 * @since 0.1.0
	 */
	@native public maxBorderRightWidth!: number

	/**
	 * The view's minimum bottom border width.
	 * @property minBorderBottomWidth
	 * @since 0.1.0
	 */
	@native public minBorderBottomWidth!: number

	/**
	 * The view's maximum bottom border width.
	 * @property maxBorderBottomWidth
	 * @since 0.1.0
	 */
	@native public maxBorderBottomWidth!: number

	/**
	 * The view's border radius.
	 * @property borderRadius
	 * @since 0.2.0
	 */
	@native public borderRadius!: any

	/**
	 * The view's top left border radius.
	 * @property borderTopLeftRadius
	 * @since 0.1.0
	 */
	@native public borderTopLeftRadius!: number

	/**
	 * The view's top right border radius.
	 * @property borderTopRightRadius
	 * @since 0.1.0
	 */
	@native public borderTopRightRadius!: number

	/**
	 * The view's bottom left border radius.
	 * @property borderBottomLeftRadius
	 * @since 0.1.0
	 */
	@native public borderBottomLeftRadius!: number

	/**
	 * The view's bottom right border radius.
	 * @property borderBottomRightRadius
	 * @since 0.1.0
	 */
	@native public borderBottomRightRadius!: number

	/**
	 * The view's padding.
	 * @property padding
	 * @since 0.2.0
	 */
	@native public padding!: any

	/**
	 * The view's top padding.
	 * @property paddingTop
	 * @since 0.1.0
	 */
	@native public paddingTop!: number

	/**
	 * The view's left padding.
	 * @property paddingLeft
	 * @since 0.1.0
	 */
	@native public paddingLeft!: number

	/**
	 * The view's right padding.
	 * @property paddingRight
	 * @since 0.1.0
	 */
	@native public paddingRight!: number

	/**
	 * The view's bottom padding.
	 * @property paddingBottom
	 * @since 0.1.0
	 */
	@native public paddingBottom!: number

	/**
	 * The view's minimum top padding.
	 * @property minPaddingTop
	 * @since 0.1.0
	 */
	@native public minPaddingTop!: number

	/**
	 * The view's maximum top padding.
	 * @property maxPaddingTop
	 * @since 0.1.0
	 */
	@native public maxPaddingTop!: number

	/**
	 * The view's minimum left padding.
	 * @property minPaddingLeft
	 * @since 0.1.0
	 */
	@native public minPaddingLeft!: number

	/**
	 * The view's maximum left padding.
	 * @property maxPaddingLeft
	 * @since 0.1.0
	 */
	@native public maxPaddingLeft!: number

	/**
	 * The view's minimum right padding.
	 * @property minPaddingRight
	 * @since 0.1.0
	 */
	@native public minPaddingRight!: number

	/**
	 * The view's maximum right padding.
	 * @property maxPaddingRight
	 * @since 0.1.0
	 */
	@native public maxPaddingRight!: number

	/**
	 * The view's minimum bottom padding.
	 * @property minPaddingBottom
	 * @since 0.1.0
	 */
	@native public minPaddingBottom!: number

	/**
	 * The view's maximum bottom padding.
	 * @property maxPaddingBottom
	 * @since 0.1.0
	 */
	@native public maxPaddingBottom!: number

	/**
	 * Determine how much this view can expand to fill the remaining space.
	 * @property expand
	 * @since 0.1.0
	 */
	@native public expand!: number

	/**
	 * Determine how much this view can shrink to fit the original space.
	 * @property shrink
	 * @since 0.1.0
	 */
	@native public shrink!: number

	/**
	 * The view's background color.
	 * @property backgroundColor
	 * @since 0.1.0
	 */
	@native public backgroundColor!: string

	/**
	 * The view's background image.
	 * @property backgroundImage
	 * @since 0.1.0
	 */
	@native public backgroundImage?: Image | string | null

	/**
	 * The view's background image container fitting.
	 * @property backgroundImageFit
	 * @since 0.4.0
	 */
	@native public backgroundImageFit!: 'fit' | 'fill' | 'none'

	/**
	 * The view's background image vertical point from which it will be positioned.
	 * @property backgroundImageAnchorTop
	 * @since 0.1.0
	 */
	@native public backgroundImageAnchorTop!: 'top' | 'center' | 'bottom' | number | string

	/**
	 * The view's background image horizontal point from which it will be positioned.
	 * @property backgroundImageAnchorLeft
	 * @since 0.1.0
	 */
	@native public backgroundImageAnchorLeft!: 'left' | 'center' | 'right' | number | string

	/**
	 * The view's background image top position.
	 * @property backgroundImageTop
	 * @since 0.1.0
	 */
	@native public backgroundImageTop!: number

	/**
	 * The view's background image left position.
	 * @property backgroundImageLeft
	 * @since 0.1.0
	 */
	@native public backgroundImageLeft!: number

	/**
	 * The view's background image width;
	 * @property backgroundImageWidth
	 * @since 0.1.0
	 */
	@native public backgroundImageWidth!: 'auto' | number

	/**
	 * The view's background image height.
	 * @property backgroundImageHeight
	 * @since 0.1.0
	 */
	@native public backgroundImageHeight!: 'auto' | number

	/**
	 * The view's shadow blur distance.
	 * @property shadowBlur
	 * @since 0.1.0
	 */
	@native public shadowBlur!: number

	/**
	 * The view's shadow color.
	 * @property shadowColor
	 * @since 0.1.0
	 */
	@native public shadowColor!: string

	/**
	 * The view's shadow vertical offset.
	 * @property shadowOffsetTop
	 * @since 0.1.0
	 */
	@native public shadowOffsetTop!: number

	/**
	 * The view's shadow vertical offset.
	 * @property shadowOffsetLeft
	 * @since 0.1.0
	 */
	@native public shadowOffsetLeft!: number

	/**
	 * Determines whether the view can scroll.
	 * @property scrollable
	 * @since 0.1.0
	 */
	@native public scrollable!: boolean

	/**
	 * The view's scrollbars mode.
	 * @property scrollbars
	 * @since 0.1.0
	 */
	@native public scrollbars!: boolean | 'none' | 'both' | 'vertical' | 'horizontal'

	/**
	 * Determines whether the view can overscroll.
	 * @property overscroll
	 * @since 0.1.0
	 */
	@native public overscroll!: boolean | 'never' | 'always' | 'always-x' | 'always-y'

	/**
	 * Determines whether the view content has momentum when scrolling.
	 * @property momentum
	 * @since 0.1.0
	 */
	@native public momentum!: boolean

	/**
	 * The view's scroll on the vertical axis.
	 * @property scrollTop
	 * @since 0.1.0
	 */
	@native public scrollTop!: number

	/**
	 * The view's scroll on the horizontal axis.
	 * @property scrollLeft
	 * @since 0.1.0
	 */
	@native public scrollLeft!: number

	/**
	 * Whether the view snaps to pages.
	 * @property paged
	 * @since 0.4.0
	 */
	@native public paged!: boolean

	/**
	 * The view's content clipping status.
	 * @property clipped
	 * @since 0.1.0
	 */
	@native public clipped!: boolean

	/**
	 * Determines whether the view is visible.
	 * @property visible
	 * @since 0.1.0
	 */
	@native public visible!: boolean

	/**
	 * The view's opacity.
	 * @property opacity
	 * @since 0.1.0
	 */
	@native public opacity!: number

	/**
	 * The view's horizontal origin for all transformations.
	 * @property originX
	 * @since 0.1.0
	 */
	@native public originX!: number

	/**
	 * The view's vertical origin for all transformations.
	 * @property originY
	 * @since 0.1.0
	 */
	@native public originY!: number

	/**
	 * The view's vertical origin for all transformations.
	 * @property originZ
	 * @since 0.1.0
	 */
	@native public originZ!: number

	/**
	 * The view's translation on the x axis.
	 * @property translationX
	 * @since 0.1.0
	 */
	@native public translationX!: number | string

	/**
	 * The view's translation on the y axis.
	 * @property translationY
	 * @since 0.1.0
	 */
	@native public translationY!: number | string

	/**
	 * The view's translation on the z axis.
	 * @property translationZ
	 * @since 0.1.0
	 */
	@native public translationZ!: number

	/**
	 * The view's on the x axis.
	 * @property rotationX
	 * @since 0.1.0
	 */
	@native public rotationX!: number | string

	/**
	 * The view's rotation on the y axis.
	 * @property rotationY
	 * @since 0.1.0
	 */
	@native public rotationY!: number | string

	/**
	 * The view's rotation on the z axis.
	 * @property rotationZ
	 * @since 0.1.0
	 */
	@native public rotationZ!: number | string

	/**
	 * The view's scale on the x axis.
	 * @property scaleX
	 * @since 0.1.0
	 */
	@native public scaleX!: number

	/**
	 * The view's translation on the y axis.
	 * @property scaleY
	 * @since 0.1.0
	 */
	@native public scaleY!: number

	/**
	 * The view's translation on the z axis.
	 * @property scaleZ
	 * @since 0.1.0
	 */
	@native public scaleZ!: number

	/**
	 * The view's z position relatived to its siblings.
	 * @property zIndex
	 * @since 0.1.0
	 */
	@native public zIndex!: number

	/**
	 * Whether touch interactions are enabled for this view.
	 * @property touchable
	 * @since 0.1.0
	 */
	@native public touchable!: boolean

	/**
	 * The top offset for this view touchable area.
	 * @property touchOffsetTop
	 * @since 0.1.0
	 */
	@native public touchOffsetTop!: number

	/**
	 * The left offset for this view touchable area.
	 * @property touchOffsetLeft
	 * @since 0.1.0
	 */
	@native public touchOffsetLeft!: number

	/**
	 * The right offset for this view touchable area.
	 * @property touchOffsetRight
	 * @since 0.1.0
	 */
	@native public touchOffsetRight!: number

	/**
	 * The bottom offset for this view touchable area.
	 * @property touchOffsetBottom
	 * @since 0.1.0
	 */
	@native public touchOffsetBottom!: number

	/**
	 * Whether the view is zoomable.
	 * @property zoomable
	 * @since 0.3.0
	 */
	@native public zoomable!: boolean

	/**
	 * The view's minimum zoom.
	 * @property minZoom
	 * @since 0.3.0
	 */
	@native public minZoom!: number

	/**
	 * The view's maximum zoom.
	 * @property maxZoom
	 * @since 0.3.0
	 */
	@native public maxZoom!: number

	/**
	 * The view that is being zoomed.
	 * @property zoomedView
	 * @since 0.3.0
	 */
	@native public zoomedView?: View | null

	/**
	 * Wether the view is scrolling.
	 * @property scrolling
	 * @since 0.1.0
	 */
	@native public scrolling!: boolean

	/**
	 * Wether the view is dragging.
	 * @property dragging
	 * @since 0.1.0
	 */
	@native public dragging!: boolean

	/**
	 * The view's top position once it's been measured.
	 * @property measuredTop
	 * @since 0.1.0
	 */
	public get measuredTop(): number {
		return this.native.measuredTop
	}

	/**
	 * The view's left position once it's been measured.
	 * @property measuredLeft
	 * @since 0.1.0
	 */
	public get measuredLeft(): number {
		return this.native.measuredLeft
	}

	/**
	 * The view's width once it's been measured.
	 * @property measuredWidth
	 * @since 0.1.0
	 */
	public get measuredWidth(): number {
		return this.native.measuredWidth
	}

	/**
	 * The view's height once it's been measured.
	 * @property measuredHeight
	 * @since 0.1.0
	 */
	public get measuredHeight(): number {
		return this.native.measuredHeight
	}

	/**
	 * The width of the view minus its borders and padding.
	 * @property measuredInnerWidth
	 * @since 0.1.0
	 */
	public get measuredInnerWidth(): number {
		return this.native.measuredInnerWidth
	}

	/**
	 * The height of the view minus its borders and padding.
	 * @property measuredInnerHeight
	 * @since 0.1.0
	 */
	public get measuredInnerHeight(): number {
		return this.native.measuredInnerHeight
	}

	/**
	 * The view's content width used to layout its children once it's been measured.
	 * @property measuredContentWidth
	 * @since 0.1.0
	 */
	public get measuredContentWidth(): number {
		return this.native.measuredContentWidth
	}

	/**
	 * The view's content height used to layout its children once it's been measured.
	 * @property measuredContentHeight
	 * @since 0.1.0
	 */
	public get measuredContentHeight(): number {
		return this.native.measuredContentHeight
	}

	/**
	 * The view's measured margin top.
	 * @property measuredMarginTop
	 * @since 0.1.0
	 */
	public get measuredMarginTop(): number {
		return this.native.measuredMarginTop
	}

	/**
	 * The view's measured margin left.
	 * @property measuredMarginLeft
	 * @since 0.1.0
	 */
	public get measuredMarginLeft(): number {
		return this.native.measuredMarginLeft
	}

	/**
	 * The view's measured margin right.
	 * @property measuredMarginRight
	 * @since 0.1.0
	 */
	public get measuredMarginRight(): number {
		return this.native.measuredMarginRight
	}

	/**
	 * The view's measured margin bottom.
	 * @property measuredMarginBottom
	 * @since 0.1.0
	 */
	public get measuredMarginBottom(): number {
		return this.native.measuredMarginBottom
	}

	/**
	 * The view's measured padding top.
	 * @property measuredPaddingTop
	 * @since 0.1.0
	 */
	public get measuredPaddingTop(): number {
		return this.native.measuredPaddingTop
	}

	/**
	 * The view's measured padding left.
	 * @property measuredPaddingLeft
	 * @since 0.1.0
	 */
	public get measuredPaddingLeft(): number {
		return this.native.measuredPaddingLeft
	}

	/**
	 * The view's measured padding right.
	 * @property measuredPaddingRight
	 * @since 0.1.0
	 */
	public get measuredPaddingRight(): number {
		return this.native.measuredPaddingRight
	}

	/**
	 * The view's measured padding bottom.
	 * @property measuredPaddingBottom
	 * @since 0.1.0
	 */
	public get measuredPaddingBottom(): number {
		return this.native.measuredPaddingBottom
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes this view.
	 * @constructor
	 * @since 0.1.0
	 */
	constructor() {
		super()
		let classList = getClassList(this)
		let classRefs = getClassRefs(this)
		if (classList) this.native.classList = classList
		if (classRefs) this.native.classRefs = classRefs
	}

	/**
	 * Releases the objects associated to this view.
	 * @method destroy
	 * @since 0.1.0
	 */
	public destroy() {

		this.onDestroy()

		// TODO
		// This could be done on native?
		let children = this.children
		if (children.length) {
			children.slice(0).forEach(view => view.destroy())
		}

		this.removeFromParent()

		this.native.destroy()

		this[STYLES] = []
		this[STATES] = []
		this[CHILDREN] = []
		this[GESTURES].clear()

		super.destroy()
	}

	/**
	 * Makes this view a shadow root.
	 * @method createShadowRoot
	 * @since 0.1.0
	 */
	public createShadowRoot() {
		this.native.createShadowRoot()
		return this
	}

	//--------------------------------------------------------------------------
	// Methods: Lifecycle
	//--------------------------------------------------------------------------

	/**
	 * Called when the view is in valid hierarchy.
	 * @method onReady
	 * @since 0.5.0
	 */
	public onReady() {

	}

	/**
	 * Called when the view is destroyed.
	 * @method onDestroy
	 * @since 0.4.0
	 */
	public onDestroy() {

	}

	//--------------------------------------------------------------------------
	// Methods: View hierarchy
	//--------------------------------------------------------------------------

	/**
	 * Adds a child view at the end of this view's child list.
	 * @method append
	 * @since 0.1.0
	 */
	public append(view: Node) {
		return this.insert(view, this.children.length)
	}

	/**
	 * Adds a child view at an index of this view's child list.
	 * @method insert
	 * @since 0.1.0
	 */
	public insert(view: Node, index: number) {

		if (view instanceof Component) {
			view.build()
		}

		if (view instanceof Fragment) {
			view.inject(this, index)
			return this
		}

		if (view.parent) {
			view.removeFromParent()
		}

		view.setResponder(this)

		if (index > this.children.length) {
			index = this.children.length
		} else if (index < 0) {
			index = 0
		}

		this.insertChild(view, index)

		return this
	}

	/**
	 * Adds a child view before a view from this view's child list.
	 * @method insertBefore
	 * @since 0.1.0
	 */
	public insertBefore(view: View, before: View) {

		let index = this.children.indexOf(before)
		if (index > -1) {
			this.insert(view, index)
		}

		return this
	}

	/**
	 * Adds a child view after a view from this view's child list.
	 * @method insertAfter
	 * @since 0.1.0
	 */
	public insertAfter(view: View, after: View) {

		let index = this.children.indexOf(after)
		if (index > -1) {
			this.insert(view, index + 1)
		}

		return this
	}

	/**
	 * Convenience method to add this view to a specified view.
	 * @method inject
	 * @since 0.4.0
	 */
	public inject(into: View) {
		into.append(this)
		return this
	}

	/**
	 * Removes a view from this view's child list.
	 * @method remove
	 * @since 0.1.0
	 */
	public remove(view: View) {

		let index = this.children.indexOf(view)
		if (index == -1) {
			return this
		}

		view.setResponder(null)

		this.removeChild(index)

		return this
	}

	/**
	 * Remove all views this this view.
	 * @method removeAll
	 * @since 0.4.0
	 */
	public removeAll() {

		let children = this.children.slice(0)

		for (let view of children) {
			view.removeFromParent()
		}

		return this
	}

	/**
	 * Removes this view from its parent view.
	 * @method removeFromParent
	 * @since 0.1.0
	 */
	public removeFromParent() {

		let parent = this.parent
		if (parent) {
			parent.remove(this)
		}

		return this
	}

	/**
	 * Replaces this view with a specified view.
	 * @method replaceWith
	 * @since 0.1.0
	 */
	public replaceWith(view: View) {

		let parent = this.parent
		if (parent == null) {
			return this
		}

		if (view) {
			parent.insertAfter(view, this)
		}

		this.removeFromParent()

		return this
	}

	/**
	 * Indicates whether this view is a parent of the specified view.
	 * @method contains
	 * @since 0.1.0
	 */
	public contains(view: View) {

		let parent = view.parent
		if (parent == this) {
			return true
		}

		while (parent) {

			if (parent == this) {
				return true
			}

			parent = parent.parent
		}

		return false
	}

	//--------------------------------------------------------------------------
	// Methods: Styles
	//--------------------------------------------------------------------------

	/**
	 * @method hasStyle
	 * @since 0.1.0
	 * @hidden
	 */
	public hasStyle(style: string) {
		return this[STYLES].includes(style)
	}

	/**
	 * Appends a visual style to this view.
	 * @method addStyle
	 * @since 0.1.0
	 */
	public addStyle(style: string) {

		style = style.trim()

		if (style == '') {
			return this
		}

		let index = this[STYLES].indexOf(style)
		if (index > -1) {
			return this
		}

		this[STYLES].push(style);

		this.native.addStyle(style)

		return this
	}

	/**
	 * Appends an array of visual style to this view.
	 * @method addStyles
	 * @since 0.4.0
	 */
	public addStyles(...styles: Array<string>) {
		for (let style of styles) this.addStyle(style)
		return this
	}

	/**
	 * Removes a visual style from this view.
	 * @method removeStyle
	 * @since 0.1.0
	 */
	public removeStyle(style: string) {

		let index = this[STYLES].indexOf(style)
		if (index < 0) {
			return this
		}

		this[STYLES].splice(index, 1)

		this.native.removeStyle(style)

		return this
	}

	/**
	 * Toggles a visual style from this view.
	 * @method toggleStyle
	 * @since 0.1.0
	 */
	public toggleStyle(style: string, toggle?: boolean) {

		if (toggle == null) {
			toggle = this.hasStyle(style) == false
		}

		return toggle ? this.addStyle(style) : this.removeStyle(style)
	}

	//--------------------------------------------------------------------------
	// Methods: States
	//--------------------------------------------------------------------------

	/**
	 * Indicates whether the specified state has been set.
	 * @method hasState
	 * @since 0.1.0
	 */
	public hasState(state: string) {
		return this[STATES].includes(state)
	}

	/**
	 * @method setState
	 * @since 0.1.0
	 */
	public setState(state: string, enabled: boolean = true) {

		state = state.trim()

		if (state == '') {
			return this
		}

		if (enabled) {

			let index = this[STATES].indexOf(state)
			if (index > -1) {
				return this
			}

			this[STATES].push(state)

			this.native.addState(state)

		} else {

			let index = this[STATES].indexOf(state)
			if (index < 0) {
				return this
			}

			this[STATES].splice(index, 1)

			this.native.removeState(state)
		}

		return this
	}

	/**
	 * @method setStates
	 * @since 0.4.0
	 */
	public setStates(...states: Array<string>) {
		for (let state of states) this.setState(state)
		return this
	}

	//--------------------------------------------------------------------------
	// Methods: Scheduling
	//--------------------------------------------------------------------------

	/**
	 * Invalidates the view's drawing and schedule a redraw update.
	 * @method scheduleRedraw
	 * @since 0.1.0
	 */
	public scheduleRedraw() {
		this.native.scheduleRedraw()
		return this
	}

	/**
	 * Invalidates the view's layout and schedule a layout update.
	 * @method scheduleLayout
	 * @since 0.1.0
	 */
	public scheduleLayout() {
		this.native.scheduleLayout()
		return this
	}

	/**
	 * Manually measures this view only.
	 * @method measure
	 * @since 0.1.0
	 */
	public measure() {
		this.native.measure()
		return this
	}

	/**
	 * Manually resolve the the measures of this view and its ancestor.
	 * @method resolve
	 * @since 0.1.0
	 */
	public resolve() {
		this.native.resolve()
		return this
	}

	//--------------------------------------------------------------------------
	// Events Management
	//--------------------------------------------------------------------------

	/**
	 * @method on
	 * @since 0.1.0
	 * @hidden
	 */
	public on(type: string | Gesture, listener: EventListener) {

		if (typeof type == 'string') {
			let constructor = GestureRegistry.get(type)
			if (constructor) {
				type = new constructor()
			}
		}

		if (type instanceof Gesture) {
			this.appendGestureListener(listener, type)
			return this
		}

		return super.on(type, listener)
	}

	/**
	 * @method off
	 * @since 0.1.0
	 * @hidden
	 */
	public off(type: string | Gesture, listener: EventListener) {

		if (type instanceof Gesture) {
			this.removeGestureListener(listener)
			return this
		}

		if (GestureRegistry.has(type)) {
			this.removeGestureListener(listener)
			return this
		}

		return super.off(type, listener)
	}

	//--------------------------------------------------------------------------
	// Methods: Animation
	//--------------------------------------------------------------------------

	/**
	 * Convenience method to transition properties from a single view.
	 * @method transition
	 * @since 0.4.0
	 */
	public transition(animate: ViewProperties<View>): Promise<void>
	public transition(options: ViewTransitionOptions, animate: ViewProperties<View>): Promise<void>
	public transition(...args: Array<any>): Promise<void> {

		let animate: any = {}
		let options: ViewTransitionOptions = {
			duration: DEFAULT_DURATION,
			equation: DEFAULT_EQUATION,
			delay: 0
		}

		if (args.length == 2) {
			options = args[0]
			animate = args[1]
		} else {
			animate = args[0]
		}

		return View.transition(options, () => {
			for (let key in animate) {
				(this as any)[key] = animate[key]
			}
		})
	}

	//--------------------------------------------------------------------------
	// Methods: Scrolling Management
	//--------------------------------------------------------------------------

	/**
	 * Scrolls to a specific location.
	 * @method scrollTo
	 * @since 0.1.0
	 */
	public scrollTo(top: number, left: number = 0) {
		this.native.scrollTo(top, left)
		return this
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method onEmit
	 * @since 0.1.0
	 */
	public onEmit(event: Event) {

		super.onEmit(event)

		if (event instanceof TouchEvent) {

			if (event.canceled) {
				return
			}

			switch (event.type) {

				case 'touchcancel':
					this.onTouchCancel(event)
					break

				case 'touchstart':
					this.onTouchStart(event)
					break

				case 'touchmove':
					this.onTouchMove(event)
					break

				case 'touchend':
					this.onTouchEnd(event)
					break
			}
		}

		switch (event.type) {

			case 'beforelayout':
				this.onBeforeLayout(event)
				break

			case 'layout':
				this.onLayout(event)
				break

			case 'insert':
				this.onInsert(event)
				break

			case 'remove':
				this.onRemove(event)
				break

			case 'movetoparent':
				this.onMoveToParentDefault(event)
				this.onMoveToParent(event)
				break

			case 'movetowindow':
				this.onMoveToWindowDefault(event)
				this.onMoveToWindow(event)
				break

			case 'scrollstart':
				this.onScrollStart(event)
				break

			case 'scrollend':
				this.onScrollEnd(event)
				break

			case 'scroll':
				this.onScroll(event)
				break

			case 'overscroll':
				this.onOverscroll(event)
				break

			case 'dragstart':
				this.onDragStart(event)
				break

			case 'dragend':
				this.onDragEnd(event)
				break

			case 'drag':
				this.onDrag(event)
				break

			case 'zoomstart':
				this.onZoomStart(event)
				break

			case 'zoomend':
				this.onZoomEnd(event)
				break

			case 'zoom':
				this.onZoom(event)
				break

			case 'redraw':
				this.onRedraw(event)
				break
		}
	}

	/**
	 * @inherited
	 * @method onDispatch
	 * @since 0.1.0
	 */
	public onDispatch(event: Event) {

		super.onDispatch(event)

		if (event.cancelable && event instanceof TouchEvent) {

			if (event.type == 'touchstart' ||
				event.type == 'touchmove') {

				if (this.cancelScroll == false && this.scrollable && event.canceled) {
					this.cancelScroll = true
					this.scrollable = false
				}

				return
			}

			if (event.type == 'touchcancel' ||
				event.type == 'touchend') {

				if (event.activeTouches.length == 0) {
					if (this.cancelScroll) {
						this.cancelScroll = false
						this.scrollable = true
					}
				}

				return
			}
		}
	}

	/**
	 * Called before a layout operation occurs.
	 * @method onBeforeLayout
	 * @since 0.1.0
	 */
	public onBeforeLayout(event: Event) {

	}

	/**
	 * Called once a layout operation occurs.
	 * @method onLayout
	 * @since 0.1.0
	 */
	public onLayout(event: Event) {

	}

	/**
	 * Called when a child view is added.
	 * @method onInsert
	 * @since 0.1.0
	 */
	public onInsert(event: Event) {

	}

	/**
	 * Called when a child view is removed.
	 * @method onRemove
	 * @since 0.1.0
	 */
	public onRemove(event: Event) {

	}

	/**
	 * Called when this view is moved to a parent view.
	 * @method onMoveToParent
	 * @since 0.2.0
	 */
	public onMoveToParent(event: Event) {

	}

	/**
	 * Called when this view is moved to a window.
	 * @method onMoveToWindow
	 * @since 0.2.0
	 */
	public onMoveToWindow(event: Event) {

	}

	/**
	 * @method onScrollStart
	 * @since 0.1.0
	 */
	public onScrollStart(event: Event) {

	}

	/**
	 * @method onScrollEnd
	 * @since 0.1.0
	 */
	public onScrollEnd(event: Event) {

	}

	/**
	 * @method onScroll
	 * @since 0.1.0
	 */
	public onScroll(event: Event) {

	}

	/**
	 * @method onOverscroll
	 * @since 0.1.0
	 */
	public onOverscroll(event: Event) {

	}

	/**
	 * @method onDragStart
	 * @since 0.1.0
	 */
	public onDragStart(event: Event) {

	}

	/**
	 * @method onDragEnd
	 * @since 0.1.0
	 */
	public onDragEnd(event: Event) {

	}

	/**
	 * @method onDrag
	 * @since 0.1.0
	 */
	public onDrag(event: Event) {

	}

	/**
	 * @method onZoomStart
	 * @since 0.3.0
	 */
	public onZoomStart(event: Event) {

	}

	/**
	 * @method onZoomEnd
	 * @since 0.3.0
	 */
	public onZoomEnd(event: Event) {

	}

	/**
	 * @method onZoom
	 * @since 0.3.0
	 */
	public onZoom(event: Event) {

	}

	/**
	 * @method onRedraw
	 * @since 0.4.0
	 */
	public onRedraw(event: Event<ViewRedrawEvent>) {

	}

	/**
	 * Called when a touch cancel event occurs.
	 * @method onTouchCancel
	 * @since 0.1.0
	 */
	public onTouchCancel(event: TouchEvent) {

	}

	/**
	 * Called when a touch start event occurs.
	 * @method onTouchStart
	 * @since 0.1.0
	 */
	public onTouchStart(event: TouchEvent) {

	}

	/**
	 * Called when a touch move event occurs.
	 * @method onTouchMove
	 * @since 0.1.0
	 */
	public onTouchMove(event: TouchEvent) {

	}

	/**
	 * Called when a touch end event occurs.
	 * @method onTouchEnd
	 * @since 0.1.0
	 */
	public onTouchEnd(event: TouchEvent) {

	}

	//--------------------------------------------------------------------------
	// JSX
	//--------------------------------------------------------------------------

	/**
	 * @property __jsxProps
	 * @since 0.4.0
	 * @hidden
	 */
	public __jsxProps: any

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method onMoveToParentDefault
	 * @since 0.3.0
	 * @hidden
	 */
	public onMoveToParentDefault(event: Event<ViewMoveToWindowEvent>) {

	}

	/**
	 * @method onMoveToWindowDefault
	 * @since 0.3.0
	 * @hidden
	 */
	public onMoveToWindowDefault(event: Event<ViewMoveToWindowEvent>) {
		if (this[READY] == false) {
			this[READY] = true
			this.onReady()
		}
	}

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * TODO
	 * @method setDefaultValue
	 * @since 0.4.0
	 */
	public setDefaultValue(value: string | number | boolean) {

	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property [READY]
	 * @since 0.5.0
	 * @hidden
	 */
	private [READY]: boolean = false

	/**
	 * @property [CHILDREN]
	 * @since 0.1.0
	 * @hidden
	 */
	private [CHILDREN]: Array<View> = []

	/**
	 * @property [STYLES]
	 * @since 0.3.0
	 * @hidden
	 */
	private [STYLES]: Array<string> = []

	/**
	 * @property [STATES]
	 * @since 0.1.0
	 * @hidden
	 */
	private [STATES]: Array<string> = []

	/**
	 * @property [GESTURES]
	 * @since 0.4.0
	 * @hidden
	 */
	private [GESTURES]: Map<Function, Gesture> = new Map()

	/**
	 * @property cancelScroll
	 * @since 0.1.0
	 * @hidden
	 */
	private cancelScroll: boolean = false

	/**
	 * @method insertChild
	 * @since 0.4.0
	 * @hidden
	 */
	private insertChild(view: View, index: number) {
		this.native.insert(view.native, index)
		this.children.splice(index, 0, view)
		this.emit<ViewInsertEvent>('insert', { data: { view, index } })
		return this
	}

	/**
	 * @method removeChild
	 * @since 0.4.0
	 * @hidden
	 */
	private removeChild(index: number) {

		let view = this[CHILDREN][index]
		if (view == null) {
			return this
		}

		this.native.remove(view.native)
		this.children.splice(index, 1)
		this.emit<ViewRemoveEvent>('remove', { data: { view, index } })

		return this
	}

	/**
	 * @method appendGestureListener
	 * @since 0.5.0
	 * @hidden
	 */
	private appendGestureListener(listener: EventListener, gesture: Gesture) {

		if (this[GESTURES].has(listener) == false) {
			this[GESTURES].set(listener, gesture)
			gesture.attach(this, listener)
		}

		return this
	}

	/**
	 * @method removeGestureListener
	 * @since 0.5.0
	 * @hidden
	 */
	private removeGestureListener(listener: EventListener) {

		let gesture = this[GESTURES].get(listener)
		if (gesture == null) {
			return this
		}

		gesture.detach()

		this[GESTURES].delete(listener)
	}

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

	/**
	 * @property native
	 * @since 0.1.0
	 * @hidden
	 */
	public native: any

	/**
	 * @method nativeMoveToParent
	 * @since 0.2.0
	 * @hidden
	 */
	private nativeMoveToParent(parent: View) {
		this.emit<ViewMoveToParentEvent>('movetoparent', { data: { parent } })
	}

	/**
	 * @method nativeMoveToWindow
	 * @since 0.2.0
	 * @hidden
	 */
	private nativeMoveToWindow(window: Window) {
		this.emit<ViewMoveToWindowEvent>('movetowindow', { data: { window } })
	}

	/**
	 * @method nativeScrollStart
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeScrollStart() {
		this.emit('scrollstart')
	}

	/**
	 * @method nativeScrollEnd
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeScrollEnd() {
		this.emit('scrollend')
	}

	/**
	 * @method nativeScroll
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeScroll() {
		this.emit('scroll')
	}

	/**
	 * @method nativeDragStart
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeDragStart() {
		this.emit('dragstart')
	}

	/**
	 * @method nativeDragEnd
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeDragEnd() {
		this.emit('dragend')
	}

	/**
	 * @method nativeDrag
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeDrag() {
		this.emit('drag')
	}

	/**
	 * @method nativeZoomStart
	 * @since 0.3.0
	 * @hidden
	 */
	private nativeZoomStart() {
		this.emit('zoomstart')
	}

	/**
	 * @method nativeZoomEnd
	 * @since 0.3.0
	 * @hidden
	 */
	private nativeZoomEnd(scale: number) {
		this.emit('zoomend', { data: { scale } })
	}

	/**
	 * @method nativeZoom
	 * @since 0.3.0
	 * @hidden
	 */
	private nativeZoom() {
		this.emit('zoom')
	}

	/**
	 * @method nativeLayoutBegan
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeLayoutBegan() {
		this.emit('beforelayout')
	}

	/**
	 * @method nativeLayoutFinished
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeLayoutFinished() {
		this.emit('layout')
	}

	/**
	 * @method nativeRedraw
	 * @since 0.4.0
	 * @hidden
	 */
	private nativeRedraw(canvas: Canvas) {
		this.emit<ViewRedrawEvent>('redraw', { data: { canvas } })
	}
}

/**
 * Animation duration registry.
 * @const AnimationDurationRegistry
 * @since 0.1.0
 */
export const AnimationDurationRegistry: Map<string, number> = new Map()
AnimationDurationRegistry.set('slow', 750)
AnimationDurationRegistry.set('fast', 250)

/**
 * Animation equation registry.
 * @const AnimationEquationRegistry
 * @since 0.1.0
 */
export const AnimationEquationRegistry: Map<string, Array<number>> = new Map()
AnimationEquationRegistry.set('default', [0.25, 0.1, 0.25, 1.0])
AnimationEquationRegistry.set('linear', [0.0, 0.0, 1.0, 1.0])
AnimationEquationRegistry.set('ease-in', [0.42, 0.0, 1.0, 1.0])
AnimationEquationRegistry.set('ease-out', [0.0, 0.0, 0.58, 1.0])
AnimationEquationRegistry.set('ease-in-out', [0.42, 0, 0.58, 1.0])

//------------------------------------------------------------------------------
// Window Class
//------------------------------------------------------------------------------

@bridge('dezel.view.Window')

/**
 * Displays the top most view at the root of the hierarchy.
 * @class Window
 * @super View
 * @since 0.1.0
 */
export class Window extends View {

	/**
	 * Initializes the window.
	 * @constructor
	 * @since 0.1.0
	 */
	constructor() {
		super()
		this.id = 'window'
	}

	/**
	 * Finds a view from this window's hierarchy at the specified point.
	 * @method viewFromPoint
	 * @since 0.2.0
	 */
	public viewFromPoint(x: number, y: number, visible: boolean = true, touchable: boolean = true): View | undefined {
		return this.native.viewFromPoint(x, y, visible, touchable)
	}
}

//------------------------------------------------------------------------------
// Fragment
//------------------------------------------------------------------------------

/**
 * Manages a series of view.
 * @class Fragment
 * @since 0.1.0
 */
export class Fragment {

	//--------------------------------------------------------------------------
	// ViewProperties
	//--------------------------------------------------------------------------

	/**
	 * The fragment's children.
	 * @property children
	 * @since 0.1.0
	 */
	public get children(): Array<Node> {
		return this[CHILDREN]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Adds a child view at the end of this fragment's child list.
	 * @method append
	 * @since 0.1.0
	 */
	public append(view: View) {
		return this.insert(view, this.children.length)
	}

	/**
	 * Adds a child view at an index of this fragment's child list.
	 * @method insert
	 * @since 0.1.0
	 */
	public insert(view: View, index: number) {

		if (view.parent) {
			view.removeFromParent()
		}

		if (index > this.children.length) {
			index = this.children.length
		} else if (index < 0) {
			index = 0
		}

		this.children.splice(index, 0, view)

		this.onInsert(view)

		return this
	}

	/**
	 * Adds a child view before a view from this fragment's child list.
	 * @method insertBefore
	 * @since 0.1.0
	 */
	public insertBefore(view: View, before: View) {

		let index = this.children.indexOf(before)
		if (index > -1) {
			this.insert(view, index)
		}

		return this
	}

	/**
	 * Adds a child view after a view from this fragment's child list.
	 * @method insertAfter
	 * @since 0.1.0
	 */
	public insertAfter(view: View, after: View) {

		let index = this.children.indexOf(after)
		if (index > -1) {
			this.insert(view, index + 1)
		}

		return this
	}

	/**
	 * Removes a view from this fragment's child list.
	 * @method remove
	 * @since 0.1.0
	 */
	public remove(view: View) {

		let index = this.children.indexOf(view)
		if (index == -1) {
			return this
		}

		this.children.splice(index, 1)

		this.onRemove(view)

		return this
	}

	/**
	 * Remove all views this this view.
	 * @method removeAllViews
	 * @since 0.1.0
	 */
	public removeAllViews() {
		this[CHILDREN] = []
		return this
	}

	/**
	 * Inserts this fragment to the specified view.
	 * @method inject
	 * @since 0.4.0
	 */
	public inject(view: View, index: number = 0) {
		this[CHILDREN].forEach(child => view.insert(child, index++))
		return this
	}

	/**
	 * Called when a child view is added.
	 * @method onInsert
	 * @since 0.1.0
	 */
	public onInsert(view: View) {

	}

	/**
	 * Called when a child view is removed.
	 * @method onRemove
	 * @since 0.1.0
	 */
	public onRemove(view: View) {

	}

	//--------------------------------------------------------------------------
	// JSX API
	//--------------------------------------------------------------------------

	/**
	 * @property __jsxProps
	 * @since 0.4.0
	 * @hidden
	 */
	public __jsxProps: any

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property [CHILDREN]
	 * @since 0.1.0
	 * @hidden
	 */
	private [CHILDREN]: Array<Node> = []
}

/**
 * @type ViewInsertEvent
 * @since 0.1.0
 */
export type ViewInsertEvent = {
	view: View
	index: number
}

/**
 * @type ViewRemoveEvent
 * @since 0.1.0
 */
export type ViewRemoveEvent = {
	view: View
	index: number
}

/**
 * @type ViewMoveToParentEvent
 * @since 0.2.0
 */
export type ViewMoveToParentEvent = {
	parent?: View
}

/**
 * @type ViewMoveToWindowEvent
 * @since 0.1.0
 */
export type ViewMoveToWindowEvent = {
	window?: Window
}

/**
 * @type ViewRedrawEvent
 * @since 0.4.0
 */
export type ViewRedrawEvent = {
	canvas: Canvas
}

/**
 * Optional properies from a specified class.
 * @type ViewProperties
 * @since 0.4.0
 */
export type ViewProperties<T> = {
	[P in keyof T]?: T[P]
}

/**
 * A node that can be added to a view.
 * @type Node
 * @since 0.4.0
 */
export type Node = View | Fragment

//------------------------------------------------------------------------------
// Component Class
//------------------------------------------------------------------------------

/**
 * The base class for components.
 * @class Component
 * @super View
 * @since 0.1.0
 */
export abstract class Component extends View {

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * The view's children.
	 * @property children
	 * @since 0.1.0
	 */
	public get children(): Array<View> {
		return this.build() && this[CHILDREN]
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Initializes the component.
	 * @constructor
	 * @since 0.1.0
	 */
	constructor() {
		super()
		this.createShadowRoot()
	}

	/**
	 * Renders the component.
	 * @method render
	 * @since 0.3.0
	 */
	public render() {
		return undefined
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * Called when the component and its hierarchy is created.
	 * @method onCreate
	 * @since 0.4.0
	 */
	public onCreate() {

	}

	//--------------------------------------------------------------------------
	// Internal API
	//--------------------------------------------------------------------------

	/**
	 * @method build
	 * @since 0.4.0
	 * @hidden
	 */
	public build() {

		if (this[BUILT]) {
			return this
		}

		this[BUILT] = true

		let content = this.render()
		if (content) {
			this.append(content)
		}

		this.onCreate()

		return this
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property [BUILT]
	 * @since 0.4.0
	 * @hidden
	 */
	private [BUILT]: boolean = false
}

//------------------------------------------------------------------------------
// Functions
//------------------------------------------------------------------------------

/**
 * @const classRefs
 * @since 0.4.0
 * @hidden
 */
const classRefs: any = {}

/**
 * @const classListCache
 * @since 0.4.0
 * @hidden
 */
const classListCache = new Map<any, any>()

/**
 * @const classRefsCache
 * @since 0.2.0
 * @hidden
 */
const classRefsCache = new Map<any, any>()

/**
 * @function addRef
 * @since 0.4.0
 * @hidden
 */
export const addRef = function (prototype: object, name: string, prop: string) {

	let refs = classRefs[prototype.constructor.name]
	if (refs == null) {
		refs = classRefs[prototype.constructor.name] = createRefs(prototype)
	}

	refs[name] = prop
}

/**
 * @function getRef
 * @since 0.4.0
 * @hidden
 */
export const getRef = function (prototype: object, name: string) {

	let refs = classRefs[prototype.constructor.name]
	if (refs == null) {
		refs = classRefs[prototype.constructor.name] = createRefs(prototype)
	}

	return refs[name]
}

/**
 * @function getRefs
 * @since 0.4.0
 * @hidden
 */
export const getRefs = function (prototype: object) {

	let refs = classRefs[prototype.constructor.name]
	if (refs == null) {
		refs = classRefs[prototype.constructor.name] = createRefs(prototype)
	}

	return refs
}

/**
 * @function createRefs
 * @since 0.4.0
 * @hidden
 */
export const createRefs = function (prototype: object) {

	let parent = Object.getPrototypeOf(prototype)

	while (parent) {

		let parentRefs = classRefs[parent.constructor.name]
		if (parentRefs) {
			return Object.assign({}, parentRefs)
		}

		parent = Object.getPrototypeOf(parent)
	}

	return {}
}

/**
 * @function getClassList
 * @since 0.2.0
 * @hidden
 */
export const getClassList = (view: View) => {

	let classList = view.constructor.name

	if (view.constructor != View) {

		let classListValue = classListCache.get(view.constructor)
		if (classListValue == null) {
			classListCache.set(view.constructor, classListValue = getClassListValue(view))
		}

		classList = classListValue
	}

	return classList
}

/**
 * @function getClassRefs
 * @since 0.4.0
 * @hidden
 */
export const getClassRefs = (view: View) => {

	let classRefsValue = classRefsCache.get(view.constructor)
	if (classRefsValue == null) {
		classRefsCache.set(view.constructor, classRefsValue = getClassRefsValue(view))
	}

	return classRefsValue
}

/**
 * @function getClassListValue
 * @since 0.4.0
 * @hidden
 */
export const getClassListValue = (view: View) => {

	let klass = view.constructor.name
	let proto = view.constructor.prototype

	while (proto) {

		proto = Object.getPrototypeOf(proto)

		let constructor = proto.constructor
		if (constructor == View) {
			proto = null
		}

		klass = klass + '.' + constructor.name
	}

	return klass
}

/**
 * @function getClassRefsValue
 * @since 0.4.0
 * @hidden
 */
export const getClassRefsValue = (view: View) => {
	return Object.keys(getRefs(view)).join(',')
}