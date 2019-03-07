/**
 * Image in memory cache.
 * @class ImageLiveCache
 * @since 0.1.0
 */
open class ImageLiveCache {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property cache
	 * @since 0.1.0
	 * @hidden
	 */
	private(set) public var cache: NSCache = NSCache<NSString, UIImage>()

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method set
	 * @since 0.1.0
	 * @hidden
	 */
	open func set(_ uri: String, data: UIImage) {
		self.cache.setObject(data, forKey: uri as NSString)
	}

	/**
	 * @method get
	 * @since 0.1.0
	 * @hidden
	 */
	open func get(_ uri: String) -> UIImage? {
		return self.cache.object(forKey: uri as NSString)
	}

	/**
	 * @method has
	 * @since 0.1.0
	 * @hidden
	 */
	open func has(_ uri: String) -> Bool {
		return self.get(uri) != nil
	}
}
