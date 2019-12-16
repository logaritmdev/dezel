public typealias ImageLoaderCallback = (UIImage?) -> Void

/**
 * @class ImageLoader
 * @super NSObject
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
	 * @method load
	 * @since 0.1.0
	 */
	open func load(_ source: JavaScriptProperty, callback: @escaping ImageLoaderCallback) {

		if (source.type == .null) {
			callback(nil)
			return
		}

		if (source.type == .string) {
			self.load(source.string, callback: callback)
			return
		}
	}

	/**
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
			self.didLoad(source, image: image)
			return
		}

		if (source.hasPrefix("http://") ||
			source.hasPrefix("https://")) {
			self.loadRemoteImage(source)
			return
		}

		if (source.hasPrefix("file://")) {
			self.loadLocalImage(source.replacingOccurrences(of: "file://", with: ""))
			return
		}

		self.loadLocalImage("app/\(source)")
	}

	/**
	 * @method loadLocalImage
	 * @since 0.7.0
	 */
	open func loadLocalImage(_ source: String) {

		if let image = UIImage(named: source, in: nil, compatibleWith: nil) {
			self.didLoad(source, image: image)
			return
		}

		self.didFail(source, error: NSError(domain: "InvalidResource", code: 1, userInfo: nil))
	}

	/**
	 * @method loadRemoteImage
	 * @since 0.7.0
	 */
	open func loadRemoteImage(_ source: String) {

		DispatchQueue.global(qos: .background).async {

			if let image = ImageLoader.diskCache.get(source) {

				DispatchQueue.main.async {
					self.didLoad(source, image: image)
				}

				return
			}

			let url = URL(string: source)
			if (url == nil) {

				DispatchQueue.main.async {
					self.didFail(source, error: NSError(domain: "InvalidURL", code: 1, userInfo: nil))
				}

				return
			}

			let data: Data

			do {

				data = try Data(contentsOf: url!)

			} catch {

				DispatchQueue.main.async {
					self.didFail(source, error: NSError(domain: "InvalidRequest", code: 1, userInfo: nil))
				}

				return
			}

			guard let image = UIImage(data: data) else {

				DispatchQueue.main.async {
					self.didFail(source, error: NSError(domain: "InvalidData", code: 1, userInfo: nil))
				}

				return
			}

			DispatchQueue.main.async {
				self.didLoad(source, image: image)
			}
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method didLoad
	 * @since 0.7.0
	 * @hidden
	 */
	private func didLoad(_ source: String, image: UIImage) {

		DispatchQueue.global(qos: .background).async {
			ImageLoader.diskCache.set(source, data: image)
			ImageLoader.liveCache.set(source, data: image)
		}

		self.callback?(image)
	}

	/**
	 * @method didFail
	 * @since 0.7.0
	 * @hidden
	 */
	private func didFail(_ source: String, error: NSError) {
		NSLog("Dezel: Image error: \(source)")
		self.callback?(nil)
	}
}
