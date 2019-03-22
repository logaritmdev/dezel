package ca.logaritm.dezel.networking

import android.os.AsyncTask
import android.util.Log
import java.io.IOException
import java.io.InputStream
import java.io.UnsupportedEncodingException
import java.net.HttpURLConnection
import java.net.MalformedURLException
import java.net.SocketTimeoutException
import java.net.URL
import java.nio.charset.Charset
import java.util.*

/**
 * @class HttpRequest
 * @since 0.1.0
 * @hidden
 */
open class HttpRequest(url: String, method: String) {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property listener
	 * @since 0.1.0
	 * @hidden
	 */
	open var listener: HttpRequestListener? = null

	/**
	 * @property headers
	 * @since 0.1.0
	 * @hidden
	 */
	open var headers: MutableMap<String, String> = mutableMapOf()
		set(value) {
			if (field != value) {
				field = value
				this.requestHeaders = headers
			}
		}

	/**
	 * @property timeout
	 * @since 0.1.0
	 * @hidden
	 */
	open var timeout: Double = 60.0
		set(value) {
			if (field != value) {
				field = value
				this.requestTimeout = value.toInt()
			}
		}

	/**
	 * @property username
	 * @since 0.1.0
	 * @hidden
	 */
	open var username: String? = null

	/**
	 * @property password
	 * @since 0.1.0
	 * @hidden
	 */
	open var password: String? = null

	/**
	 * @property url
	 * @since 0.1.0
	 * @hidden
	 */
	public var url: URL? = null
		private set

	/**
	 * @property response
	 * @since 0.1.0
	 * @hidden
	 */
	public var response: String = ""
		private set

	/**
	 * @property responseCode
	 * @since 0.1.0
	 * @hidden
	 */
	public var responseCode: Int = -1
		private set

	/**
	 * @property responseLength
	 * @since 0.1.0
	 * @hidden
	 */
	public var responseLength: Int = -1
		private set

	/**
	 * @property responseLoaded
	 * @since 0.1.0
	 * @hidden
	 */
	public var responseLoaded: Int = -1
		private set

	/**
	 * @property responseHeaders
	 * @since 0.1.0
	 * @hidden
	 */
	public var responseHeaders: MutableMap<String, String> = mutableMapOf()
		private set

	/**
	 * @property requestUrl
	 * @since 0.1.0
	 * @hidden
	 */
	private var requestUrl: String = ""

	/**
	 * @property requestMethod
	 * @since 0.1.0
	 * @hidden
	 */
	private var requestMethod: String = "GET"

	/**
	 * @property requestHeaders
	 * @since 0.1.0
	 * @hidden
	 */
	private var requestHeaders: MutableMap<String, String> = mutableMapOf()

	/**
	 * @property requestTimeout
	 * @since 0.1.0
	 * @hidden
	 */
	private var requestTimeout: Int = 0

	/**
	 * @property task
	 * @since 0.1.0
	 * @hidden
	 */
	private var task: RequestTask? = null

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	init {
		this.requestUrl = url
		this.requestMethod = method
	}

	/**
	 * @method send
	 * @since 0.1.0
	 */
	open fun send(data: String) {

		var task = this.task
		if (task != null) {
			task.cancel(true)
		}

		try {
			this.url = URL(this.requestUrl)
		} catch (e: MalformedURLException) {
			Log.d("DEZEL", "HttpRequest", e)
			return
		}

		task = RequestTask()
		task.data = data.toByteArray(charset("UTF-8"))
		task.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, this.url)
		this.task = task

		this.onSend(data)
	}

	/**
	 * @method abort
	 * @since 0.1.0
	 */
	open fun abort() {
		this.reset()
		this.onAbort()
	}

	/**
	 * @method reset
	 * @since 0.1.0
	 */
	private fun reset() {

		val task = this.task
		if (task != null) {
			task.cancel(true)
		}

		this.response = ""
		this.responseCode = -1
		this.responseLength = 0
		this.responseLoaded = 0
	}

	/**
	 * @method onSend
	 * @since 0.1.0
	 */
	private fun onSend(data: String) {
		Log.d("DEZEL", "onSend")
		this.listener?.onSend(this, data)
	}

	/**
	 * @method onProgress
	 * @since 0.1.0
	 */
	private fun onProgress(value: Int, total: Int) {
		this.listener?.onProgress(this, value, total)
	}

	/**
	 * @method onTimeout
	 * @since 0.1.0
	 */
	private fun onTimeout() {
		Log.d("DEZEL", "onTimeout")
		this.listener?.onTimeout(this)
	}

	/**
	 * @method onFail
	 * @since 0.1.0
	 */
	private fun onFail(code: Int) {
		Log.d("DEZEL", "onFail")
		this.listener?.onFail(this, code)
	}

	/**
	 * @method onAbort
	 * @since 0.1.0
	 */
	private fun onAbort() {
		Log.d("DEZEL", "onAbort")
		this.listener?.onAbort(this)
	}

	/**
	 * @method onComplete
	 * @since 0.1.0
	 */
	private fun onComplete() {
		Log.d("DEZEL", "onComplete")
		this.listener?.onComplete(this)
	}

	//--------------------------------------------------------------------------
	// Classes
	//--------------------------------------------------------------------------

	/**
	 * @class RequestTaskProgress
	 * @since 0.1.0
	 * @hidden
	 */
	private class RequestTaskProgress(var value: Int, var total: Int)

	/**
	 * @class RequestTask
	 * @since 0.1.0
	 * @hidden
	 */
	private inner class RequestTask : AsyncTask<URL, RequestTaskProgress, Int>() {

		val REQUEST_FAIL = 1
		val REQUEST_TIMEOUT = 2
		val REQUEST_COMPLETE = 3

		/**
		 * @property data
		 * @since 0.1.0
		 * @hidden
		 */
		public var data: ByteArray? = null

		/**
		 * @property connection
		 * @since 0.1.0
		 * @hidden
		 */
		private lateinit var connection: HttpURLConnection


		/**
		 * @method doInBackground
		 * @since 0.1.0
		 * @hidden
		 */
		override fun doInBackground(vararg params: URL?): Int {

			try {

				val url = params[0]
				if (url == null) {
					return REQUEST_FAIL
				}
				Log.d("DEZEL", "BEGIN TASK to " + url.toString())
				this.connection = url.openConnection() as HttpURLConnection

				val locale = Locale.getDefault()
				val l = locale.language
				val r = locale.country

				this.connection.setRequestProperty("Accept-Language", "$l-$r,$l;q=0.5")

				for ((key, value) in requestHeaders.entries) {
					this.connection.setRequestProperty(key, value)
				}

				this.connection.doInput = true
				this.connection.requestMethod = requestMethod
				this.connection.connectTimeout = requestTimeout
				this.connection.readTimeout = requestTimeout

				if (requestMethod.toUpperCase() != "GET") {
					this.connection.doOutput = true
					this.connection.outputStream.use { output ->
						output.write(this.data)
					}
				}

				this.connection.connect()

				responseHeaders.clear()

				for ((key, value) in this.connection.headerFields) if (key != null) {
					responseHeaders[key] = value[0]
				}

				responseLength = this.connection.contentLength

				val string = StringBuilder()
				val stream: InputStream

				responseCode = this.connection.responseCode

				if (responseCode != 200 &&
					responseCode != 201) {
					stream = this.connection.errorStream
				} else {
					stream = this.connection.inputStream
				}

				val data = ByteArray(256)
				var totalRead = 0
				var bytesRead = stream.read(data)

				while (bytesRead > 0) {

					if (isCancelled) {
						break
					}

					totalRead += bytesRead

					try {
						string.append(String(data, 0, bytesRead, Charset.forName("UTF-8")))
					} catch (e: UnsupportedEncodingException) {
						Log.e("DEZEL", "Invalid charset", e)
					}

					responseLoaded = totalRead

					this.publishProgress(RequestTaskProgress(
						responseLoaded,
						responseLength
					))

					bytesRead = stream.read(data)
				}

				stream.close()

				response = string.toString()

			} catch (e: SocketTimeoutException) {
				return REQUEST_TIMEOUT
			} catch (e: IOException) {
				return REQUEST_FAIL
			} finally {
				this.connection.disconnect()
			}

			return REQUEST_COMPLETE
		}

		/**
		 * @method onPostExecute
		 * @since 0.1.0
		 * @hidden
		 */
		override fun onPostExecute(code: Int?) {

			if (code == null) {
				return
			}

			if (isCancelled) {
				return
			}

			if (code == REQUEST_FAIL) {
				onFail(code)
				return
			}

			if (code == REQUEST_TIMEOUT) {
				onTimeout()
				return
			}

			if (code == REQUEST_COMPLETE) {
				onComplete()
				return
			}
		}

		/**
		 * @method onProgressUpdate
		 * @since 0.1.0
		 * @hidden
		 */
		override fun onProgressUpdate(vararg values: RequestTaskProgress) {
			onProgress(values[0].value, values[0].total)
		}
	}
}