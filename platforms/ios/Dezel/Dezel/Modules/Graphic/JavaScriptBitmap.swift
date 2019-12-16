/**
 * @class JavaScriptBitmap
 * @super JavaScriptClass
 * @since 0.7.0
 */
open class JavaScriptBitmap: JavaScriptClass {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property bitmap
	 * @since 0.7.0
	 */
	open var bitmap: UIImage?

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

		self.bitmap = nil

		self.loaded.reset(false)
		self.loading.reset(true)

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
			self.bitmap = image
			self.loaded.reset(true)
			self.loading.reset(false)
			self.callMethod("nativeOnLoad")
			return
		}

		self.bitmap = nil
		self.loaded.reset(false)
		self.loading.reset(false)
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
	 * @property loaded
	 * @since 0.7.0
	 */
	@objc lazy var loaded = JavaScriptProperty(boolean: false)

	/**
	 * @property loading
	 * @since 0.7.0
	 */
	@objc lazy var loading = JavaScriptProperty(boolean: false)

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_width
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_width(callback: JavaScriptGetterCallback) {
		callback.returns(Double(self.bitmap?.size.width ?? 0))
	}

	//--------------------------------------------------------------------------

	/**
	 * @method jsGet_height
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_height(callback: JavaScriptGetterCallback) {
		callback.returns(Double(self.bitmap?.size.height ?? 0))
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
	 * @method jsGet_loaded
	 * @since 0.7.0
	 * @hidden
	 */
	@objc func jsGet_loaded(callback: JavaScriptGetterCallback) {
		callback.returns(self.loaded)
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
}
