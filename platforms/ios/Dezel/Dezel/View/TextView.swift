import UIKit

/**
 * @class TextView
 * @super UIView
 * @since 0.7.0
 */
open class TextView: UIView, Updatable, Clippable, TransitionListener {

	//----------------------------------------------------------------------
	// MARK: Properties
	//----------------------------------------------------------------------

	/**
	 * @property bounds
	 * @since 0.7.0
	 */
	override open var bounds: CGRect {
		willSet {
			self.invalidTextLayer = true
		}
	}

	/**
	 * @property fontFamily
	 * @since 0.7.0
	 */
	open var fontFamily: String = "default" {
		willSet {
			self.textLayer.fontFamily = newValue
		}
	}

	/**
	 * @property fontWeight
	 * @since 0.7.0
	 */
	open var fontWeight: String = "normal" {
		willSet {
			self.textLayer.fontWeight = newValue
		}
	}

	/**
	 * @property fontStyle
	 * @since 0.7.0
	 */
	open var fontStyle: String = "normal" {
		willSet {
			self.textLayer.fontStyle = newValue
		}
	}

	/**
	 * @property fontSize
	 * @since 0.7.0
	 */
	open var fontSize: CGFloat = 17 {
		willSet {
			self.textLayer.fontSize = newValue
		}
	}

	/**
	 * @property text
	 * @since 0.7.0
	 */
	open var text: String = "" {
		willSet {
			self.textLayer.text = newValue
		}
	}

	/**
	 * @property textColor
	 * @since 0.7.0
	 */
	open var textColor: UIColor = .black {
		willSet {
			self.textLayer.textColor = newValue.cgColor
		}
	}

	/**
	 * @property textAlign
	 * @since 0.7.0
	 */
	open var textAlign: TextAlign = .middleLeft {
		willSet {
			self.textLayer.textAlign = newValue
		}
	}

	/**
	 * @property textBaseline
	 * @since 0.7.0
	 */
	open var textBaseline: CGFloat = 0 {
		willSet {
			self.textLayer.textBaseline = newValue
		}
	}

	/**
	 * @property textKerning
	 * @since 0.7.0
	 */
	open var textKerning: CGFloat = 0 {
		willSet {
			self.textLayer.textKerning = newValue
		}
	}

	/**
	 * @property textLeading
	 * @since 0.7.0
	 */
	open var textLeading: CGFloat = 0 {
		willSet {
			self.textLayer.textLeading = newValue
		}
	}

	/**
	 * @property textShadowBlur
	 * @since 0.7.0
	 */
	open var textShadowBlur: CGFloat = 0 {
		willSet {
			self.textLayer.shadowRadius = newValue / CGFloat(Double.pi)
		}
	}

	/**
	 * @property textShadowColor
	 * @since 0.7.0
	 */
	open var textShadowColor: UIColor = .black {
		willSet {
			self.textLayer.shadowColor = newValue.cgColor
		}
	}

	/**
	 * @property textShadowOffsetTop
	 * @since 0.7.0
	 */
	open var textShadowOffsetTop: CGFloat = 0 {
		willSet {
			self.textLayer.shadowOffset = self.textLayer.shadowOffset.setTop(newValue)
		}
	}

	/**
	 * @property textShadowOffsetLeft
	 * @since 0.7.0
	 */
	open var textShadowOffsetLeft: CGFloat = 0 {
		willSet {
			self.textLayer.shadowOffset = self.textLayer.shadowOffset.setLeft(newValue)
		}
	}

	/**
	 * @property textDecoration
	 * @since 0.7.0
	 */
	open var textDecoration: TextDecoration = .none {
		willSet {
			self.textLayer.textDecoration = newValue
		}
	}

	/**
	 * @property textTransform
	 * @since 0.7.0
	 */
	open var textTransform: TextTransform = .none {
		willSet {
			self.textLayer.textTransform = newValue
		}
	}

	/**
	 * @property textOverflow
	 * @since 0.7.0
	 */
	open var textOverflow: TextOverflow = .ellipsis {
		willSet {
			self.textLayer.textOverflow = newValue
		}
	}

	/**
	 * @property linkColor
	 * @since 0.7.0
	 */
	open var linkColor: UIColor = .blue {
		willSet {
			self.textLayer.linkColor = newValue
		}
	}

	/**
	 * @property linkDecoration
	 * @since 0.7.0
	 */
	open var linkDecoration: TextDecoration = .underline {
		willSet {
			self.textLayer.linkDecoration = newValue
		}
	}

	/**
	 * @property minLines
	 * @since 0.7.0
	 */
	open var minLines: Int = 0 {
		willSet {
			self.textLayer.minLines = newValue
		}
	}

	/**
	 * @property maxLines
	 * @since 0.7.0
	 */
	open var maxLines: Int = 0 {
		willSet {
			self.textLayer.maxLines = newValue
		}
	}

	/**
	 * @property paddingTop
	 * @since 0.7.0
	 */
	open var paddingTop: CGFloat = 0 {
		willSet {
			self.invalidTextLayer = true
		}
	}

	/**
	 * @property paddingLeft
	 * @since 0.7.0
	 */
	open var paddingLeft: CGFloat = 0 {
		willSet {
			self.invalidTextLayer = true
		}
	}

	/**
	 * @property paddingRight
	 * @since 0.7.0
	 */
	open var paddingRight: CGFloat = 0 {
		willSet {
			self.invalidTextLayer = true
		}
	}

	/**
	 * @property paddingBottom
	 * @since 0.7.0
	 */
	open var paddingBottom: CGFloat = 0 {
		willSet {
			self.invalidTextLayer = true
		}
	}

	/**
	 * @property hasFrame
	 * @since 0.7.0
	 */
	internal var hasFrame: Bool = false

	/**
	 * @property delegate
	 * @since 0.7.0
	 * @hidden
	 */
	private weak var observer: TextViewObserver?

	/**
	 * @property textLayer
	 * @since 0.7.0
	 * @hidden
	 */
	private let textLayer: TextLayer = TextLayer()

	/**
	 * @property invalidTextLayer
	 * @since 0.7.0
	 * @hidden
	 */
	private var invalidTextLayer: Bool = false

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
	public init(frame: CGRect, observer: TextViewObserver?) {

		super.init(frame: frame)

		self.layer.masksToBounds = true

		self.textLayer.frame = frame
		self.textLayer.textColor = .black
		self.textLayer.textKerning = 0
		self.textLayer.textLeading = 0
		self.textLayer.textBaseline = 0
		self.textLayer.listener = self

		self.layer.addSublayer(self.textLayer)

		self.observer = observer
	}

	/**
	 * @method measure
	 * @since 0.7.0
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

	/**
	 * @method update
	 * @since 0.7.0
	 */
	open func update() {

		if (self.invalidTextLayer) {
			self.invalidTextLayer = false
			self.updateTextLayer()
		}

		self.textLayer.update()
	}

	/**
	 * @method updateTextLayer
	 * @since 0.7.0
	 */
	open func updateTextLayer() {

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

	//--------------------------------------------------------------------------
	// MARK: Methods - Touches
	//--------------------------------------------------------------------------

	/**
	 * @method touchesBegan
	 * @since 0.7.0
	 */
	override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

		super.touchesBegan(touches, with: event)

		// TODO
		// This needs to be improved but it will have to do for now

	}

	/**
	 * @method touchesEnded
	 * @since 0.7.0
	 */
	override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

		super.touchesEnded(touches, with: event)

		guard let touch = touches.first else {
			return
		}

		if let character = self.textLayer.find(at: touch.location(in: self)) {
			if let link = character.link {
				self.observer?.didPressLink(textView: self, url: link)
			}
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Animations
	//--------------------------------------------------------------------------

	/**
	 * @method action
	 * @since 0.7.0
	 */
	override open func action(for layer: CALayer, forKey event: String) -> CAAction? {
		return Transition.action(for: layer, key: event)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Animations Protocol
	//--------------------------------------------------------------------------

	/**
	 * @method shouldBeginTransitionAnimation
	 * @since 0.7.0
	 */
	open func shouldBeginTransitionAnimation(animation: CABasicAnimation, for property: String, of layer: CALayer) -> Bool {

		if (property == "bounds" ||
			property == "position") {
			return self.hasFrame
		}

		return true
	}

	/**
	 * @method willBeginTransitionAnimation
	 * @since 0.7.0
	 */
	open func willBeginTransitionAnimation(animation: CABasicAnimation, for property: String, of layer: CALayer) {

	}

	/**
	 * @method didCommitTransition
	 * @since 0.7.0
	 */
	open func didCommitTransition() {

	}

	/**
	 * @method didFinishTransition
	 * @since 0.7.0
	 */
	open func didFinishTransition() {

	}
}
