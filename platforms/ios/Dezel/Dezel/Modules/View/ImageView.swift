/**
 * @class ImageView
 * @since 0.1.0
 * @hidden
 */
open class ImageView: View {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The image view's source.
	 * @property source
	 * @since 0.4.0
	 */
	@objc open var source: Property = Property() {

		willSet {

			self.imageLoader.load(newValue) { image in

				self.imageData = image

				if (self.layoutNode.wrapsContentWidth ||
					self.layoutNode.wrapsContentHeight) {
					self.layoutNode.invalidateSize()
				}
			}
		}
	}

	/**
	 * The image view's image container fit.
	 * @property imageFit
	 * @since 0.4.0
	 */
	@objc open var imageFit: Property = Property(string: "contain") {
		willSet {
			self.invalidateImage()
		}
	}

	/**
	 * The image view's image top anchor.
	 * @property imageAnchorTop
	 * @since 0.1.0
	 */
	@objc open var imageAnchorTop: Property = Property(number: 0.5) {
		willSet {
			self.invalidateImage()
		}
	}

	/**
	 * The image view's image left anchor.
	 * @property imageAnchorLeft
	 * @since 0.1.0
	 */
	@objc open var imageAnchorLeft: Property = Property(number: 0.5) {
		willSet {
			self.invalidateImage()
		}
	}

	/**
	 * The image view's image top position.
	 * @property imageTop
	 * @since 0.1.0
	 */
	@objc open var imageTop: Property = Property(number: 50, unit: .pc) {
		willSet {
			self.invalidateImage()
		}
	}

	/**
	 * The image view's image left position.
	 * @property imageLeft
	 * @since 0.1.0
	 */
	@objc open var imageLeft: Property = Property(number: 50, unit: .pc) {
		willSet {
			self.invalidateImage()
		}
	}

	/**
	 * The image view's image width.
	 * @property imageWidth
	 * @since 0.1.0
	 */
	@objc open var imageWidth: Property = Property(string: "auto") {
		willSet {
			self.invalidateImage()
		}
	}

	/**
	 * The image view's image height.
	 * @property imageHeight
	 * @since 0.1.0
	 */
	@objc open var imageHeight: Property = Property(string: "auto") {
		willSet {
			self.invalidateImage()
		}
	}

	/**
	 * The image view's image filter.
	 * @property imageFilter
	 * @since 0.5.0
	 */
	@objc open var imageFilter: Property = Property(string: "none") {
		willSet {
			self.view.imageFilter = self.getImageFilter(newValue.string)
		}
	}

	/**
	 * The image view's image tint color.
	 * @property imageTint
	 * @since 0.1.0
	 */
	@objc open var imageTint: Property = Property(string: "transparent") {
		willSet {
			self.view.imageTint = CGColorParse(newValue.string)
		}
	}

	/**
	 * @property imageData
	 * @since 0.4.0
	 * @hidden
	 */
	private var imageData: UIImage? {
		willSet {
			self.invalidateImage()
		}
	}

	/**
	 * @property imageLoader
	 * @since 0.1.0
	 * @hidden
	 */
	private var imageLoader: ImageLoader = ImageLoader()

	/**
	 * @property invalidImage
	 * @since 0.1.0
	 * @hidden
	 */
	private var invalidImage: Bool = false

	/**
	 * @property view
	 * @since 0.1.0
	 * @hidden
	 */
	private var view: ContentImageView {
		return self.content as! ContentImageView
	}

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method createContentView
	 * @since 0.5.0
	 */
	override open func createContentView() -> ContentImageView {
		return ContentImageView(frame: .zero)
	}

	/**
	 * @inherited
	 * @method update
	 * @since 0.1.0
	 */
	override open func update() {

		super.update()

		if (self.invalidImage) {
			self.invalidImage = false
			self.updateImage()
		}

		if (self.view.hasFrame == false && self.resolvedFrame) {
			self.view.hasFrame = true
		}
	}

	/**
	 * Updates the image.
	 * @method updateImage
	 * @since 0.1.0
	 */
	open func updateImage() {

		self.view.image = nil

		guard let image = self.imageData else {
			return
		}

		var autoW = false
		var autoH = false
		var imageW = 0.0
		var imageH = 0.0
		var imageT = 0.0
		var imageL = 0.0

		if (self.imageWidth.type == .string &&
			self.imageWidth.string == "auto") {

			autoW = true

		} else {

			switch (self.imageWidth.unit) {

				case .pc: imageW = self.imageWidth.number / 100 * self.resolvedInnerWidth
				case .vw: imageW = self.imageWidth.number / 100 * self.layoutNode.viewportWidth
				case .vh: imageW = self.imageWidth.number / 100 * self.layoutNode.viewportHeight
				case .pw: imageW = self.imageWidth.number / 100 * self.resolvedInnerWidth
				case .ph: imageW = self.imageWidth.number / 100 * self.resolvedInnerHeight
				case .cw: imageW = self.imageWidth.number / 100 * self.resolvedContentWidth
				case .ch: imageW = self.imageWidth.number / 100 * self.resolvedContentHeight

				default:
					imageW = self.imageWidth.number
					break
			}
		}

		if (self.imageHeight.type == .string &&
			self.imageHeight.string == "auto") {

			autoH = true

		} else {

			switch (self.imageHeight.unit) {

				case .pc: imageH = self.imageHeight.number / 100 * self.resolvedInnerHeight
				case .vw: imageH = self.imageHeight.number / 100 * self.layoutNode.viewportWidth
				case .vh: imageH = self.imageHeight.number / 100 * self.layoutNode.viewportHeight
				case .pw: imageH = self.imageHeight.number / 100 * self.resolvedInnerWidth
				case .ph: imageH = self.imageHeight.number / 100 * self.resolvedInnerHeight
				case .cw: imageH = self.imageHeight.number / 100 * self.resolvedContentWidth
				case .ch: imageH = self.imageHeight.number / 100 * self.resolvedContentHeight

				default:
					imageH = self.imageHeight.number
					break
			}
		}

		switch (self.imageTop.unit) {

			case .pc: imageT = self.imageTop.number / 100 * self.resolvedInnerHeight
			case .vw: imageT = self.imageTop.number / 100 * self.layoutNode.viewportWidth
			case .vh: imageT = self.imageTop.number / 100 * self.layoutNode.viewportHeight
			case .pw: imageT = self.imageTop.number / 100 * self.resolvedInnerWidth
			case .ph: imageT = self.imageTop.number / 100 * self.resolvedInnerHeight
			case .cw: imageT = self.imageTop.number / 100 * self.resolvedContentWidth
			case .ch: imageT = self.imageTop.number / 100 * self.resolvedContentHeight

			default:
				imageT = self.imageTop.number
				break
		}

		switch (self.imageLeft.unit) {

			case .pc: imageL = self.imageLeft.number / 100 * self.resolvedInnerWidth
			case .vw: imageL = self.imageLeft.number / 100 * self.layoutNode.viewportWidth
			case .vh: imageL = self.imageLeft.number / 100 * self.layoutNode.viewportHeight
			case .pw: imageL = self.imageLeft.number / 100 * self.resolvedInnerWidth
			case .ph: imageL = self.imageLeft.number / 100 * self.resolvedInnerHeight
			case .cw: imageL = self.imageLeft.number / 100 * self.resolvedContentWidth
			case .ch: imageL = self.imageLeft.number / 100 * self.resolvedContentHeight

			default:
				imageL = self.imageLeft.number
				break
		}

		let naturalImageW = Double(image.size.width)
		let naturalImageH = Double(image.size.height)

		let frameW = self.resolvedInnerWidth
		let frameH = self.resolvedInnerHeight
		let scaleX = frameW / naturalImageW
		let scaleY = frameH / naturalImageH

		if (autoW && autoH) {

			switch (self.imageFit.string) {

				case "none":
					imageW = naturalImageW
					imageH = naturalImageH

				case "cover":
					let scale = max(scaleX, scaleY)
					imageW = naturalImageW * scale
					imageH = naturalImageH * scale

				case "contain":
					let scale = min(scaleX, scaleY)
					imageW = naturalImageW * scale
					imageH = naturalImageH * scale

				default: break
			}

		} else if (autoW) {
			imageW = imageH * (naturalImageW / naturalImageH)
		} else if (autoH) {
			imageH = imageW * (naturalImageH / naturalImageW)
		}

		let anchorT = self.getImageAnchorTop(self.imageAnchorTop)
		let anchorL = self.getImageAnchorLeft(self.imageAnchorLeft)

		imageT = imageT - (anchorT * imageH)
		imageL = imageL - (anchorL * imageW)

		self.view.image = image
		self.view.imageTop = CGFloat(imageT)
		self.view.imageLeft = CGFloat(imageL)
		self.view.imageWidth = CGFloat(imageW)
		self.view.imageHeight = CGFloat(imageH)
	}

	//--------------------------------------------------------------------------
	// MARK: Methods - Layout Node Delegate
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method measure
	 * @since 0.5.0
	 */
	override open func measure(in bounds: CGSize, min: CGSize, max: CGSize) -> CGSize {

		if (self.invalidImage) {
			self.invalidImage = false
			self.updateImage()
		}

		return self.view.measure(in: bounds, min: min, max: max)
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method invalidateFrame
	 * @since 0.1.0
	 * @hidden
	 */
	override internal func invalidateFrame() {

		super.invalidateFrame()

		if (self.imageTop.unit == .pc ||
			self.imageLeft.unit == .pc ||
			self.imageWidth.unit == .pc ||
			self.imageHeight.unit == .pc) {
			self.invalidateImage()
		}
	}

	/**
	 * @method invalidateImage
	 * @since 0.1.0
	 * @hidden
	 */
	internal func invalidateImage() {
		if (self.invalidImage == false) {
			self.invalidImage = true
			self.scheduleUpdate()
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Private API - Conversions
	//--------------------------------------------------------------------------

	/**
	 * @method getImageAnchorTop
	 * @since 0.1.0
	 * @hidden
	 */
	private func getImageAnchorTop(_ prop: Property) -> Double {

		if (prop.type == .string) {

			switch (prop.string) {

				case "top":    return 0.0
				case "center": return 0.5
				case "bottom": return 1.0

				default:
					NSLog("Unrecognized value for imageAnchorTop: \(prop.string)")
			}
		}

		return prop.number
	}

	/**
	 * @method getImageAnchorLeft
	 * @since 0.1.0
	 * @hidden
	 */
	private func getImageAnchorLeft(_ prop: Property) -> Double {

		if (prop.type == .string) {

			switch (prop.string) {

				case "left":   return 0.0
				case "center": return 0.5
				case "right":  return 1.0

				default:
					NSLog("Unrecognized value for imageAnchorLeft: \(prop.string)")
			}
		}

		return prop.number
	}

	/**
	 * @method getImageFilter
	 * @since 0.5.0
	 * @hidden
	 */
	private func getImageFilter(_ value: String) -> ImageFilter {

		switch (value) {

			case "none":
				return .none
			case "grayscale":
				return .grayscale

			default:
				NSLog("Unrecognized value for imageFilter: \(value)")
		}

		return .none
	}

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_source
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsGet_source(callback: JavaScriptGetterCallback) {
		callback.returns(self.source)
	}

	/**
	 * @method jsSet_source
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsSet_source(callback: JavaScriptSetterCallback) {
		self.source = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_imageFit
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsGet_imageFit(callback: JavaScriptGetterCallback) {
		callback.returns(self.imageFit)
	}

	/**
	 * @method jsSet_imageFit
	 * @since 0.4.0
	 * @hidden
	 */
	@objc open func jsSet_imageFit(callback: JavaScriptSetterCallback) {
		self.imageFit = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_imageAnchorTop
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_imageAnchorTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.imageAnchorTop)
	}

	/**
	 * @method jsSet_imageAnchorTop
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_imageAnchorTop(callback: JavaScriptSetterCallback) {
		self.imageAnchorTop = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_imageAnchorLeft
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_imageAnchorLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.imageAnchorLeft)
	}

	/**
	 * @method jsSet_imageAnchorLeft
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_imageAnchorLeft(callback: JavaScriptSetterCallback) {
		self.imageAnchorLeft = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_imageTop
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_imageTop(callback: JavaScriptGetterCallback) {
		callback.returns(self.imageTop)
	}

	/**
	 * @method jsSet_imageTop
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_imageTop(callback: JavaScriptSetterCallback) {
		self.imageTop = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_imageLeft
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_imageLeft(callback: JavaScriptGetterCallback) {
		callback.returns(self.imageLeft)
	}

	/**
	 * @method jsSet_imageLeft
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_imageLeft(callback: JavaScriptSetterCallback) {
		self.imageLeft = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_imageWidth
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_imageWidth(callback: JavaScriptGetterCallback) {
		callback.returns(self.imageWidth)
	}

	/**
	 * @method jsSet_imageWidth
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_imageWidth(callback: JavaScriptSetterCallback) {
		self.imageWidth = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_imageHeight
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_imageHeight(callback: JavaScriptGetterCallback) {
		callback.returns(self.imageHeight)
	}

	/**
	 * @method jsSet_imageHeight
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_imageHeight(callback: JavaScriptSetterCallback) {
		self.imageHeight = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_imageFilter
	 * @since 0.5.0
	 * @hidden
	 */
	@objc open func jsGet_imageFilter(callback: JavaScriptGetterCallback) {
		callback.returns(self.imageFilter)
	}

	/**
	 * @method jsSet_imageFilter
	 * @since 0.5.0
	 * @hidden
	 */
	@objc open func jsSet_imageFilter(callback: JavaScriptSetterCallback) {
		self.imageFilter = Property(value: callback.value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_imageTint
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsGet_imageTint(callback: JavaScriptGetterCallback) {
		callback.returns(self.imageTint)
	}

	/**
	 * @method jsSet_imageTint
	 * @since 0.1.0
	 * @hidden
	 */
	@objc open func jsSet_imageTint(callback: JavaScriptSetterCallback) {
		self.imageTint = Property(value: callback.value)
	}
}
