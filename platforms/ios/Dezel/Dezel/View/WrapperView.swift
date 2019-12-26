/**
 * @class WrapperView
 * @super UIView
 * @since 0.1.0
 */
open class WrapperView: UIView, Animatable {

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
	 * @property id
	 * @since 0.2.0
	 */
	open var id: String = ""

	/**
	 * @property bounds
	 * @since 0.1.0
	 */
	override open var bounds: CGRect {
		willSet {
			self.renderLayer.resize(newValue)
			self.bitmapLayer.resize(newValue)
			self.borderLayer.resize(newValue)
			self.shadowLayer.resize(newValue)
			self.invalidateFrame()
			self.invalidateShape()
		}
	}

	/**
	 * @property content
	 * @since 0.1.0
	 */
	open var content: UIView

	/**
	 * @property backgroundColor
	 * @since 0.7.0
	 */
	open override var backgroundColor: UIColor? {

		set {
			self.renderLayer.backgroundColor = newValue?.cgColor
		}

		get {
			return UIColor(color: self.renderLayer.backgroundColor)
		}
	}

	/**
	 * @property backgroundLinearGradient
	 * @since 0.7.0
	 */
	open var backgroundLinearGradient: LinearGradient? {
		willSet {
			self.renderLayer.setGradient(newValue)
		}
	}

	/**
	 * @property backgroundRadialGradient
	 * @since 0.7.0
	 */
	open var backgroundRadialGradient: RadialGradient? {
		willSet {
			self.renderLayer.setGradient(newValue)
		}
	}

	/**
	 * @property backgroundImage
	 * @since 0.1.0
	 */
	open var backgroundImage: UIImage? {
		willSet {
			self.bitmapLayer.image = newValue?.cgImage
		}
	}

	/**
	 * @property backgroundImageFit
	 * @since 0.7.0
	 */
	open var backgroundImageFit: ImageFit = .cover {
		willSet {
			self.bitmapLayer.imageFit = newValue
		}
	}

	/**
	 * @property backgroundImageLeft
	 * @since 0.1.0
	 */
	open var backgroundImagePosition: ImagePosition = .middleCenter {
		willSet {
			self.bitmapLayer.imagePosition = newValue
		}
	}

	/**
	 * @property borderTopColor
	 * @since 0.1.0
	 */
	open var borderTopColor: UIColor = .black {
		willSet {
			self.borderLayer.borderTopColor = newValue.cgColor
		}
	}

	/**
	 * @property borderLeftColor
	 * @since 0.1.0
	 */
	open var borderLeftColor: UIColor = .black {
		willSet {
			self.borderLayer.borderLeftColor = newValue.cgColor
		}
	}

	/**
	 * @property borderRightColor
	 * @since 0.1.0
	 */
	open var borderRightColor: UIColor = .black {
		willSet {
			self.borderLayer.borderRightColor = newValue.cgColor
		}
	}

	/**
	 * @property borderBottomColor
	 * @since 0.1.0
	 */
	open var borderBottomColor: UIColor = .black {
		willSet {
			self.borderLayer.borderBottomColor = newValue.cgColor
		}
	}

	/**
	 * @property borderTopWidth
	 * @since 0.1.0
	 */
	open var borderTopWidth: CGFloat = 0 {
		willSet {
			self.borderLayer.borderTopWidth = newValue
			self.invalidateFrame()
			self.invalidateShape()
		}
	}

	/**
	 * @property borderLeftWidth
	 * @since 0.1.0
	 */
	open var borderLeftWidth: CGFloat = 0 {
		willSet {
			self.borderLayer.borderLeftWidth = newValue
			self.invalidateFrame()
			self.invalidateShape()
		}
	}

	/**
	 * @property borderRightWidth
	 * @since 0.1.0
	 */
	open var borderRightWidth: CGFloat = 0 {
		willSet {
			self.borderLayer.borderRightWidth = newValue
			self.invalidateFrame()
			self.invalidateShape()
		}
	}

	/**
	 * @property borderBottomWidth
	 * @since 0.1.0
	 */
	open var borderBottomWidth: CGFloat = 0 {
		willSet {
			self.borderLayer.borderBottomWidth = newValue
			self.invalidateFrame()
			self.invalidateShape()
		}
	}

	/**
	 * @property borderTopLeftRadius
	 * @since 0.1.0
	 */
	open var borderTopLeftRadius: CGFloat = 0 {
		willSet {
			self.invalidateShape()
		}
	}

	/**
	 * @property borderTopRightRadius
	 * @since 0.1.0
	 */
	open var borderTopRightRadius: CGFloat = 0 {
		willSet {
			self.invalidateShape()
		}
	}

	/**
	 * @property borderBottomLeftRadius
	 * @since 0.1.0
	 */
	open var borderBottomLeftRadius: CGFloat = 0 {
		willSet {
			self.invalidateShape()
		}
	}

	/**
	 * @property borderBottomRightRadius
	 * @since 0.1.0
	 */
	open var borderBottomRightRadius: CGFloat = 0 {
		willSet {
			self.invalidateShape()
		}
	}

	/**
	 * @property shadowBlur
	 * @since 0.1.0
	 */
	open var shadowBlur: CGFloat = 0 {
		willSet {
			self.shadowLayer.shadowBlur = newValue
		}
	}

	/**
	 * @property shadowColor
	 * @since 0.1.0
	 */
	open var shadowColor: UIColor = .clear {
		willSet {
			self.shadowLayer.shadowColor = newValue.cgColor
		}
	}

	/**
	 * @property shadowOffsetTop
	 * @since 0.1.0
	 */
	open var shadowOffsetTop: CGFloat = 0 {
		willSet {
			self.shadowLayer.shadowOffsetTop = newValue
		}
	}

	/**
	 * @property shadowOffsetLeft
	 * @since 0.1.0
	 */
	open var shadowOffsetLeft: CGFloat = 0 {
		willSet {
			self.shadowLayer.shadowOffsetLeft = newValue
		}
	}

	/**
	 * @property drawable
	 * @since 0.4.0
	 */
	open var drawable: Bool = false {
		willSet {

		}
	}

	/**
	 * @property shadowLayer
	 * @since 0.1.0
	 * @hidden
	 */
	internal var shadowLayer: ShadowLayer = ShadowLayer()

	/**
	 * @property renderLayer
	 * @since 0.1.0
	 * @hidden
	 */
	internal var renderLayer: RenderLayer = RenderLayer()

	/**
	 * @property bitmapLayer
	 * @since 0.1.0
	 * @hidden
	 */
	internal var bitmapLayer: BitmapLayer = BitmapLayer()

	/**
	 * @property borderLayer
	 * @since 0.1.0
	 * @hidden
	 */
	internal var borderLayer: BorderLayer = BorderLayer()

	/**
	 * @property shape
	 * @since 0.7.0
	 * @hidden
	 */
	private var shape: ShapeLayer = ShapeLayer()

	/**
	 * @property invalidFrame
	 * @since 0.2.0
	 * @hidden
	 */
	private var invalidFrame: Bool = false

	/**
	 * @property invalidShape
	 * @since 0.2.0
	 * @hidden
	 */
	private var invalidShape: Bool = false

	/**
	 * @property animatesBitmapLayer
	 * @since 0.2.0
	 * @hidden
	 */
	private var animatesBitmapLayer: Bool = false

	/**
	 * @property animatesBorderLayer
	 * @since 0.2.0
	 * @hidden
	 */
	private var animatesBorderLayer: Bool = false

	/**
	 * @property animatesShadowLayer
	 * @since 0.2.0
	 * @hidden
	 */
	private var animatesShadowLayer: Bool = false

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

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
	public required init(content: UIView) {

		self.content = content

		super.init(frame: .zero)

		self.layer.addSublayer(self.shadowLayer)
		self.layer.addSublayer(self.renderLayer)

		self.shape.listener = self

		self.shadowLayer.listener = self
		self.renderLayer.listener = self
		self.bitmapLayer.listener = self
		self.borderLayer.listener = self

		self.borderLayer.borderTopColor = .black
		self.borderLayer.borderLeftColor = .black
		self.borderLayer.borderRightColor = .black
		self.borderLayer.borderBottomColor = .black

		self.addSubview(content)
	}

	/**
	 * @method update
	 * @since 0.1.0
	 */
	open func update() {

		if (self.invalidFrame) {
			self.invalidFrame = false
			self.updateFrame()
		}

		if (self.invalidShape) {
			self.invalidShape = false
			self.updateShape()
		}

		let needsShadowLayer = self.needsShadowLayer()
		let needsBitmapLayer = self.needsBitmapLayer()
		let needsBorderLayer = self.needsBorderLayer()

		self.renderLayer.update()

		if (needsShadowLayer) {
			self.shadowLayer.update()
		}

		if (needsBitmapLayer) {
			self.bitmapLayer.update()
		}

		if (needsBorderLayer) {
			self.borderLayer.update()
		}

		self.toggleShadowLayer(needsShadowLayer)
		self.toggleBitmapLayer(needsBitmapLayer)
		self.toggleBorderLayer(needsBorderLayer)
	}

	/**
	 * @method updateFrame
	 * @since 0.2.0
	 */
	open func updateFrame() {

		let borderWidthT = self.borderTopWidth
		let borderWidthL = self.borderLeftWidth
		let borderWidthR = self.borderRightWidth
		let borderWidthB = self.borderBottomWidth

		let x = borderWidthL
		let y = borderWidthT
		let w = self.bounds.width - borderWidthL - borderWidthR
		let h = self.bounds.height - borderWidthT - borderWidthB

		let center = CGPoint(
			x: x + w / 2,
			y: y + h / 2
		)

		let bounds = CGRect(
			x: 0,
			y: 0,
			width: w,
			height: h
		)

		self.content.center = center
		self.content.bounds = bounds

		if let content = self.content as? Resizable {

			let frame = CGRect(
				x: x,
				y: y,
				width: w,
				height: h
			)

			content.didResize(frame: frame)
		}
	}

	/**
	 * @method updateShape
	 * @since 0.2.0
	 */
	open func updateShape() {

		let borderWidthT = self.borderTopWidth
		let borderWidthL = self.borderLeftWidth
		let borderWidthR = self.borderRightWidth
		let borderWidthB = self.borderBottomWidth

		let shapeW = self.bounds.width
		let shapeH = self.bounds.height

		var outerTL = self.borderTopLeftRadius
		var outerTR = self.borderTopRightRadius
		var outerBL = self.borderBottomLeftRadius
		var outerBR = self.borderBottomRightRadius

		let maxRadius = (min(shapeW, shapeH) / 2.0)

		if (outerTL > maxRadius) { outerTL = maxRadius }
		if (outerTR > maxRadius) { outerTR = maxRadius }
		if (outerBL > maxRadius) { outerBL = maxRadius }
		if (outerBR > maxRadius) { outerBR = maxRadius }

		var innerRadiusTLY = max(outerTL - borderWidthT, 0)
		var innerRadiusTLX = max(outerTL - borderWidthL, 0)
		var innerRadiusTRY = max(outerTR - borderWidthT, 0)
		var innerRadiusTRX = max(outerTR - borderWidthR, 0)
		var innerRadiusBLY = max(outerBL - borderWidthB, 0)
		var innerRadiusBLX = max(outerBL - borderWidthL, 0)
		var innerRadiusBRY = max(outerBR - borderWidthB, 0)
		var innerRadiusBRX = max(outerBR - borderWidthR, 0)

		if (innerRadiusTLY == 0 || innerRadiusTLX == 0) {
			innerRadiusTLY = 0
			innerRadiusTLX = 0
		}

		if (innerRadiusTRY == 0 || innerRadiusTRX == 0) {
			innerRadiusTRY = 0
			innerRadiusTRX = 0
		}

		if (innerRadiusBLY == 0 || innerRadiusBLX == 0) {
			innerRadiusBLY = 0
			innerRadiusBLX = 0
		}

		if (innerRadiusBRY == 0 || innerRadiusBRX == 0) {
			innerRadiusBRY = 0
			innerRadiusBRX = 0
		}

		var innerTLX: CGFloat = 0
		var innerTLY: CGFloat = 0
		var innerTRX: CGFloat = 0
		var innerTRY: CGFloat = 0
		var innerBRX: CGFloat = 0
		var innerBRY: CGFloat = 0
		var innerBLX: CGFloat = 0
		var innerBLY: CGFloat = 0

		if (borderWidthT == 0) {
			innerTRX = innerRadiusTRX
			innerTLX = innerRadiusTLX
		}

		if (borderWidthL == 0) {
			innerTLY = innerRadiusTLY
			innerBLY = innerRadiusBLY
		}

		if (borderWidthR == 0) {
			innerTRY = innerRadiusTRY
			innerBRY = innerRadiusBRY
		}

		if (borderWidthB == 0) {
			innerBRX = innerRadiusBRX
			innerBLX = innerRadiusBLX
		}

		if (borderWidthT > 0 && borderWidthL > 0) {
			if (borderWidthT > borderWidthL) {
				innerTLX = innerRadiusTLY * (borderWidthL / borderWidthT)
				innerTLY = innerRadiusTLY
			} else {
				innerTLX = innerRadiusTLX
				innerTLY = innerRadiusTLX * (borderWidthT / borderWidthL)
			}
		}

		if (borderWidthT > 0 && borderWidthR > 0) {
			if (borderWidthT > borderWidthR) {
				innerTRX = innerRadiusTRY * (borderWidthR / borderWidthT)
				innerTRY = innerRadiusTRY
			} else {
				innerTRX = innerRadiusTRX
				innerTRY = innerRadiusTRX * (borderWidthT / borderWidthR)
			}
		}

		if (borderWidthB > 0 && borderWidthR > 0) {
			if (borderWidthB > borderWidthR) {
				innerBRX = innerRadiusBRY * (borderWidthR / borderWidthB)
				innerBRY = innerRadiusBRY
			} else {
				innerBRX = innerRadiusBRX
				innerBRY = innerRadiusBRX * (borderWidthB / borderWidthR)
			}
		}

		if (borderWidthB > 0 && borderWidthL > 0) {
			if (borderWidthB > borderWidthL) {
				innerBLX = innerRadiusBLY * (borderWidthL / borderWidthB)
				innerBLY = innerRadiusBLY
			} else {
				innerBLX = innerRadiusBLX
				innerBLY = innerRadiusBLX * (borderWidthB / borderWidthL)
			}
		}

		let innerTL = CGPoint(x: innerTLX, y: innerTLY)
		let innerTR = CGPoint(x: innerTRX, y: innerTRY)
		let innerBL = CGPoint(x: innerBLX, y: innerBLY)
		let innerBR = CGPoint(x: innerBRX, y: innerBRY)

		self.shadowLayer.borderTopLeftRadius = outerTL
		self.shadowLayer.borderTopRightRadius = outerTR
		self.shadowLayer.borderBottomLeftRadius = outerBL
		self.shadowLayer.borderBottomRightRadius = outerBR

		self.renderLayer.borderTopLeftRadius = outerTL
		self.renderLayer.borderTopRightRadius = outerTR
		self.renderLayer.borderBottomLeftRadius = outerBL
		self.renderLayer.borderBottomRightRadius = outerBR

		self.borderLayer.borderTopLeftRadius = outerTL
		self.borderLayer.borderTopRightRadius = outerTR
		self.borderLayer.borderBottomLeftRadius = outerBL
		self.borderLayer.borderBottomRightRadius = outerBR

		self.borderLayer.borderTopLeftInnerRadius = innerTL
		self.borderLayer.borderTopRightInnerRadius = innerTR
		self.borderLayer.borderBottomLeftInnerRadius = innerBL
		self.borderLayer.borderBottomRightInnerRadius = innerBR

		if (self.content is Clippable == false) {
			return
		}

		let contentW = self.frame.width - borderWidthL - borderWidthR
		let contentH = self.frame.height - borderWidthT - borderWidthB

		if (innerTL != .zero || innerTR != .zero ||
			innerBL != .zero || innerBR != .zero) {

			let path = CGMutablePath()

			path.addRoundedRect(CGRect(
				x: 0,
				y: 0,
				width: contentW,
				height: contentH
			), [
				innerTR.x, innerTR.y,
				innerBR.x, innerBR.y,
				innerBL.x, innerBL.y,
				innerTL.x, innerTL.y
			])

			self.shape.path = path

			self.content.layer.mask = self.shape
			self.content.layer.shouldRasterize = true
	
		} else {

			self.content.layer.mask = nil
			self.content.layer.shouldRasterize = false

			/*
			 * The shape path must be set after the mask is cleared. Setting
			 * the path during an animation will trigger the
			 * willBeginShapeAnimation method that might set a mask that will
			 * be active for the duration of the animation only.
			 */

			self.shape.path = CGOuterRoundedRectPath(
				contentW,
				contentH,
				0.001,
				0.001,
				0.001,
				0.001
			)
		}
	}

	/**
	 * @method scheduleRedraw
	 * @since 0.4.0
	 */
	open func scheduleRedraw() {

	}

	//--------------------------------------------------------------------------
	// MARK: Transition Listener
	//--------------------------------------------------------------------------

	/**
	 * @method willAnimate
	 * @since 0.7.0
	 */
	open func willAnimate(layer: CALayer, property: String) {

		if (property == "borderTopWidth" ||
			property == "borderTopColor" ||
			property == "borderLeftWidth" ||
			property == "borderLeftColor" ||
			property == "borderRightWidth" ||
			property == "borderRightColor" ||
			property == "borderBottomWidth" ||
			property == "borderBottomColor") {
			self.animatesBorderLayer = true
			return
		}

		if (property == "shadowBlur" ||
			property == "shadowColor" ||
			property == "shadowOffsetTop" ||
			property == "shadowOffsetLeft") {
			self.animatesShadowLayer = true
			return
		}

		if (property == "path") {
			self.content.layer.mask = self.shape
			self.content.layer.shouldRasterize = false
		}
	}

	/**
	 * @method didBeginTransition
	 * @since 0.7.0
	 */
	open func didBeginTransition(layer: CALayer) {

	}

	/**
	 * @method didCommitTransition
	 * @since 0.7.0
	 */
	open func didCommitTransition(layer: CALayer) {

	}

	/**
	 * @method didFinishTransition
	 * @since 0.7.0
	 */
	open func didFinishTransition(layer: CALayer) {

		self.animatesBitmapLayer = false
		self.animatesBorderLayer = false
		self.animatesShadowLayer = false

		self.toggleShadowLayer(self.needsShadowLayer())
		self.toggleBitmapLayer(self.needsBitmapLayer())
		self.toggleBorderLayer(self.needsBorderLayer())

		if (self.borderLayer.borderTopLeftInnerRadius != .zero ||
			self.borderLayer.borderTopRightInnerRadius != .zero ||
			self.borderLayer.borderBottomLeftInnerRadius != .zero ||
			self.borderLayer.borderBottomRightInnerRadius != .zero) {
			self.content.layer.shouldRasterize = true
			return
		}

		/*
		 * Rasterization during animation was turned off for performance
		 * reasons and can be turned on now. Also, a mask was applied even
		 * if the radius was zero (to animate to 0) and it can be removed.
		 */

		self.content.layer.mask = nil
		self.content.layer.shouldRasterize = false
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method invalidateFrame
	 * @since 0.2.0
	 * @hidden
	 */
	private func invalidateFrame() {
		self.invalidFrame = true
	}

	/**
	 * @method invalidateShape
	 * @since 0.2.0
	 * @hidden
	 */
	private func invalidateShape() {
		self.invalidShape = true
	}

	/**
	 * @method hasShadow
	 * @since 0.1.0
	 * @hidden
	 */
	private func hasShadow() -> Bool {
		return self.shadowColor.alpha > 0 && (self.shadowBlur > 0 || self.shadowOffsetTop > 0 || self.shadowOffsetLeft > 0)
	}

	/**
	 * @method hasBorder
	 * @since 0.1.0
	 * @hidden
	 */
	private func hasBorder() -> Bool {

		if (self.borderTopColor.alpha > 0 &&
			self.borderTopWidth > 0) {
			return true
		}

		if (self.borderLeftColor.alpha > 0 &&
			self.borderLeftWidth > 0) {
			return true
		}

		if (self.borderRightColor.alpha > 0 &&
			self.borderRightWidth > 0) {
			return true
		}

		if (self.borderBottomColor.alpha > 0 &&
			self.borderBottomWidth > 0) {
			return true
		}

		return false
	}

	/**
	 * @method hasBackgroundImage
	 * @since 0.1.0
	 * @hidden
	 */
	private func hasBackgroundImage() -> Bool {
		return self.backgroundImage != nil
	}

	/**
	 * @method needsShadowLayer
	 * @since 0.1.0
	 * @hidden
	 */
	private func needsShadowLayer() -> Bool {
		return self.animatesShadowLayer || self.hasShadow()
	}

	/**
	 * @method needsBorderLayer
	 * @since 0.1.0
	 * @hidden
	 */
	private func needsBorderLayer() -> Bool {
		return self.animatesBorderLayer || self.hasBorder()
	}

	/**
	 * @method needsBitmapLayer
	 * @since 0.1.0
	 * @hidden
	 */
	private func needsBitmapLayer() -> Bool {
		return self.animatesBitmapLayer || self.hasBackgroundImage()
	}

	/**
	 * @method needsCanvasLayer
	 * @since 0.1.0
	 * @hidden
	 */
	private func needsCanvasLayer() -> Bool {
		return self.drawable
	}

	/**
	 * @method toggleShadowLayer
	 * @since 0.2.0
	 * @hidden
	 */
	private func toggleShadowLayer(_ toggle: Bool) {
		self.toggleLayer(self.shadowLayer, toggle: toggle, at: 1, in: self.layer)
	}

	/**
	 * @method toggleBitmapLayer
	 * @since 0.2.0
	 * @hidden
	 */
	private func toggleBitmapLayer(_ toggle: Bool) {
		self.toggleLayer(self.bitmapLayer, toggle: toggle, at: 0, in: self.renderLayer)
	}

	/**
	 * @method toggleBorderLayer
	 * @since 0.2.0
	 * @hidden
	 */
	private func toggleBorderLayer(_ toggle: Bool) {
		self.toggleLayer(self.borderLayer, toggle: toggle, at: 1, in: self.renderLayer)
	}

	/**
	 * @method toggleLayer
	 * @since 0.1.0
	 * @hidden
	 */
	private func toggleLayer(_ layer: CALayer, toggle: Bool, at: Int, in parent: CALayer) {

		if (toggle) {

			if (layer.superlayer == nil) {
				parent.insertLayer(layer, at: at)
			}

		} else {

			if (layer.superlayer == parent) {
				parent.removeLayer(layer)
			}
		}
	}
}

