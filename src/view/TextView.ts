import { bridge } from '../decorator/bridge'
import { native } from '../decorator/native'
import { View } from './View'

@bridge('dezel.view.TextView')

/**
 * Displays static text.
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
	 * The text view's text alignment.
	 * @property textAlignment
	 * @since 0.1.0
	 */
	@native public textAlignment!: 'start' | 'end' | 'left' | 'right' | 'center'

	/**
	 * The text view's text placement.
	 * @property textPlacement
	 * @since 0.1.0
	 */
	@native public textPlacement!: 'top' | 'middle' | 'bottom'

	/**
	 * The text view's text baseline offset.
	 * @property textBaseline
	 * @since 0.1.0
	 */
	@native public textBaseline!: number

	/**
	 * The text view's text kerning.
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
	 * The text view's text shadow blur distance.
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
	 * The text view's text shadow vertical offset.
	 * @property textShadowOffsetTop
	 * @since 0.1.0
	 */
	@native public textShadowOffsetTop!: number

	/**
	 * The text view's text shadow horizontal offset.
	 * @property textShadowOffsetLeft
	 * @since 0.1.0
	 */
	@native public textShadowOffsetLeft!: number

	/**
	 * The text view's text decoration.
	 * @property textDecoration
	 * @since 0.1.0
	 */
	@native public textDecoration!: 'none' | 'underline'

	/**
	 * The text view's text tranform.
	 * @property textTransform
	 * @since 0.1.0
	 */
	@native public textTransform!: 'none' | 'uppercase' | 'lowercase' | 'capitalize'

	/**
	 * The text view's text overflow mode.
	 * @property textOverflow
	 * @since 0.1.0
	 */
	@native public textOverflow!: 'clip' | 'ellipsis'

	/**
	 * The text view's link color.
	 * @property linkColor
	 * @since 0.1.0
	 */
	@native public linkColor!: string

	/**
	 * The text view's line limit.
	 * @property lines
	 * @since 0.1.0
	 */
	@native public lines!: number

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Measures the text view's text within the specified bounds.
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

		return this.native.measureText(width, height)
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
		this.text = String(value)
	}

	//--------------------------------------------------------------------------
	// Native API
	//--------------------------------------------------------------------------

	/**
	 * @method nativePressLink
	 * @since 0.5.0
	 * @hidden
	 */
	private nativePressLink(url: string) {
		this.emit('presslink', { data: { url } })
	}
}
