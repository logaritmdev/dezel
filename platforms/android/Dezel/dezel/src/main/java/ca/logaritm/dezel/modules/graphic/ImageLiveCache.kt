package ca.logaritm.dezel.modules.graphic

import android.graphics.Bitmap
import android.util.LruCache

/**
 * @class ImageLiveCache
 * @since 0.1.0
 * @hidden
 */
open class ImageLiveCache(val size: Int) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property cache
	 * @since 0.1.0
	 * @hidden
	 */
	private val cache: LruCache<String, Bitmap> = LruCache(size)

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Stores the bitmap in memory.
	 * @method set
	 * @since 0.1.0
	 */
	public fun set(uri: String, bitmap: Bitmap) {
		if (this.cache.get(uri) == null) {
			this.cache.put(uri, bitmap)
		}
	}

	/**
	 * Retrieves the bitmap from memory.
	 * @method get
	 * @since 0.1.0
	 */
	public fun get(uri: String): Bitmap? {
		return this.cache.get(uri)
	}

	/**
	 * Indicates whether a memory cache exists.
	 * @method has
	 * @since 0.1.0
	 */
	public fun has(uri: String): Boolean {
		return this.cache.get(uri) != null
	}
}