import { bound } from '../decorator/bound'
import { state } from '../decorator/state'
import { bridge } from '../native/bridge'
import { native } from '../native/native'
import { Event } from '../event/Event'
import { TapGestureDetector } from '../gesture/TapGestureDetector'
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
	 * Whether the text area auto corrects the value.
	 * @property autocorrect
	 * @since 0.1.0
	 */
	@native public autocorrect!: boolean

	/**
	 * Whether the text area auto capitalizes the value.
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
	 * The text area's text alignment.
	 * @property textAlign
	 * @since 0.1.0
	 */
	@native public textAlign!: 'top left' | 'top right' | 'top center' | 'left' | 'right' | 'center' | 'bottom left' | 'bottom right' | 'bottom center'

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
	 * The text area's text transform.
	 * @property textTransform
	 * @since 0.1.0
	 */
	@native public textTransform!: 'none' | 'uppercase' | 'lowercase' | 'capitalize'

	/**
	 * The text area's text shadow blur size.
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
	 * The text area's text shadow top offset.
	 * @property textShadowOffsetTop
	 * @since 0.1.0
	 */
	@native public textShadowOffsetTop!: number

	/**
	 * The text area's text shadow left offset.
	 * @property textShadowOffsetLeft
	 * @since 0.1.0
	 */
	@native public textShadowOffsetLeft!: number

	/**
	 * Whether the text area is disabled.
	 * @property disabled
	 * @since 0.1.0
	 */
	@state public disabled: boolean = false

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Moves the focus to this text area.
	 * @method focus
	 * @since 0.1.0
	 */
	public focus() {
		native(this).focus()
		return this
	}

	/**
	 * Removes the focus from this text area.
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
	 * Called when the text area's value changes.
	 * @method onChange
	 * @since 0.1.0
	 */
	public onChange(event: Event) {

	}

	/**
	 * Called when the text area receives the focus.
	 * @method onFocus
	 * @since 0.1.0
	 */
	public onFocus(event: Event) {

	}

	/**
	 * Called when the text area loses the focus.
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