/**
 * @class JavaScriptImage
 * @super JavaScriptClass
 * @since 0.7.0
 */
open class JavaScriptImage: JavaScriptClass {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property data
	 * @since 0.7.0
	 */
	open var data: UIImage?

	/**
	 * @property loader
	 * @since 0.7.0
	 * @hidden
	 */
	private var loader: ImageLoader = ImageLoader()

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method load
	 * @since 0.7.0
	 */
	open func load(_ source: String) {

		self.data = nil
		self.loading.reset(true)
		self.complete.reset(false)

		self.protect()

		self.loader.load(source) { image in
			self.set(image)
			self.unprotect()
		}
	}

	/**
	 * @method set
	 * @since 0.7.0
	 */
	open func set(_ image: UIImage?) {

		if let image = image {
			self.data = image
			self.loading.reset(false)
			self.complete.reset(true)
			self.callMethod("nativeOnLoad")
			return
		}

		self.data = nil
		self.loading.reset(false)
		self.complete.reset(false)
		self.callMethod("nativeOnError")
	}

	//--------------------------------------------------------------------------
	// MARK: JS Properties
	//--------------------------------------------------------------------------

	/**
	 * @property source
	 * @since 0.7.0
	 */
	@objc lazy var source = JavaScriptProperty() { value in
		self.load(value.string)
	}

	/**
	 * @property loading
	 * @since 0.7.0
	 */
	@objc lazy var loading = JavaScriptProperty(boolean: false)

	/**
	 * @property complete
	 * @since 0.7.0
	 */
	@objc lazy var complete = JavaScriptProperty(boolean: false)

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_width
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_width(callback: JavaScriptGetterCallback) {
		callback.returns(Double(self.data?.size.width ?? 0))
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_height
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_height(callback: JavaScriptGetterCallback) {
		callback.returns(Double(self.data?.size.height ?? 0))
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_source
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_source(callback: JavaScriptGetterCallback) {
		callback.returns(self.source)
	}

	/**
	 * @method jsSet_source
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsSet_source(callback: JavaScriptSetterCallback) {
		self.source.reset(callback.value, lock: self)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_loading
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_loading(callback: JavaScriptGetterCallback) {
		callback.returns(self.loading)
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_complete
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_complete(callback: JavaScriptGetterCallback) {
		callback.returns(self.complete)
	}
}
