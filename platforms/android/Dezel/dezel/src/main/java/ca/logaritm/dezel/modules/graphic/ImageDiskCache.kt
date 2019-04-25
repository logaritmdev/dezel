package ca.logaritm.dezel.modules.graphic

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import ca.logaritm.dezel.extension.md5
import com.jakewharton.disklrucache.DiskLruCache
import java.io.BufferedInputStream
import java.io.BufferedOutputStream
import java.io.File
import java.io.IOException

/**
 * @class ImageDiskCache
 * @since 0.1.0
 * @hidden
 */
open class ImageDiskCache(size: Int, context: Context) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property cache
	 * @since 0.1.0
	 * @hidden
	 */
	private val cache: DiskLruCache = DiskLruCache.open(File(context.cacheDir.path + File.separator + "dezel"), 1, 1, size.toLong())

	//--------------------------------------------------------------------------
	// Method
	//--------------------------------------------------------------------------

	/**
	 * Stores the bitmap on disk.
	 * @method set
	 * @since 0.1.0
	 */
	public fun set(uri: String, data: Bitmap) {

		var editor: DiskLruCache.Editor? = null

		try {

			editor = this.cache.edit(uri.md5())
			if (editor == null) {
				return
			}

			val stream = BufferedOutputStream(editor.newOutputStream(0), 8 * 1024)

			data.compress(Bitmap.CompressFormat.PNG, 100, stream)

			stream.close()
			editor.commit()

			this.cache.flush()

		} catch (exception:IOException) {
			editor?.abort()
		}
	}

	/**
	 * Retrieves the bitmap from disk.
	 * @method get
	 * @since 0.1.0
	 */
	public fun get(uri: String): Bitmap? {

		var bitmap: Bitmap? = null

		try {

			val snapshot = this.cache.get(uri.md5())
			if (snapshot == null) {
				return null
			}

			val stream = snapshot.getInputStream(0)
			if (stream != null) {
				bitmap = BitmapFactory.decodeStream(BufferedInputStream(stream, 8 * 1024))
			}

			snapshot.close()

		} catch (e: IOException) {
			e.printStackTrace()
		} catch (e: OutOfMemoryError) {
			e.printStackTrace()
		}

		return bitmap
	}

	/**
	 * Indicates whether a cache exists.
	 * @method has
	 * @since 0.1.0
	 */
	public fun has(uri: String): Boolean {
		return this.cache.get(uri.md5()) != null
	}
}