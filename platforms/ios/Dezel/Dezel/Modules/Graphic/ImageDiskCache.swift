/**
 * @class ImageDiskCache
 * @since 0.1.0
 */
open class ImageDiskCache {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property cache
	 * @since 0.1.0
	 * @hidden
	 */
	private(set) public var cache: LRUDiskCache = LRUDiskCache(name: "dezel_cache")

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method set
	 * @since 0.1.0
	 * @hidden
	 */
	open func set(_ uri: String, data: UIImage) {
		if let d = data.pngData() {
			self.cache.setData(d, forKey: uri)
		}
	}

	/**
	 * @method get
	 * @since 0.1.0
	 * @hidden
	 */
	open func get(_ uri: String) -> UIImage? {

		if let data = self.cache.data(forKey: uri) {
			return UIImage(data: data)
		}

		return nil
	}

	/**
	 * @method has
	 * @since 0.1.0
	 * @hidden
	 */
	open func has(_ uri: String) -> Bool {
		return self.cache.containsData(forKey: uri)
	}
}
