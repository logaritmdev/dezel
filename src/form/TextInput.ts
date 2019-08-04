import { bound } from '../decorator/bound'
import { state } from '../decorator/state'
import { watch } from '../decorator/watch'
import { Event } from '../event/Event'
import { GestureEvent } from '../gesture/GestureEvent'
import { bridge } from '../native/bridge'
import { native } from '../native/native'
import { Touch } from '../touch/Touch'
import { TouchEvent } from '../touch/TouchEvent'
import { View } from '../view/View'
import { ViewMoveToWindowEvent } from '../view/View'
import { Window } from '../view/Window'
import './TextInput.ds'
import './TextInput.ds.android'
import './TextInput.ds.ios'


@bridge('dezel.form.TextInput')

/**
 * Displays an editable area of a single line.
 * @class TextInput
 * @super View
 * @since 0.1.0
 */
export class TextInput extends View {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The text input's type.
	 * @property type
	 * @since 0.1.0
	 */
	@native public type!: 'text' | 'number' | 'email' | 'phone' | 'password'

	/**
	 * The text input's value.
	 * @property value
	 * @since 0.1.0
	 */
	@native public value!: string

	/**
	 * The text input's placeholder.
	 * @property placeholder
	 * @since 0.1.0
	 */
	@native public placeholder!: string

	/**
	 * The text input's placeholder color.
	 * @property placeholderColor
	 * @since 0.1.0
	 */
	@native public placeholderColor!: string

	/**
	 * The text input's format.
	 * @property format
	 * @since 0.5.0
	 */
	@native public format!: string

	/**
	 * The text input's locale.
	 * @property locale
	 * @since 0.5.0
	 */
	@native public locale!: string

	/**
	 * The text input's autocorrect status.
	 * @property autocorrect
	 * @since 0.1.0
	 */
	@native public autocorrect!: boolean

	/**
	 * The text input's autocapitalize status.
	 * @property autocapitalize
	 * @since 0.1.0
	 */
	@native public autocapitalize!: boolean

	/**
	 * The text input's font family.
	 * @property fontFamily
	 * @since 0.1.0
	 */
	@native public fontFamily!: string

	/**
	 * The text input's font weight.
	 * @property fontWeight
	 * @since 0.1.0
	 */
	@native public fontWeight!: string

	/**
	 * The text input's font style.
	 * @property fontStyle
	 * @since 0.1.0
	 */
	@native public fontStyle!: string

	/**
	 * The text input's font size.
	 * @property fontSize
	 * @since 0.1.0
	 */
	@native public fontSize!: number

	/**
	 * The text input's text color.
	 * @property textColor
	 * @since 0.1.0
	 */
	@native public textColor!: string

	/**
	 * The text input's text horizontal alignment.
	 * @property textAlignment
	 * @since 0.1.0
	 */
	@native public textAlignment!: 'start' | 'end' | 'left' | 'right' | 'center'

	/**
	 * The text input's text vertical alignment.
	 * @property textLocation
	 * @since 0.1.0
	 */
	@native public textLocation!: 'top' | 'middle' | 'bottom'

	/**
	 * The text input's text kerning.
	 * @property textKerning
	 * @since 0.1.0
	 */
	@native public textKerning!: number

	/**
	 * The text input's text leading.
	 * @property textLeading
	 * @since 0.1.0
	 */
	@native public textLeading!: number

	/**
	 * The text input's text decoration.
	 * @property textDecoration
	 * @since 0.1.0
	 */
	@native public textDecoration!: string

	/**
	 * The text input's text tranform.
	 * @property textTransform
	 * @since 0.1.0
	 */
	@native public textTransform!: 'none' | 'uppercase' | 'lowercase' | 'capitalize'

	/**
	 * The text input's text shadow blur distance.
	 * @property textShadowBlur
	 * @since 0.1.0
	 */
	@native public textShadowBlur!: number

	/**
	 * The text input's text shadow color.
	 * @property textShadowColor
	 * @since 0.1.0
	 */
	@native public textShadowColor!: string

	/**
	 * The text input's text shadow vertical offset.
	 * @property textShadowOffsetTop
	 * @since 0.1.0
	 */
	@native public textShadowOffsetTop!: number

	/**
	 * The text input's text shadow horizontal offset.
	 * @property textShadowOffsetLeft
	 * @since 0.1.0
	 */
	@native public textShadowOffsetLeft!: number

	/**
	 * Whether to display a clear button.
	 * @property clearButton
	 * @since 0.1.0
	 */
	@native public clearButton!: boolean

	/**
	 * The text input'S clear button color.
	 * @property clearButtonColor
	 * @since 0.1.0
	 */
	@native public clearButtonColor!: string

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
		native(this).focus()
		return this
	}

	/**
	 * Removes the focus from the input.
	 * @method blur
	 * @since 0.1.0
	 */
	public blur() {
		native(this).blur()
		return this
	}

	/**
	 * Select text with specified range.
	 * @method selectRange
	 * @since 0.5.0
	 */

	public selectRange(): TextInput
	public selectRange(index: number | null): TextInput
	public selectRange(index: number | null, ending: number | null): TextInput
	public selectRange(...args: Array<any>): TextInput {

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
	protected onInput(event: Event) {

	}

	/**
	 * Called when the text field receives the focus.
	 * @method onFocus
	 * @since 0.1.0
	 */
	protected onFocus(event: Event) {

	}

	/**
	 * Called when the text field loses the focus.
	 * @method onBlur
	 * @since 0.1.0
	 */
	protected onBlur(event: Event) {

	}

	/**
	 * @inherited
	 * @method onMoveToWindow
	 * @since 0.2.0
	 */
	protected onMoveToWindow(window: Window | null) {

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
	 * @method nativeOnChange
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnChange(value: string) {
		this.emit<TextInputChangeEvent>('change', { data: { value } })
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
 * @type TextInputChangeEvent
 * @since 0.1.0
 */
export type TextInputChangeEvent = {
	value: string
}