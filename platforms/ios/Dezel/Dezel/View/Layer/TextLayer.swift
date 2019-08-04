/**
 * The layer that renders text.
 * @class TextLayer
 * @super Layer
 * @since 0.1.0
 */
open class TextLayer: Layer {

	//--------------------------------------------------------------------------
	// MARK: Class Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method needsDisplay
	 * @since 0.1.0
	 */
	override open class func needsDisplay(forKey key: String) -> Bool {

		if (key == "textColor" ||
			key == "textKerning" ||
			key == "textLeading" ||
			key == "textBaseline") {
			return true
		}

		return super.needsDisplay(forKey: key)
	}

	//----------------------------------------------------------------------
	// MARK: Properties
	//----------------------------------------------------------------------

	/**
	 * @inherited
	 * @property bounds
	 * @since 0.1.0
	 */
	override open var bounds: CGRect {

		didSet {

			let oldW = oldValue.size.width
			let oldH = oldValue.size.height
			let newW = self.bounds.size.width
			let newH = self.bounds.size.height

			if (newW != oldW ||
				newH != oldH) {
				self.setNeedsDisplay()
			}
		}
	}

	/**
	 * The text layer's text layout.
	 * @property layout
	 * @since 0.5.0
	 */
	private(set) public var layout: TextLayout = TextLayout()

	/**
	 * The text layer's text color.
	 * @property textColor
	 * @since 0.1.0
	 */
	@NSManaged public var textColor: CGColor

	/**
	 * The text layer's text kerning.
	 * @property textKerning
	 * @since 0.1.0
	 */
	@NSManaged public var textKerning: CGFloat

	/**
	 * The text layer's text leading.
	 * @property textLeading
	 * @since 0.1.0
	 */
	@NSManaged public var textLeading: CGFloat

	/**
	 * The text layer's text baseline.
	 * @property textBaseline
	 * @since 0.1.0
	 */
	@NSManaged public var textBaseline: CGFloat

	/**
	 * The text layer's font family.
	 * @property fontFamily
	 * @since 0.1.0
	 */
	public var fontFamily: String = "" {
		willSet {
			self.font = nil
			self.invalidateAttributes()
			self.invalidateAttributedText()
			self.invalidateAttributedEllipsis()
			self.setNeedsDisplay()
		}
	}

	/**
	 * The text layer's font weight.
	 * @property fontWeight
	 * @since 0.1.0
	 */
	public var fontWeight: String = "" {
		willSet {
			self.font = nil
			self.invalidateAttributes()
			self.invalidateAttributedText()
			self.invalidateAttributedEllipsis()
			self.setNeedsDisplay()
		}
	}

	/**
	 * The text layer's font size.
	 * @property fontSize
	 * @since 0.1.0
	 */
	public var fontSize: CGFloat = 17 {
		willSet {
			self.font = nil
			self.invalidateAttributes()
			self.invalidateAttributedText()
			self.invalidateAttributedEllipsis()
			self.setNeedsDisplay()
		}
	}

	/**
	 * The text layer's font style.
	 * @property fontStyle
	 * @since 0.1.0
	 */
	public var fontStyle: String = "" {
		willSet {
			self.font = nil
			self.invalidateAttributes()
			self.invalidateAttributedText()
			self.invalidateAttributedEllipsis()
			self.setNeedsDisplay()
		}
	}

	/**
	 * The text layer's text.
	 * @property text
	 * @since 0.1.0
	 */
	public var text: String = "" {
		willSet {
			self.invalidateAttributedText()
			self.setNeedsDisplay()
		}
	}

	/**
	 * The text layer's text decoration.
	 * @property textDecoration
	 * @since 0.1.0
	 */
	open var textDecoration: TextDecoration = .none {
		willSet {
			self.invalidateAttributes()
			self.invalidateAttributedText()
			self.setNeedsDisplay()
		}
	}

	/**
	 * The text layer's text transform.
	 * @property textTransform
	 * @since 0.1.0
	 */
	open var textTransform: TextTransform = .none {
		willSet {
			self.invalidateAttributes()
			self.invalidateAttributedText()
			self.setNeedsDisplay()
		}
	}

	/**
	 * The text layer's text alignment.
	 * @property textAlignment
	 * @since 0.1.0
	 */
	open var textAlignment: TextAlignment = .start {
		willSet {
			self.invalidateAttributes()
			self.invalidateAttributedText()
			self.setNeedsDisplay()
		}
	}

	/**
	 * The text layer's text location.
	 * @property textLocation
	 * @since 0.7.0
	 */
	open var textLocation: TextLocation = .middle {
		willSet {
			self.layout.textLocation = newValue
			self.setNeedsDisplay()
		}
	}

	/**
	 * The text layer's text overflow.
	 * @property textOverflow
	 * @since 0.1.0
	 */
	open var textOverflow: TextOverflow = .ellipsis {
		willSet {
			self.layout.textOverflow = newValue
			self.setNeedsDisplay()
		}
	}

	/**
	 * The text layer's maximum amount of lines.
	 * @property maxLines
	 * @since 0.7.0
	 */
	open var maxLines: Int = 0 {
		willSet {
			self.layout.maxLines = newValue
			self.setNeedsDisplay()
		}
	}

	/**
	 * The text layer's link color.
	 * @property linkColor
	 * @since 0.5.0
	 */
	open var linkColor: CGColor = CGColorCreateRGBA(r: 0, g: 0, b: 255, a: 1) {
		willSet {
			self.invalidateAttributes()
			self.invalidateAttributedText()
			self.setNeedsDisplay()
		}
	}

	/**
	 * The text layer's link decoration.
	 * @property linkDecoration
	 * @since 0.5.0
	 */
	open var linkDecoration: TextDecoration = .underline {
		willSet {
			self.invalidateAttributes()
			self.invalidateAttributedText()
			self.setNeedsDisplay()
		}
	}

	/**
	 * @property font
	 * @since 0.1.0
	 * @hidden
	 */
	private var font: UIFont?

	/**
	 * @property attributes
	 * @since 0.1.0
	 * @hidden
	 */
	private var attributes: TextAttributes = TextAttributes()

	/**
	 * @property attributedText
	 * @since 0.5.0
	 * @hidden
	 */
	private var attributedText: NSAttributedString = NSAttributedString(string: "") {
		willSet {
			self.layout.text = newValue
		}
	}

	/**
	 * @property attributedEllipsis
	 * @since 0.5.0
	 * @hidden
	 */
	private var attributedEllipsis: NSAttributedString = NSAttributedString(string: "…") {
		willSet {
			self.layout.ellipsis = newValue
		}
	}

	/**
	 * @property invalidAttributes
	 * @since 0.5.0
	 * @hidden
	 */
	private var invalidAttributes: Bool = false

	/**
	 * @property invalidAttributedText
	 * @since 0.5.0
	 * @hidden
	 */
	private var invalidAttributedText: Bool = false

	/**
	 * @property invalidAttributedEllipsis
	 * @since 0.5.0
	 * @hidden
	 */
	private var invalidAttributedEllipsis: Bool = false

	/**
	 * @property textParserOptions
	 * @since 0.5.0
	 * @hidden
	 */
	private var textParserOptions: TextParser.Options = TextParser.Options(
		linkTextColor: CGColorCreateRGBA(r: 0, g: 0, b: 1, a: 1),
		linkTextDecoration: .underline
	)

	//----------------------------------------------------------------------
	// MARK: Methods
	//----------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	required public init() {
		super.init()
		self.needsDisplayOnBoundsChange = true
		self.shadowRadius = 0
		self.shadowOffset = .zero
	}

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	override init(layer: Any) {

		super.init(layer: layer as AnyObject)

		if let layer = layer as? TextLayer {
			self.fontFamily = layer.fontFamily
			self.fontWeight = layer.fontWeight
			self.fontStyle = layer.fontStyle
			self.fontSize = layer.fontSize
			self.text = layer.text
			self.textColor = layer.textColor
			self.textKerning = layer.textKerning
			self.textLeading = layer.textLeading
			self.textDecoration = layer.textDecoration
			self.textTransform = layer.textTransform
			self.textAlignment = layer.textAlignment
			self.textLocation = layer.textLocation
			self.textBaseline = layer.textBaseline
			self.maxLines = layer.maxLines
		}
	}

	/**
	 * Returns the character at the specified location.
	 * @method find
	 * @since 0.5.0
	 */
	open func find(at point: CGPoint) -> NSAttributedString? {
		return self.layout.find(at: point)
	}

	/**
	 * @method measure
	 * @since 0.1.0
	 * @hidden
	 */
	public func measure(in size: CGSize, min: CGSize, max: CGSize) -> CGSize {

		if (self.text.length == 0) {
			return .zero
		}

		self.update(in: size)

		return self.layout.extent.clamped(min: min, max: max)
	}

	/**
	 * @method update
	 * @since 0.5.0
	 * @hidden
	 */
	override open func update() {
		self.update(in: self.bounds.size)
	}

	/**
	 * @method update
	 * @since 0.5.0
	 * @hidden
	 */
	open func update(in size: CGSize) {

		if (self.invalidAttributes) {
			self.invalidAttributes = false
			self.updateAttributes()
		}

		if (self.invalidAttributedText) {
			self.invalidAttributedText = false
			self.updateAttributedText()
		}

		if (self.invalidAttributedEllipsis) {
			self.invalidAttributedEllipsis = false
			self.updateAttributedEllipsis()
		}

		self.layout.build(in: size)
	}

	/**
	 * Updates the attributes.
	 * @method updateAttributes
	 * @since 0.4.0
	 */
	open func updateAttributes() {

		if (self.font == nil) {
			self.font = UIFont.from(
				family: self.fontFamily,
				weight: self.fontWeight,
				style: self.fontStyle,
				size: self.fontSize
			)
		}

		let textColor: CGColor
		let textKerning: CGFloat
		let textLeading: CGFloat

		if let presentation = self.presentation() {
			textColor = presentation.textColor
			textKerning = presentation.textKerning
			textLeading = presentation.textLeading
		} else {
			textColor = self.textColor
			textKerning = self.textKerning
			textLeading = self.textLeading
		}

		var attributes = TextAttributes()
		attributes.setFont(self.font)
		attributes.setTextColor(textColor)
		attributes.setTextKerning(textKerning)
		attributes.setTextLeading(textLeading)
		attributes.setTextAlignment(self.textAlignment)
		attributes.setTextDecoration(self.textDecoration)
		attributes.setBaselineOffset(0)

		self.attributes = attributes
	}

	/**
	 * Updates the attributed text string.
	 * @method updateAttributedText
	 * @since 0.5.0
	 */
	open func updateAttributedText() {

		if (self.text.length == 0) {
			return
		}

		var string = self.text.normalize()

		switch (self.textTransform) {

			case .uppercase:
				string = string.uppercased()
			case .lowercase:
				string = string.lowercased()
			case .capitalize:
				string = string.capitalized

			default:
				break
		}

		if (string.isHTML) {
			self.textParserOptions.linkTextColor = self.linkColor
			self.textParserOptions.linkTextDecoration = self.linkDecoration
			self.attributedText = TextParser(html: string, base: self.attributes, options: self.textParserOptions).string
			return
		}

		self.attributedText = NSAttributedString(string: string, attributes: self.attributes)
	}

	/**
	 * Updates the attributed ellipsis string.
	 * @method updateAttributedEllipsis
	 * @since 0.5.0
	 */
	open func updateAttributedEllipsis() {
		self.attributedEllipsis = NSAttributedString(string: "…", attributes: self.attributes)
	}

	/**
	 * @inherited
	 * @method didChangeValue
	 * @since 0.1.0
	 */
	override open func didChangeValue(forKey key: String) {

		if (key == "textColor") {
			self.invalidateAttributes()
			self.invalidateAttributedText()
			self.invalidateAttributedEllipsis()
			self.setNeedsDisplay()
			return
		}

		if (key == "textKerning") {

			self.invalidateAttributes()
			self.invalidateAttributedText()
			self.setNeedsDisplay()

			self.layout.textKerning = self.textKerning

			return
		}

		if (key == "textLeading") {

			self.invalidateAttributes()
			self.invalidateAttributedText()
			self.setNeedsDisplay()

			self.layout.textLeading = self.textLeading

			return
		}

		if (key == "textBaseline") {

			self.invalidateAttributes()
			self.invalidateAttributedText()
			self.setNeedsDisplay()

			self.layout.textBaseline = self.textBaseline

			return
		}
	}

	/**
	 * @method draw
	 * @since 0.1.0
	 * @hidden
	 */
	override open func draw(in context: CGContext) {

		if (self.text.length == 0) {
			return
		}

		if (self.shadowRadius > 0 ||
			self.shadowOffset.width != 0 ||
			self.shadowOffset.height != 0) {
			self.shadowOpacity = 1
		} else {
			self.shadowOpacity = 0
		}

		self.update()

		self.layout.draw(in: context)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Animations
	//--------------------------------------------------------------------------

	/**
	 * @method action
	 * @since 0.1.0
	 * @hidden
	 */
	override open func action(forKey key: String) -> CAAction? {

		if let transition = Transition.current {

			var current = self.presentation()
			if (current == nil || self.animation(forKey: key) == nil) {
				current = self
			}

			let animation = CABasicAnimation(keyPath: key)

			switch (key) {

				case "textColor":
					animation.fromValue = current!.textColor
				case "textKerning":
					animation.fromValue = current!.textKerning
				case "textLeading":
					animation.fromValue = current!.textLeading
				case "textBaseline":
					animation.fromValue = current!.textBaseline

				default:
					break
			}

			if (animation.fromValue != nil) {

				if (transition.delay > 0) {
					animation.beginTime = CACurrentMediaTime() + transition.delay
					animation.fillMode = CAMediaTimingFillMode.both
				}

				return animation
			}
		}

		return super.action(forKey: key)
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method invalidateAttributes
	 * @since 0.1.0
	 * @hidden
	 */
	private func invalidateAttributes() {
		self.invalidAttributes = true
	}

	/**
	 * @method invalidateAttributedText
	 * @since 0.5.0
	 * @hidden
	 */
	private func invalidateAttributedText() {
		self.invalidAttributedText = true
	}

	/**
	 * @method invalidateAttributedEllipsis
	 * @since 0.5.0
	 * @hidden
	 */
	private func invalidateAttributedEllipsis() {
		self.invalidAttributedEllipsis = true
	}
}
