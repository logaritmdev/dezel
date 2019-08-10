/**
 * An editable text input.
 * @class JavaScriptTextInput
 * @since 0.7.0
 */
open class JavaScriptTextInput: JavaScriptView, TextInputDelegate {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The text input's input type.
	 * @property type
	 * @since 0.7.0
	 */
	@objc open var type: Property = Property(string: "text") {
		willSet {
			self.view.type = self.getType(newValue.string)
		}
	}

	/**
	 * The text input's value.
	 * @property value
	 * @since 0.7.0
	 */
	@objc open var value: Property = Property(string: "") {
		willSet {
			self.view.value = newValue.string
		}
	}

	/**
	 * The text input's placeholder.
	 * @property placeholder
	 * @since 0.7.0
	 */
	@objc open var placeholder: Property = Property(string: "") {
		willSet {
			self.view.placeholder = newValue.string
		}
	}

	/**
	 * The text input's placeholder color.
	 * @property placeholderColor
	 * @since 0.7.0
	 */
	@objc open var placeholderColor: Property = Property(string: "gray") {
		willSet {
			self.view.placeholderColor = CGColorParse(newValue.string)
		}
	}

	/**
	 * The text input's value format.
	 * @property format
	 * @since 0.7.0
	 */
	@objc open var format: Property = Property(string: "") {
		willSet {
			self.view.format = newValue.string
		}
	}

	/**
	 * The text input's value format locale.
	 * @property format
	 * @since 0.7.0
	 */
	@objc open var locale: Property = Property(string: "") {
		willSet {
			self.view.locale = newValue.string
		}
	}

	/**
	 * The text input's autocorrect status.
	 * @property autocorrect
	 * @since 0.7.0
	 */
	@objc open var autocorrect: Property = Property(boolean: true) {
		willSet {
			self.view.autocorrectionType = newValue.boolean ? .yes : .no
		}
	}

	/**
	 * The text input's autocapitalize status.
	 * @property autocapitalize
	 * @since 0.7.0
	 */
	@objc open var autocapitalize: Property = Property(boolean: true) {
		willSet {
			self.view.autocapitalizationType = newValue.boolean ? .sentences : .none
		}
	}

	/**
	 * The text input's font family.
	 * @property fontFamily
	 * @since 0.7.0
	 */
	@objc open var fontFamily: Property = Property(string: "default") {
		willSet {
			self.view.fontFamily = newValue.string
		}
	}

	/**
	 * The text input's font weight.
	 * @property fontWeight
	 * @since 0.7.0
	 */
	@objc open var fontWeight: Property = Property(string: "normal") {
		willSet {
			self.view.fontWeight = newValue.string
		}
	}

	/**
	 * The text input's font style.
	 * @property fontStyle
	 * @since 0.7.0
	 */
	@objc open var fontStyle: Property = Property(string: "normal") {
		willSet {
			self.view.fontStyle = newValue.string
		}
	}

	/**
	 * The text input's font size.
	 * @property fontSize
	 * @since 0.7.0
	 */
	@objc open var fontSize: Property = Property(number: 17) {
		willSet {
			self.invalidateFontSize()
		}
	}

	/**
	 * The text input's minimum font size.
	 * @property minFontSize
	 * @since 0.7.0
	 */
	@objc open var minFontSize: Property = Property(number: 0) {
		willSet {
			self.invalidateFontSize()
		}
	}

	/**
	 * The text input's maximum font size.
	 * @property maxFontSize
	 * @since 0.7.0
	 */
	@objc open var maxFontSize: Property = Property(number: Double.max) {
		willSet {
			self.invalidateFontSize()
		}
	}

	/**
	 * The text input's text color.
	 * @property textColor
	 * @since 0.7.0
	 */
	@objc open var textColor: Property = Property(string: "#000") {
		willSet {
			self.view.textColor = UIColor(string: newValue.string)
		}
	}

	/**
	 * The text input's text alignment.
	 * @property textAlignment
	 * @since 0.7.0
	 */
	@objc open var textAlignment: Property = Property(string: "start") {
		willSet {
			self.view.textAlign = self.getTextAlignment(newValue.string)
		}
	}

	/**
	 * The text input's text location.
	 * @property textLocation
	 * @since 0.7.0
	 */
	@objc open var textLocation: Property = Property(string: "middle") {
		willSet {
			self.view.textLocation = self.getTextLocation(newValue.string)
		}
	}

	/**
	 * The text input's text kerning.
	 * @property textKerning
	 * @since 0.7.0
	 */
	@objc open var textKerning: Property = Property(number: 0) {
		willSet {
			self.view.textKerning = CGFloat(newValue.number)
		}
	}

	/**
	 * The text input's text leading.
	 * @property textLeading
	 * @since 0.7.0
	 */
	@objc open var textLeading: Property = Property(number: 0) {
		willSet {
			self.view.textLeading = CGFloat(newValue.number)
		}
	}

	/**
	 * The text input's text shadow blur.
	 * @property textShadowBlur
	 * @since 0.7.0
	 */
	@objc open var textShadowBlur: Property = Property(number: 0) {
		willSet {
			self.view.textShadowBlur = CGFloat(newValue.number)
		}
	}

	/**
	 * The text input's text shadow color.
	 * @property textShadowColor
	 * @since 0.7.0
	 */
	@objc open var textShadowColor: Property = Property(string: "#000") {
		willSet {
			self.view.textShadowColor = CGColorParse(newValue.string)
		}
	}

	/**
	 * The text input's text shadow offset top.
	 * @property textShadowOffsetTop
	 * @since 0.7.0
	 */
	@objc open var textShadowOffsetTop: Property = Property(number: 0) {
		willSet {
			self.view.textShadowOffsetTop = CGFloat(newValue.number)
		}
	}

	/**
	 * The text input's text shadow offset left.
	 * @property textShadowOffsetLeft
	 * @since 0.7.0
	 */
	@objc open var textShadowOffsetLeft: Property = Property(number: 0) {
		willSet {
			self.view.textShadowOffsetLeft = CGFloat(newValue.number)
		}
	}

	/**
	 * The text input's text decoration.
	 * @property textDecoration
	 * @since 0.7.0
	 */
	@objc open var textDecoration: Property = Property(string: "none") {
		willSet {
			self.view.textDecoration = self.getTextDecoration(newValue.string)
		}
	}

	/**
	 * The text input's text transform.
	 * @property textTransform
	 * @since 0.7.0
	 */
	@objc open var textTransform: Property = Property(string: "none") {
		willSet {
			self.view.textTransform = self.getTextTransform(newValue.string)
		}
	}

	/**
	 * Whether the text input is clearable.
	 * @property clearable
	 * @since 0.7.0
	 */
	@objc open var clearable: Property = Property(boolean: false) {
		willSet {
			self.view.clearable = newValue.boolean
		}
	}

	/**
	 * The text input's clear button color.
	 * @property clearButtonColor
	 * @since 0.7.0
	 */
	@objc open var clearButtonColor: Property = Property(string: "grey") {
		willSet {
			self.view.clearButtonColor = CGColorParse(newValue.string)
		}
	}

	/**
	 * @property view
	 * @since 0.7.0
	 * @hidden
	 */
	private var view: TextInput {
		return self.content as! TextInput
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
	override open func createContentView() -> TextInput {
		return TextInput(frame: .zero, delegate: self)
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

		// TODO
		// This must be computed using the font size and padding.

		return CGSize(width: 130, height: 40)
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
	open func didChange(textInput: TextInput, value: String) {
		self.value.reset(string: value)
		self.callMethod("nativeOnChange", arguments: [self.context.createString(value)], result: nil)
	}

	/**
	 * @inherited
	 * @method didFocus
	 * @since 0.7.0
	 */
	open func didFocus(textInput: TextInput) {
		self.callMethod("nativeOnFocus")
	}

	/**
	 * @inherited
	 * @method didBlur
	 * @since 0.7.0
	 */
	open func didBlur(textInput: TextInput) {
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

			case "date":
				return .date
			case "time":
				return .time
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
	 * @method jsGet_type
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_type(callback: JavaScriptGetterCallback) {
		callback.returns(self.type)
	}

	/**
	 * @method jsSet_type
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_type(callback: JavaScriptSetterCallback) {
		self.type = Property(value: callback.value)
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
		self.value = Property(value: callback.value)
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
		self.placeholder = Property(value: callback.value)
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
		self.placeholderColor = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_format
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_format(callback: JavaScriptGetterCallback) {
		callback.returns(self.format)
	}

	/**
	 * @method jsSet_format
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_format(callback: JavaScriptSetterCallback) {
		self.format = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_locale
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_locale(callback: JavaScriptGetterCallback) {
		callback.returns(self.locale)
	}

	/**
	 * @method jsSet_locale
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_locale(callback: JavaScriptSetterCallback) {
		self.locale = Property(value: callback.value)
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
		self.autocorrect = Property(value: callback.value)
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
		self.autocapitalize = Property(value: callback.value)
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
		self.fontFamily = Property(value: callback.value)
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
		self.fontWeight = Property(value: callback.value)
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
		self.fontStyle = Property(value: callback.value)
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
		self.fontSize = Property(value: callback.value)
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
		self.minFontSize = Property(value: callback.value)
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
		self.maxFontSize = Property(value: callback.value)
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
		self.textColor = Property(value: callback.value)
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
		self.textAlignment = Property(value: callback.value)
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
		self.textLocation = Property(value: callback.value)
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
		self.textKerning = Property(value: callback.value)
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
		self.textLeading = Property(value: callback.value)
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
		self.textDecoration = Property(value: callback.value)
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
		self.textTransform = Property(value: callback.value)
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
		self.textShadowBlur = Property(value: callback.value)
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
		self.textShadowColor = Property(value: callback.value)
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
		self.fontFamily = Property(value: callback.value)
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
		self.textShadowOffsetLeft = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_clearable
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_clearable(callback: JavaScriptGetterCallback) {
		callback.returns(self.clearable)
	}

	/**
	 * @method jsSet_clearable
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_clearable(callback: JavaScriptSetterCallback) {
		self.clearable = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_clearButtonColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_clearButtonColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.clearButtonColor)
	}

	/**
	 * @method jsSet_clearButtonColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_clearButtonColor(callback: JavaScriptSetterCallback) {
		self.clearButtonColor = Property(value: callback.value)
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

	/**
	 * @method jsFunction_selectRange
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsFunction_selectRange(callback: JavaScriptFunctionCallback) {

		if (callback.arguments == 0) {
			self.view.selectedTextRange = self.view.range(start: 0, end: self.view.value.length)
			return
		}

		if (callback.arguments == 2) {

			let s = callback.argument(0)
			let e = callback.argument(1)

			if (s.isNull ||
				e.isNull) {
				self.view.selectedTextRange = nil
				return
			}

			self.view.selectedTextRange = self.view.range(start: s.number.int(), end: e.number.int())
			return
		}
	}
}
