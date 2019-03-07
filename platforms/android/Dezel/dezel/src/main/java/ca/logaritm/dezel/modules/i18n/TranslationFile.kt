package ca.logaritm.dezel.modules.i18n

import android.content.Context
import ca.logaritm.dezel.extension.getFile
import java.io.InputStream
import java.util.*

/**
 * Translation file locator and loader.
 * @class TranslationFile
 * @since 0.5.0
 */
open class TranslationFile(context: Context, name: String? = null) {

	//--------------------------------------------------------------------------
	//  Properties
	//--------------------------------------------------------------------------

	/**
	 * Whether the translation file has been loaded.
	 * @property loaded
	 * @since 0.5.0
	 */
	public var loaded: Boolean = false
		private set

	/**
	 * @property context
	 * @since 0.5.0
	 * @hidden
	 */
	private var context: Context = context

	//--------------------------------------------------------------------------
	//  Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.5.0
	 */
	init {
		this.load(name)
	}

	//--------------------------------------------------------------------------
	//  Private API
	//--------------------------------------------------------------------------

	/**
	 * @method load
	 * @since 0.5.0
	 * @hidden
	 */
	private fun load(name: String?) {

		if (name == null) {

			val lan = Locale.getDefault().language
			val cou = Locale.getDefault().country

			if (lan == "" ||
				cou == "") {
				return
			}

			this.getFile("${lan}_${cou}.mo")?.let {
				this.load(it)
				return
			}

			this.getFile(Regex("^${lan}_[a-zA-Z]+\\.mo$"))?.let {
				this.load(it)
				return
			}

			return
		}

		this.getFile(name)?.let {
			this.load(it)
		}
	}

	/**
	 * @method load
	 * @since 0.5.0
	 * @hidden
	 */
	private fun load(file: InputStream) {
		TranslationManagerExternal.load(file.readBytes())
		this.loaded = true
	}

	/**
	 * @method getFile
	 * @since 0.5.0
	 * @hidden
	 */
	private fun getFile(named: String): InputStream? {
		return this.context.assets.getFile("languages", named)
	}

	/**
	 * @method getFile
	 * @since 0.5.0
	 * @hidden
	 */
	private fun getFile(match: Regex): InputStream? {
		return this.context.assets.getFile("languages", match)
	}
}