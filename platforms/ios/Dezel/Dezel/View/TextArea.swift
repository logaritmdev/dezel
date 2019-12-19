/**
 * @class ContentTextArea
 * @super UITextView
 * @since 0.7.0
 */
open class TextArea: UITextView, UITextViewDelegate {

	//--------------------------------------------------------------------------
	// MARK: Layer Class
	//--------------------------------------------------------------------------

	/**
	 * @property layerClass
	 * @since 0.7.0
	 */
	open override class var layerClass: AnyClass {
		return Layer.self
	}

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property value
	 * @since 0.7.0
	 */
	open var value: String = "" {
		didSet {
			self.attributedText = self.getAttributedText()
			self.placeholderLabel.isHidden = value != ""
		}
	}

	/**
	 * @property placeholder
	 * @since 0.7.0
	 */
	open var placeholder: String? {
		didSet {
			self.attributedPlaceholder = self.getAttributedPlaceholder()
		}
	}

	/**
	 * @property placeholderColor
	 * @since 0.7.0
	 */
	open var placeholderColor: UIColor = .gray {
		didSet {
			self.attributedPlaceholder = self.getAttributedPlaceholder()
		}
	}

	/**
	 * @property fontFamily
	 * @since 0.7.0
	 */
	open var fontFamily: String = "" {
		willSet {
			self.invalidateFont()
			self.invalidateAttributedText()
		}
	}

	/**
	 * @property fontWeight
	 * @since 0.7.0
	 */
	open var fontWeight: String = "normal" {
		willSet {
			self.invalidateFont()
			self.invalidateAttributedText()
		}
	}

	/**
	 * @property fontStyle
	 * @since 0.7.0
	 */
	open var fontStyle: String = "normal" {
		willSet {
			self.invalidateFont()
			self.invalidateAttributedText()
		}
	}

	/**
	 * @property fontSize
	 * @since 0.7.0
	 */
	open var fontSize: CGFloat = 17.0 {
		willSet {
			self.invalidateFont()
			self.invalidateAttributedText()
		}
	}

	/**
	 * @property textColor
	 * @since 0.7.0
	 */
	override open var textColor: UIColor? {
		willSet {
			self.invalidateAttributedText()
		}
	}

	/**
	 * @property textAlign
	 * @since 0.7.0
	 */
	open var textAlign: TextAlign = .middleLeft {
		willSet {
			self.invalidateAttributedText()
		}
	}

	/**
	 * @property textKerning
	 * @since 0.7.0
	 */
	open var textKerning: CGFloat = 0 {
		willSet {
			self.invalidateAttributedText()
		}
	}

	/**
	 * @property textLeading
	 * @since 0.7.0
	 */
	open var textLeading: CGFloat = 0 {
		willSet {
			self.invalidateAttributedText()
		}
	}

	/**
	 * @property textDecoration
	 * @since 0.7.0
	 */
	open var textDecoration: TextDecoration = .none {
		willSet {
			self.invalidateAttributedText()
		}
	}

	/**
	 * @property textTransform
	 * @since 0.7.0
	 */
	open var textTransform: TextTransform = .none {
		willSet {
			self.invalidateAttributedText()
		}
	}

	/**
	 * @property textShadowBlur
	 * @since 0.7.0
	 */
	open var textShadowBlur: CGFloat = 0 {
		willSet {
			self.layer.shadowRadius = newValue / CGFloat(Double.pi)
		}
	}

	/**
	 * @property textShadowColor
	 * @since 0.7.0
	 */
	open var textShadowColor: UIColor = .black {
		willSet {
			self.layer.shadowColor = newValue.cgColor
		}
	}

	/**
	 * @property textShadowOffsetTop
	 * @since 0.7.0
	 */
	open var textShadowOffsetTop: CGFloat = 0 {
		willSet {
			self.layer.shadowOffset = self.layer.shadowOffset.setTop(newValue)
		}
	}

	/**
	 * @property textShadowOffsetLeft
	 * @since 0.7.0
	 */
	open var textShadowOffsetLeft: CGFloat = 0 {
		willSet {
			self.layer.shadowOffset = self.layer.shadowOffset.setLeft(newValue)
		}
	}

	/**
	 * @property paddingTop
	 * @since 0.7.0
	 */
	open var paddingTop: CGFloat = 0 {
		willSet {
			self.setNeedsLayout()
		}
	}

	/**
	 * @property paddingLeft
	 * @since 0.7.0
	 */
	open var paddingLeft: CGFloat = 0 {
		willSet {
			self.setNeedsLayout()
		}
	}

	/**
	 * @property paddingRight
	 * @since 0.7.0
	 */
	open var paddingRight: CGFloat = 0 {
		willSet {
			self.setNeedsLayout()
		}
	}

	/**
	 * @property paddingBottom
	 * @since 0.7.0
	 */
	open var paddingBottom: CGFloat = 0 {
		willSet {
			self.setNeedsLayout()
		}
	}

	/**
	 * @property attributedPlaceholder
	 * @since 0.7.0
	 */
	open var attributedPlaceholder: NSAttributedString? {
		willSet {
			self.placeholderLabel.attributedText = newValue
		}
	}

	/**
	 * @property observer
	 * @since 0.7.0
	 * @hidden
	 */
	internal weak var observer: TextAreaObserver?

	/**
	 * @property placeholderLabel
	 * @since 0.7.0
	 * @hidden
	 */
	private var placeholderLabel: UILabel = UILabel()

	/**
	 * @property invalidFont
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidFont: Bool = false

	/**
	 * @property invalidAttributedText
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidAttributedText: Bool = false

	/**
	 * @property invalidAttributedPlaceholder
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidAttributedPlaceholder: Bool = false

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public init(frame: CGRect, observer: TextAreaObserver?) {

		super.init(frame: frame, textContainer: nil)

		self.font = UIFont.systemFont(ofSize: 17)

		self.delegate = self
		self.autocorrectionType = .yes
		self.autocapitalizationType = .sentences

		self.placeholderLabel.numberOfLines = 0
		self.placeholderLabel.isUserInteractionEnabled = false
		self.placeholderLabel.attributedText = self.getAttributedPlaceholder()
		self.addSubview(self.placeholderLabel)

		self.observer = observer
	}

	/**
	 * @method layoutSubviews
	 * @since 0.7.0
	 */
	override open func layoutSubviews() {

		super.layoutSubviews()

		let carret = CGFloat(5)
		self.placeholderLabel.sizeToFit()
		self.placeholderLabel.frame.origin.y = self.paddingTop
		self.placeholderLabel.frame.origin.x = self.paddingLeft + carret
		self.placeholderLabel.frame.size.width = self.bounds.width - self.paddingLeft - self.paddingRight - carret

		self.textContainerInset = UIEdgeInsets(top: self.paddingTop, left: self.paddingLeft, bottom: self.paddingBottom, right: self.paddingRight)
	}

	/**
	 * @method focus
	 * @since 0.7.0
	 */
	open func focus() {
		if (self.isFirstResponder == false) {
			self.becomeFirstResponder()
		}
	}

	/**
	 * @method blur
	 * @since 0.7.0
	 */
	open func blur() {
		if (self.isFirstResponder) {
			self.resignFirstResponder()
		}
	}

	/**
	 * @method draw
	 * @since 0.7.0
	 */
	override open func draw(_ rect: CGRect) {

		if (self.invalidFont) {
			self.invalidFont = false
			self.updateFont()
		}

		if (self.invalidAttributedText) {
			self.invalidAttributedText = false
			self.attributedText = self.getAttributedText()
		}

		if (self.invalidAttributedPlaceholder) {
			self.invalidAttributedPlaceholder = false
			self.attributedPlaceholder = self.getAttributedPlaceholder()
		}

		super.draw(rect)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Text Field Delegate
	//--------------------------------------------------------------------------

	/**
	 * @since 0.7.0
	 * @hidden
	 */
	open func textView(_ textView: UITextView, shouldChangeTextIn charactersRange: NSRange, replacementText string: String) -> Bool {

		if let text = textView.text, let range = Range(charactersRange, in: text) {

			let begin = textView.beginningOfDocument
			let position = textView.position(from: begin, offset: charactersRange.location)
			let offset = textView.offset(from: begin, to: position!) + string.count

			self.observer?.didChange(textInput: self, value: text.replacingCharacters(in: range, with: string))

			if let cursor = textView.position(from: begin, offset: offset) {
				textView.selectedTextRange = textView.textRange(
					from: cursor,
					to: cursor
				)
			}
		}

		return false
	}

	/**
	 * @since 0.7.0
	 * @hidden
	 */
	open func textViewShouldReturn(_ textView: UITextView) -> Bool {
		textView.resignFirstResponder()
		return true
	}

	/**
	 * @since 0.7.0
	 * @hidden
	 */
	open func textViewDidBeginEditing(_ textView: UITextView) {
		self.observer?.didFocus(textInput: self)
	}

	/**
	 * @since 0.7.0
	 * @hidden
	 */
	open func textViewDidEndEditing(_ textView: UITextView) {
		self.observer?.didBlur(textInput: self)
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method invalidateFont
	 * @since 0.7.0
	 * @hidden
	 */
	private func invalidateFont() {
		if (self.invalidFont == false) {
			self.invalidFont = true
			self.setNeedsDisplay()
		}
	}

	/**
	 * @method invalidateAttributedText
	 * @since 0.7.0
	 * @hidden
	 */
	private func invalidateAttributedText() {
		if (self.invalidAttributedText == false) {
			self.invalidAttributedText = true
			self.setNeedsDisplay()
		}
	}

	/**
	 * @method invalidateAttributedPlaceholder
	 * @since 0.7.0
	 * @hidden
	 */
	private func invalidateAttributedPlaceholder() {
		if (self.invalidAttributedPlaceholder == false) {
			self.invalidAttributedPlaceholder = true
			self.setNeedsDisplay()
		}
	}

	/**
	 * @method updateFont
	 * @since 0.7.0
	 * @hidden
	 */
	open func updateFont() {
		self.font = UIFont.from(family: self.fontFamily, weight: self.fontWeight, style: self.fontStyle, size: self.fontSize)
	}

	/**
	 * @method getAttributedText
	 * @since 0.7.0
	 * @hidden
	 */
	private func getAttributedText() -> NSAttributedString? {

		var attributes = TextAttributes()
		attributes.setFont(self.font)
		attributes.setTextColor(self.textColor)
		attributes.setTextKerning(self.textKerning)
		attributes.setTextLeading(self.textLeading)
		attributes.setTextAlign(self.textAlign)
		attributes.setTextDecoration(self.textDecoration)
		attributes.setBaselineOffset(0)

		var value = self.value

		switch (self.textTransform) {

			case .uppercase:
				value = value.uppercased()
			case .lowercase:
				value = value.uppercased()
			case .capitalize:
				value = value.capitalized

			default: break
		}

		return NSAttributedString(string: value, attributes: attributes)
	}

	/**
	 * @method getAttributedPlaceholder
	 * @since 0.7.0
	 * @hidden
	 */
	private func getAttributedPlaceholder() -> NSAttributedString? {

		guard var placeholder = self.placeholder else {
			return nil
		}

		var attributes = TextAttributes()
		attributes.setFont(self.font)
		attributes.setTextColor(self.placeholderColor)
		attributes.setTextKerning(self.textKerning)
		attributes.setTextLeading(self.textLeading)
		attributes.setTextAlign(self.textAlign)
		attributes.setTextDecoration(self.textDecoration)
		attributes.setBaselineOffset(0)

		switch (self.textTransform) {

			case .uppercase:
				placeholder = placeholder.uppercased()
			case .lowercase:
				placeholder = placeholder.uppercased()
			case .capitalize:
				placeholder = placeholder.capitalized

			default: break
		}

		return NSAttributedString(string: placeholder, attributes: attributes)
	}
}
