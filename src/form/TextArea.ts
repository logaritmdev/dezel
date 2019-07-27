import { bound } from '../decorator/bound'
import { bridge } from '../decorator/bridge'
import { native } from '../decorator/native'
import { state } from '../decorator/state'
import { watch } from '../decorator/watch'
import { Event } from '../event/Event'
import { GestureEvent } from '../gesture/GestureEvent'
import { Touch } from '../touch/Touch'
import { TouchEvent } from '../touch/TouchEvent'
import { View } from '../view/View'
import { ViewMoveToWindowEvent } from '../view/View'
import { Window } from '../view/Window'
import './TextArea.ds'
import './TextArea.ds.android'
import './TextArea.ds.ios'


@bridge('dezel.form.TextArea')

/**
 * Displays an editable area of multiple lines.
 * @class TextArea
 * @super View
 * @since 0.1.0
 */
export class TextArea extends View {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The text area's value.
	 * @property value
	 * @since 0.1.0
	 */
	@native public value!: string

	/**
	 * The text area's placeholder.
	 * @property placeholder
	 * @since 0.1.0
	 */
	@native public placeholder!: string

	/**
	 * The text area's placeholder color.
	 * @property placeholderColor
	 * @since 0.1.0
	 */
	@native public placeholderColor!: string

	/**
	 * The text area's autocorrect status.
	 * @property autocorrect
	 * @since 0.1.0
	 */
	@native public autocorrect!: boolean

	/**
	 * The text area's autocapitalize status.
	 * @property autocapitalize
	 * @since 0.1.0
	 */
	@native public autocapitalize!: boolean

	/**
	 * The text area's font family.
	 * @property fontFamily
	 * @since 0.1.0
	 */
	@native public fontFamily!: string

	/**
	 * The text area's font weight.
	 * @property fontWeight
	 * @since 0.1.0
	 */
	@native public fontWeight!: string

	/**
	 * The text area's font style.
	 * @property fontStyle
	 * @since 0.1.0
	 */
	@native public fontStyle!: string

	/**
	 * The text area's font size.
	 * @property fontSize
	 * @since 0.1.0
	 */
	@native public fontSize!: number

	/**
	 * The text area's text color.
	 * @property textColor
	 * @since 0.1.0
	 */
	@native public textColor!: string

	/**
	 * The text area's text horizontal alignment.
	 * @property textAlignment
	 * @since 0.1.0
	 */
	@native public textAlignment!: 'start' | 'end' | 'left' | 'right' | 'center'

	/**
	 * The text area's text vertical alignment.
	 * @property textPlacement
	 * @since 0.1.0
	 */
	@native public textPlacement!: 'top' | 'middle' | 'bottom'

	/**
	 * The text area's text kerning.
	 * @property textKerning
	 * @since 0.1.0
	 */
	@native public textKerning!: number

	/**
	 * The text area's text leading.
	 * @property textLeading
	 * @since 0.1.0
	 */
	@native public textLeading!: number

	/**
	 * The text area's text decoration.
	 * @property textDecoration
	 * @since 0.1.0
	 */
	@native public textDecoration!: string

	/**
	 * The text area's text tranform.
	 * @property textTransform
	 * @since 0.1.0
	 */
	@native public textTransform!: 'none' | 'uppercase' | 'lowercase' | 'capitalize'

	/**
	 * The text area's text shadow blur distance.
	 * @property textShadowBlur
	 * @since 0.1.0
	 */
	@native public textShadowBlur!: number

	/**
	 * The text area's text shadow color.
	 * @property textShadowColor
	 * @since 0.1.0
	 */
	@native public textShadowColor!: string

	/**
	 * The text area's text shadow vertical offset.
	 * @property textShadowOffsetTop
	 * @since 0.1.0
	 */
	@native public textShadowOffsetTop!: number

	/**
	 * The text area's text shadow horizontal offset.
	 * @property textShadowOffsetLeft
	 * @since 0.1.0
	 */
	@native public textShadowOffsetLeft!: number

	/**
	 * Whether the state of this text input is disabled.
	 * @property disabled
	 * @since 0.1.0
	 */
	@state public disabled: boolean = false

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Gives the focus to the input.
	 * @method focus
	 * @since 0.1.0
	 */
	public focus() {
		this.native.focus()
		return this
	}

	/**
	 * Removes the focus from the input.
	 * @method blur
	 * @since 0.1.0
	 */
	public blur() {
		this.native.blur()
		return this
	}

	//--------------------------------------------------------------------------
	// Events
	//--------------------------------------------------------------------------

	/**
	 * @inherited
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
	 * Called when the text field changes value from a user input.
	 * @method onInput
	 * @since 0.1.0
	 */
	public onInput(event: Event) {

	}

	/**
	 * Called when the text field receives the focus.
	 * @method onFocus
	 * @since 0.1.0
	 */
	public onFocus(event: Event) {

	}

	/**
	 * Called when the text field loses the focus.
	 * @method onBlur
	 * @since 0.1.0
	 */
	public onBlur(event: Event) {

	}

	/**
	 * @inherited
	 * @method onMoveToWindow
	 * @since 0.2.0
	 */
	public onMoveToWindow(window?: Window | null) {

		super.onMoveToWindow(window)

		if (this.window) {
			this.window.off('tap', this.onWindowTap)
		}

		if (window) {
			window.on('tap', this.onWindowTap)
		}
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property trackedOutsideTouch
	 * @since 0.1.0
	 * @hidden
	 */
	private trackedOutsideTouch?: Touch | null

	/**
	 * @method onBlurDefault
	 * @since 0.1.0
	 * @hidden
	 */
	private onBlurDefault(event: Event) {
		this.setState('focused', false)
	}

	/**
	 * @method onFocusDefault
	 * @since 0.1.0
	 * @hidden
	 */
	private onFocusDefault(event: Event) {
		this.setState('focused', true)
	}

	/**
	 * @method onWindowTap
	 * @since 0.1.0
	 * @hidden
	 */
	@bound private onWindowTap(event: GestureEvent) {

		for (let touch of event.touches) {
			if (touch.target == this) {
				return
			}
		}

		this.blur()
	}

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

	/**
	 * @method private nativeChange
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeChange(value: string) {
		this.emit<TextAreaChangeEvent>('change', { data: { value } })
	}

	/**
	 * @method private nativeFocus
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeFocus() {
		this.emit('focus')
	}

	/**
	 * @method private nativeBlur
	 * @since 0.1.0
	 * @hidden
	 */
	private nativeBlur() {
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