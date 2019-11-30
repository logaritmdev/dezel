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
	@native public fontSize!: number | string

	/**
	 * @property minFontSize
	 * @since 0.1.0
	 */
	@native public minFontSize!: number

	/**
	 * @property maxFontSize
	 * @since 0.1.0
	 */
	@native public maxFontSize!: number

	/**
	 * @property text
	 * @since 0.1.0
	 */
	@native public text!: string

	/**
	 * @property textAlignment
	 * @since 0.1.0
	 */
	@native public textAlignment!: 'start' | 'end' | 'left' | 'right' | 'center'

	/**
	 * @property textLocation
	 * @since 0.7.0
	 */
	@native public textLocation!: 'top' | 'middle' | 'bottom'

	/**
	 * @property textBaseline
	 * @since 0.1.0
	 */
	@native public textBaseline!: number

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
	 * @property textShadowBlur
	 * @since 0.1.0
	 */
	@native public textShadowBlur!: number

	/**
	 * @property textDecoration
	 * @since 0.1.0
	 */
	@native public textDecoration!: 'none' | 'underline'

	/**
	 * @property textTransform
	 * @since 0.1.0
	 */
	@native public textTransform!: 'none' | 'uppercase' | 'lowercase' | 'capitalize'

	/**
	 * @property textOverflow
	 * @since 0.1.0
	 */
	@native public textOverflow!: 'clip' | 'ellipsis'

	/**
	 * @property textColor
	 * @since 0.1.0
	 */
	@native public textColor!: string

	/**
	 * @property textOpacity
	 * @since 0.7.0
	 */
	@native public textOpacity!: number

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
	 * @property linkColor
	 * @since 0.1.0
	 */
	@native public linkColor!: string

	/**
	 * @property minLines
	 * @since 0.7.0
	 */
	@native public minLines!: number

	/**
	 * @property maxLines
	 * @since 0.7.0
	 */
	@native public maxLines!: number

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
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
	//--------------------------------------------------------------------------

	/**
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
	 * @method nativeOnPressLink
	 * @since 0.7.0
	 * @hidden
	 */
	private nativeOnPressLink(url: string) {
		this.emit('presslink', { data: { url } })
	}
}
