/**
 * An editable text area.
 * @class JavaScriptTextArea
 * @since 0.7.0
 */
open class JavaScriptTextArea: JavaScriptView, TextAreaDelegate {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property view
	 * @since 0.7.0
	 * @hidden
	 */
	private var view: TextArea {
		return self.content as! TextArea
	}

	/**
	 * @property invalidFont
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidFont: Bool = false

	/**
	 * @property invalidFontSize
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidFontSize: Bool = false

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method createContentView
	 * @since 0.7.0
	 */
	override open func createContentView() -> TextArea {
		return TextArea(frame: .zero, delegate: self)
	}

	/**
	 * @inherited
	 * @method update
	 * @since 0.7.0
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
	 * @since 0.7.0
	 */
	open func updateFont() {

	}

	/**
	 * Updates the font size based on its unit.
	 * @method updateFontSize
	 * @since 0.7.0
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
	 * @since 0.7.0
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
	 * @since 0.7.0
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
	 * @since 0.7.0
	 */
	open func didChange(textInput: TextArea, value: String) {
		self.value = JavaScriptProperty(string: value)
		self.callMethod("nativeOnChange", arguments: [self.context.createString(value)], result: nil)
	}

	/**
	 * @inherited
	 * @method didFocus
	 * @since 0.7.0
	 */
	open func didFocus(textInput: TextArea) {
		self.callMethod("nativeOnFocus")
	}

	/**
	 * @inherited
	 * @method didBlur
	 * @since 0.7.0
	 */
	open func didBlur(textInput: TextArea) {
		self.callMethod("nativeOnBlur")
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method invalidateFontSize
	 * @since 0.7.0
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
	 * @since 0.7.0
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
	 * @since 0.7.0
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
	 * @since 0.7.0
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
	 * @since 0.7.0
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
	 * @method getTextLocation
	 * @since 0.7.0
	 * @hidden
	 */
	open func getTextLocation(_ value: String) -> TextLocation {

		switch (value) {

			case "top":
				return .top
			case "middle":
				return .middle
			case "bottom":
				return .bottom

			default:
				NSLog("Unrecognized value for textLocation: \(value)")
		}

		return .middle
	}

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * The text input's value.
	 * @property value
	 * @since 0.7.0
	 */
	@objc public lazy var value = JavaScriptProperty(string: "") { value in
		self.view.value = value.string
	}

	/**
	 * The text input's placeholder.
	 * @property placeholder
	 * @since 0.7.0
	 */
	@objc public lazy var placeholder = JavaScriptProperty(string: "") { value in
		self.view.placeholder = value.string
	}

	/**
	 * The text input's placeholder color.
	 * @property placeholderColor
	 * @since 0.7.0
	 */
	@objc public lazy var placeholderColor = JavaScriptProperty(string: "gray") { value in
		self.view.placeholderColor = CGColorParse(value.string)
	}

	/**
	 * The text input's autocorrect status.
	 * @property autocorrect
	 * @since 0.7.0
	 */
	@objc public lazy var autocorrect = JavaScriptProperty(boolean: true) { value in
		self.view.autocorrectionType = value.boolean ? .yes : .no
	}

	/**
	 * The text input's autocapitalize status.
	 * @property autocapitalize
	 * @since 0.7.0
	 */
	@objc public lazy var autocapitalize = JavaScriptProperty(boolean: true) { value in
		self.view.autocapitalizationType = value.boolean ? .sentences : .none
	}

	/**
	 * The text input's font family.
	 * @property fontFamily
	 * @since 0.7.0
	 */
	@objc public lazy var fontFamily = JavaScriptProperty(string: "default") { value in
		self.view.fontFamily = value.string
	}

	/**
	 * The text input's font weight.
	 * @property fontWeight
	 * @since 0.7.0
	 */
	@objc public lazy var fontWeight = JavaScriptProperty(string: "normal") { value in
		self.view.fontWeight = value.string
	}

	/**
	 * The text input's font style.
	 * @property fontStyle
	 * @since 0.7.0
	 */
	@objc public lazy var fontStyle = JavaScriptProperty(string: "normal") { value in
		self.view.fontStyle = value.string
	}

	/**
	 * The text input's font size.
	 * @property fontSize
	 * @since 0.7.0
	 */
	@objc public lazy var fontSize = JavaScriptProperty(number: 17) { value in
		self.invalidateFontSize()
	}

	/**
	 * The text input's minimum font size.
	 * @property minFontSize
	 * @since 0.7.0
	 */
	@objc public lazy var minFontSize = JavaScriptProperty(number: 0) { value in
		self.invalidateFontSize()
	}

	/**
	 * The text input's maximum font size.
	 * @property maxFontSize
	 * @since 0.7.0
	 */
	@objc public lazy var maxFontSize = JavaScriptProperty(number: Double.max) { value in
		self.invalidateFontSize()
	}

	/**
	 * The text input's text color.
	 * @property textColor
	 * @since 0.7.0
	 */
	@objc public lazy var textColor = JavaScriptProperty(string: "#000") { value in
		self.view.textColor = UIColor(string: value.string)
	}

	/**
	 * The text input's text alignment.
	 * @property textAlignment
	 * @since 0.7.0
	 */
	@objc public lazy var textAlignment = JavaScriptProperty(string: "start") { value in
		self.view.textAlign = self.getTextAlignment(value.string)
	}

	/**
	 * The text input's text location.
	 * @property textLocation
	 * @since 0.7.0
	 */
	@objc public lazy var textLocation = JavaScriptProperty(string: "top") { value in
		self.view.textLocation = self.getTextLocation(value.string)
	}

	/**
	 * The text input's text kerning.
	 * @property textKerning
	 * @since 0.7.0
	 */
	@objc public lazy var textKerning = JavaScriptProperty(number: 0) { value in
		self.view.textKerning = CGFloat(value.number)
	}

	/**
	 * The text input's text leading.
	 * @property textLeading
	 * @since 0.7.0
	 */
	@objc public lazy var textLeading = JavaScriptProperty(number: 0) { value in
		self.view.textLeading = CGFloat(value.number)
	}

	/**
	 * The text input's text shadow blur.
	 * @property textShadowBlur
	 * @since 0.7.0
	 */
	@objc public lazy var textShadowBlur = JavaScriptProperty(number: 0) { value in
		self.view.textShadowBlur = CGFloat(value.number)
	}

	/**
	 * The text input's text shadow color.
	 * @property textShadowColor
	 * @since 0.7.0
	 */
	@objc public lazy var textShadowColor = JavaScriptProperty(string: "#000") { value in
		self.view.textShadowColor = CGColorParse(value.string)
	}

	/**
	 * The text input's text shadow offset top.
	 * @property textShadowOffsetTop
	 * @since 0.7.0
	 */
	@objc public lazy var textShadowOffsetTop = JavaScriptProperty(number: 0) { value in
		self.view.textShadowOffsetTop = CGFloat(value.number)
	}

	/**
	 * The text input's text shadow offset left.
	 * @property textShadowOffsetLeft
	 * @since 0.7.0
	 */
	@objc public lazy var textShadowOffsetLeft = JavaScriptProperty(number: 0) { value in
		self.view.textShadowOffsetLeft = CGFloat(value.number)
	}

	/**
	 * The text input's text decoration.
	 * @property textDecoration
	 * @since 0.7.0
	 */
	@objc public lazy var textDecoration = JavaScriptProperty(string: "none") { value in
		self.view.textDecoration = self.getTextDecoration(value.string)
	}

	/**
	 * The text input's text transform.
	 * @property textTransform
	 * @since 0.7.0
	 */
	@objc public lazy var textTransform = JavaScriptProperty(string: "none") { value in
		self.view.textTransform = self.getTextTransform(value.string)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_value
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_value(callback: JavaScriptGetterCallback) {
		callback.returns(self.value)
	}

	/**
	 * @method jsSet_value
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_value(callback: JavaScriptSetterCallback) {
		self.value.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_placeholder
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_placeholder(callback: JavaScriptGetterCallback) {
		callback.returns(self.placeholder)
	}

	/**
	 * @method jsSet_placeholder
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_placeholder(callback: JavaScriptSetterCallback) {
		self.placeholder.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_placeholderColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_placeholderColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.placeholderColor)
	}

	/**
	 * @method jsSet_placeholderColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_placeholderColor(callback: JavaScriptSetterCallback) {
		self.placeholderColor.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_autocorrect
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_autocorrect(callback: JavaScriptGetterCallback) {
		callback.returns(self.autocorrect)
	}

	/**
	 * @method jsSet_autocorrect
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_autocorrect(callback: JavaScriptSetterCallback) {
		self.autocorrect.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_autocapitalize
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_autocapitalize(callback: JavaScriptGetterCallback) {
		callback.returns(self.autocapitalize)
	}

	/**
	 * @method jsSet_autocapitalize
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_autocapitalize(callback: JavaScriptSetterCallback) {
		self.autocapitalize.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_fontFamily
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_fontFamily(callback: JavaScriptGetterCallback) {
		callback.returns(self.fontFamily)
	}

	/**
	 * @method jsSet_fontFamily
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_fontFamily(callback: JavaScriptSetterCallback) {
		self.fontFamily.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_fontWeight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_fontWeight(callback: JavaScriptGetterCallback) {
		callback.returns(self.fontWeight)
	}

	/**
	 * @method jsSet_fontWeight
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_fontWeight(callback: JavaScriptSetterCallback) {
		self.fontWeight.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_fontStyle
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_fontStyle(callback: JavaScriptGetterCallback) {
		callback.returns(self.fontStyle)
	}

	/**
	 * @method jsSet_fontStyle
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_fontStyle(callback: JavaScriptSetterCallback) {
		self.fontStyle.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_fontSize
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_fontSize(callback: JavaScriptGetterCallback) {
		callback.returns(self.fontSize)
	}

	/**
	 * @method jsSet_fontSize
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_fontSize(callback: JavaScriptSetterCallback) {
		self.fontSize.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_minFontSize
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_minFontSize(callback: JavaScriptGetterCallback) {
		callback.returns(self.minFontSize)
	}

	/**
	 * @method jsSet_minFontSize
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_minFontSize(callback: JavaScriptSetterCallback) {
		self.minFontSize.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxFontSize
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_maxFontSize(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxFontSize)
	}

	/**
	 * @method jsSet_maxFontSize
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_maxFontSize(callback: JavaScriptSetterCallback) {
		self.maxFontSize.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_textColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.textColor)
	}

	/**
	 * @method jsSet_textColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_textColor(callback: JavaScriptSetterCallback) {
		self.textColor.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textAlignment
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_textAlignment(callback: JavaScriptGetterCallback) {
		callback.returns(self.textAlignment)
	}

	/**
	 * @method jsSet_textAlignment
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_textAlignment(callback: JavaScriptSetterCallback) {
		self.textAlignment.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textLocation
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_textLocation(callback: JavaScriptGetterCallback) {
		callback.returns(self.textLocation)
	}

	/**
	 * @method jsSet_textLocation
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_textLocation(callback: JavaScriptSetterCallback) {
		self.textLocation.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textKerning
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_textKerning(callback: JavaScriptGetterCallback) {
		callback.returns(self.textKerning)
	}

	/**
	 * @method jsSet_textKerning
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_textKerning(callback: JavaScriptSetterCallback) {
		self.textKerning.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textLeading
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_textLeading(callback: JavaScriptGetterCallback) {
		callback.returns(self.textLeading)
	}

	/**
	 * @method jsSet_textLeading
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_textLeading(callback: JavaScriptSetterCallback) {
		self.textLeading.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textDecoration
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_textDecoration(callback: JavaScriptGetterCallback) {
		callback.returns(self.textDecoration)
	}

	/**
	 * @method jsSet_textDecoration
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_textDecoration(callback: JavaScriptSetterCallback) {
		self.textDecoration.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textTransform
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_textTransform(callback: JavaScriptGetterCallback) {
		callback.returns(self.textTransform)
	}

	/**
	 * @method jsSet_textTransform
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_textTransform(callback: JavaScriptSetterCallback) {
		self.textTransform.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textShadowBlur
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_textShadowBlur(callback: JavaScriptGetterCallback) {
		callback.returns(self.textShadowBlur)
	}

	/**
	 * @method jsSet_textShadowBlur
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_textShadowBlur(callback: JavaScriptSetterCallback) {
		self.textShadowBlur.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textShadowColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_textShadowColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.textShadowColor)
	}

	/**
	 * @method jsSet_textShadowColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_textShadowColor(callback: JavaScriptSetterCallback) {
		self.textShadowColor.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textShadowOffsetTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_textShadowOffsetTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.textShadowOffsetTop)
	}

	/**
	 * @method jsSet_textShadowOffsetTop
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_textShadowOffsetTop(callback: JavaScriptSetterCallback) {
		self.fontFamily.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textShadowOffsetLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_textShadowOffsetLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.textShadowOffsetLeft)
	}

	/**
	 * @method jsSet_textShadowOffsetLeft
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_textShadowOffsetLeft(callback: JavaScriptSetterCallback) {
		self.textShadowOffsetLeft.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------
	// MARK: JS Functions
	//--------------------------------------------------------------------------

	/**
	 * @method jsFunction_focus
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_focus(callback: JavaScriptFunctionCallback) {
		self.view.focus()
	}

	/**
	 * @method jsFunction_blur
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_blur(callback: JavaScriptFunctionCallback) {
		self.view.blur()
	}
}
