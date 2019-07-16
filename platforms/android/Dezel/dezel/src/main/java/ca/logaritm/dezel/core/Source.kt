package ca.logaritm.dezel.core

import android.content.Context
import ca.logaritm.dezel.networking.RemoteFileLoader
import java.io.IOException

/**
 * A context source file.
 * @class Source
 * @since 0.7.0
 */
open class Source(context: Context, location: String, category: Category) {

	//--------------------------------------------------------------------------
	// Enum
	//--------------------------------------------------------------------------

	/**
	 * Source categories.
	 * @enum Category
	 * @since 0.7.0
	 */
	public enum class Category {
		STYLE,
		SCRIPT
	}

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The source's context.
	 * @property context
	 * @since 0.7.0
	 */
	public var context: Context
		private set

	/**
	 * The source's category.
	 * @property category
	 * @since 0.7.0
	 */
	public var category: Category
		private set

	/**
	 * The source's location.
	 * @property location
	 * @since 0.7.0
	 */
	public var location: String
		private set

	/**
	 * The source's data.
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
		this.location = location
		this.category = category
	}

	/**
	 * @method read
	 * @since 0.7.0
	 * @hidden
	 */
	private fun read(): String {

		try {

			if (this.location.startsWith("http://") ||
				this.location.startsWith("https://")) {
				return RemoteFileLoader().execute(this.location).get()
			}

			return this.context.assets.open(this.location).reader().use {
				it.readText()
			}

		} catch (e: IOException) {
			throw Exception("Cannot load source at location ${this.location}.")
		}
	}
}