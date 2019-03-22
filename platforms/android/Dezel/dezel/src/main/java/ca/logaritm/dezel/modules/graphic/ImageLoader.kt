package ca.logaritm.dezel.modules.graphic

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.AsyncTask
import android.util.Log
import ca.logaritm.dezel.core.Property
import ca.logaritm.dezel.core.PropertyType
import ca.logaritm.dezel.extension.baseName
import ca.logaritm.dezel.extension.ceil
import ca.logaritm.dezel.extension.fileExt
import ca.logaritm.dezel.extension.fileName
import java.io.IOException
import java.io.InputStream
import java.net.URL

/**
 * @class ImageLoader
 * @since 0.1.0
 * @hidden
 */
open class ImageLoader(val context: Context) {

	//--------------------------------------------------------------------------
	// Static
	//--------------------------------------------------------------------------

	companion object {

		/**
		 * @property assets
		 * @since 0.1.0
		 * @hidden
		 */
		private var assets: MutableMap<String, Array<String>> = mutableMapOf()

		/**
		 * @property liveCache
		 * @since 0.1.0
		 * @hidden
		 */
		private lateinit var liveCache: ImageLiveCache

		/**
		 * @property diskCache
		 * @since 0.1.0
		 * @hidden
		 */
		private lateinit var diskCache: ImageDiskCache

		/**
		 * @method setup
		 * @since 0.1.0
		 * @hidden
		 */
		public fun setup(context: Context) {
			ImageLoader.liveCache = ImageLiveCache(16 * 1024 * 1024)
			ImageLoader.diskCache = ImageDiskCache(32 * 1024 * 1024, context)
		}
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property callback
	 * @since 0.1.0
	 * @hidden
	 */
	private var callback: ((image: Bitmap?) -> Unit)? = null

	/**
	 * @property downloadTask
	 * @since 0.1.0
	 * @hidden
	 */
	private var downloadTask: ImageLoader.DownloadTask? = null

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Convenience method to load an image from a Property object.
	 * @method load
	 * @since 0.1.0
	 */
	open fun load(source: Property, callback: (image: Bitmap?) -> Unit) {

		if (source.type == PropertyType.NULL) {
			callback(null)
			return
		}

		if (source.type == PropertyType.STRING) {
			this.load(source.string, callback)
			return
		}

		if (source.type == PropertyType.OBJECT) {
			val image = source.cast(Image::class.java)
			if (image != null) {
				callback(image.data)
			}
		}
	}

	/**
	 * Loads the image from the specified source.
	 * @method load
	 * @since 0.1.0
	 */
	open fun load(source: String, callback: (image: Bitmap?) -> Unit) {

		this.downloadTask?.cancel(true)
		this.downloadTask = null

		this.callback = callback

		val source = source.trim()
		if (source == "") {
			return
		}

		val image = ImageLoader.liveCache.get(source)
		if (image != null) {
			this.loaded(source, image)
			return
		}

		if (source.startsWith("http://") ||
			source.startsWith("https://")) {
			this.loadHttpImage(source)
			return
		}

		this.loadDiskImage(source)
	}

	/**
	 * Loads the image from disk.
	 * @method loadDiskImage
	 * @since 0.1.0
	 */
	open fun loadDiskImage(source: String) {

		/*
		 * This does not handle relative path starting with ./ very well. This is
		 * a hopefully temporary hack to remove the first ./ from the beginning
		 */

		var path = source
		if (path.startsWith("./")) {
			path = path.substring(2)
		}

		val stream = this.getImageStream(this.context, path)
		if (stream == null) {
			this.failed(path, Exception("Unable to load image stream for $path"))
			return
		}

		val dpi = this.context.resources.displayMetrics.densityDpi

		val options = BitmapFactory.Options()
		options.inDensity = stream.scale * 160
		options.inTargetDensity = dpi
		options.inScreenDensity = dpi

		val bitmap = BitmapFactory.decodeStream(stream, null, options)
		if (bitmap == null) {
			return
		}

		this.loaded(source, bitmap)
	}

	/**
	 * Loads the image from the network.
	 * @method loadHttpImage
	 * @since 0.1.0
	 */
	open fun loadHttpImage(source: String) {

		if (ImageLoader.diskCache.has(source)) {
			ImageLoader.GetCache().execute(GetCacheData(this, source))
			return
		}

		val downloadTask = DownloadTask()
		downloadTask.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, DownloadTaskData(this, source))
		this.downloadTask = downloadTask
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method loaded
	 * @since 0.1.0
	 * @hidden
	 */
	private fun loaded(source: String, image: Bitmap) {
		ImageLoader.SetCache().execute(SetCacheData(this, source, image))
		this.callback?.invoke(image)
	}

	/**
	 * @method failed
	 * @since 0.1.0
	 * @hidden
	 */
	protected fun failed(source: String, error: Exception) {
		Log.d("Dezel", "Image failed: $source")
		this.callback?.invoke(null)
	}

	/**
	 * @method getImageStream
	 * @since 0.1.0
	 * @hidden
	 */
	private fun getImageStream(context: android.content.Context, file: String): ImageLoader.ImageStream? {

		val dir = file.baseName

		var files = assets[dir]
		if (files == null) {
			files = context.assets.list(dir)
			assets[dir] = files
		}

		if (files == null) {
			return null
		}

		val density = context.resources.displayMetrics.density.ceil().toInt()

		var image = this.getImagePath(file, density, files)
		var scale = density

		if (image == null) {
			image = this.getImagePath(file, 4, files)
			scale = 4
		}

		if (image == null) {
			image = this.getImagePath(file, 3, files)
			scale = 3
		}

		if (image == null) {
			image = this.getImagePath(file, 2, files)
			scale = 2
		}

		if (image == null) {
			image = this.getImagePath(file, 1, files)
			scale = 1
		}

		if (image == null) {
			image = file
			scale = 1
		}

		val stream: InputStream

		try {
			stream = context.assets.open(image)
		} catch (exception: IOException) {
			return null
		}

		return ImageLoader.ImageStream(stream, scale)
	}

	/**
	 * @method getImagePath
	 * @since 0.1.0
	 * @hidden
	 */
	private fun getImagePath(file: String, density: Int, files: Array<String>): String? {

		val baseName = file.baseName
		val fileName = file.fileName
		val fileType = file.fileExt

		val image = "$fileName@${density}x$fileType"

		for (item in files) {
			if (image == item) {
				return "$baseName/$image"
			}
		}

		return null
	}


	//-------------------------------------------------------------------------
	// Classes
	//-------------------------------------------------------------------------

	/**
	 * @class ImageStream
	 * @since 0.1.0
	 * @hidden
	 */
	private class ImageStream(val stream: InputStream, val scale: Int) : InputStream() {

		/**
		 * @method read
		 * @since 0.1.0
		 * @hidden
		 */
		@Throws(IOException::class)
		override fun read(): Int {
			return this.stream.read()
		}
	}

	/**
	 * @class DownloadTask
	 * @since 0.1.0
	 * @hidden
	 */
	private class DownloadTask : AsyncTask<DownloadTaskData, Void, Bitmap?>() {

		/**
		 * @property resource
		 * @since 0.1.0
		 * @hidden
		 */
		private lateinit var data: DownloadTaskData

		/**
		 * @property error
		 * @since 0.4.0
		 * @hidden
		 */
		private var error: Exception? = null

		/**
		 * @method doInBackground
		 * @since 0.1.0
		 * @hidden
		 */
		override fun doInBackground(vararg params: DownloadTaskData): Bitmap? {

			this.data = params[0]

			try {
				return BitmapFactory.decodeStream(URL(this.data.source).openStream())
			} catch (e: Exception) {
				this.error = e
			}

			return null
		}

		/**
		 * @method onPostExecute
		 * @since 0.1.0
		 * @hidden
		 */
		override fun onPostExecute(bitmap: Bitmap?) {

			if (this.isCancelled) {
				return
			}

			if (bitmap == null) {

				val error = this.error
				if (error != null) {
					this.data.loader.failed(this.data.source, error)
				}

				return
			}

			SetCache().execute(SetCacheData(this.data.loader, this.data.source, bitmap))

			this.data.loader.loaded(this.data.source, bitmap)
		}
	}

	/**
	 * @class GetCache
	 * @since 0.1.0
	 * @hidden
	 */
	private class GetCache : AsyncTask<GetCacheData, Void, Bitmap?>() {

		/**
		 * @property resource
		 * @since 0.4.0
		 * @hidden
		 */
		private lateinit var data: GetCacheData

		/**
		 * @method doInBackground
		 * @since 0.1.0
		 * @hidden
		 */
		override fun doInBackground(vararg params: GetCacheData): Bitmap? {
			this.data = params[0]
			return ImageLoader.diskCache.get(this.data.source)
		}

		/**
		 * @method onPostExecute
		 * @since 0.1.0
		 * @hidden
		 */
		override fun onPostExecute(bitmap: Bitmap?) {
			if (bitmap != null) this.data.loader.loaded(this.data.source, bitmap)
		}
	}

	/**
	 * @class SetCache
	 * @since 0.1.0
	 * @hidden
	 */
	private class SetCache : AsyncTask<SetCacheData, Void, Unit>() {

		/**
		 * @method doInBackground
		 * @since 0.1.0
		 * @hidden
		 */
		override fun doInBackground(vararg params: SetCacheData) {
			val data = params[0]
			ImageLoader.liveCache.set(data.source, data.image)
			ImageLoader.diskCache.set(data.source, data.image)
		}
	}

	/**
	 * @class SetCacheData
	 * @since 0.4.0
	 * @hidden
	 */
	private data class SetCacheData(val loader: ImageLoader, val source: String, val image: Bitmap)

	/**
	 * @class GetCacheData
	 * @since 0.4.0
	 * @hidden
	 */
	private data class GetCacheData(val loader: ImageLoader, val source: String)

	/**
	 * @class DownloadTaskData
	* @since 0.4.0
	* @hidden
	*/
	private data class DownloadTaskData(val loader: ImageLoader, val source: String)
}