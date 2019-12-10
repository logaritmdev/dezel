/**
 * @class TextLayer
 * @super Layer
 * @since 0.1.0
 */
open class TextLayer: Layer {

	//--------------------------------------------------------------------------
	// MARK: Class Methods
	//--------------------------------------------------------------------------

	/**
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
	 * @property textColor
	 * @since 0.1.0
	 */
	@NSManaged public var textColor: CGColor

	/**
	 * @property textKerning
	 * @since 0.1.0
	 */
	@NSManaged public var textKerning: CGFloat

	/**
	 * @property textLeading
	 * @since 0.1.0
	 */
	@NSManaged public var textLeading: CGFloat

	/**
	 * @property textBaseline
	 * @since 0.1.0
	 */
	@NSManaged public var textBaseline: CGFloat

	/**
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
	 * @property textAlign
	 * @since 0.1.0
	 */
	open var textAlign: TextAlign = .middleLeft {
		willSet {
			self.layout.textAlign = newValue
			self.invalidateAttributes()
			self.invalidateAttributedText()
			self.setNeedsDisplay()
		}
	}

	/**
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
	 * @property minLines
	 * @since 0.7.0
	 */
	open var minLines: Int = 0 {
		willSet {
			self.layout.minLines = newValue
			self.setNeedsDisplay()
		}
	}

	/**
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
	 * @property linkColor
	 * @since 0.5.0
	 */
	open var linkColor: UIColor = .blue {
		willSet {
			self.invalidateAttributes()
			self.invalidateAttributedText()
			self.setNeedsDisplay()
		}
	}

	/**
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
	 * @property layout
	 * @since 0.5.0
	 */
	private(set) public var layout: TextLayout = TextLayout()

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
		linkTextColor: .blue,
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
		self.shadowOffset = .zero
		self.shadowRadius = 0
		self.shadowOpacity = 0
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
			self.textAlign = layer.textAlign
			self.textKerning = layer.textKerning
			self.textLeading = layer.textLeading
			self.textDecoration = layer.textDecoration
			self.textTransform = layer.textTransform
			self.textBaseline = layer.textBaseline
			self.maxLines = layer.maxLines
		}
	}

	/**
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
	public func measure(size: CGSize, min: CGSize, max: CGSize) -> CGSize {

		if (self.text.length == 0) {
			return .zero
		}

		self.update(in: size)

		return self.layout.extent.clamp(min: min, max: max)
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
		attributes.setTextAlign(self.textAlign)
		attributes.setTextKerning(textKerning)
		attributes.setTextLeading(textLeading)
		attributes.setTextDecoration(self.textDecoration)
		attributes.setBaselineOffset(0)

		self.attributes = attributes
	}

	/**
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
	 * @method updateAttributedEllipsis
	 * @since 0.5.0
	 */
	open func updateAttributedEllipsis() {
		self.attributedEllipsis = NSAttributedString(string: "…", attributes: self.attributes)
	}

	/**
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
					animation.delay = transition.delay
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
