package ca.logaritm.dezel.modules.graphic

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.AsyncTask
import android.util.Log
import ca.logaritm.dezel.core.JavaScriptProperty
import ca.logaritm.dezel.core.JavaScriptPropertyType
import ca.logaritm.dezel.extension.type.baseName
import ca.logaritm.dezel.extension.type.fileExt
import ca.logaritm.dezel.extension.type.fileName
import java.io.IOException
import java.io.InputStream
import java.net.URL
import kotlin.math.ceil

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
			liveCache = ImageLiveCache(liveCacheMaxBytes())
			diskCache = ImageDiskCache(diskCacheMaxBytes(), context)
		}

		/**
		 * @method liveCacheMaxBytes
		 * @since 0.6.0
		 * @hidden
		 */
		protected fun liveCacheMaxBytes(): Int {
			return Runtime.getRuntime().maxMemory().toInt() / 8
		}

		/**
		 * @method diskCacheMaxBytes
		 * @since 0.1.0
		 * @hidden
		 */
		protected fun diskCacheMaxBytes(): Int {
			return 128 * 1024 * 1024 // 64 MB
		}
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property task
	 * @since 0.7.0
	 * @hidden
	 */
	private var task: ImageLoaderTask? = null

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method load
	 * @since 0.1.0
	 */
	open fun load(source: String, callback: ImageLoaderCallback) {

		this.task?.cancel()
		this.task = null

		val source = source.trim()
		if (source == "") {
			callback(null)
			return
		}

		val image = liveCache.get(source)
		if (image != null) {
			callback(image)
			return
		}

		this.task = ImageLoaderTask(this.context, source, callback)
	}

	//-------------------------------------------------------------------------
	// Classes
	//-------------------------------------------------------------------------

	/**
	 * @class ImageLoaderTask
	 * @since 0.7.0
	 * @hidden
	 */
	private class ImageLoaderTask(context: Context, source: String, callback: ImageLoaderCallback) {

		/**
		 * @property callback
		 * @since 0.7.0
		 * @hidden
		 */
		private var callback: ImageLoaderCallback = callback

		/**
		 * @property canceled
		 * @since 0.7.0
		 * @hidden
		 */
		private var canceled: Boolean = false

		/**
		 * @property downloadTask
		 * @since 0.7.0
		 * @hidden
		 */
		private var downloadTask: DownloadTask? = null

		/**
		 * @constructor
		 * @since 0.7.0
		 */
		init {

			if (source.startsWith("http://") ||
				source.startsWith("https://")) {

				this.load(source)

			} else {

				try {

					ImageReader.read(context, source) { bitmap ->
						this.onLoad(source, bitmap)
					}

				} catch (e: Exception) {
					this.onFail(source, e)
				}
			}
		}

		/**
		 * @method cancel
		 * @since 0.7.0
		 */
		public fun cancel() {
			this.canceled = true
		}

		/**
		 * @method load
		 * @since 0.7.0
		 * @hidden
		 */
		private fun load(source: String) {

			if (diskCache.has(source)) {
				GetCache().execute(GetCacheData(this, source))
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
		 * @method onLoad
		 * @since 0.7.0
		 * @hidden
		 */
		internal fun onLoad(source: String, image: Bitmap) {
			SetCache().execute(SetCacheData(this, source, image))
			this.callback.invoke(image)
		}

		/**
		 * @method onFail
		 * @since 0.7.0
		 * @hidden
		 */
		internal fun onFail(source: String, error: Exception) {
			this.callback.invoke(null)
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
				if (error == null) {
					return
				}

				this.data.task.onFail(this.data.source, error)

				return
			}

			SetCache().execute(SetCacheData(this.data.task, this.data.source, bitmap))

			this.data.task.onLoad(this.data.source, bitmap)
		}
	}

	/**
	 * @class GetCache
	 * @since 0.1.0
	 * @hidden
	 */
	private class GetCache : AsyncTask<GetCacheData, Void, Bitmap?>() {

		/**
		 * @property task
		 * @since 0.7.0
		 * @hidden
		 */
		private lateinit var task: ImageLoaderTask

		/**
		 * @property data
		 * @since 0.7.0
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
			return diskCache.get(this.data.source)
		}

		/**
		 * @method onPostExecute
		 * @since 0.1.0
		 * @hidden
		 */
		override fun onPostExecute(bitmap: Bitmap?) {
			if (bitmap != null) this.data.task.onLoad(this.data.source, bitmap)
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
			liveCache.set(data.source, data.image)
			diskCache.set(data.source, data.image)
		}
	}

	/**
	 * @class DownloadTaskData
	 * @since 0.4.0
	 * @hidden
	 */
	private data class DownloadTaskData(val task: ImageLoaderTask, val source: String)

	/**
	 * @class SetCacheData
	 * @since 0.4.0
	 * @hidden
	 */
	private data class SetCacheData(val task: ImageLoaderTask, val source: String, val image: Bitmap)

	/**
	 * @class GetCacheData
	 * @since 0.4.0
	 * @hidden
	 */
	private data class GetCacheData(val task: ImageLoaderTask, val source: String)
}

/**
 * @typealias ImageLoaderCallback
 * @since 0.7.0
 */
typealias ImageLoaderCallback = (image: Bitmap?) -> Unit