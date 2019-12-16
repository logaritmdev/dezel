import { bound } from '../decorator/bound'
import { state } from '../decorator/state'
import { bridge } from '../native/bridge'
import { native } from '../native/native'
import { Event } from '../event/Event'
import { TapGestureDetector } from '../gesture/TapGestureDetector'
import { View } from '../view/View'
import { Window } from '../view/Window'
import './style/TextInput.style'
import './style/TextInput.style.android'
import './style/TextInput.style.ios'

@bridge('dezel.form.TextInput')

/**
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
	 * Whether the text input auto corrects the value.
	 * @property autocorrect
	 * @since 0.1.0
	 */
	@native public autocorrect!: boolean

	/**
	 * Whether the text input auto capitalizes the value.
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
	 * The text input's text alignment.
	 * @property textAlign
	 * @since 0.1.0
	 */
	@native public textAlign!: 'top left' | 'top right' | 'top center' | 'left' | 'right' | 'center' | 'bottom left' | 'bottom right' | 'bottom center'

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
	 * The text input's text transform.
	 * @property textTransform
	 * @since 0.1.0
	 */
	@native public textTransform!: 'none' | 'uppercase' | 'lowercase' | 'capitalize'

	/**
	 * The text input's text shadow blur size.
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
	 * The text input's text shadow top offset.
	 * @property textShadowOffsetTop
	 * @since 0.1.0
	 */
	@native public textShadowOffsetTop!: number

	/**
	 * The text input's text shadow left offset.
	 * @property textShadowOffsetLeft
	 * @since 0.1.0
	 */
	@native public textShadowOffsetLeft!: number

	/**
	 * Whether the text input is disabled.
	 * @property disabled
	 * @since 0.1.0
	 */
	@state public disabled: boolean = false

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Moves the focus to this text input.
	 * @method focus
	 * @since 0.1.0
	 */
	public focus() {
		native(this).focus()
		return this
	}

	/**
	 * Removes the focus from this text input.
	 * @method blur
	 * @since 0.1.0
	 */
	public blur() {
		native(this).blur()
		return this
	}

	/**
	 * Select text at range.
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

			case 'change':
				this.onChange(event)
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
	 * Called when the text input value changes.
	 * @method onChange
	 * @since 0.1.0
	 */
	public onChange(event: Event) {

	}

	/**
	 * Called when the text input receives the focus.
	 * @method onFocus
	 * @since 0.1.0
	 */
	public onFocus(event: Event) {

	}

	/**
	 * Called when the text input loses the focus.
	 * @method onBlur
	 * @since 0.1.0
	 */
	public onBlur(event: Event) {

	}

	/**
	 * @inherited
	 * @method onMoveToWindow
	 * @since 0.7.0
	 */
	public onMoveToWindow(window: Window | null, former: Window | null) {

		if (window) {
			window.gestures.append(this.gesture)
			return
		}

		if (former) {
			former.gestures.remove(this.gesture)
			return
		}
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @property gesture
	 * @since 0.7.0
	 * @hidden
	 */
	private gesture: TapGestureDetector = new TapGestureDetector(callback => {

		let target = this.window?.findViewAt(callback.x, callback.y)
		if (target == this) {
			return
		}

		this.blur()
	})

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