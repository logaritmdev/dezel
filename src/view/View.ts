import { setEmitterResponder } from '../event/private/Emitter'
import { Emitter } from '../event/Emitter'
import { Event } from '../event/Event'
import { GestureManager } from '../gesture/GestureManager'
import { Canvas } from '../graphic/Canvas'
import { Image } from '../graphic/Image'
import { bridge } from '../native/bridge'
import { native } from '../native/native'
import { TouchEvent } from '../touch/TouchEvent'
import { getClassName } from './private/View'
import { insertItem } from './private/View'
import { insertView } from './private/View'
import { removeItem } from './private/View'
import { removeView } from './private/View'
import { $children } from './symbol/View'
import { $gestures } from './symbol/View'
import { $states } from './symbol/View'
import { $styles } from './symbol/View'
import { Placeholder } from './Placeholder'
import { StateList } from './StateList'
import { StyleList } from './StyleList'
import { Window } from './Window'

@bridge('dezel.view.View')

/**
 * @class View
 * @super Emitter
 * @since 0.1.0
 */
export class View extends Emitter {

	//--------------------------------------------------------------------------
	// Static Methods
	//--------------------------------------------------------------------------

	/**
	 * @method transition
	 * @since 0.1.0
	 */
	public static transition(animate: Function): Promise<void>
	public static transition(options: ViewTransitionOptions, animate: Function): Promise<void>
	public static transition(...args: Array<any>): Promise<void> {

		let animate: Function
		let options: ViewTransitionOptions = {
			duration: AnimationDefaultDuration,
			equation: AnimationDefaultEquation,
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

		let duration = AnimationDefaultDuration
		let equation = AnimationDefaultEquation
		let delay = options.delay || 0

		if (typeof options.duration == 'string') {

			let value = AnimationDurationRegistry.get(options.duration)
			if (value) {
				duration = value
			} else {
				duration = AnimationDefaultDuration
			}

		} else {
			duration = options.duration || AnimationDefaultDuration
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

					equation = AnimationDefaultEquation

				}
			}
		}

		return new Promise(success => {

			native(View).transition(
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
	 * @property styles
	 * @since 0.7.0
	 */
	public get styles(): StyleList {
		return this[$styles]
	}

	/**
	 * @property states
	 * @since 0.7.0
	 */
	public get states(): StateList {
		return this[$states]
	}

	/**
	 * @property window
	 * @since 0.1.0
	 */
	public get window(): Window | null {
		return native(this).window
	}

	/**
	 * @property parent
	 * @since 0.1.0
	 */
	public get parent(): View | null {
		return native(this).parent
	}

	/**
	 * @property children
	 * @since 0.1.0
	 */
	public get children(): ReadonlyArray<View> {
		return this[$children]
	}

	/**
	 * @property gestures
	 * @since 0.7.0
	*/
	public get gestures(): GestureManager {
		return this[$gestures]
	}

	/**
	 * @property id
	 * @since 0.1.0
	 */
	@native public id!: string

	/**
	 * @property backgroundColor
	 * @since 0.1.0
	 */
	@native public backgroundColor!: string

	/**
	 * @property backgroundImage
	 * @since 0.1.0
	 */
	@native public backgroundImage!: Image | string | null

	/**
	 * @property backgroundImageFit
	 * @since 0.4.0
	 */
	@native public backgroundImageFit!: 'fit' | 'fill' | 'none'

	/**
	 * @property backgroundImageAnchorTop
	 * @since 0.1.0
	 */
	@native public backgroundImageAnchorTop!: 'top' | 'center' | 'bottom' | number | string

	/**
	 * @property backgroundImageAnchorLeft
	 * @since 0.1.0
	 */
	@native public backgroundImageAnchorLeft!: 'left' | 'center' | 'right' | number | string

	/**
	 * @property backgroundImageTop
	 * @since 0.1.0
	 */
	@native public backgroundImageTop!: number | string

	/**
	 * @property backgroundImageLeft
	 * @since 0.1.0
	 */
	@native public backgroundImageLeft!: number | string

	/**
	 * @property backgroundImageWidth
	 * @since 0.1.0
	 */
	@native public backgroundImageWidth!: 'auto' | number

	/**
	 * @property backgroundImageHeight
	 * @since 0.1.0
	 */
	@native public backgroundImageHeight!: 'auto' | number

	/**
	 * @property backgroundImageTint
	 * @since 0.7.0
	 */
	@native public backgroundImageTint!: string | 'none'

	/**
	 * @property border
	 * @since 0.2.0
	 */
	@native public border!: any

	/**
	 * @property borderWidth
	 * @since 0.2.0
	 */
	@native public borderWidth!: any

	/**
	 * @property borderColor
	 * @since 0.2.0
	 */
	@native public borderColor!: any

	/**
	 * @property borderTop
	 * @since 0.4.0
	 */
	@native public borderTop!: any

	/**
	 * @property borderLeft
	 * @since 0.4.0
	 */
	@native public borderLeft!: any

	/**
	 * @property borderRight
	 * @since 0.4.0
	 */
	@native public borderRight!: any

	/**
	 * @property borderBottom
	 * @since 0.4.0
	 */
	@native public borderBottom!: any

	/**
	 * @property borderTopColor
	 * @since 0.1.0
	 */
	@native public borderTopColor!: string

	/**
	 * @property borderLeftColor
	 * @since 0.1.0
	 */
	@native public borderLeftColor!: string

	/**
	 * @property borderRightColor
	 * @since 0.1.0
	 */
	@native public borderRightColor!: string

	/**
	 * @property borderBottomColor
	 * @since 0.1.0
	 */
	@native public borderBottomColor!: string

	/**
	 * @property borderTopWidth
	 * @since 0.1.0
	 */
	@native public borderTopWidth!: number | string

	/**
	 * @property borderLeftWidth
	 * @since 0.1.0
	 */
	@native public borderLeftWidth!: number | string

	/**
	 * @property borderRightWidth
	 * @since 0.1.0
	 */
	@native public borderRightWidth!: number | string

	/**
	 * @property borderBottomWidth
	 * @since 0.1.0
	 */
	@native public borderBottomWidth!: number | string

	/**
	 * @property minBorderTopWidth
	 * @since 0.1.0
	 */
	@native public minBorderTopWidth!: number

	/**
	 * @property maxBorderTopWidth
	 * @since 0.1.0
	 */
	@native public maxBorderTopWidth!: number

	/**
	 * @property minBorderLeftWidth
	 * @since 0.1.0
	 */
	@native public minBorderLeftWidth!: number

	/**
	 * @property maxBorderLeftWidth
	 * @since 0.1.0
	 */
	@native public maxBorderLeftWidth!: number

	/**
	 * @property minBorderRightWidth
	 * @since 0.1.0
	 */
	@native public minBorderRightWidth!: number

	/**
	 * @property maxBorderRightWidth
	 * @since 0.1.0
	 */
	@native public maxBorderRightWidth!: number

	/**
	 * @property minBorderBottomWidth
	 * @since 0.1.0
	 */
	@native public minBorderBottomWidth!: number

	/**
	 * @property maxBorderBottomWidth
	 * @since 0.1.0
	 */
	@native public maxBorderBottomWidth!: number

	/**
	 * @property borderRadius
	 * @since 0.2.0
	 */
	@native public borderRadius!: any

	/**
	 * @property borderTopLeftRadius
	 * @since 0.1.0
	 */
	@native public borderTopLeftRadius!: number

	/**
	 * @property borderTopRightRadius
	 * @since 0.1.0
	 */
	@native public borderTopRightRadius!: number

	/**
	 * @property borderBottomLeftRadius
	 * @since 0.1.0
	 */
	@native public borderBottomLeftRadius!: number

	/**
	 * @property borderBottomRightRadius
	 * @since 0.1.0
	 */
	@native public borderBottomRightRadius!: number

	/**
	 * @property shadowBlur
	 * @since 0.1.0
	 */
	@native public shadowBlur!: number

	/**
	 * @property shadowColor
	 * @since 0.1.0
	 */
	@native public shadowColor!: string

	/**
	 * @property shadowOffsetTop
	 * @since 0.1.0
	 */
	@native public shadowOffsetTop!: number

	/**
	 * @property shadowOffsetLeft
	 * @since 0.1.0
	 */
	@native public shadowOffsetLeft!: number

	/**
	 * @property top
	 * @since 0.1.0
	 */
	@native public top!: number | string

	/**
	 * @property left
	 * @since 0.1.0
	 */
	@native public left!: number | string

	/**
	 * @property right
	 * @since 0.1.0
	 */
	@native public right!: number | string

	/**
	 * @property bottom
	 * @since 0.1.0
	 */
	@native public bottom!: number | string

	/**
	 * @property minTop
	 * @since 0.1.0
	 */
	@native public minTop!: number

	/**
	 * @property maxTop
	 * @since 0.1.0
	 */
	@native public maxTop!: number

	/**
	 * @property minLeft
	 * @since 0.1.0
	 */
	@native public minLeft!: number

	/**
	 * @property maxLeft
	 * @since 0.1.0
	 */
	@native public maxLeft!: number

	/**
	 * @property minRight
	 * @since 0.1.0
	 */
	@native public minRight!: number

	/**
	 * @property maxRight
	 * @since 0.1.0
	 */
	@native public maxRight!: number

	/**
	 * @property minBottom
	 * @since 0.1.0
	 */
	@native public minBottom!: number

	/**
	 * @property maxBottom
	 * @since 0.1.0
	 */
	@native public maxBottom!: number

	/**
	 * @property anchorTop
	 * @since 0.1.0
	 */
	@native public anchorTop!: 'top' | 'center' | 'bottom' | number | string

	/**
	 * @property anchorLeft
	 * @since 0.1.0
	 */
	@native public anchorLeft!: 'left' | 'center' | 'right' | number | string

	/**
	 * @property width
	 * @since 0.1.0
	 */
	@native public width!: number | string | 'fill' | 'wrap'

	/**
	 * @property height
	 * @since 0.1.0
	 */
	@native public height!: number | string | 'fill' | 'wrap'

	/**
	 * @property minWidth
	 * @since 0.1.0
	 */
	@native public minWidth!: number

	/**
	 * @property maxWidth
	 * @since 0.1.0
	 */
	@native public maxWidth!: number

	/**
	 * @property minHeight
	 * @since 0.1.0
	 */
	@native public minHeight!: number

	/**
	 * @property maxHeight
	 * @since 0.1.0
	 */
	@native public maxHeight!: number

	/**
	 * @property expandFactor
	 * @since 0.7.0
	 */
	@native public expandFactor!: number

	/**
	 * @property shrinkFactor
	 * @since 0.7.0
	 */
	@native public shrinkFactor!: number

	/**
	 * @property contentTop
	 * @since 0.1.0
	 */
	@native public contentTop!: number

	/**
	 * @property contentLeft
	 * @since 0.1.0
	 */
	@native public contentLeft!: number

	/**
	 * @property contentWidth
	 * @since 0.1.0
	 */
	@native public contentWidth!: number | string | 'auto'

	/**
	 * @property contentHeight
	 * @since 0.1.0
	 */
	@native public contentHeight!: number | string | 'auto'

	/**
	 * @property contentInsetTop
	 * @since 0.1.0
	 */
	@native public contentInsetTop!: number

	/**
	 * @property contentInsetLeft
	 * @since 0.1.0
	 */
	@native public contentInsetLeft!: number

	/**
	 * @property contentInsetRight
	 * @since 0.1.0
	 */
	@native public contentInsetRight!: number

	/**
	 * @property contentInsetBottom
	 * @since 0.1.0
	 */
	@native public contentInsetBottom!: number

	/**
	 * @property contentDirection
	 * @since 0.7.0
	 */
	@native public contentDirection!: 'vertical' | 'horizontal'

	/**
	 * @property contentAlignment
	 * @since 0.7.0
	 */
	@native public contentAlignment!: 'start' | 'center' | 'end'

	/**
	 * @property contentDisposition
	 * @since 0.7.0
	 */
	@native public contentDisposition!: 'start' | 'center' | 'end' | 'space-around' | 'space-between' | 'space-evenly'

	/**
	 * @property margin
	 * @since 0.2.0
	 */
	@native public margin!: any

	/**
	 * @property marginTop
	 * @since 0.1.0
	 */
	@native public marginTop!: number

	/**
	 * @property marginLeft
	 * @since 0.1.0
	 */
	@native public marginLeft!: number

	/**
	 * @property marginRight
	 * @since 0.1.0
	 */
	@native public marginRight!: number

	/**
	 * @property marginBottom
	 * @since 0.1.0
	 */
	@native public marginBottom!: number

	/**
	 * @property minMarginTop
	 * @since 0.1.0
	 */
	@native public minMarginTop!: number

	/**
	 * @property maxMarginTop
	 * @since 0.1.0
	 */
	@native public maxMarginTop!: number

	/**
	 * @property minMarginLeft
	 * @since 0.1.0
	 */
	@native public minMarginLeft!: number

	/**
	 * @property maxMarginLeft
	 * @since 0.1.0
	 */
	@native public maxMarginLeft!: number

	/**
	 * @property minMarginRight
	 * @since 0.1.0
	 */
	@native public minMarginRight!: number

	/**
	 * @property maxMarginRight
	 * @since 0.1.0
	 */
	@native public maxMarginRight!: number

	/**
	 * @property minMarginBottom
	 * @since 0.1.0
	 */
	@native public minMarginBottom!: number

	/**
	 * @property maxMarginBottom
	 * @since 0.1.0
	 */
	@native public maxMarginBottom!: number

	/**
	 * @property padding
	 * @since 0.2.0
	 */
	@native public padding!: any

	/**
	 * @property paddingTop
	 * @since 0.1.0
	 */
	@native public paddingTop!: number

	/**
	 * @property paddingLeft
	 * @since 0.1.0
	 */
	@native public paddingLeft!: number

	/**
	 * @property paddingRight
	 * @since 0.1.0
	 */
	@native public paddingRight!: number

	/**
	 * @property paddingBottom
	 * @since 0.1.0
	 */
	@native public paddingBottom!: number

	/**
	 * @property minPaddingTop
	 * @since 0.1.0
	 */
	@native public minPaddingTop!: number

	/**
	 * @property maxPaddingTop
	 * @since 0.1.0
	 */
	@native public maxPaddingTop!: number

	/**
	 * @property minPaddingLeft
	 * @since 0.1.0
	 */
	@native public minPaddingLeft!: number

	/**
	 * @property maxPaddingLeft
	 * @since 0.1.0
	 */
	@native public maxPaddingLeft!: number

	/**
	 * @property minPaddingRight
	 * @since 0.1.0
	 */
	@native public minPaddingRight!: number

	/**
	 * @property maxPaddingRight
	 * @since 0.1.0
	 */
	@native public maxPaddingRight!: number

	/**
	 * @property minPaddingBottom
	 * @since 0.1.0
	 */
	@native public minPaddingBottom!: number

	/**
	 * @property maxPaddingBottom
	 * @since 0.1.0
	 */
	@native public maxPaddingBottom!: number

	/**
	 * @property originX
	 * @since 0.1.0
	 */
	@native public originX!: number

	/**
	 * @property originY
	 * @since 0.1.0
	 */
	@native public originY!: number

	/**
	 * @property originZ
	 * @since 0.1.0
	 */
	@native public originZ!: number

	/**
	 * @property translationX
	 * @since 0.1.0
	 */
	@native public translationX!: number | string

	/**
	 * @property translationY
	 * @since 0.1.0
	 */
	@native public translationY!: number | string

	/**
	 * @property translationZ
	 * @since 0.1.0
	 */
	@native public translationZ!: number

	/**
	 * @property rotationX
	 * @since 0.1.0
	 */
	@native public rotationX!: number | string

	/**
	 * @property rotationY
	 * @since 0.1.0
	 */
	@native public rotationY!: number | string

	/**
	 * @property rotationZ
	 * @since 0.1.0
	 */
	@native public rotationZ!: number | string

	/**
	 * @property scaleX
	 * @since 0.1.0
	 */
	@native public scaleX!: number

	/**
	 * @property scaleY
	 * @since 0.1.0
	 */
	@native public scaleY!: number

	/**
	 * @property scaleZ
	 * @since 0.1.0
	 */
	@native public scaleZ!: number

	/**
	 * @property zIndex
	 * @since 0.1.0
	 */
	@native public zIndex!: number

	/**
	 * @property scrollable
	 * @since 0.1.0
	 */
	@native public scrollable!: boolean

	/**
	 * @property scrollbars
	 * @since 0.1.0
	 */
	@native public scrollbars!: boolean | 'none' | 'both' | 'vertical' | 'horizontal'

	/**
	 * @property overscroll
	 * @since 0.1.0
	 */
	@native public overscroll!: boolean | 'auto' | 'never' | 'always' | 'always-x' | 'always-y'

	/**
	 * @property scrollTop
	 * @since 0.1.0
	 */
	@native public scrollTop!: number

	/**
	 * @property scrollLeft
	 * @since 0.1.0
	 */
	@native public scrollLeft!: number

	/**
	 * @property scrollMomentum
	 * @since 0.1.0
	 */
	@native public scrollMomentum!: boolean

	/**
	 * @property scrolling
	 * @since 0.1.0
	 */
	@native public scrolling!: boolean

	/**
	 * @property dragging
	 * @since 0.1.0
	 */
	@native public dragging!: boolean

	/**
	 * @property zoomable
	 * @since 0.3.0
	 */
	@native public zoomable!: boolean

	/**
	 * @property minZoom
	 * @since 0.3.0
	 */
	@native public minZoom!: number

	/**
	 * @property maxZoom
	 * @since 0.3.0
	 */
	@native public maxZoom!: number

	/**
	 * @property zoomedView
	 * @since 0.3.0
	 */
	@native public zoomedView!: View | null

	/**
	 * @property touchable
	 * @since 0.1.0
	 */
	@native public touchable!: boolean

	/**
	 * @property touchOffsetTop
	 * @since 0.1.0
	 */
	@native public touchOffsetTop!: number

	/**
	 * @property touchOffsetLeft
	 * @since 0.1.0
	 */
	@native public touchOffsetLeft!: number

	/**
	 * @property touchOffsetRight
	 * @since 0.1.0
	 */
	@native public touchOffsetRight!: number

	/**
	 * @property touchOffsetBottom
	 * @since 0.1.0
	 */
	@native public touchOffsetBottom!: number

	/**
	 * @property visible
	 * @since 0.1.0
	 */
	@native public visible!: boolean

	/**
	 * @property opacity
	 * @since 0.1.0
	 */
	@native public opacity!: number

	/**
	 * @property drawable
	 * @since 0.4.0
	 */
	@native public drawable!: boolean

	/**
	 * @property clipped
	 * @since 0.1.0
	 */
	@native public clipped!: boolean

	/**
	 * @property paged
	 * @since 0.4.0
	 */
	@native public paged!: boolean

	/**
	 * @property measuredTop
	 * @since 0.1.0
	 */
	public get measuredTop(): number {
		return native(this).measuredTop
	}

	/**
	 * @property measuredLeft
	 * @since 0.1.0
	 */
	public get measuredLeft(): number {
		return native(this).measuredLeft
	}

	/**
	 * @property measuredWidth
	 * @since 0.1.0
	 */
	public get measuredWidth(): number {
		return native(this).measuredWidth
	}

	/**
	 * @property measuredHeight
	 * @since 0.1.0
	 */
	public get measuredHeight(): number {
		return native(this).measuredHeight
	}

	/**
	 * @property measuredInnerWidth
	 * @since 0.1.0
	 */
	public get measuredInnerWidth(): number {
		return native(this).measuredInnerWidth
	}

	/**
	 * @property measuredInnerHeight
	 * @since 0.1.0
	 */
	public get measuredInnerHeight(): number {
		return native(this).measuredInnerHeight
	}

	/**
	 * @property measuredContentWidth
	 * @since 0.1.0
	 */
	public get measuredContentWidth(): number {
		return native(this).measuredContentWidth
	}

	/**
	 * @property measuredContentHeight
	 * @since 0.1.0
	 */
	public get measuredContentHeight(): number {
		return native(this).measuredContentHeight
	}

	/**
	 * @property measuredMarginTop
	 * @since 0.1.0
	 */
	public get measuredMarginTop(): number {
		return native(this).measuredMarginTop
	}

	/**
	 * @property measuredMarginLeft
	 * @since 0.1.0
	 */
	public get measuredMarginLeft(): number {
		return native(this).measuredMarginLeft
	}

	/**
	 * @property measuredMarginRight
	 * @since 0.1.0
	 */
	public get measuredMarginRight(): number {
		return native(this).measuredMarginRight
	}

	/**
	 * @property measuredMarginBottom
	 * @since 0.1.0
	 */
	public get measuredMarginBottom(): number {
		return native(this).measuredMarginBottom
	}

	/**
	 * @property measuredPaddingTop
	 * @since 0.1.0
	 */
	public get measuredPaddingTop(): number {
		return native(this).measuredPaddingTop
	}

	/**
	 * @property measuredPaddingLeft
	 * @since 0.1.0
	 */
	public get measuredPaddingLeft(): number {
		return native(this).measuredPaddingLeft
	}

	/**
	 * @property measuredPaddingRight
	 * @since 0.1.0
	 */
	public get measuredPaddingRight(): number {
		return native(this).measuredPaddingRight
	}

	/**
	 * @property measuredPaddingBottom
	 * @since 0.1.0
	 */
	public get measuredPaddingBottom(): number {
		return native(this).measuredPaddingBottom
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	constructor() {
		super()
		native(this).className = getClassName(this)
	}

	/**
	 * @method destroy
	 * @since 0.1.0
	 */
	public destroy() {
		// TODO FIXME put in onDestroy
		if (this.parent) {
			this.parent.remove(this)
		}

		native(this).destroy()

		return super.destroy()
	}

	/**
	 * @method append
	 * @since 0.1.0
	 */
	public append(child: View | Placeholder) {
		this.insert(child, this.children.length)
		return this
	}

	/**
	 * @method insert
	 * @since 0.1.0
	 */
	public insert(child: View | Placeholder, index: number) {

		if (child instanceof Placeholder) {
			child.embed(this, index)
			return this
		}

		if (child.parent) {
			child.parent.remove(child)
		}

		if (index > this.children.length) {
			index = this.children.length
		} else if (index < 0) {
			index = 0
		}

		setEmitterResponder(child, this)

		insertItem(this, child, index)
		insertView(this, child, index)

		this.emit<ViewInsertEvent>('insert', { data: { child, index } })

		return this
	}

	/**
	 * @method insertBefore
	 * @since 0.1.0
	 */
	public insertBefore(child: View, before: View) {

		let index = this.children.indexOf(before)
		if (index == -1) {
			return this
		}

		this.insert(child, index)

		return this
	}

	/**
	 * @method insertAfter
	 * @since 0.1.0
	 */
	public insertAfter(child: View, after: View) {

		let index = this.children.indexOf(after)
		if (index == -1) {
			return this
		}

		this.insert(this, index + 1)

		return this
	}

	/**
	 * @method replace
	 * @since 0.7.0
	 */
	public replace(child: View, using: View) {

		let index = this.children.indexOf(child)
		if (index == -1) {
			return this
		}

		this.remove(child)
		this.insert(using, index)

		return this
	}

	/**
	 * @method remove
	 * @since 0.1.0
	 */
	public remove(child: View | Placeholder) {

		if (child instanceof Placeholder) {
			child.destroy()
			return this
		}

		let index = this.children.indexOf(child)
		if (index == -1) {
			return this
		}

		setEmitterResponder(child, null)

		removeItem(this, child, index)
		removeView(this, child, index)

		this.emit<ViewRemoveEvent>('remove', { data: { child, index } })

		return this
	}

	/**
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
	 * @method removeAll
	 * @since 0.7.0
	 */
	public removeAll() {

		while (this.children.length) {
			this.remove(this.children[0])
		}

		return this
	}

	/**
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
	// Lifecycle
	//--------------------------------------------------------------------------

	/**
	 * @method onDestroy
	 * @since 0.4.0
	 */
	protected onDestroy() {

	}

	//--------------------------------------------------------------------------
	// Methods: Measuring and Drawing
	//--------------------------------------------------------------------------

	/**
	 * @method scheduleRedraw
	 * @since 0.1.0
	 */
	public scheduleRedraw() {
		native(this).scheduleRedraw()
		return this
	}

	/**
	 * @method scheduleLayout
	 * @since 0.1.0
	 */
	public scheduleLayout() {
		native(this).scheduleLayout()
		return this
	}

	/**
	 * @method resolve
	 * @since 0.1.0
	 */
	public resolve() {
		native(this).resolve()
		return this
	}

	/**
	 * @method measure
	 * @since 0.1.0
	 */
	public measure() {
		native(this).measure()
		return this
	}

	//--------------------------------------------------------------------------
	// Methods: Animation
	//--------------------------------------------------------------------------

	/**
	 * @method transition
	 * @since 0.4.0
	 */
	public transition(animate: ViewTransitionProperties<View>): Promise<void>
	public transition(options: ViewTransitionOptions, animate: ViewTransitionProperties<View>): Promise<void>
	public transition(...args: Array<any>): Promise<void> {

		let animate: any = {}
		let options: ViewTransitionOptions = {
			duration: AnimationDefaultDuration,
			equation: AnimationDefaultEquation,
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
	// Scrolling
	//--------------------------------------------------------------------------

	/**
	 * @method scrollTo
	 * @since 0.1.0
	 */
	public scrollTo(top: number, left: number = 0) {
		native(this).scrollTo(top, left)
		return this
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @method onEvent
	 * @since 0.7.0
	 */
	public onEvent(event: Event) {

		super.onEvent(event)

		if (event instanceof TouchEvent) {

			switch (event.type) {

				case 'touchstart':
					this.onTouchStart(event)
					break

				case 'touchmove':
					this.onTouchMove(event)
					break

				case 'touchend':
					this.onTouchEnd(event)
					break

				case 'touchcancel':
					this.onTouchCancel(event)
					break
			}

			this.gestures.onTouchEvent(event)
		}

		switch (event.type) {

			case 'destroy':
				this.onDestroy()
				break

			case 'layout':
				this.onLayout()
				break

			case 'redraw':
				this.onRedraw(event.data.canvas)
				break

			case 'insert':
				this.onInsert(event.data.child, event.data.index)
				break

			case 'remove':
				this.onRemove(event.data.child, event.data.index)
				break

			case 'movetoparent':
				this.onMoveToParent(event.data.parent)
				break

			case 'movetowindow':
				this.onMoveToWindow(event.data.window)
				break

			case 'scrollstart':
				this.onScrollStart()
				break

			case 'scrollend':
				this.onScrollEnd()
				break

			case 'scroll':
				this.onScroll()
				break

			case 'overscroll':
				this.onOverscroll()
				break

			case 'dragstart':
				this.onDragStart()
				break

			case 'dragend':
				this.onDragEnd()
				break

			case 'drag':
				this.onDrag()
				break

			case 'zoomstart':
				this.onZoomStart()
				break

			case 'zoomend':
				this.onZoomEnd()
				break

			case 'zoom':
				this.onZoom()
				break
		}
	}

	/**
	 * @method onLayout
	 * @since 0.1.0
	 */
	protected onLayout() {

	}

	/**
	 * @method onRedraw
	 * @since 0.4.0
	 */
	protected onRedraw(canvas: Canvas) {

	}

	/**
	 * @method onInsert
	 * @since 0.1.0
	 */
	protected onInsert(child: View, index: number) {

	}

	/**
	 * @method onRemove
	 * @since 0.1.0
	 */
	protected onRemove(child: View, index: number) {

	}

	/**
	 * @method onMoveToWindow
	 * @since 0.2.0
	 */
	protected onMoveToWindow(window: Window | null) {

	}

	/**
	 * @method onMoveToParent
	 * @since 0.2.0
	 */
	protected onMoveToParent(parent: View | null) {

	}

	/**
	 * @method onScrollStart
	 * @since 0.1.0
	 */
	protected onScrollStart() {

	}

	/**
	 * @method onScrollEnd
	 * @since 0.1.0
	 */
	protected onScrollEnd() {

	}

	/**
	 * @method onScroll
	 * @since 0.1.0
	 */
	protected onScroll() {

	}

	/**
	 * @method onOverscroll
	 * @since 0.1.0
	 */
	protected onOverscroll() {

	}

	/**
	 * @method onDragStart
	 * @since 0.1.0
	 */
	protected onDragStart() {

	}

	/**
	 * @method onDragEnd
	 * @since 0.1.0
	 */
	protected onDragEnd() {

	}

	/**
	 * @method onDrag
	 * @since 0.1.0
	 */
	protected onDrag() {

	}

	/**
	 * @method onZoomStart
	 * @since 0.3.0
	 */
	protected onZoomStart() {

	}

	/**
	 * @method onZoomEnd
	 * @since 0.3.0
	 */
	protected onZoomEnd() {

	}

	/**
	 * @method onZoom
	 * @since 0.3.0
	 */
	protected onZoom() {

	}

	/**
	 * @method onTouchStart
	 * @since 0.1.0
	 */
	protected onTouchStart(event: TouchEvent) {

	}

	/**
	 * @method onTouchMove
	 * @since 0.1.0
	 */
	protected onTouchMove(event: TouchEvent) {

	}

	/**
	 * @method onTouchEnd
	 * @since 0.1.0
	 */
	protected onTouchEnd(event: TouchEvent) {

	}

	/**
	 * @method onTouchCancel
	 * @since 0.1.0
	 */
	protected onTouchCancel(event: TouchEvent) {

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
	 * @method dispatchTouchCancel
	 * @since 0.7.0
	 */
	public dispatchTouchCancel(event: TouchEvent) {

	}

	/**
	 * @method dispatchTouchStart
	 * @since 0.7.0
	 */
	public dispatchTouchStart(event: TouchEvent) {

	}

	/**
	 * @method dispatchTouchMove
	 * @since 0.7.0
	 */
	public dispatchTouchMove(evnet: TouchEvent) {

	}

	/**
	 * @method dispatchTouchEnd
	 * @since 0.7.0
	 */
	public dispatchTouchEnd(event: TouchEvent) {

	}

	/**
	 * @method setDefaultValue
	 * @since 0.4.0
	 */
	public setDefaultValue(value: string | number | boolean) {
		// TODO
		// Rename coherce something
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property $styles
	 * @since 0.7.0
	 * @hidden
	 */
	private [$styles]: StyleList = new StyleList(this)

	/**
	 * @property $states
	 * @since 0.7.0
	 * @hidden
	 */
	private [$states]: StateList = new StateList(this)

	/**
	 * @property $gestures
	 * @since 0.7.0
	 * @hidden
	 */
	private [$gestures]: GestureManager = new GestureManager(this)

	/**
	 * @property $children
	 * @since 0.7.0
	 * @hidden
	 */
	private [$children]: Array<View> = []

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

	/**
	 * @method nativeOnDestroy
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnDestroy() {
		this.emit('destroy')
	}

	/**
	 * @method nativeOnMoveToParent
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnMoveToParent(parent: View) {
		this.emit<ViewMoveToParentEvent>('movetoparent', { data: { parent } })
	}

	/**
	 * @method nativeOnMoveToWindow
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnMoveToWindow(window: Window) {
		this.emit<ViewMoveToWindowEvent>('movetowindow', { data: { window } })
	}

	/**
	 * @method nativeOnScrollStart
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnScrollStart() {
		this.emit('scrollstart')
	}

	/**
	 * @method nativeOnScrollEnd
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnScrollEnd() {
		this.emit('scrollend')
	}

	/**
	 * @method nativeOnScroll
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnScroll() {
		this.emit('scroll')
	}

	/**
	 * @method nativeOnDragStart
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeOnDragStart() {
		this.emit('dragstart')
	}

	/**
	 * @method nativeOnDragEnd
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnDragEnd() {
		this.emit('dragend')
	}

	/**
	 * @method nativeOnDrag
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnDrag() {
		this.emit('drag')
	}

	/**
	 * @method nativeOnZoomStart
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnZoomStart() {
		this.emit('zoomstart')
	}

	/**
	 * @method nativeOnZoomEnd
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnZoomEnd(scale: number) {
		this.emit('zoomend', { data: { scale } })
	}

	/**
	 * @method nativeOnZoom
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnZoom() {
		this.emit('zoom')
	}

	/**
	 * @method nativeOnLayout
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnLayout() {
		this.emit('layout')
	}

	/**
	 * @method nativeOnRedraw
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnRedraw(canvas: Canvas) {
		this.emit<ViewRedrawEvent>('redraw', { data: { canvas } })
	}
}

/**
 * @const AnimationDefaultDuration
 * @since 0.4.0
 */
export const AnimationDefaultDuration = 350

/**
 * @const AnimationDefaultEquation
 * @since 0.4.0
 */
export const AnimationDefaultEquation = [0.25, 0.1, 0.25, 1.0]

/**
 * @const AnimationDurationRegistry
 * @since 0.1.0
 */
export const AnimationDurationRegistry: Map<string, number> = new Map()
AnimationDurationRegistry.set('slow', 750)
AnimationDurationRegistry.set('fast', 250)

/**
 * @const AnimationEquationRegistry
 * @since 0.1.0
 */
export const AnimationEquationRegistry: Map<string, Array<number>> = new Map()
AnimationEquationRegistry.set('default', [0.25, 0.1, 0.25, 1.0])
AnimationEquationRegistry.set('linear', [0.0, 0.0, 1.0, 1.0])
AnimationEquationRegistry.set('ease-in', [0.42, 0.0, 1.0, 1.0])
AnimationEquationRegistry.set('ease-out', [0.0, 0.0, 0.58, 1.0])
AnimationEquationRegistry.set('ease-in-out', [0.42, 0, 0.58, 1.0])

/**
 * @interface ViewTransitionOptions
 * @since 0.1.0
 */
export interface ViewTransitionOptions {
	equation?: string | Array<number>
	duration?: string | number
	delay?: number
}

/**
 * @type ViewTransitionProperties
 * @since 0.4.0
 */
export type ViewTransitionProperties<T> = {
	[P in keyof T]?: T[P]
}

/**
 * @type ViewInsertEvent
 * @since 0.1.0
 */
export type ViewInsertEvent = {
	child: View
	index: number
}

/**
 * @type ViewRemoveEvent
 * @since 0.1.0
 */
export type ViewRemoveEvent = {
	child: View
	index: number
}

/**
 * @type ViewMoveToParentEvent
 * @since 0.2.0
 */
export type ViewMoveToParentEvent = {
	parent: View | null
}

/**
 * @type ViewMoveToWindowEvent
 * @since 0.1.0
 */
export type ViewMoveToWindowEvent = {
	window: Window | null
}

/**
 * @type ViewRedrawEvent
 * @since 0.4.0
 */
export type ViewRedrawEvent = {
	canvas: Canvas
}