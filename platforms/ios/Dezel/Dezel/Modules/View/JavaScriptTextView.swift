/**
 * @class JavaScriptTextView
 * @since 0.7.0
 * @hidden
 */
open class JavaScriptTextView: JavaScriptView, TextViewDelegate {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property invalidFontSize
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidFontSize: Bool = false

	/**
	 * @property view
	 * @since 0.7.0
	 * @hidden
	 */
	private var view: TextView {
		return self.content as! TextView
	}

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method createContentView
	 * @since 0.7.0
	 */
	override open func createContentView() -> TextView {
		return TextView(frame: .zero, delegate: self)
	}

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

		return self.view.measure(in: bounds, min: min, max: max)
	}

	/**
	 * @method update
	 * @since 0.7.0
	 * @hidden
	 */
	override open func update() {

		super.update()

		if (self.invalidFontSize) {
			self.invalidFontSize = false
			self.updateFontSize()
		}

		if (self.view.hasFrame == false && self.resolvedFrame) {
			self.view.hasFrame = true
		}
	}

	/**
	 * Resolves the font size based on its unit.
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

		if (self.layoutNode.wrapsContentWidth ||
			self.layoutNode.wrapsContentHeight) {
			self.layoutNode.invalidateSize()
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Layout Node Delegate
	//--------------------------------------------------------------------------

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
	// MARK: Methods - Content Text View Delegate
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method didPressLink
	 * @since 0.7.0
	 */
	open func didPressLink(textView: TextView, url: String) {
		self.callMethod("nativeOnPressLink", arguments: [self.context.createString(url)])
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

	/**
	 * @method getTextOverflow
	 * @since 0.7.0
	 * @hidden
	 */
	open func getTextOverflow(_ value: String) -> TextOverflow {

		switch (value) {

			case "clip":
				return .clip
			case "ellipsis":
				return .ellipsis

			default:
				NSLog("Unrecognized value for textOverflow: \(value)")
		}

		return .ellipsis
	}

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * The text view's font family.
	 * @property fontFamily
	 * @since 0.7.0
	 */
	@objc open lazy var fontFamily = JavaScriptProperty(string: "default") { value in

		self.view.fontFamily = value.string

		if (self.layoutNode.wrapsContentWidth ||
			self.layoutNode.wrapsContentHeight) {
			self.layoutNode.invalidateSize()
		}
	}

	/**
	 * The text view's font weight.
	 * @property fontWeight
	 * @since 0.7.0
	 */
	@objc open lazy var fontWeight = JavaScriptProperty(string: "normal") { value in

		self.view.fontWeight = value.string

		if (self.layoutNode.wrapsContentWidth ||
			self.layoutNode.wrapsContentHeight) {
			self.layoutNode.invalidateSize()
		}
	}

	/**
	 * The text view's font style.
	 * @property fontStyle
	 * @since 0.7.0
	 */
	@objc open lazy var fontStyle = JavaScriptProperty(string: "normal") { value in

		self.view.fontStyle = value.string

		if (self.layoutNode.wrapsContentWidth ||
			self.layoutNode.wrapsContentHeight) {
			self.layoutNode.invalidateSize()
		}
	}

	/**
	 * The text view's font size.
	 * @property fontSize
	 * @since 0.7.0
	 */
	@objc open lazy var fontSize = JavaScriptProperty(number: 17) { value in
		self.invalidateFontSize()
	}

	/**
	 * The text view's minimum font size.
	 * @property minFontSize
	 * @since 0.7.0
	 */
	@objc open lazy var minFontSize = JavaScriptProperty(number: 0) { value in
		self.invalidateFontSize()
	}

	/**
	 * The text view's maximum font size.
	 * @property maxFontSize
	 * @since 0.7.0
	 */
	@objc open lazy var maxFontSize = JavaScriptProperty(number: Double.max) { value in
		self.invalidateFontSize()
	}

	/**
	 * The text view's text.
	 * @property text
	 * @since 0.7.0
	 */
	@objc open lazy var text = JavaScriptProperty(string: "") { value in

		self.view.text = value.string

		if (self.layoutNode.wrapsContentWidth ||
			self.layoutNode.wrapsContentHeight) {
			self.layoutNode.invalidateSize()
		}
	}

	/**
	 * The text view's text color.
	 * @property textColor
	 * @since 0.7.0
	 */
	@objc open lazy var textColor = JavaScriptProperty(string: "#000") { value in
		self.view.textColor = CGColorParse(value.string)
	}

	/**
	 * The text view's text alignment.
	 * @property textAlignment
	 * @since 0.7.0
	 */
	@objc open lazy var textAlignment = JavaScriptProperty(string: "start") { value in
		self.view.textAlignment = self.getTextAlignment(value.string)
	}

	/**
	 * The text view's text location.
	 * @property textLocation
	 * @since 0.7.0
	 */
	@objc open lazy var textLocation = JavaScriptProperty(string: "middle") { value in
		self.view.textLocation = self.getTextLocation(value.string)
	}

	/**
	 * The text view's text baseline.
	 * @property textBaseline
	 * @since 0.7.0
	 */
	@objc open lazy var textBaseline = JavaScriptProperty(number: 0) { value in

		self.view.textBaseline = CGFloat(value.number)

		if (self.layoutNode.wrapsContentWidth ||
			self.layoutNode.wrapsContentHeight) {
			self.layoutNode.invalidateSize()
		}
	}

	/**
	 * The text view's text kerning.
	 * @property textKerning
	 * @since 0.7.0
	 */
	@objc open lazy var textKerning = JavaScriptProperty(number: 0) { value in

		self.view.textKerning = CGFloat(value.number)

		if (self.layoutNode.wrapsContentWidth ||
			self.layoutNode.wrapsContentHeight) {
			self.layoutNode.invalidateSize()
		}
	}

	/**
	 * The text view's text leading.
	 * @property textLeading
	 * @since 0.7.0
	 */
	@objc open lazy var textLeading = JavaScriptProperty(number: 0) { value in

		self.view.textLeading = CGFloat(value.number)

		if (self.layoutNode.wrapsContentWidth ||
			self.layoutNode.wrapsContentHeight) {
			self.layoutNode.invalidateSize()
		}
	}

	/**
	 * The text view's text shadow blur.
	 * @property textShadowBlur
	 * @since 0.7.0
	 */
	@objc open lazy var textShadowBlur = JavaScriptProperty(number: 0) { value in
		self.view.textShadowBlur = CGFloat(value.number)
	}

	/**
	 * The text view's text shadow color.
	 * @property textShadowColor
	 * @since 0.7.0
	 */
	@objc open lazy var textShadowColor = JavaScriptProperty(string: "#000") { value in
		self.view.textShadowColor = CGColorParse(value.string)
	}

	/**
	 * The text view's text shadow offset top.
	 * @property textShadowOffsetTop
	 * @since 0.7.0
	 */
	@objc open lazy var textShadowOffsetTop = JavaScriptProperty(number: 0) { value in
		self.view.textShadowOffsetTop = CGFloat(value.number)
	}

	/**
	 * The text view's text shadow offset left.
	 * @property textShadowOffsetLeft
	 * @since 0.7.0
	 */
	@objc open lazy var textShadowOffsetLeft = JavaScriptProperty(number: 0) { value in
		self.view.textShadowOffsetLeft = CGFloat(value.number)
	}

	/**
	 * The text view's text decoration.
	 * @property textDecoration
	 * @since 0.7.0
	 */
	@objc open lazy var textDecoration = JavaScriptProperty(string: "none") { value in

		self.view.textDecoration = self.getTextDecoration(value.string)

		if (self.layoutNode.wrapsContentWidth ||
			self.layoutNode.wrapsContentHeight) {
			self.layoutNode.invalidateSize()
		}
	}

	/**
	 * The text view's text transform mode.
	 * @property textTransform
	 * @since 0.7.0
	 */
	@objc open lazy var textTransform = JavaScriptProperty(string: "none") { value in

		self.view.textTransform = self.getTextTransform(value.string)

		if (self.layoutNode.wrapsContentWidth ||
			self.layoutNode.wrapsContentHeight) {
			self.layoutNode.invalidateSize()
		}
	}

	/**
	 * The text view's text overflow.
	 * @property textOverflow
	 * @since 0.7.0
	 */
	@objc open lazy var textOverflow = JavaScriptProperty(string: "ellipsis") { value in

		self.view.textOverflow = self.getTextOverflow(value.string)

		if (self.layoutNode.wrapsContentWidth ||
			self.layoutNode.wrapsContentHeight) {
			self.layoutNode.invalidateSize()
		}
	}

	/**
	 * The text view's link color.
	 * @property linkColor
	 * @since 0.7.0
	 */
	@objc open lazy var linkColor = JavaScriptProperty(string: "blue") { value in
		self.view.linkColor = CGColorParse(value.string)
	}

	/**
	 * The text view's maximum amount of lines.
	 * @property maxLines
	 * @since 0.7.0
	 */
	@objc open lazy var maxLines = JavaScriptProperty(number: 0) { value in

		self.view.maxLines = Int(value.number)

		if (self.layoutNode.wrapsContentWidth ||
			self.layoutNode.wrapsContentHeight) {
			self.layoutNode.invalidateSize()
		}
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
	 * @method jsGet_text
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_text(callback: JavaScriptGetterCallback) {
		callback.returns(self.text)
	}

	/**
	 * @method jsSet_text
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_text(callback: JavaScriptSetterCallback) {
		self.text.reset(callback.value, lock: self)
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
		return self.textAlignment.reset(callback.value, lock: self)
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
	 * @method jsGet_textBaseline
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_textBaseline(callback: JavaScriptGetterCallback) {
		callback.returns(self.textBaseline)
	}

	/**
	 * @method jsSet_textBaseline
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_textBaseline(callback: JavaScriptSetterCallback) {
		self.textBaseline.reset(callback.value, lock: self)
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

	/**
	 * @method jsGet_textOverflow
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_textOverflow(callback: JavaScriptGetterCallback) {
		callback.returns(self.textOverflow)
	}

	/**
	 * @method jsSet_textOverflow
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_textOverflow(callback: JavaScriptSetterCallback) {
		self.textOverflow.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_linkColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_linkColor(callback: JavaScriptGetterCallback) {
		callback.returns(self.linkColor)
	}

	/**
	 * @method jsSet_linkColor
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_linkColor(callback: JavaScriptSetterCallback) {
		self.linkColor.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_maxLines
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_maxLines(callback: JavaScriptGetterCallback) {
		callback.returns(self.maxLines)
	}

	/**
	 * @method jsSet_maxLines
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_maxLines(callback: JavaScriptSetterCallback) {
		self.maxLines.reset(callback.value, lock: self)
	}
}
