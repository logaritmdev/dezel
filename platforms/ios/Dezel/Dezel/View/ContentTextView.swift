import UIKit

/**
 * @class ContentTextView
 * @since 0.1.0
 * @hidden
 */
open class ContentTextView: UIView, Updatable, Clippable, TransitionListener {

	//----------------------------------------------------------------------
	// MARK: Properties
	//----------------------------------------------------------------------

	/**
	 * @inherited
	 * @property frame
	 * @since 0.2.0
	 */
	override open var frame: CGRect {
		willSet {
			self.textLayerInvalidFrame = true
		}
	}

	/**
	 * @inherited
	 * @property clipsToBounds
	 * @since 0.1.0
	 */
	override open var clipsToBounds: Bool {
		set { }
		get {
			return true
		}
	}

	/**
	 * The text view's font family.
	 * @property fontFamily
	 * @since 0.1.0
	 */
	open var fontFamily: String = "default" {
		willSet {
			self.textLayer.fontFamily = newValue
		}
	}

	/**
	 * The text view's font weight.
	 * @property fontWeight
	 * @since 0.1.0
	 */
	open var fontWeight: String = "normal" {
		willSet {
			self.textLayer.fontWeight = newValue
		}
	}

	/**
	 * The text view's font style.
	 * @property fontStyle
	 * @since 0.1.0
	 */
	open var fontStyle: String = "normal" {
		willSet {
			self.textLayer.fontStyle = newValue
		}
	}

	/**
	 * The text view's font size.
	 * @property fontSize
	 * @since 0.1.0
	 */
	open var fontSize: CGFloat = 17 {
		willSet {
			self.textLayer.fontSize = newValue
		}
	}

	/**
	 * The text view's text.
	 * @property text
	 * @since 0.1.0
	 */
	open var text: String = "" {
		willSet {
			self.textLayer.text = newValue
		}
	}

	/**
	 * The text view's text color.
	 * @property textColor
	 * @since 0.1.0
	 */
	open var textColor: CGColor = .black {
		willSet {
			self.textLayer.textColor = newValue
		}
	}

	/**
	 * The text view's text alignment.
	 * @property textAlignment
	 * @since 0.1.0
	 */
	open var textAlignment: TextAlignment = .start {
		willSet {
			self.textLayer.textAlignment = newValue
		}
	}

	/**
	 * The text view's text placement.
	 * @property textPlacement
	 * @since 0.1.0
	 */
	open var textPlacement: TextPlacement = .middle {
		willSet {
			self.textLayer.textPlacement = newValue
		}
	}

	/**
	 * The text view's text baseline.
	 * @property textBaseline
	 * @since 0.1.0
	 */
	open var textBaseline: CGFloat = 0 {
		willSet {
			self.textLayer.textBaseline = newValue
		}
	}

	/**
	 * The text view's text kerning.
	 * @property textKerning
	 * @since 0.1.0
	 */
	open var textKerning: CGFloat = 0 {
		willSet {
			self.textLayer.textKerning = newValue
		}
	}

	/**
	 * The text view's text leading.
	 * @property textLeading
	 * @since 0.1.0
	 */
	open var textLeading: CGFloat = 0 {
		willSet {
			self.textLayer.textLeading = newValue
		}
	}

	/**
	 * The text view's text shadow blur.
	 * @property textShadowBlur
	 * @since 0.1.0
	 */
	open var textShadowBlur: CGFloat = 0 {
		willSet {
			self.textLayer.shadowRadius = newValue / CGFloat(Double.pi)
		}
	}

	/**
	 * The text view's text shadow color.
	 * @property textShadowColor
	 * @since 0.1.0
	 */
	open var textShadowColor: CGColor = .black {
		willSet {
			self.textLayer.shadowColor = newValue
		}
	}

	/**
	 * The text view's text shadow offset top.
	 * @property textShadowOffsetTop
	 * @since 0.1.0
	 */
	open var textShadowOffsetTop: CGFloat = 0 {
		willSet {
			self.textLayer.shadowOffset = self.textLayer.shadowOffset.setTop(newValue)
		}
	}

	/**
	 * The text view's text shadow offset left.
	 * @property textShadowOffsetLeft
	 * @since 0.1.0
	 */
	open var textShadowOffsetLeft: CGFloat = 0 {
		willSet {
			self.textLayer.shadowOffset = self.textLayer.shadowOffset.setLeft(newValue)
		}
	}

	/**
	 * The text view's text decoration.
	 * @property textDecoration
	 * @since 0.1.0
	 */
	open var textDecoration: TextDecoration = .none {
		willSet {
			self.textLayer.textDecoration = newValue
		}
	}

	/**
	 * The text view's text transform mode.
	 * @property textTransform
	 * @since 0.1.0
	 */
	open var textTransform: TextTransform = .none {
		willSet {
			self.textLayer.textTransform = newValue
		}
	}

	/**
	 * The text view's text overflow.
	 * @property textOverflow
	 * @since 0.1.0
	 */
	open var textOverflow: TextOverflow = .ellipsis {
		willSet {
			self.textLayer.textOverflow = newValue
		}
	}

	/**
	 * The text view's link color.
	 * @property linkColor
	 * @since 0.5.0
	 */
	open var linkColor: CGColor = CGColorCreateRGBA(r: 0, g: 0, b: 255, a: 1) {
		willSet {
			self.textLayer.linkColor = newValue
		}
	}

	/**
	 * The text view's link color.
	 * @property linkDecoration
	 * @since 0.5.0
	 */
	open var linkDecoration: TextDecoration = .underline {
		willSet {
			self.textLayer.linkDecoration = newValue
		}
	}

	/**
	 * The text view's line limit.
	 * @property lines
	 * @since 0.1.0
	 */
	open var lines: Int = 0 {
		willSet {
			self.textLayer.lines = newValue
		}
	}

	/**
	 * The text view's padding top.
	 * @property paddingTop
	 * @since 0.1.0
	 */
	open var paddingTop: CGFloat = 0 {
		willSet {
			self.textLayerInvalidFrame = true
		}
	}

	/**
	 * The text view's padding left.
	 * @property paddingLeft
	 * @since 0.1.0
	 */
	open var paddingLeft: CGFloat = 0 {
		willSet {
			self.textLayerInvalidFrame = true
		}
	}

	/**
	 * The text view's padding right.
	 * @property paddingRight
	 * @since 0.1.0
	 */
	open var paddingRight: CGFloat = 0 {
		willSet {
			self.textLayerInvalidFrame = true
		}
	}

	/**
	 * The text view's padding bottom.
	 * @property paddingBottom
	 * @since 0.1.0
	 */
	open var paddingBottom: CGFloat = 0 {
		willSet {
			self.textLayerInvalidFrame = true
		}
	}

	/**
	 * Indicates whether this view has a valid frame.
	 * @property hasFrame
	 * @since 0.2.0
	 */
	open var hasFrame: Bool = false

	/**
	 * @property contentViewDelegate
	 * @since 0.5.0
	 * @hidden
	 */
	internal weak var contentViewDelegate: ContentTextViewDelegate?

	/**
	 * @property textLayer
	 * @since 0.1.0
	 * @hidden
	 */
	private let textLayer: TextLayer = TextLayer()

	/**
	 * @property textLayerInvalidFrame
	 * @since 0.2.0
	 * @hidden
	 */
	private var textLayerInvalidFrame: Bool = false

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * Required constructor.
	 * @constructor
	 * @since 0.1.0
	 */
	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/**
	 * Required constructor.
	 * @constructor
	 * @since 0.1.0
	 */
	public init(frame: CGRect, delegate: ContentTextViewDelegate?) {

		super.init(frame: frame)

		self.layer.masksToBounds = true
		self.layer.contentsScale = UIScreen.main.scale
		self.layer.rasterizationScale = UIScreen.main.scale

		self.textLayer.frame = frame
		self.textLayer.textColor = .black
		self.textLayer.textKerning = 0
		self.textLayer.textLeading = 0
		self.textLayer.textBaseline = 0
		self.textLayer.listener = self

		self.layer.addSublayer(self.textLayer)

		self.contentViewDelegate = delegate
	}

	/**
	 * @inherited
	 * @method update
	 * @since 0.2.0
	 */
	open func update() {

		if (self.textLayerInvalidFrame) {
			self.textLayerInvalidFrame = false
			self.updateTextLayerFrame()
		}

		self.textLayer.update()
	}

	/**
	 * Updates the text layer frame.
	 * @method updateTextLayerFrame
	 * @since 0.2.0
	 */
	open func updateTextLayerFrame() {

		let paddingT = self.paddingTop
		let paddingL = self.paddingLeft
		let paddingR = self.paddingRight
		let paddingB = self.paddingBottom

		var bounds = self.bounds
		bounds.size.width = bounds.size.width - paddingL - paddingR
		bounds.size.height = bounds.size.height - paddingT - paddingB
		bounds.origin.x = paddingL
		bounds.origin.y = paddingT
		
		self.textLayer.frame = bounds
	}

	/**
	 * Measures natural text view size.
	 * @method measure
	 * @since 0.1.0
	 */
	open func measure(in bounds: CGSize, min: CGSize, max: CGSize) -> CGSize {

		let paddingT = self.paddingTop
		let paddingL = self.paddingLeft
		let paddingR = self.paddingRight
		let paddingB = self.paddingBottom

		var frame = bounds
		if (frame.width > 0) {

			frame.width -= paddingL
			frame.width -= paddingR

			if (frame.width < 0) {
				frame.width = 1
			}
		}

		if (frame.height > 0) {

			frame.height -= paddingT
			frame.height -= paddingB

			if (frame.height < 0) {
				frame.height = 1
			}
		}

		return self.textLayer.measure(in: frame, min: min, max: max)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Touches
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method touchesBegan
	 * @since 0.5.0
	 */
	override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

		super.touchesBegan(touches, with: event)

		// TODO
		// This needs to be improved but it will have to do for now

	}

	/**
	 * @inherited
	 * @method touchesEnded
	 * @since 0.5.0
	 */
	override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

		super.touchesEnded(touches, with: event)

		guard let touch = touches.first else {
			return
		}

		if let character = self.textLayer.find(at: touch.location(in: self)) {
			if let link = character.link {
				self.contentViewDelegate?.didPressLink(textView: self, url: link)
			}
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Animations
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method action
	 * @since 0.1.0
	 */
	override open func action(for layer: CALayer, forKey event: String) -> CAAction? {
		return Transition.action(for: layer, key: event)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Animations Protocol
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method shouldBeginTransitionAnimation
	 * @since 0.2.0
	 */
	open func shouldBeginTransitionAnimation(animation: CABasicAnimation, for property: String, of layer: CALayer) -> Bool {

		if (property == "bounds" ||
			property == "position") {
			return self.hasFrame
		}

		return true
	}

	/**
	 * @inherited
	 * @method willBeginTransitionAnimation
	 * @since 0.2.0
	 */
	open func willBeginTransitionAnimation(animation: CABasicAnimation, for property: String, of layer: CALayer) {

	}

	/**
	 * @inherited
	 * @method didBeginTransition
	 * @since 0.2.0
	 */
	open func didBeginTransition() {

	}

	/**
	 * @inherited
	 * @method didFinishTransition
	 * @since 0.2.0
	 */
	open func didFinishTransition() {

	}
}
