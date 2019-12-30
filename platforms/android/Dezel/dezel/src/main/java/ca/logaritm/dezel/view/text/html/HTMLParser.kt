package ca.logaritm.dezel.view.text.html

import org.xml.sax.InputSource
import org.xml.sax.XMLReader
import org.xml.sax.helpers.DefaultHandler
import org.xml.sax.helpers.XMLReaderFactory
import java.io.StringReader

/**
 * @class HTMLParser
 * @since 0.5.0
 */
public object HTMLParser {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property reader
	 * @since 0.5.0
	 * @hidden
	 */
	private val reader: XMLReader = XMLReaderFactory.createXMLReader("org.ccil.cowan.tagsoup.Parser")

	/**
	 * @property source
	 * @since 0.5.0
	 * @hidden
	 */
	private var source: InputSource = InputSource()

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * @method parse
	 * @since 0.5.0
	 */
	public fun parse(string: String, handler: DefaultHandler) {
		this.source.characterStream = StringReader(string)
		this.reader.contentHandler = handler
		this.reader.parse(source)
	}
}