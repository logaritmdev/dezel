public typealias ImageLoaderCallback = (UIImage?) -> Void

/**
 * Manages images loading.
 * @class ImageLoader
 * @since 0.1.0
 */
open class ImageLoader: NSObject {

	//--------------------------------------------------------------------------
	// MARK: Static
	//--------------------------------------------------------------------------

	/**
	 * @property liveCache
	 * @since 0.1.0
	 * @hidden
	 */
	private static var liveCache: ImageLiveCache = ImageLiveCache()

	/**
	 * @property diskCache
	 * @since 0.1.0
	 * @hidden
	 */
	private static var diskCache: ImageDiskCache = ImageDiskCache()

	/**
	 * The default image loader.
	 * @property main
	 * @since 0.6.0
	 */
	public static var main: ImageLoader = ImageLoader()

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property callback
	 * @since 0.1.0
	 * @hidden
	 */
	private var callback: ImageLoaderCallback?

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * Convenience method to load an image from a Property object.
	 * @method load
	 * @since 0.1.0
	 */
	open func load(_ source: Property, callback: @escaping ImageLoaderCallback) {

		if (source.type == .null) {
			callback(nil)
			return
		}

		if (source.type == .string) {
			self.load(source.string, callback: callback)
			return
		}

		if (source.type == .object) {
			if let image = source.cast(Image.self) {
				callback(image.data)
			}
		}
	}

	/**
	 * Loads the image from the specified source.
	 * @method load
	 * @since 0.1.0
	 */
	open func load(_ source: String, callback: @escaping ImageLoaderCallback) {

		self.callback = callback

		let source = source.trim()
		if (source == "") {
			return
		}

		if let image = ImageLoader.liveCache.get(source) {
			self.loaded(source, image: image)
			return
		}

		if (source.hasPrefix("http://") ||
			source.hasPrefix("https://")) {
			self.loadHttpImage(source)
			return
		}

		if (source.hasPrefix("file://")) {
			self.loadDiskImage(source.replacingOccurrences(of: "file://", with: ""))
			return
		}

		self.loadDiskImage("app/\(source)")
	}

	/**
	 * Loads the image from disk.
	 * @method loadDiskImage
	 * @since 0.1.0
	 */
	open func loadDiskImage(_ source: String) {

		if let image = UIImage(named: source, in: nil, compatibleWith: nil) {
			self.loaded(source, image: image)
			return
		}

		self.failed(source, error: NSError(domain: "InvalidResource", code: 1, userInfo: nil))
	}

	/**
	 * Loads the image from the network.
	 * @method loadHttpImage
	 * @since 0.1.0
	 */
	open func loadHttpImage(_ source: String) {

		DispatchQueue.global(qos: .background).async {

			if let image = ImageLoader.diskCache.get(source) {

				DispatchQueue.main.async {
					self.loaded(source, image: image)
				}

				return
			}

			let url = URL(string: source)
			if (url == nil) {

				DispatchQueue.main.async {
					self.failed(source, error: NSError(domain: "InvalidURL", code: 1, userInfo: nil))
				}

				return
			}

			let data: Data

			do {

				data = try Data(contentsOf: url!)

			} catch {

				DispatchQueue.main.async {
					self.failed(source, error: NSError(domain: "InvalidRequest", code: 1, userInfo: nil))
				}

				return
			}

			guard let image = UIImage(data: data) else {

				DispatchQueue.main.async {
					self.failed(source, error: NSError(domain: "InvalidData", code: 1, userInfo: nil))
				}

				return
			}

			DispatchQueue.main.async {
				self.loaded(source, image: image)
			}
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method loaded
	 * @since 0.1.0
	 * @hidden
	 */
	private func loaded(_ source: String, image: UIImage) {

		DispatchQueue.global(qos: .background).async {
			ImageLoader.diskCache.set(source, data: image)
			ImageLoader.liveCache.set(source, data: image)
		}

		self.callback?(image)
	}

	/**
	 * @method failed
	 * @since 0.1.0
	 * @hidden
	 */
	private func failed(_ source: String, error: NSError) {
		NSLog("Dezel: Image error: \(source)")
		self.callback?(nil)
	}
}
