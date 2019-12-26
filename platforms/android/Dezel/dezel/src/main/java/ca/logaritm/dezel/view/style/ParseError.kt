package ca.logaritm.dezel.view.style

import java.lang.Exception

open class StylesheetError(message: String): Exception(message) {
	public override var message: String = ""
	public var col: Int = 0
	public var row: Int = 0
	public var url: String = ""
}