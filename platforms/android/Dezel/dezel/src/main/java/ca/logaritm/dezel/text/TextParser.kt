package ca.logaritm.dezel.text

import android.text.SpannableString
import android.text.Spanned
import ca.logaritm.dezel.extension.SpannableString
import ca.logaritm.dezel.extension.append
import ca.logaritm.dezel.extension.last
import ca.logaritm.dezel.font.Font
import ca.logaritm.dezel.text.html.HTMLParser
import ca.logaritm.dezel.text.span.FontSpan
import ca.logaritm.dezel.text.span.LinkSpan
import ca.logaritm.dezel.text.span.TextColorSpan
import ca.logaritm.dezel.text.span.TextDecorationSpan
import ca.logaritm.dezel.view.graphic.Color
import ca.logaritm.dezel.view.type.TextDecoration
import org.xml.sax.Attributes
import org.xml.sax.helpers.DefaultHandler

/**
 * Parses HTML to create an attributed string.
 * @class TextParser
 * @since 0.5.0
 */
open class TextParser(html: String, base: List<Any>, options: Options): DefaultHandler() {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The parsed spanned string.
	 * @property string
	 * @since 0.5.0
	 */
	public var string: SpannableString
		private set

	/**
	 * The link text color.
	 * @property linkTextColor
	 * @since 0.5.0
	 */
	public var linkTextColor: Int = options.linkTextColor
		private set

	/**
	 * The link text decoration.
	 * @property linkTextDecoration
	 * @since 0.5.0
	 */
	public var linkTextDecoration: TextDecoration = options.linkTextDecoration
		private set

	/**
	 * @property html
	 * @since 0.5.0
	 * @hidden
	 */
	private var html: String = ""

	/**
	 * @property text
	 * @since 0.5.0
	 * @hidden
	 */
	private var text: StringBuilder = StringBuilder()

	/**
	 * @property base
	 * @since 0.5.0
	 * @hidden
	 */
	private var base: List<Any>

	/**
	 * @property stack
	 * @since 0.5.0
	 * @hidden
	 */
	private var stack: MutableList<Node> = mutableListOf()

	/**
	 * @property nodes
	 * @since 0.5.0
	 * @hidden
	 */
	private var nodes: MutableList<Node> = mutableListOf()

	//--------------------------------------------------------------------------
	//  Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.5.0
	 */
	init {

		this.html = html
		this.base = base

		HTMLParser.parse(html, this)

		this.string = SpannableString(this.text, base)

		this.nodes.forEach {
			it.apply(this.string, this)
		}
	}

	//--------------------------------------------------------------------------
	// XML Parser Delegate
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method startElement
	 * @since 0.5.0
	 */
	override fun startElement(uri: String, tag: String, fdqn: String, attributes: Attributes) {

		val name = tag.toLowerCase()
		if (name == "br") {
			this.text.append("\n")
			return
		}

		var node: Node? = null

		when (name) {

			"a"      -> node = A()
			"b"      -> node = B()
			"i"      -> node = I()
			"u"      -> node = U()
			"em"     -> node = I()
			"font"   -> node = Font()
			"strong" -> node = B()

			else      -> {}
		}

		if (node != null) {

			node.length = 0
			node.offset = this.text.length
			node.configure(attributes, this)

			this.stack.add(node)
		}
	}

	/**
	 * @inherited
	 * @method endElement
	 * @since 0.5.0
	 */
	override fun endElement(uri: String, tag: String, qName: String?) {

		var valid = false

		val name = tag.toLowerCase()

		when (name) {

			"a"      -> valid = true
			"b"      -> valid = true
			"i"      -> valid = true
			"u"      -> valid = true
			"em"     -> valid = true
			"sup"    -> valid = true
			"sub"    -> valid = true
			"font"   -> valid = true
			"strong" -> valid = true

			else      -> {}
		}

		if (valid == false) {
			return
		}

		val last = this.stack.last
		if (last == null) {
			return
		}

		last.length = this.text.length - last.offset

		this.nodes.append(last)
		this.stack.remove(last)
	}

	/**
	 * @inherited
	 * @method characters
	 * @since 0.5.0
	 */
	override fun characters(ch: CharArray, start: Int, length: Int) {

		var string = String(ch, start, length)

		if (this.text.length > 0 && this.text.last() == '\n') {
			if (string.first() == ' ') {
				string = string.trimStart()
			}
		}

		this.text.append(string)
	}

	/**
	 * The text parser options.
	 * @class Options
	 * @since 0.5.0
	 */
	public data class Options(
		var linkTextColor: Int,
		var linkTextDecoration: TextDecoration
	)

	//--------------------------------------------------------------------------
	// Private Classes
	//--------------------------------------------------------------------------

	/**
	 * @class Node
	 * @since 0.5.0
	 * @hidden
	 */
	open class Node {

		/**
		 * @property offset
		 * @since 0.5.0
		 * @hidden
		 */
		public var offset: Int = 0

		/**
		 * @property length
		 * @since 0.5.0
		 * @hidden
		 */
		public var length: Int = 0

		/**
		 * Configures the node.
		 * @method configure
		 * @since 0.5.0
		 */
		open fun configure(attributes: Attributes, parser: TextParser) {

		}

		/**
		 * Applies the attributes to the string.
		 * @method apply
		 * @since 0.5.0
		 */
		open fun apply(string: SpannableString, parser: TextParser) {
	
		}

		public fun font(string: Spanned): ca.logaritm.dezel.font.Font {

			val spans = string.getSpans(this.offset, this.length - this.offset, FontSpan::class.java)
			if (spans.size > 0) {
				return spans[0].font
			}

			return ca.logaritm.dezel.font.Font.DEFAULT
		}
	}

	/**
	 * @class Font
	 * @since 0.5.0
	 * @hidden
	 */
	private class Font: Node() {

		/**
		 * @property face
		 * @since 0.5.0
		 * @hidden
		 */
		private var face: String? = null

		/**
		 * @property size
		 * @since 0.5.0
		  @hidden
		 */
		private var size: String? = null

		/**
		 * @property color
		 * @since 0.5.0
		 * @hidden
		 */
		private var color: String? = null

		/**
		 * @inherited
		 * @method configure
		 * @since 0.5.0
		 */
		override fun configure(attributes: Attributes, parser: TextParser) {
			this.face = attributes.getValue("face")
			this.size = attributes.getValue("size")
			this.color = attributes.getValue("color")
		}

		/**
		 * @inherited
		 * @method apply
		 * @since 0.5.0
		 */
		override fun apply(string: SpannableString, parser: TextParser) {
			this.applyFont(string, parser)
			this.applyColor(string, parser)
		}

		/**
		 * @inherited
		 * @method applyFont
		 * @since 0.5.0
		 */
		private fun applyFont(string: SpannableString, parser: TextParser) {

			val face = this.face
			val size = this.size

			if (face == null ||
				size == null) {
				return
			}

			string.setSpan(
				FontSpan(Font(face, "normal", "normal", size.toFloat())),
				this.offset,
				this.offset + this.length,
				SpannableString.SPAN_INCLUSIVE_INCLUSIVE
			)
		}

		/**
		 * @inherited
		 * @method applyColor
		 * @since 0.5.0
		 */
		private fun applyColor(string: SpannableString, parser: TextParser) {

			val color = this.color
			if (color == null) {
				return
			}

			string.setSpan(
				TextColorSpan(Color.parse(color)),
				this.offset,
				this.offset + this.length,
				SpannableString.SPAN_INCLUSIVE_INCLUSIVE
			)
		}
	}

	/**
	 * @class A
	 * @since 0.5.0
	 * @hidden
	 */
	private class A: Node() {

		/**
		 * @property href
		 * @since 0.5.0
		 * @hidden
		 */
		private var href: String? = null

		/**
		 * @inherited
		 * @method configure
		 * @since 0.5.0
		 */
		override fun configure(attributes: Attributes, parser: TextParser) {
			this.href = attributes.getValue("href")
		}

		/**
		 * @inherited
		 * @method apply
		 * @since 0.5.0
		 */
		override fun apply(string: SpannableString, parser: TextParser) {

			val href = this.href
			if (href == null) {
				return
			}

			string.setSpan(
				LinkSpan(href, parser.linkTextColor, parser.linkTextDecoration),
				this.offset,
				this.offset + this.length,
				SpannableString.SPAN_INCLUSIVE_INCLUSIVE
			)
		}
	}

	/**
	 * @class B
	 * @since 0.5.0
	 * @hidden
	 */
	open class B: Node() {

		/**
		 * @inherited
		 * @method apply
		 * @since 0.5.0
		 */
		override fun apply(string: SpannableString, parser: TextParser) {
			string.setSpan(FontSpan(this.font(string).withBold()), this.offset, this.length - this.offset, SpannableString.SPAN_INCLUSIVE_INCLUSIVE)
		}
	}

	/**
	 * @class I
	 * @since 0.5.0
	 * @hidden
	 */
	open class I: Node() {

		/**
		 * @inherited
		 * @method apply
		 * @since 0.5.0
		 */
		override fun apply(string: SpannableString, parser: TextParser) {
			string.setSpan(FontSpan(this.font(string).withItalic()), this.offset, this.length - this.offset, SpannableString.SPAN_INCLUSIVE_INCLUSIVE)
		}
	}

	/**
	 * @class U
	 * @since 0.5.0
	 * @hidden
	 */
	private class U: Node() {

		/**
		 * @inherited
		 * @method apply
		 * @since 0.5.0
		 */
		override fun apply(string: SpannableString, parser: TextParser) {
			string.setSpan(TextDecorationSpan(TextDecoration.UNDERLINE), this.offset, this.length - this.offset, SpannableString.SPAN_INCLUSIVE_INCLUSIVE)
		}
	}
}