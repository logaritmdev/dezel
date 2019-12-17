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
	 * @property task
	 * @since 0.7.0
	 * @hidden
	 */
	private var task: ImageLoaderTask?

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method load
	 * @since 0.1.0
	 */
	open func load(_ source: String, callback: @escaping ImageLoaderCallback) {

		self.task?.cancel()
		self.task = nil

		let source = source.trim()
		if (source == "") {
			callback(nil)
			return
		}

		if let image = ImageLoader.liveCache.get(source) {
			callback(image)
			return
		}

		self.task = ImageLoaderTask(source: source, callback: callback)
	}

	//--------------------------------------------------------------------------
	// MARK: Classes
	//--------------------------------------------------------------------------

	/**
	 * @class ImageLoaderTask
	 * @since 0.7.0
	 * @hidden
	 */
	private class ImageLoaderTask {

		/**
		 * @property callback
		 * @since 0.7.0
		 * @hidden
		 */
		private var callback: ImageLoaderCallback

		/**
		 * @property canceled
		 * @since 0.7.0
		 * @hidden
		 */
		private var canceled: Bool = false

		/**
		 * @constructor
		 * @since 0.7.0
		 */
		public init(source: String, callback: @escaping ImageLoaderCallback) {

			self.callback = callback

			if (source.hasPrefix("http://") ||
				source.hasPrefix("https://")) {
				self.load(source)
				return
			}

			if let image = UIImage(path: source) {
				self.didLoad(source, image: image)
				return
			}

			self.didFail(source, error: NSError(domain: "InvalidResource", code: 1, userInfo: nil))
		}

		/**
		 * @method cancel
		 * @since 0.7.0
		 */
		public func cancel() {
			self.canceled = true
		}

		/**
		 * @method load
		 * @since 0.7.0
		 * @hidden
		 */
		private func load(_ source: String) {

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

			if (self.canceled) {
				return
			}

			self.callback(image)
		}

		/**
		 * @method didFail
		 * @since 0.7.0
		 * @hidden
		 */
		private func didFail(_ source: String, error: NSError) {

			if (self.canceled) {
				return
			}

			self.callback(nil)
		}
	}
}
