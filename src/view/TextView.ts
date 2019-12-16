import { setValueOf } from '../jsx/private/createElement'
import { bridge } from '../native/bridge'
import { native } from '../native/native'
import { View } from './View'

@bridge('dezel.view.TextView')

/**
  * @class TextView
 * @super View
 * @since 0.1.0
 */
export class TextView extends View {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The text view's font family.
	 * @property fontFamily
	 * @since 0.1.0
	 */
	@native public fontFamily!: string

	/**
	 * The text view's font weight.
	 * @property fontWeight
	 * @since 0.1.0
	 */
	@native public fontWeight!: string

	/**
	 * The text view's font style.
	 * @property fontStyle
	 * @since 0.1.0
	 */
	@native public fontStyle!: string

	/**
	 * The text view's font size.
	 * @property fontSize
	 * @since 0.1.0
	 */
	@native public fontSize!: number | string

	/**
	 * The text view's minimum font size.
	 * @property minFontSize
	 * @since 0.1.0
	 */
	@native public minFontSize!: number

	/**
	 * The text view's maximum font size.
	 * @property maxFontSize
	 * @since 0.1.0
	 */
	@native public maxFontSize!: number

	/**
	 * The text view's text.
	 * @property text
	 * @since 0.1.0
	 */
	@native public text!: string

	/**
	 * The text view's text color.
	 * @property textColor
	 * @since 0.1.0
	 */
	@native public textColor!: string

	/**
	 * The text view's text align.
	 * @property textAlign
	 * @since 0.1.0
	 */
	@native public textAlign!: 'top left' | 'top right' | 'top center' | 'left' | 'right' | 'center' | 'bottom left' | 'bottom right' | 'bottom center'

	/**
	 * The text view's text baseline.
	 * @property textBaseline
	 * @since 0.1.0
	 */
	@native public textBaseline!: number

	/**
	 * The text view text kerning.
	 * @property textKerning
	 * @since 0.1.0
	 */
	@native public textKerning!: number

	/**
	 * The text view's text leading.
	 * @property textLeading
	 * @since 0.1.0
	 */
	@native public textLeading!: number

	/**
	 * The text view's text decoration.
	 * @property textDecoration
	 * @since 0.1.0
	 */
	@native public textDecoration!: 'none' | 'underline'

	/**
	 * The text view's text transform.
	 * @property textTransform
	 * @since 0.1.0
	 */
	@native public textTransform!: 'none' | 'uppercase' | 'lowercase' | 'capitalize'

	/**
	 * The text view's text overflow.
	 * @property textOverflow
	 * @since 0.1.0
	 */
	@native public textOverflow!: 'clip' | 'ellipsis'

	/**
	 * The text view's shadow blur size.
	 * @property textShadowBlur
	 * @since 0.1.0
	 */
	@native public textShadowBlur!: number

	/**
	 * The text view's text shadow color.
	 * @property textShadowColor
	 * @since 0.1.0
	 */
	@native public textShadowColor!: string

	/**
	 * The text view's text shadow top offset.
	 * @property textShadowOffsetTop
	 * @since 0.1.0
	 */
	@native public textShadowOffsetTop!: number

	/**
	 * The text view's text shadow left offset.
	 * @property textShadowOffsetLeft
	 * @since 0.1.0
	 */
	@native public textShadowOffsetLeft!: number

	/**
	 * The text view's link color.
	 * @property linkColor
	 * @since 0.1.0
	 */
	@native public linkColor!: string

	/**
	 * The text view's minimum amount of lines.
	 * @property minLines
	 * @since 0.7.0
	 */
	@native public minLines!: number

	/**
	 * The text view's maximum amount of lines.
	 * @property maxLines
	 * @since 0.7.0
	 */
	@native public maxLines!: number

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Measures the text view's text in the specified bounds.
	 * @method measureText
	 * @since 0.1.0
	 */
	public measureText(width: number, height: number) {

		if (width == null) {
			width = -1
		}

		if (height == null) {
			height = -1
		}

		return native(this).measureText(width, height)
	}

	//--------------------------------------------------------------------------
	// Internal API
	//------------------------------------------------ --------------------------

	/**
	 * @property setValueOf
	 * @since 0.7.0
	 * @hidden
	 */
	public [setValueOf] = function (this: TextView, value: number | string | boolean) {
		this.text = String(value)
	}

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

	/**
	 * @method nativeOnPressLink
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnPressLink(url: string) {
		this.emit('presslink', { data: { url } })
	}
}
