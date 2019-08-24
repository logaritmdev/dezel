package ca.logaritm.dezel.networking

import android.os.AsyncTask
import java.io.IOException
import java.io.InputStream
import java.net.HttpURLConnection
import java.net.SocketTimeoutException
import java.net.URL
import java.nio.charset.Charset
import java.util.*

/**
 * @class HttpRequest
 * @since 0.7.0
 * @hidden
 */
open class HttpRequest(url: URL, method: String) : AsyncTask<URL, HttpRequestProgress, HttpResponse>() {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The request's listener.
	 * @property listener
	 * @since 0.1.0
	 */
	open var listener: HttpRequestListener? = null

	/**
	 * The request's headers.
	 * @property headers
	 * @since 0.1.0
	 */
	open var headers: MutableMap<String, String> = mutableMapOf()

	/**
	 * The request's timeout.
	 * @property timeout
	 * @since 0.1.0
	 */
	open var timeout: Double = 60.0

	/**
	 * The request's username.
	 * @property username
	 * @since 0.1.0
	 */
	open var username: String? = null

	/**
	 * The request's password.
	 * @property password
	 * @since 0.1.0
	 */
	open var password: String? = null

	/**
	 * The request's data.
	 * @property data
	 * @since 0.1.0
	 */
	open var data: ByteArray? = null

	/**
	 * @property url
	 * @since 0.1.0
	 * @hidden
	 */
	private var url: URL

	/**
	 * @property method
	 * @since 0.1.0
	 * @hidden
	 */
	private var method: String

	/**
	 * @property sending
	 * @since 0.1.0
	 * @hidden
	 */
	private var sending: Boolean = false

	/**
	 * @property connection
	 * @since 0.7.0
	 * @hidden
	 */
	private lateinit var connection: HttpURLConnection

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 */
	init {
		this.url = url
		this.method = method
	}

	/**
	 * Sends the request.
	 * @method send
	 * @since 0.1.0
	 */
	open fun send() {
		if (this.sending == false) {
			this.sending = true
			this.execute()
		}
	}

	/**
	 * Aborts the current request.
	 * @method abort
	 * @since 0.1.0
	 */
	open fun abort() {
		this.reset()
	}

	/**
	 * @method doInBackground
	 * @since 0.7.0
	 * @hidden
	 */
	override fun doInBackground(vararg params: URL?): HttpResponse {

		val url = params[0]
		if (url == null) {
			throw Exception("HttpRequest URL missing.")
		}

		val response = HttpResponse(url)

		try {

			this.connection = url.openConnection() as HttpURLConnection

			val locale = Locale.getDefault()
			val l = locale.language
			val r = locale.country

			this.connection.setRequestProperty("Accept-Language", "$l-$r,$l;q=0.5")

			this.headers.entries.forEach {
				this.connection.setRequestProperty(it.key, it.value)
			}

			this.connection.doInput = true
			this.connection.readTimeout = this.timeout.toInt()
			this.connection.connectTimeout = this.timeout.toInt()
			this.connection.requestMethod = this.method

			if (this.method.toUpperCase() != "GET") {
				this.connection.doOutput = true
				this.connection.outputStream.use { output ->
					output.write(this.data)
				}
			}

			this.connection.connect()

			this.connection.headerFields.forEach {

				val k = it.key
				val v = it.value

				if (k != null) {
					response.headers[k] = v[0]
				}
			}

			val stream: InputStream

			if (this.connection.responseCode == 200 ||
				this.connection.responseCode == 201) {
				stream = this.connection.inputStream
			} else {
				stream = this.connection.errorStream
			}

			val bytesList = ByteArray(256)
			var bytesRead = stream.read(bytesList)
			var totalRead = 0

			val string = StringBuilder()

			while (bytesRead > 0) {

				if (this.isCancelled) {
					break
				}

				totalRead += bytesRead

				string.append(
					String(
						bytesList, 0,
						bytesRead,
						Charset.forName("UTF-8")
					)
				)

				this.publishProgress(HttpRequestProgress(totalRead, this.connection.contentLength))

				bytesRead = stream.read(bytesList)
			}

			stream.close()

			response.data = string.toString()
			response.statusCode = this.connection.responseCode
			response.statusText = this.connection.responseMessage

		} catch (e: SocketTimeoutException) {

			response.statusCode = 408
			response.statusText = "Request Timeout"

		} catch (e: IOException)  {

			response.statusCode = 0
			response.statusText = e.message ?: "IO Error"

		} catch (e: Exception) {

			response.statusCode = 0
			response.statusText = e.message ?: "Error"

		} finally {
			this.connection.disconnect()
		}

		return response
	}

	/**
	 * @method onPostExecute
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onPostExecute(response: HttpResponse) {

		if (response.statusCode == 200 ||
			response.statusCode == 201) {
			this.listener?.onComplete(this, response)
			return
		}

		if (response.statusCode == 408) {
			this.listener?.onTimeout(this, response)
			return
		}

		this.listener?.onError(this, response)
	}

	/**
	 * @method onProgressUpdate
	 * @since 0.7.0
	 * @hidden
	 */
	override fun onProgressUpdate(vararg values: HttpRequestProgress) {
		this.listener?.onProgress(this, values[0].loaded, values[0].length)
	}

	//--------------------------------------------------------------------------
	// Private API
	//--------------------------------------------------------------------------

	/**
	 * @method set
	 * @since 0.1.0
	 * @hidden
	 */
	private fun reset() {
		this.cancel(true)
	}

	/**
	 * @method set
	 * @since 0.1.0
	 * @hidden
	 */
	private fun execute() {
		this.executeOnExecutor(THREAD_POOL_EXECUTOR, this.url)
	}
}