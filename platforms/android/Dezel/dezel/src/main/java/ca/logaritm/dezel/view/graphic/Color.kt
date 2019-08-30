package ca.logaritm.dezel.view.graphic

import ca.logaritm.dezel.string.Scanner
import java.util.*
import android.graphics.Color as AndroidColor

/**
 * @object Color
 * @since 0.1.0
 * @hidden
 */
public object Color {

	//--------------------------------------------------------------------------
	// Static Properties
	//--------------------------------------------------------------------------

	/**
	 * @const TRANSPARENT
	 * @since 0.1.0
	 * @hidden
	 */
	public val TRANSPARENT = AndroidColor.TRANSPARENT

	/**
	 * @const BLACK
	 * @since 0.1.0
	 * @hidden
	 */
	public val BLACK = AndroidColor.argb(255, 0, 0, 0)

	/**
	 * @const WHITE
	 * @since 0.1.0
	 * @hidden
	 */
	public val WHITE = AndroidColor.argb(255, 255, 255, 255)

	/**'
	 * @const GRAY
	 * @since 0.3.0
	 * @hidden
	 */
	public val GRAY = AndroidColor.argb(255, 68, 68, 68)

	/**
	 * Color names.
	 * @property colors
	 * @since 0.1.0
	 */
	private val colors: HashMap<String, String> = object : HashMap<String, String>() {
		init {
			put("aliceblue", "#f0f8ff")
			put("antiquewhite", "#faebd7")
			put("aqua", "#00ffff")
			put("aquamarine", "#7fffd4")
			put("azure", "#f0ffff")
			put("beige", "#f5f5dc")
			put("bisque", "#ffe4c4")
			put("black", "#000000")
			put("blanchedalmond", "#ffebcd")
			put("blue", "#0000ff")
			put("blueviolet", "#8a2be2")
			put("brown", "#a52a2a")
			put("burlywood", "#deb887")
			put("cadetblue", "#5f9ea0")
			put("chartreuse", "#7fff00")
			put("chocolate", "#d2691e")
			put("coral", "#ff7f50")
			put("cornflowerblue", "#6495ed")
			put("cornsilk", "#fff8dc")
			put("crimson", "#dc143c")
			put("cyan", "#00ffff")
			put("darkblue", "#00008b")
			put("darkcyan", "#008b8b")
			put("darkgoldenrod", "#b8860b")
			put("darkgray", "#a9a9a9")
			put("darkgreen", "#006400")
			put("darkgrey", "#a9a9a9")
			put("darkkhaki", "#bdb76b")
			put("darkmagenta", "#8b008b")
			put("darkolivegreen", "#556b2f")
			put("darkorange", "#ff8c00")
			put("darkorchid", "#9932cc")
			put("darkred", "#8b0000")
			put("darksalmon", "#e9967a")
			put("darkseagreen", "#8fbc8f")
			put("darkslateblue", "#483d8b")
			put("darkslategray", "#2f4f4f")
			put("darkslategrey", "#2f4f4f")
			put("darkturquoise", "#00ced1")
			put("darkviolet", "#9400d3")
			put("deeppink", "#ff1493")
			put("deepskyblue", "#00bfff")
			put("dimgray", "#696969")
			put("dimgrey", "#696969")
			put("dodgerblue", "#1e90ff")
			put("firebrick", "#b22222")
			put("floralwhite", "#fffaf0")
			put("forestgreen", "#228b22")
			put("fuchsia", "#ff00ff")
			put("gainsboro", "#dcdcdc")
			put("ghostwhite", "#f8f8ff")
			put("gold", "#ffd700")
			put("goldenrod", "#daa520")
			put("gray", "#808080")
			put("green", "#008000")
			put("greenyellow", "#adff2f")
			put("grey", "#808080")
			put("honeydew", "#f0fff0")
			put("hotpink", "#ff69b4")
			put("indianred", "#cd5c5c")
			put("indigo", "#4b0082")
			put("ivory", "#fffff0")
			put("khaki", "#f0e68c")
			put("lavender", "#e6e6fa")
			put("lavenderblush", "#fff0f5")
			put("lawngreen", "#7cfc00")
			put("lemonchiffon", "#fffacd")
			put("lightblue", "#add8e6")
			put("lightcoral", "#f08080")
			put("lightcyan", "#e0ffff")
			put("lightgoldenrodyellow", "#fafad2")
			put("lightgray", "#d3d3d3")
			put("lightgreen", "#90ee90")
			put("lightgrey", "#d3d3d3")
			put("lightpink", "#ffb6c1")
			put("lightsalmon", "#ffa07a")
			put("lightseagreen", "#20b2aa")
			put("lightskyblue", "#87cefa")
			put("lightslategray", "#778899")
			put("lightslategrey", "#778899")
			put("lightsteelblue", "#b0c4de")
			put("lightyellow", "#ffffe0")
			put("lime", "#00ff00")
			put("limegreen", "#32cd32")
			put("linen", "#faf0e6")
			put("magenta", "#ff00ff")
			put("maroon", "#800000")
			put("mediumaquamarine", "#66cdaa")
			put("mediumblue", "#0000cd")
			put("mediumorchid", "#ba55d3")
			put("mediumpurple", "#9370db")
			put("mediumseagreen", "#3cb371")
			put("mediumslateblue", "#7b68ee")
			put("mediumspringgreen", "#00fa9a")
			put("mediumturquoise", "#48d1cc")
			put("mediumvioletred", "#c71585")
			put("midnightblue", "#191970")
			put("mintcream", "#f5fffa")
			put("mistyrose", "#ffe4e1")
			put("moccasin", "#ffe4b5")
			put("navajowhite", "#ffdead")
			put("navy", "#000080")
			put("oldlace", "#fdf5e6")
			put("olive", "#808000")
			put("olivedrab", "#6b8e23")
			put("orange", "#ffa500")
			put("orangered", "#ff4500")
			put("orchid", "#da70d6")
			put("palegoldenrod", "#eee8aa")
			put("palegreen", "#98fb98")
			put("paleturquoise", "#afeeee")
			put("palevioletred", "#db7093")
			put("papayawhip", "#ffefd5")
			put("peachpuff", "#ffdab9")
			put("peru", "#cd853f")
			put("pink", "#ffc0cb")
			put("plum", "#dda0dd")
			put("powderblue", "#b0e0e6")
			put("purple", "#800080")
			put("red", "#ff0000")
			put("rosybrown", "#bc8f8f")
			put("royalblue", "#4169e1")
			put("saddlebrown", "#8b4513")
			put("salmon", "#fa8072")
			put("sandybrown", "#f4a460")
			put("seagreen", "#2e8b57")
			put("seashell", "#fff5ee")
			put("sienna", "#a0522d")
			put("silver", "#c0c0c0")
			put("skyblue", "#87ceeb")
			put("slateblue", "#6a5acd")
			put("slategray", "#708090")
			put("slategrey", "#708090")
			put("snow", "#fffafa")
			put("springgreen", "#00ff7f")
			put("steelblue", "#4682b4")
			put("tan", "#d2b48c")
			put("teal", "#008080")
			put("thistle", "#d8bfd8")
			put("tomato", "#ff6347")
			put("turquoise", "#40e0d0")
			put("violet", "#ee82ee")
			put("wheat", "#f5deb3")
			put("white", "#ffffff")
			put("whitesmoke", "#f5f5f5")
			put("yellow", "#ffff00")
			put("yellowgreen", "#9acd32")
		}
	}

	//--------------------------------------------------------------------------
	// Static Methods
	//--------------------------------------------------------------------------

	/**
	 * Creates a color from a toString.
	 * @method parse
	 * @since 0.1.0
	 */
	public fun parse(from: String): Int {

		var color = from

		color = color.toLowerCase().trim { it <= ' ' }

		if (color == "transparent" ||
			color == "none") {
			return TRANSPARENT
		}

		if (color == "random") {
			val random = Random()
			color = colors.values.elementAt(random.nextInt(colors.values.size))
		}

		if (color.startsWith("rgba")) {
			return this.createWithRGBA(color)
		}

		if (color.startsWith("rgb")) {
			return this.createWithRGB(color)
		}

		if (color.startsWith("#")) {
			return this.createWithHex(color)
		}

		val hex = colors[color]
		if (hex != null) {
			return this.createWithHex(hex)
		}

		return AndroidColor.BLACK
	}

	/**
	 * Creates a color from a RGB toString.
	 * @method createWithRGB
	 * @since 0.1.0
	 */
	public fun createWithRGB(color: String): Int {

		val sp = color.indexOf('(')
		val ep = color.indexOf(')')

		if (sp > -1 && ep > -1) {

			val chunks = color.substring(sp + 1, ep).split(",")

			if (chunks.size == 3) {

				val r = chunks[0].trim { it <= ' ' }.toInt()
				val g = chunks[1].trim { it <= ' ' }.toInt()
				val b = chunks[2].trim { it <= ' ' }.toInt()

				return AndroidColor.rgb(r, g, b)
			}
		}

		return AndroidColor.BLACK
	}

	/**
	 * Creates a color from a RGBA toString.
	 * @method createWithRGBA
	 * @since 0.1.0
	 */
	public fun createWithRGBA(color: String): Int {

		val sp = color.indexOf('(')
		val ep = color.indexOf(')')

		if (sp > -1 && ep > -1) {

			val chunks = color.substring(sp + 1, ep).split(",")

			if (chunks.size == 4) {

				val r = chunks[0].trim { it <= ' ' }.toInt()
				val g = chunks[1].trim { it <= ' ' }.toInt()
				val b = chunks[2].trim { it <= ' ' }.toInt()
				val a = chunks[3].trim { it <= ' ' }.toFloat()

				return AndroidColor.argb((a * 255).toInt(), r, g, b)
			}
		}

		return AndroidColor.BLACK
	}

	/**
	 * Creates a color from an hex toString.
	 * @method createWithHex
	 * @since 0.1.0
	 */
	public fun createWithHex(color: String): Int {

		var col = color.substring(1)

		if (col.length == 3) {
			col = col + col
		}

		val rr = col.substring(0, 2)
		val gg = col.substring(2, 4)
		val bb = col.substring(4, 6)

		val r = Integer.parseInt(rr, 16)
		val g = Integer.parseInt(gg, 16)
		val b = Integer.parseInt(bb, 16)

		return AndroidColor.rgb(r, g, b)
	}

	/**
	 * Returns the alpha component of a color.
	 * @method alpha
	 * @since 0.1.0
	 */
	public fun alpha(color: Int): Int {
		return AndroidColor.alpha(color)
	}

	//--------------------------------------------------------------------------
	// Static Methods
	//--------------------------------------------------------------------------

	/**
	 * @function scanName
	 * @since 0.4.0
	 * @hidden
	 */
	internal fun scanName(scanner: Scanner): Int {

		val color = scanner.scan(Scanner.ALPHANUM)
		if (color == null) {
			return Color.BLACK
		}

		return Color.parse(color)
	}

	/**
	 * @function scanHexString
	 * @since 0.4.0
	 * @hidden
	 */
	internal fun scanHexString(scanner: Scanner): Int {

		scanner.scan("#")

		val hex = scanner.scanInt(16)
		if (hex == null) {
			return Color.BLACK
		}

		val r = hex shr 16 and 0x000000FF
		val g = hex shr 8  and 0x000000FF
		val b = hex        and 0x000000FF

		return AndroidColor.rgb(r, g, b)
	}

	/**
	 * @function scanRGBString
	 * @since 0.4.0
	 * @hidden
	 */
	internal fun scanRGBString(scanner: Scanner): Int {

		var r: Int?
		var g: Int?
		var b: Int?

		scanner.scan("rgb(")
		r = scanner.scanInt()
		scanner.scan(",")
		g = scanner.scanInt()
		scanner.scan(",")
		b = scanner.scanInt()
		scanner.scan(")")

		if (r == null ||
			g == null ||
			b == null) {
			return Color.BLACK
		}

		return AndroidColor.rgb(r, g, b)
	}

	/**
	 * @function scanRGBAString
	 * @since 0.4.0
	 * @hidden
	 */
	internal fun scanRGBAString(scanner: Scanner): Int {

		var r: Int?
		var g: Int?
		var b: Int?
		var a: Float?

		scanner.scan("rgba(")
		r = scanner.scanInt()
		scanner.scan(",")
		g = scanner.scanInt()
		scanner.scan(",")
		b = scanner.scanInt()
		scanner.scan(",")
		a = scanner.scanFloat()
		scanner.scan(")")

		if (r == null ||
			g == null ||
			b == null ||
			a == null) {
			return Color.BLACK
		}

		return AndroidColor.argb((a * 255).toInt(), r, g, b)
	}
}
