package ca.logaritm.dezel.view.display.exception

open class ParseError(message: String, col: Int, row: Int, url: String): Exception(message) {
	public override var message: String = message
	public var col: Int = col
	public var row: Int = row
	public var url: String = url
}