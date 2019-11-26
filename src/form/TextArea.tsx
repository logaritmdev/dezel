import { bound } from '../decorator/bound'
import { state } from '../decorator/state'
import { Event } from '../event/Event'
import { bridge } from '../native/bridge'
import { native } from '../native/native'
import { View } from '../view/View'
import { Window } from '../view/Window'
import './style/TextArea.style'
import './style/TextArea.style.android'
import './style/TextArea.style.ios'

@bridge('dezel.form.TextArea')

/**
 * @class TextArea
 * @super View
 * @since 0.1.0
 */
export class TextArea extends View {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property value
	 * @since 0.1.0
	 */
	@native public value!: string

	/**
	 * @property placeholder
	 * @since 0.1.0
	 */
	@native public placeholder!: string

	/**
	 * @property placeholderColor
	 * @since 0.1.0
	 */
	@native public placeholderColor!: string

	/**
	 * @property autocorrect
	 * @since 0.1.0
	 */
	@native public autocorrect!: boolean

	/**
	 * @property autocapitalize
	 * @since 0.1.0
	 */
	@native public autocapitalize!: boolean

	/**
	 * @property fontFamily
	 * @since 0.1.0
	 */
	@native public fontFamily!: string

	/**
	 * @property fontWeight
	 * @since 0.1.0
	 */
	@native public fontWeight!: string

	/**
	 * @property fontStyle
	 * @since 0.1.0
	 */
	@native public fontStyle!: string

	/**
	 * @property fontSize
	 * @since 0.1.0
	 */
	@native public fontSize!: number

	/**
	 * @property textColor
	 * @since 0.1.0
	 */
	@native public textColor!: string

	/**
	 * @property textAlignment
	 * @since 0.1.0
	 */
	@native public textAlignment!: 'start' | 'end' | 'left' | 'right' | 'center'

	/**
	 * @property textLocation
	 * @since 0.1.0
	 */
	@native public textLocation!: 'top' | 'middle' | 'bottom'

	/**
	 * @property textKerning
	 * @since 0.1.0
	 */
	@native public textKerning!: number

	/**
	 * @property textLeading
	 * @since 0.1.0
	 */
	@native public textLeading!: number

	/**
	 * @property textDecoration
	 * @since 0.1.0
	 */
	@native public textDecoration!: string

	/**
	 * @property textTransform
	 * @since 0.1.0
	 */
	@native public textTransform!: 'none' | 'uppercase' | 'lowercase' | 'capitalize'

	/**
	 * @property textShadowBlur
	 * @since 0.1.0
	 */
	@native public textShadowBlur!: number

	/**
	 * @property textShadowColor
	 * @since 0.1.0
	 */
	@native public textShadowColor!: string

	/**
	 * @property textShadowOffsetTop
	 * @since 0.1.0
	 */
	@native public textShadowOffsetTop!: number

	/**
	 * @property textShadowOffsetLeft
	 * @since 0.1.0
	 */
	@native public textShadowOffsetLeft!: number

	/**
	 * @property disabled
	 * @since 0.1.0
	 */
	@state public disabled: boolean = false

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method focus
	 * @since 0.1.0
	 */
	public focus() {
		native(this).focus()
		return this
	}

	/**
	 * @method blur
	 * @since 0.1.0
	 */
	public blur() {
		native(this).blur()
		return this
	}

	/**
	 * @method selectRange
	 * @since 0.5.0
	 */
	public selectRange(): TextArea
	public selectRange(index: number | null): TextArea
	public selectRange(index: number | null, ending: number | null): TextArea
	public selectRange(...args: Array<any>): TextArea {

		switch (args.length) {

			case 0:
				native(this).selectRange()
				break

			case 1:
				native(this).selectRange(args[0], args[0])
				break

			case 2:
				native(this).selectRange(args[0], args[1])
				break
		}

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

		switch (event.type) {

			case 'input':
				this.onInput(event)
				break

			case 'focus':
				this.onFocusDefault(event)
				this.onFocus(event)
				break

			case 'blur':
				this.onBlurDefault(event)
				this.onBlur(event)
				break
		}

		return super.onEvent(event)
	}

	/**
	 * @method onInput
	 * @since 0.1.0
	 */
	protected onInput(event: Event) {

	}

	/**
	 * @method onFocus
	 * @since 0.1.0
	 */
	protected onFocus(event: Event) {

	}

	/**
	 * @method onBlur
	 * @since 0.1.0
	 */
	protected onBlur(event: Event) {

	}

	/**
	 * @method onMoveToWindow
	 * @since 0.2.0
	 */
	protected onMoveToWindow(window: Window | null) {
		// TODO
		// Fix this with gesture
		// if (this.window) {
		// 	this.window.off('tap', this.onWindowTap)
		// }

		// if (window) {
		// 	window.on('tap', this.onWindowTap)
		// }
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method onBlurDefault
	 * @since 0.1.0
	 * @hidden
	 */
	private onBlurDefault(event: Event) {
		this.states.remove('focused')
	}

	/**
	 * @method onFocusDefault
	 * @since 0.1.0
	 * @hidden
	 */
	private onFocusDefault(event: Event) {
		this.states.append('focused')
	}

	/**
	 * @method onWindowTap
	 * @since 0.1.0
	 * @hidden
	 */
	// @bound private onWindowTap(event: GestureEvent) {

	// 	for (let touch of event.touches) {
	// 		if (touch.target == this) {
	// 			return
	// 		}
	// 	}

	// 	this.blur()
	// }

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

	/**
	 * @method nativeOnChange
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnChange(value: string) {
		this.emit<TextAreaChangeEvent>('change', { data: { value } })
	}

	/**
	 * @method nativeOnFocus
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnFocus() {
		this.emit('focus')
	}

	/**
	 * @method nativeOnBlur
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnBlur() {
		this.emit('blur')
	}
}

/**
 * @type TextAreaChangeEvent
 * @since 0.1.0
 */
export type TextAreaChangeEvent = {
	value: string
}