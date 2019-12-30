import Foundation

/**
 * @class TextParser
 * @super NSObject
 * @since 0.5.0
 */
open class TextParser: NSObject, XMLParserDelegate {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property string
	 * @since 0.5.0
	 */
	private(set) public var string: NSMutableAttributedString!

	/**
	 * @property linkTextColor
	 * @since 0.5.0
	 */
	private(set) public var linkTextColor: UIColor

	/**
	 * @property linkTextDecoration
	 * @since 0.5.0
	 */
	private(set) public var linkTextDecoration: TextDecoration

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
	private var text: String = ""

	/**
	 * @property base
	 * @since 0.5.0
	 * @hidden
	 */
	private var base: TextAttributes

	/**
	 * @property stack
	 * @since 0.5.0
	 * @hidden
	 */
	private var stack: [Node] = []

	/**
	 * @property items
	 * @since 0.5.0
	 * @hidden
	 */
	private var nodes: [Node] = []

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.5.0
	 */
	public init(html: String, base: TextAttributes, options: Options) {

		self.html = html
		self.base = base
		self.linkTextColor = options.linkTextColor
		self.linkTextDecoration = options.linkTextDecoration

		super.init()

		guard let data = "<body>\(html)</body>".data(using: .utf8) else {
			self.string = NSMutableAttributedString(string: html, attributes: base)
			return
		}

		let parser = XMLParser(data: data)
		parser.delegate = self
		parser.shouldProcessNamespaces = false
		parser.shouldReportNamespacePrefixes = false
		parser.shouldResolveExternalEntities = false
		parser.parse()

		self.string = NSMutableAttributedString(string: self.text, attributes: base)

		for attribute in self.nodes {
			attribute.apply(string: self.string, parser: self)
		}
	}

	//--------------------------------------------------------------------------
	// MARK: XML Parser Delegate
	//--------------------------------------------------------------------------

	/**
	 * @method parserDidStartElement
	 * @since 0.5.0
	 */
	open func parser(_ parser: XMLParser, didStartElement element: String, namespaceURI: String?, qualifiedName name: String?, attributes: [String : String] = [:]) {

		let element = element.lowercased()
		if (element == "br") {
			self.text.append("\n")
			return
		}

		var node: Node?

		switch (element) {

			case "a": node = A()
			case "b": node = B()
			case "i": node = I()
			case "u": node = U()
			case "em": node = I()
			case "font": node = Font()
			case "strong": node = B()

			default:
				break
		}

		if let node = node {

			node.length = 0
			node.offset = self.text.length
			node.configure(attributes: attributes, parser: self)

			self.stack.append(node)
		}
	}

	/**
	 * @method parserDidEndElement
	 * @since 0.5.0
	 */
    open func parser(_ parser: XMLParser, didEndElement element: String, namespaceURI: String?, qualifiedName name: String?) {

		var valid = false

		let element = element.lowercased()

		switch (element) {

			case "a": valid = true
			case "b": valid = true
			case "i": valid = true
			case "u": valid = true
			case "em": valid = true
			case "sup": valid = true
			case "sub": valid = true
			case "font": valid = true
			case "strong": valid = true

			default:
				break
		}

		if (valid == false) {
			return
		}

		guard let last = self.stack.last else {
			return
		}

		last.length = self.text.length - last.offset

		self.nodes.append(last)
		self.stack.remove(last)
	}

	/**
	 * @method parserFoundCharacters
	 * @since 0.5.0
	 */
    open func parser(_ parser: XMLParser, foundCharacters characters: String) {

		var string = characters

		if (self.text.last == "\n" ||
			self.text.last == "\r\n") {
			if (string.first == " ") {
				string = string.ltrim()
			}
		}

		self.text.append(string)
	}

	/**
	 * @struct Options
	 * @since 0.5.0
	 * @hidden
	 */
	public struct Options {
		public var linkTextColor: UIColor = .blue
		public var linkTextDecoration: TextDecoration = .underline
	}

	//--------------------------------------------------------------------------
	// MARK: Private Classes
	//--------------------------------------------------------------------------

	/**
	 * @class Node
	 * @since 0.5.0
	 * @hidden
	 */
	private class Node: NSObject {

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
		 * @property range
		 * @since 0.5.0
		 * @hidden
		 */
		public var range: NSRange {
			return NSRange(location: self.offset, length: self.length)
		}

		/**
		 * @method font
		 * @since 0.5.0
		 * @hidden
		 */
		public func font(of string: NSAttributedString) -> UIFont? {
			return string.attribute(.font, at: self.offset, effectiveRange: nil) as? UIFont
		}

		/**
		 * @method font
		 * @since 0.5.0
		 * @hidden
		 */
		public func font(of string: NSAttributedString, trait: UIFontDescriptor.SymbolicTraits) -> UIFont {

			if let font = self.font(of: string) {
				if let font = font.with(trait: trait) {
					return font
				}
			}

			return UIFont.defaultSystemFontWith(trait: trait)
		}

		/**
		 * @method configure
		 * @since 0.5.0
		 */
		open func configure(attributes: [String : String], parser: TextParser) {

		}

		/**
		 * @method apply
		 * @since 0.5.0
		 */
		open func apply(string: NSMutableAttributedString, parser: TextParser) {

		}
	}

	/**
	 * @class Font
	 * @since 0.5.0
	 * @hidden
	 */
	private class Font: Node {

		/**
		 * @property face
		 * @since 0.5.0
		 * @hidden
		 */
		private var face: String?

		/**
		 * @property size
		 * @since 0.5.0
		  @hidden
		 */
		private var size: String?

		/**
		 * @property color
		 * @since 0.5.0
		 * @hidden
		 */
		private var color: String?

		/**
		 * @method configure
		 * @since 0.5.0
		 */
		override open func configure(attributes: [String : String], parser: TextParser) {
			self.face = attributes["face"]
			self.size = attributes["size"]
			self.color = attributes["color"]
		}

		/**
		 * @method apply
		 * @since 0.5.0
		 */
		override open func apply(string: NSMutableAttributedString, parser: TextParser) {
			self.applyFont(string: string, parser: parser)
			self.applyColor(string: string, parser: parser)
		}

		/**
		 * @method applyFont
		 * @since 0.5.0
		 */
		private func applyFont(string: NSMutableAttributedString, parser: TextParser) {

			guard
				let face = self.face,
				let size = self.size,
				var font = self.font(of: string) else {
				return
			}

			if let with = font.with(face: face) {
				font = with
			}

			if let with = font.with(size: size.toNumber()) {
				font = with
			}

			string.addFont(font, range: self.range)
		}

		/**
		 * @method applyColor
		 * @since 0.5.0
		 */
		private func applyColor(string: NSMutableAttributedString, parser: TextParser) {

			guard let color = self.color else {
				return
			}

			string.addTextColor(UIColor(color: color), range: self.range)
		}
	}

	/**
	 * @class A
	 * @since 0.5.0
	 * @hidden
	 */
	private class A: Node {

		/**
		 * @property href
		 * @since 0.5.0
		 * @hidden
		 */
		private var href: String?

		/**
		 * @method configure
		 * @since 0.5.0
		 */
		override open func configure(attributes: [String : String], parser: TextParser) {
			self.href = attributes["href"]
		}

		/**
		 * @method apply
		 * @since 0.5.0
		 */
		override open func apply(string: NSMutableAttributedString, parser: TextParser) {

			guard let href = self.href else {
				return
			}

			string.addLink(href, range: self.range)
			string.addTextColor(parser.linkTextColor, range: self.range)
			string.addTextDecoration(parser.linkTextDecoration, range: range)
		}
	}

	/**
	 * @class B
	 * @since 0.5.0
	 * @hidden
	 */
	private class B: Node {

		/**
		 * @method apply
		 * @since 0.5.0
		 */
		override open func apply(string: NSMutableAttributedString, parser: TextParser) {
			string.addAttribute(.font, value: self.font(of: string, trait: .traitBold), range: self.range)
		}
	}

	/**
	 * @class ItalicStyle
	 * @since 0.5.0
	 * @hidden
	 */
	private class I: Node {

		/**
		 * @method apply
		 * @since 0.5.0
		 */
		override open func apply(string: NSMutableAttributedString, parser: TextParser) {
			string.addAttribute(.font, value: self.font(of: string, trait: .traitItalic), range: self.range)
		}
	}

	/**
	 * @class UnderlineStyle
	 * @since 0.5.0
	 * @hidden
	 */
	private class U: Node {

		/**
		 * @method apply
		 * @since 0.5.0
		 */
		override open func apply(string: NSMutableAttributedString, parser: TextParser) {
			string.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: self.range)
		}
	}
}
