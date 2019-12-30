package ca.logaritm.dezel.view.display

import android.util.Log
import ca.logaritm.dezel.view.display.exception.ParseError
import ca.logaritm.dezel.view.display.external.StylesheetExternal

/**
 * @class Stylesheet
 * @since 0.7.0
 */
open class Stylesheet {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property listener
	 * @since 0.7.0
	 */
	open var listener: StylesheetListener? = null

	/**
	 * @property handle
	 * @since 0.7.0
	 */
	public var handle: Long = 0L
		private set

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	init {
		this.handle = StylesheetExternal.create()
	}

	/**
	 * @method setVariable
	 * @since 0.7.0
	 */
	open fun setVariable(name: String, value: String) {

		try {

			StylesheetExternal.setVariable(this.handle, name, value)

		} catch (e: ParseError) {

			this.listener?.onThrowError(
				stylesheet = this,
				error = e.message,
				col = e.col,
				row = e.row,
				url = e.url
			)

		}
	}

	/**
	 * @method evaluate
	 * @since 0.7.0
	 */
	open fun evaluate(source: String, url: String) {

		try {

			StylesheetExternal.evaluate(this.handle, source, url)

		} catch (e: ParseError) {

			this.listener?.onThrowError(
				stylesheet = this,
				error = e.message,
				col = e.col,
				row = e.row,
				url = e.url
			)

		}
	}
}