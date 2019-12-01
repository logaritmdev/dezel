package ca.logaritm.dezel.application

import android.content.Context
import ca.logaritm.dezel.networking.RemoteFileLoader
import java.io.IOException

/**
 * @class Source
 * @since 0.7.0
 */
open class Source(context: Context, type: Type, path: String) {

	//--------------------------------------------------------------------------
	// Enum
	//--------------------------------------------------------------------------

	/**
	 * @enum Category
	 * @since 0.7.0
	 */
	public enum class Type {
		STYLE,
		SCRIPT
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property context
	 * @since 0.7.0
	 */
	public var context: Context
		private set

	/**
	 * @property type
	 * @since 0.7.0
	 */
	public var type: Type
		private set

	/**
	 * @property path
	 * @since 0.7.0
	 */
	public var path: String
		private set

	/**
	 * @property data
	 * @since 0.7.0
	 */
	public val data: String by lazy {
		this.read()
	}

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 * @hidden
	 */
	init {
		this.context = context
		this.type = type
		this.path = path
	}

	/**
	 * @method read
	 * @since 0.7.0
	 * @hidden
	 */
	private fun read(): String {

		try {

			if (this.path.startsWith("http://") ||
				this.path.startsWith("https://")) {
				return RemoteFileLoader().execute(this.path).get()
			}

			return this.context.assets.open(this.path).reader().use {
				it.readText()
			}

		} catch (e: IOException) {
			throw Exception("Cannot load source at location ${this.path}.")
		}
	}
}