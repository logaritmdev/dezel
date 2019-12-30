package ca.logaritm.dezel.view.display

import ca.logaritm.dezel.view.display.Stylesheet

/**
 * @interface StylesheetListener
 * @since 0.7.0
 */
interface StylesheetListener {

	/**
	 * @method onThrowError
	 * @since 0.7.0
	 */
	fun onThrowError(stylesheet: Stylesheet, error: String, col: Int, row: Int, url: String)

}