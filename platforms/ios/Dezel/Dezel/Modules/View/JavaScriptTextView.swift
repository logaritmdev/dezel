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
	 * The text view's font family.
	 * @property fontFamily
	 * @since 0.7.0
	 */
	@objc open var fontFamily: Property = Property(string: "default") {

		willSet {

			self.view.fontFamily = newValue.string

			if (self.layoutNode.wrapsContentWidth ||
				self.layoutNode.wrapsContentHeight) {
				self.layoutNode.invalidateSize()
			}
		}
	}

	/**
	 * The text view's font weight.
	 * @property fontWeight
	 * @since 0.7.0
	 */
	@objc open var fontWeight: Property = Property(string: "normal") {

		willSet {

			self.view.fontWeight = newValue.string

			if (self.layoutNode.wrapsContentWidth ||
				self.layoutNode.wrapsContentHeight) {
				self.layoutNode.invalidateSize()
			}
		}
	}

	/**
	 * The text view's font style.
	 * @property fontStyle
	 * @since 0.7.0
	 */
	@objc open var fontStyle: Property = Property(string: "normal") {

		willSet {

			self.view.fontStyle = newValue.string

			if (self.layoutNode.wrapsContentWidth ||
				self.layoutNode.wrapsContentHeight) {
				self.layoutNode.invalidateSize()
			}
		}
	}

	/**
	 * The text view's font size.
	 * @property fontSize
	 * @since 0.7.0
	 */
	@objc open var fontSize: Property = Property(number: 17) {
		willSet {
			self.invalidateFontSize()
		}
	}

	/**
	 * The text view's minimum font size.
	 * @property minFontSize
	 * @since 0.7.0
	 */
	@objc open var minFontSize: Property = Property(number: 0) {
		willSet {
			self.invalidateFontSize()
		}
	}

	/**
	 * The text view's maximum font size.
	 * @property maxFontSize
	 * @since 0.7.0
	 */
	@objc open var maxFontSize: Property = Property(number: Double.max) {
		willSet {
			self.invalidateFontSize()
		}
	}

	/**
	 * The text view's text.
	 * @property text
	 * @since 0.7.0
	 */
	@objc open var text: Property = Property(string: "") {

		willSet {

			self.view.text = newValue.string

			if (self.layoutNode.wrapsContentWidth ||
				self.layoutNode.wrapsContentHeight) {
				self.layoutNode.invalidateSize()
			}
		}
	}

	/**
	 * The text view's text color.
	 * @property textColor
	 * @since 0.7.0
	 */
	@objc open var textColor: Property = Property(string: "#000") {
		willSet {
			self.view.textColor = CGColorParse(newValue.string)
		}
	}

	/**
	 * The text view's text alignment.
	 * @property textAlignment
	 * @since 0.7.0
	 */
	@objc open var textAlignment: Property = Property(string: "start") {
		willSet {
			self.view.textAlignment = self.getTextAlignment(newValue.string)
		}
	}

	/**
	 * The text view's text placement.
	 * @property textPlacement
	 * @since 0.7.0
	 */
	@objc open var textPlacement: Property = Property(string: "middle") {
		willSet {
			self.view.textPlacement = self.getTextPlacement(newValue.string)
		}
	}

	/**
	 * The text view's text baseline.
	 * @property textBaseline
	 * @since 0.7.0
	 */
	@objc open var textBaseline: Property = Property(number: 0) {

		willSet {

			self.view.textBaseline = CGFloat(newValue.number)

			if (self.layoutNode.wrapsContentWidth ||
				self.layoutNode.wrapsContentHeight) {
				self.layoutNode.invalidateSize()
			}
		}
	}

	/**
	 * The text view's text kerning.
	 * @property textKerning
	 * @since 0.7.0
	 */
	@objc open var textKerning: Property = Property(number: 0) {

		willSet {

			self.view.textKerning = CGFloat(newValue.number)

			if (self.layoutNode.wrapsContentWidth ||
				self.layoutNode.wrapsContentHeight) {
				self.layoutNode.invalidateSize()
			}
		}
	}

	/**
	 * The text view's text leading.
	 * @property textLeading
	 * @since 0.7.0
	 */
	@objc open var textLeading: Property = Property(number: 0) {

		willSet {

			self.view.textLeading = CGFloat(newValue.number)

			if (self.layoutNode.wrapsContentWidth ||
				self.layoutNode.wrapsContentHeight) {
				self.layoutNode.invalidateSize()
			}
		}
	}

	/**
	 * The text view's text shadow blur.
	 * @property textShadowBlur
	 * @since 0.7.0
	 */
	@objc open var textShadowBlur: Property = Property(number: 0) {
		willSet {
			self.view.textShadowBlur = CGFloat(newValue.number)
		}
	}

	/**
	 * The text view's text shadow color.
	 * @property textShadowColor
	 * @since 0.7.0
	 */
	@objc open var textShadowColor: Property = Property(string: "#000") {
		willSet {
			self.view.textShadowColor = CGColorParse(newValue.string)
		}
	}

	/**
	 * The text view's text shadow offset top.
	 * @property textShadowOffsetTop
	 * @since 0.7.0
	 */
	@objc open var textShadowOffsetTop: Property = Property(number: 0) {
		willSet {
			self.view.textShadowOffsetTop = CGFloat(newValue.number)
		}
	}

	/**
	 * The text view's text shadow offset left.
	 * @property textShadowOffsetLeft
	 * @since 0.7.0
	 */
	@objc open var textShadowOffsetLeft: Property = Property(number: 0) {
		willSet {
			self.view.textShadowOffsetLeft = CGFloat(newValue.number)
		}
	}

	/**
	 * The text view's text decoration.
	 * @property textDecoration
	 * @since 0.7.0
	 */
	@objc open var textDecoration: Property = Property(string: "none") {

		willSet {

			self.view.textDecoration = self.getTextDecoration(newValue.string)

			if (self.layoutNode.wrapsContentWidth ||
				self.layoutNode.wrapsContentHeight) {
				self.layoutNode.invalidateSize()
			}
		}
	}

	/**
	 * The text view's text transform mode.
	 * @property textTransform
	 * @since 0.7.0
	 */
	@objc open var textTransform: Property = Property(string: "none") {

		willSet {

			self.view.textTransform = self.getTextTransform(newValue.string)

			if (self.layoutNode.wrapsContentWidth ||
				self.layoutNode.wrapsContentHeight) {
				self.layoutNode.invalidateSize()
			}
		}
	}

	/**
	 * The text view's text overflow.
	 * @property textOverflow
	 * @since 0.7.0
	 */
	@objc open var textOverflow: Property = Property(string: "ellipsis") {

		willSet {

			self.view.textOverflow = self.getTextOverflow(newValue.string)

			if (self.layoutNode.wrapsContentWidth ||
				self.layoutNode.wrapsContentHeight) {
				self.layoutNode.invalidateSize()
			}
		}
	}

	/**
	 * The text view's link color.
	 * @property linkColor
	 * @since 0.7.0
	 */
	@objc open var linkColor: Property = Property(string: "blue") {
		willSet {
			self.view.linkColor = CGColorParse(newValue.string)
		}
	}

	/**
	 * The text view's line limit.
	 * @property lines
	 * @since 0.7.0
	 */
	@objc open var lines: Property = Property(number: 0) {

		willSet {

			self.view.lines = Int(newValue.number)

			if (self.layoutNode.wrapsContentWidth ||
				self.layoutNode.wrapsContentHeight) {
				self.layoutNode.invalidateSize()
			}
		}
	}

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
		self.holder.callMethod("nativeOnPressLink", arguments: [self.context.createString(url)])
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
	 * @method getTextPlacement
	 * @since 0.7.0
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
		self.text = Property(value: callback.value)
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
		return self.textAlignment = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_textPlacement
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_textPlacement(callback: JavaScriptGetterCallback) {
		callback.returns(self.textPlacement)
	}

	/**
	 * @method jsSet_textPlacement
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_textPlacement(callback: JavaScriptSetterCallback) {
		self.textPlacement = Property(value: callback.value)
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
		self.textBaseline = Property(value: callback.value)
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
		self.textOverflow = Property(value: callback.value)
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
		self.linkColor = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_lines
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_lines(callback: JavaScriptGetterCallback) {
		callback.returns(self.lines)
	}

	/**
	 * @method jsSet_lines
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_lines(callback: JavaScriptSetterCallback) {
		self.lines = Property(value: callback.value)
	}
}
