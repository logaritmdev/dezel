/**
 * An editable text area.
 * @class TextArea
 * @since 0.1.0
 */
open class TextArea: View, ContentTextAreaDelegate {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The text input's value.
	 * @property value
	 * @since 0.1.0
	 */
	@objc open var value: Property = Property(string: "") {
		willSet {
			self.view.value = newValue.string
		}
	}

	/**
	 * The text input's placeholder.
	 * @property placeholder
	 * @since 0.1.0
	 */
	@objc open var placeholder: Property = Property(string: "") {
		willSet {
			self.view.placeholder = newValue.string
		}
	}

	/**
	 * The text input's placeholder color.
	 * @property placeholderColor
	 * @since 0.1.0
	 */
	@objc open var placeholderColor: Property = Property(string: "gray") {
		willSet {
			self.view.placeholderColor = CGColorParse(newValue.string)
		}
	}

	/**
	 * The text input's autocorrect status.
	 * @property autocorrect
	 * @since 0.1.0
	 */
	@objc open var autocorrect: Property = Property(boolean: true) {
		willSet {
			self.view.autocorrectionType = newValue.boolean ? .yes : .no
		}
	}

	/**
	 * The text input's autocapitalize status.
	 * @property autocapitalize
	 * @since 0.1.0
	 */
	@objc open var autocapitalize: Property = Property(boolean: true) {
		willSet {
			self.view.autocapitalizationType = newValue.boolean ? .sentences : .none
		}
	}

	/**
	 * The text input's font family.
	 * @property fontFamily
	 * @since 0.1.0
	 */
	@objc open var fontFamily: Property = Property(string: "default") {
		willSet {
			self.view.fontFamily = newValue.string
		}
	}

	/**
	 * The text input's font weight.
	 * @property fontWeight
	 * @since 0.1.0
	 */
	@objc open var fontWeight: Property = Property(string: "normal") {
		willSet {
			self.view.fontWeight = newValue.string
		}
	}

	/**
	 * The text input's font style.
	 * @property fontStyle
	 * @since 0.1.0
	 */
	@objc open var fontStyle: Property = Property(string: "normal") {
		willSet {
			self.view.fontStyle = newValue.string
		}
	}

	/**
	 * The text input's font size.
	 * @property fontSize
	 * @since 0.1.0
	 */
	@objc open var fontSize: Property = Property(number: 17) {
		willSet {
			self.invalidateFontSize()
		}
	}

	/**
	 * The text input's minimum font size.
	 * @property minFontSize
	 * @since 0.1.0
	 */
	@objc open var minFontSize: Property = Property(number: 0) {
		willSet {
			self.invalidateFontSize()
		}
	}

	/**
	 * The text input's maximum font size.
	 * @property maxFontSize
	 * @since 0.1.0
	 */
	@objc open var maxFontSize: Property = Property(number: Double.max) {
		willSet {
			self.invalidateFontSize()
		}
	}

	/**
	 * The text input's text color.
	 * @property textColor
	 * @since 0.1.0
	 */
	@objc open var textColor: Property = Property(string: "#000") {
		willSet {
			self.view.textColor = UIColor(string: newValue.string)
		}
	}

	/**
	 * The text input's text alignment.
	 * @property textAlignment
	 * @since 0.1.0
	 */
	@objc open var textAlignment: Property = Property(string: "start") {
		willSet {
			self.view.textAlign = self.getTextAlignment(newValue.string)
		}
	}

	/**
	 * The text input's text placement.
	 * @property textPlacement
	 * @since 0.1.0
	 */
	@objc open var textPlacement: Property = Property(string: "top") {
		willSet {
			self.view.textPlacement = self.getTextPlacement(newValue.string)
		}
	}

	/**
	 * The text input's text kerning.
	 * @property textKerning
	 * @since 0.1.0
	 */
	@objc open var textKerning: Property = Property(number: 0) {
		willSet {
			self.view.textKerning = CGFloat(newValue.number)
		}
	}

	/**
	 * The text input's text leading.
	 * @property textLeading
	 * @since 0.1.0
	 */
	@objc open var textLeading: Property = Property(number: 0) {
		willSet {
			self.view.textLeading = CGFloat(newValue.number)
		}
	}

	/**
	 * The text input's text shadow blur.
	 * @property textShadowBlur
	 * @since 0.1.0
	 */
	@objc open var textShadowBlur: Property = Property(number: 0) {
		willSet {
			self.view.textShadowBlur = CGFloat(newValue.number)
		}
	}

	/**
	 * The text input's text shadow color.
	 * @property textShadowColor
	 * @since 0.1.0
	 */
	@objc open var textShadowColor: Property = Property(string: "#000") {
		willSet {
			self.view.textShadowColor = CGColorParse(newValue.string)
		}
	}

	/**
	 * The text input's text shadow offset top.
	 * @property textShadowOffsetTop
	 * @since 0.1.0
	 */
	@objc open var textShadowOffsetTop: Property = Property(number: 0) {
		willSet {
			self.view.textShadowOffsetTop = CGFloat(newValue.number)
		}
	}

	/**
	 * The text input's text shadow offset left.
	 * @property textShadowOffsetLeft
	 * @since 0.1.0
	 */
	@objc open var textShadowOffsetLeft: Property = Property(number: 0) {
		willSet {
			self.view.textShadowOffsetLeft = CGFloat(newValue.number)
		}
	}

	/**
	 * The text input's text decoration.
	 * @property textDecoration
	 * @since 0.1.0
	 */
	@objc open var textDecoration: Property = Property(string: "none") {
		willSet {
			self.view.textDecoration = self.getTextDecoration(newValue.string)
		}
	}

	/**
	 * The text input's text transform.
	 * @property textTransform
	 * @since 0.1.0
	 */
	@objc open var textTransform: Property = Property(string: "none") {
		willSet {
			self.view.textTransform = self.getTextTransform(newValue.string)
		}
	}

	/**
	 * @property view
	 * @since 0.1.0
	 * @hidden
	 */
	private var view: ContentTextArea {
		return self.content as! ContentTextArea
	}

	/**
	 * @property invalidFont
	 * @since 0.1.0
	 * @hidden
	 */
	private var invalidFont: Bool = false

	/**
	 * @property invalidFontSize
	 * @since 0.1.0
	 * @hidden
	 */
	private var invalidFontSize: Bool = false

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method createContentView
	 * @since 0.5.0
	 */
	override open func createContentView() -> ContentTextArea {
		return ContentTextArea(frame: .zero, delegate: self)
	}

	/**
	 * @inherited
	 * @method destroy
	 * @since 0.5.0
	 */
	override open func destroy() {
		self.view.contentViewDelegate = nil
		super.destroy()
	}

	/**
	 * @inherited
	 * @method update
	 * @since 0.1.0
	 */
	override open func update() {

		super.update()

		if (self.invalidFont) {
			self.invalidFont = false
			self.updateFont()
		}

		if (self.invalidFontSize) {
			self.invalidFontSize = false
			self.updateFontSize()
		}
	}

	/**
	 * Updates the font.
	 * @method updateFont
	 * @since 0.1.0
	 */
	open func updateFont() {

	}

	/**
	 * Updates the font size based on its unit.
	 * @method updateFontSize
	 * @since 0.1.0
	 */
	open func updateFontSize() {

		let value: CGFloat

		switch (self.fontSize.unit) {

			case .px: value = CGFloat(self.fontSize.number)
			case .vw: value = CGFloat(self.fontSize.number / 100 * self.layoutNode.viewportWidth)
			case .vh: value = CGFloat(self.fontSize.number / 100 * self.layoutNode.viewportHeight)

			default:
				value = CGFloat(self.fontSize.number)
				break
		}

		self.view.fontSize = value.clamp(
			CGFloat(self.minFontSize.number),
			CGFloat(self.maxFontSize.number)
		)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Layout Node Delegate
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method measure
	 * @since 0.5.0
	 */
	override open func measure(in bounds: CGSize, min: CGSize, max: CGSize) -> CGSize {

		if (self.invalidFontSize) {
			self.invalidFontSize = false
			self.updateFontSize()
		}

		return CGSize(width: 130, height: 80)
	}

	/**
	 * @inherited
	 * @method didResolvePadding
	 * @since 0.1.0
	 */
	override open func didResolvePadding(node: LayoutNode) {
		super.didResolvePadding(node: node)
		self.view.paddingTop = CGFloat(self.resolvedPaddingTop)
		self.view.paddingLeft = CGFloat(self.resolvedPaddingLeft)
		self.view.paddingRight = CGFloat(self.resolvedPaddingRight)
		self.view.paddingBottom = CGFloat(self.resolvedPaddingBottom)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Content Text Input Observer
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method didChange
	 * @since 0.1.0
	 */
	open func didChange(textInput: ContentTextArea, value: String) {
		self.value = Property(string: value)
		self.holder.callMethod("nativeChange", arguments: [self.context.createString(value)], result: nil)
	}

	/**
	 * @inherited
	 * @method didFocus
	 * @since 0.1.0
	 */
	open func didFocus(textInput: ContentTextArea) {
		self.holder.callMethod("nativeFocus")
	}

	/**
	 * @inherited
	 * @method didBlur
	 * @since 0.1.0
	 */
	open func didBlur(textInput: ContentTextArea) {
		self.holder.callMethod("nativeBlur")
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method invalidateFontSize
	 * @since 0.1.0
	 * @hidden
	 */
	private func invalidateFontSize() {
		if (self.invalidFontSize == false) {
			self.invalidFontSize = true
			self.scheduleUpdate()
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Private API - Conversions
	//--------------------------------------------------------------------------

	/**
	 * @method getType
	 * @since 0.1.0
	 * @hidden
	 */
	open func getType(_ value: String) -> InputType {

		switch (value) {

			case "text":
				return .text
			case "number":
				return .number
			case "email":
				return .email
			case "phone":
				return .phone
			case "password":
				return .password

			default:
				NSLog("Unrecognized value for type: \(value)")
		}

		return .text
	}

	/**
	 * @method getTextDecoration
	 * @since 0.1.0
	 * @hidden
	 */
	open func getTextDecoration(_ value: String) -> TextDecoration {

		switch (value) {

			case "none":
				return .none
			case "underline":
				return .underline

			default:
				NSLog("Unrecognized value for textDecoration: \(value)")
		}

		return .none
	}

	/**
	 * @method getTextTransform
	 * @since 0.1.0
	 * @hidden
	 */
	open func getTextTransform(_ value: String) -> TextTransform {

		switch (value) {

			case "none":
				return .none
			case "uppercase":
				return .uppercase
			case "lowercase":
				return .lowercase
			case "capitalize":
				return .capitalize

			default:
				NSLog("Unrecognized value for textTransform: \(value)")
		}

		return .none
	}

	/**
	 * @method getTextAlignment
	 * @since 0.1.0
	 * @hidden
	 */
	open func getTextAlignment(_ value: String) -> TextAlignment {

		switch (value) {

			case "start":
				return .start
			case "end":
				return .end
			case "left":
				return .left
			case "right":
				return .right
			case "center":
				return .center

			default:
				NSLog("Unrecognized value for textAlignment: \(value)")
		}

		return .start
	}

	/**
	 * @method getTextPlacement
	 * @since 0.1.0
	 * @hidden
	 */
	open func getTextPlacement(_ value: String) -> TextPlacement {

		switch (value) {

			case "top":
				return .top
			case "middle":
				return .middle
			case "bottom":
				return .bottom

			default:
				NSLog("Unrecognized value for textPlacement: \(value)")
		}

		return .middle
	}

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_value
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_value(callback: JavaScriptGetterCallback) {
		callback.returns(self.value)
	}

	/**
	 * @method jsSet_value
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_value(callback: JavaScriptSetterCallback) {
		self.value = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_placeholder
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_placeholder(callback: JavaScriptGetterCallback) {
		callback.returns(self.placeholder)
	}

	/**
	 * @method jsSet_placeholder
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_placeholder(callback: JavaScriptSetterCallback) {
		self.placeholder = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_placeholderColor
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_placeholderColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.placeholderColor)
	}

	/**
	 * @method jsSet_placeholderColor
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_placeholderColor(callback: JavaScriptSetterCallback) {
		self.placeholderColor = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_autocorrect
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_autocorrect(callback: JavaScriptGetterCallback) {
		callback.returns(self.autocorrect)
	}

	/**
	 * @method jsSet_autocorrect
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_autocorrect(callback: JavaScriptSetterCallback) {
		self.autocorrect = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_autocapitalize
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_autocapitalize(callback: JavaScriptGetterCallback) {
		callback.returns(self.autocapitalize)
	}

	/**
	 * @method jsSet_autocapitalize
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_autocapitalize(callback: JavaScriptSetterCallback) {
		self.autocapitalize = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_fontFamily
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_fontFamily(callback: JavaScriptGetterCallback) {
		callback.returns(self.fontFamily)
	}

	/**
	 * @method jsSet_fontFamily
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_fontFamily(callback: JavaScriptSetterCallback) {
		self.fontFamily = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_fontWeight
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_fontWeight(callback: JavaScriptGetterCallback) {
		callback.returns(self.fontWeight)
	}

	/**
	 * @method jsSet_fontWeight
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_fontWeight(callback: JavaScriptSetterCallback) {
		self.fontWeight = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_fontStyle
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_fontStyle(callback: JavaScriptGetterCallback) {
		callback.returns(self.fontStyle)
	}

	/**
	 * @method jsSet_fontStyle
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_fontStyle(callback: JavaScriptSetterCallback) {
		self.fontStyle = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_fontSize
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_fontSize(callback: JavaScriptGetterCallback) {
		callback.returns(self.fontSize)
	}

	/**
	 * @method jsSet_fontSize
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_fontSize(callback: JavaScriptSetterCallback) {
		self.fontSize = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minFontSize
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_minFontSize(callback: JavaScriptGetterCallback) {
		callback.returns(self.minFontSize)
	}

	/**
	 * @method jsSet_minFontSize
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_minFontSize(callback: JavaScriptSetterCallback) {
		self.minFontSize = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxFontSize
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_maxFontSize(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxFontSize)
	}

	/**
	 * @method jsSet_maxFontSize
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_maxFontSize(callback: JavaScriptSetterCallback) {
		self.maxFontSize = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textColor
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_textColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.textColor)
	}

	/**
	 * @method jsSet_textColor
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_textColor(callback: JavaScriptSetterCallback) {
		self.textColor = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textAlignment
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_textAlignment(callback: JavaScriptGetterCallback) {
		callback.returns(self.textAlignment)
	}

	/**
	 * @method jsSet_textAlignment
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_textAlignment(callback: JavaScriptSetterCallback) {
		self.textAlignment = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textPlacement
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_textPlacement(callback: JavaScriptGetterCallback) {
		callback.returns(self.textPlacement)
	}

	/**
	 * @method jsSet_textPlacement
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_textPlacement(callback: JavaScriptSetterCallback) {
		self.textPlacement = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textKerning
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_textKerning(callback: JavaScriptGetterCallback) {
		callback.returns(self.textKerning)
	}

	/**
	 * @method jsSet_textKerning
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_textKerning(callback: JavaScriptSetterCallback) {
		self.textKerning = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textLeading
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_textLeading(callback: JavaScriptGetterCallback) {
		callback.returns(self.textLeading)
	}

	/**
	 * @method jsSet_textLeading
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_textLeading(callback: JavaScriptSetterCallback) {
		self.textLeading = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textDecoration
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_textDecoration(callback: JavaScriptGetterCallback) {
		callback.returns(self.textDecoration)
	}

	/**
	 * @method jsSet_textDecoration
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_textDecoration(callback: JavaScriptSetterCallback) {
		self.textDecoration = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textTransform
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_textTransform(callback: JavaScriptGetterCallback) {
		callback.returns(self.textTransform)
	}

	/**
	 * @method jsSet_textTransform
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_textTransform(callback: JavaScriptSetterCallback) {
		self.textTransform = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textShadowBlur
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_textShadowBlur(callback: JavaScriptGetterCallback) {
		callback.returns(self.textShadowBlur)
	}

	/**
	 * @method jsSet_textShadowBlur
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_textShadowBlur(callback: JavaScriptSetterCallback) {
		self.textShadowBlur = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textShadowColor
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_textShadowColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.textShadowColor)
	}

	/**
	 * @method jsSet_textShadowColor
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_textShadowColor(callback: JavaScriptSetterCallback) {
		self.textShadowColor = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textShadowOffsetTop
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_textShadowOffsetTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.textShadowOffsetTop)
	}

	/**
	 * @method jsSet_textShadowOffsetTop
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_textShadowOffsetTop(callback: JavaScriptSetterCallback) {
		self.fontFamily = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textShadowOffsetLeft
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_textShadowOffsetLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.textShadowOffsetLeft)
	}

	/**
	 * @method jsSet_textShadowOffsetLeft
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_textShadowOffsetLeft(callback: JavaScriptSetterCallback) {
		self.textShadowOffsetLeft = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_focus
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_focus(callback: JavaScriptFunctionCallback) {
		self.view.focus()
	}

	/**
	 * @method jsFunction_blur
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsFunction_blur(callback: JavaScriptFunctionCallback) {
		self.view.blur()
	}
}
