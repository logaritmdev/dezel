/**
 * @class JavaScriptTextArea
 * @super JavaScriptView
 * @since 0.7.0
 */
open class JavaScriptTextArea: JavaScriptView, TextAreaObserver {

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
	 * @method createContentView
	 * @since 0.7.0
	 */
	override open func createContentView() -> TextArea {
		return TextArea(frame: .zero, observer: self)
	}

	/**
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
	 * @method updateFont
	 * @since 0.7.0
	 */
	open func updateFont() {

	}

	/**
	 * @method updateFontSize
	 * @since 0.7.0
	 */
	open func updateFontSize() {

		let value: CGFloat

		switch (self.fontSize.unit) {

			case .px: value = CGFloat(self.fontSize.number)
			case .vw: value = CGFloat(self.fontSize.number / 100 * self.node.display.viewportWidth)
			case .vh: value = CGFloat(self.fontSize.number / 100 * self.node.display.viewportHeight)

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
	// MARK: Display Node Delegate
	//--------------------------------------------------------------------------

	/**
	 * @method measure
	 * @since 0.7.0
	 */
	override open func measure(bounds: CGSize, min: CGSize, max: CGSize) -> CGSize {

		if (self.invalidFontSize) {
			self.invalidFontSize = false
			self.updateFontSize()
		}

		return CGSize(width: 130, height: 80)
	}

	/**
	 * @method didResolvePadding
	 * @since 0.7.0
	 */
	override open func didResolvePadding(node: DisplayNode) {
		super.didResolvePadding(node: node)
		self.view.paddingTop = CGFloat(self.resolvedPaddingTop)
		self.view.paddingLeft = CGFloat(self.resolvedPaddingLeft)
		self.view.paddingRight = CGFloat(self.resolvedPaddingRight)
		self.view.paddingBottom = CGFloat(self.resolvedPaddingBottom)
	}

	//--------------------------------------------------------------------------
	// MARK: Content Text Input Observer
	//--------------------------------------------------------------------------

	/**
	 * @method didChange
	 * @since 0.7.0
	 */
	open func didChange(textInput: TextArea, value: String) {
		self.value = JavaScriptProperty(string: value)
		self.callMethod("nativeOnChange", arguments: [self.context.createString(value)], result: nil)
	}

	/**
	 * @method didFocus
	 * @since 0.7.0
	 */
	open func didFocus(textInput: TextArea) {
		self.node.appendState("focus")
		self.callMethod("nativeOnFocus")
	}

	/**
	 * @method didBlur
	 * @since 0.7.0
	 */
	open func didBlur(textInput: TextArea) {
		self.node.removeState("focus")
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
	private func getType(_ value: JavaScriptProperty) -> InputType {

		switch (value.string) {

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
	 * @method getTextAlign
	 * @since 0.7.0
	 * @hidden
	 */
	private func getTextAlign(_ value: String) -> TextAlign {

		switch (value) {

			case "top left":
				return .topLeft
			case "top right":
				return .topRight
			case "top center":
				return .topCenter

			case "left":
				return .middleLeft
			case "right":
				return .middleRight
			case "center":
				return .middleCenter

			case "bottom left":
				return .bottomLeft
			case "bottom right":
				return .bottomRight
			case "bottom center":
				return .bottomCenter

			default:
				NSLog("Unrecognized value for textAlign: \(value)")
		}

		return .middleLeft
	}

	/**
	 * @method getTextDecoration
	 * @since 0.7.0
	 * @hidden
	 */
	private func getTextDecoration(_ value: JavaScriptProperty) -> TextDecoration {

		switch (value.string) {

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
	private func getTextTransform(_ value: JavaScriptProperty) -> TextTransform {

		switch (value.string) {

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

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @property value
	 * @since 0.7.0
	 */
	@objc open lazy var value = JavaScriptProperty(string: "") { value in
		self.view.value = value.string
	}

	/**
	 * @property placeholder
	 * @since 0.7.0
	 */
	@objc open lazy var placeholder = JavaScriptProperty(string: "") { value in
		self.view.placeholder = value.string
	}

	/**
	 * @property placeholderColor
	 * @since 0.7.0
	 */
	@objc open lazy var placeholderColor = JavaScriptProperty(string: "gray") { value in
		self.view.placeholderColor = UIColor(color: value)
	}

	/**
	 * @property autocorrect
	 * @since 0.7.0
	 */
	@objc open lazy var autocorrect = JavaScriptProperty(boolean: true) { value in
		self.view.autocorrectionType = value.boolean ? .yes : .no
	}

	/**
	 * @property autocapitalize
	 * @since 0.7.0
	 */
	@objc open lazy var autocapitalize = JavaScriptProperty(boolean: true) { value in
		self.view.autocapitalizationType = value.boolean ? .sentences : .none
	}

	/**
	 * @property fontFamily
	 * @since 0.7.0
	 */
	@objc open lazy var fontFamily = JavaScriptProperty(string: "default") { value in
		self.view.fontFamily = value.string
	}

	/**
	 * @property fontWeight
	 * @since 0.7.0
	 */
	@objc open lazy var fontWeight = JavaScriptProperty(string: "normal") { value in
		self.view.fontWeight = value.string
	}

	/**
	 * @property fontStyle
	 * @since 0.7.0
	 */
	@objc open lazy var fontStyle = JavaScriptProperty(string: "normal") { value in
		self.view.fontStyle = value.string
	}

	/**
	 * @property fontSize
	 * @since 0.7.0
	 */
	@objc open lazy var fontSize = JavaScriptProperty(number: 17) { value in
		self.invalidateFontSize()
	}

	/**
	 * @property minFontSize
	 * @since 0.7.0
	 */
	@objc open lazy var minFontSize = JavaScriptProperty(number: 0) { value in
		self.invalidateFontSize()
	}

	/**
	 * @property maxFontSize
	 * @since 0.7.0
	 */
	@objc open lazy var maxFontSize = JavaScriptProperty(number: Double.max) { value in
		self.invalidateFontSize()
	}

	/**
	 * @property textColor
	 * @since 0.7.0
	 */
	@objc open lazy var textColor = JavaScriptProperty(string: "#000") { value in
		self.view.textColor = UIColor(color: value)
	}

	/**
	 * @property textAlign
	 * @since 0.7.0
	 */
	@objc open lazy var textAlign = JavaScriptProperty(string: "left") { value in
		self.view.textAlign = self.getTextAlign(value.string)
	}

	/**
	 * @property textKerning
	 * @since 0.7.0
	 */
	@objc open lazy var textKerning = JavaScriptProperty(number: 0) { value in
		self.view.textKerning = CGFloat(value.number)
	}

	/**
	 * @property textLeading
	 * @since 0.7.0
	 */
	@objc open lazy var textLeading = JavaScriptProperty(number: 0) { value in
		self.view.textLeading = CGFloat(value.number)
	}

	/**
	 * @property textDecoration
	 * @since 0.7.0
	 */
	@objc open lazy var textDecoration = JavaScriptProperty(string: "none") { value in
		self.view.textDecoration = self.getTextDecoration(value)
	}

	/**
	 * @property textTransform
	 * @since 0.7.0
	 */
	@objc open lazy var textTransform = JavaScriptProperty(string: "none") { value in
		self.view.textTransform = self.getTextTransform(value)
	}

	/**
	 * @property textShadowBlur
	 * @since 0.7.0
	 */
	@objc open lazy var textShadowBlur = JavaScriptProperty(number: 0) { value in
		self.view.textShadowBlur = CGFloat(value.number)
	}

	/**
	 * @property textShadowColor
	 * @since 0.7.0
	 */
	@objc open lazy var textShadowColor = JavaScriptProperty(string: "#000") { value in
		self.view.textShadowColor = UIColor(color: value)
	}

	/**
	 * @property textShadowOffsetTop
	 * @since 0.7.0
	 */
	@objc open lazy var textShadowOffsetTop = JavaScriptProperty(number: 0) { value in
		self.view.textShadowOffsetTop = CGFloat(value.number)
	}

	/**
	 * @property textShadowOffsetLeft
	 * @since 0.7.0
	 */
	@objc open lazy var textShadowOffsetLeft = JavaScriptProperty(number: 0) { value in
		self.view.textShadowOffsetLeft = CGFloat(value.number)
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
		self.placeholderColor.reset(callback.value, lock: self, parse: true)
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
		self.fontSize.reset(callback.value, lock: self, parse: true)
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
		self.minFontSize.reset(callback.value, lock: self, parse: true)
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
		self.maxFontSize.reset(callback.value, lock: self, parse: true)
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
		self.textColor.reset(callback.value, lock: self, parse: true)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textAlign
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_textAlign(callback: JavaScriptGetterCallback) {
		callback.returns(self.textAlign)
	}

	/**
	 * @method jsSet_textAlign
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_textAlign(callback: JavaScriptSetterCallback) {
		self.textAlign.reset(callback.value, lock: self)
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
		self.textKerning.reset(callback.value, lock: self, parse: true)
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
		self.textLeading.reset(callback.value, lock: self, parse: true)
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
		self.textShadowBlur.reset(callback.value, lock: self, parse: true)
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
		self.textShadowColor.reset(callback.value, lock: self, parse: true)
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
		self.fontFamily.reset(callback.value, lock: self, parse: true)
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
		self.textShadowOffsetLeft.reset(callback.value, lock: self, parse: true)
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
