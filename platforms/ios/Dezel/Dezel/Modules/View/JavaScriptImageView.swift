/**
 * @class JavaScriptImageView
 * @super JavaScriptView
 * @since 0.7.0
 */
open class JavaScriptImageView: JavaScriptView {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property loader
	 * @since 0.7.0
	 * @hidden
	 */
	private var loader: ImageLoader = ImageLoader()

	/**
	 * @property view
	 * @since 0.7.0
	 * @hidden
	 */
	private var view: ImageView {
		return self.content as! ImageView
	}

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method createContentView
	 * @since 0.7.0
	 */
	override open func createContentView() -> ImageView {
		return ImageView(frame: .zero)
	}

	/**
	 * @method measure
	 * @since 0.7.0
	 */
	override open func measure(bounds: CGSize, min: CGSize, max: CGSize) -> CGSize {
		return self.view.measure(bounds: bounds, min: min, max: max)
	}

	//--------------------------------------------------------------------------
	// MARK: Display Node Delegate
	//--------------------------------------------------------------------------

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
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method getImageFit
	 * @since 0.7.0
	 * @hidden
	 */
	private func getImageFit(_ value: String) -> ImageFit {

		switch (value) {

			case "cover":
				return .cover
			case "contain":
				return .contain

			default:
				NSLog("Unrecognized value for imageFit: \(value)")
		}

		return .contain
	}

	/**
	 * @method getImagePosition
	 * @since 0.7.0
	 * @hidden
	 */
	private func getImagePosition(_ value: String) -> ImagePosition {

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
				NSLog("Unrecognized value for imagePosition: \(value)")
		}

		return .middleCenter
	}

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @property source
	 * @since 0.7.0
	 */
	@objc open lazy var source = JavaScriptProperty() { value in

		self.view.image = nil

		self.loader.load(value.string) { image in

			self.view.image = image

			if (self.node.isWrappingContentWidth ||
				self.node.isWrappingContentHeight) {
				self.node.invalidateSize()
			}
		}
	}

	/**
	 * @property imageFit
	 * @since 0.7.0
	 */
	@objc open lazy var imageFit = JavaScriptProperty(string: "contain") { value in
		self.view.imageFit = self.getImageFit(value.string)
	}

	/**
	 * @property imagePosition
	 * @since 0.7.0
	 */
	@objc open lazy var imagePosition = JavaScriptProperty(string: "center") { value in
		self.view.imagePosition = self.getImagePosition(value.string)
	}

	/**
	 * @property tint
	 * @since 0.7.0
	 */
	@objc open lazy var tint = JavaScriptProperty(string: "transparent") { value in
		self.view.tint = UIColor(color: value)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_source
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_source(callback: JavaScriptGetterCallback) {
		callback.returns(self.source)
	}

	/**
	 * @method jsSet_source
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_source(callback: JavaScriptSetterCallback) {
		self.source.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_imageFit
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_imageFit(callback: JavaScriptGetterCallback) {
		callback.returns(self.imageFit)
	}

	/**
	 * @method jsSet_imageFit
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_imageFit(callback: JavaScriptSetterCallback) {
		self.imageFit.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_imagePosition
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_imagePosition(callback: JavaScriptGetterCallback) {
		callback.returns(self.imagePosition)
	}

	/**
	 * @method jsSet_imageFit
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_imagePosition(callback: JavaScriptSetterCallback) {
		self.imagePosition.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_tint
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsGet_tint(callback: JavaScriptGetterCallback) {
		callback.returns(self.tint)
	}

	/**
	 * @method jsSet_tint
	 * @since 0.7.0
	 * @hidden
	 */
	@objc open func jsSet_tint(callback: JavaScriptSetterCallback) {
		self.tint.reset(callback.value, lock: self, parse: true)
	}
}
