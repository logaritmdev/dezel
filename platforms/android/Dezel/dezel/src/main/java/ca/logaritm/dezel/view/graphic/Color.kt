package ca.logaritm.dezel.view.graphic

import android.util.Log
import ca.logaritm.dezel.core.JavaScriptProperty
import ca.logaritm.dezel.core.JavaScriptPropertyFunctionValue
import ca.logaritm.dezel.core.JavaScriptPropertyValue
import ca.logaritm.dezel.util.string.Scanner
import java.util.*
import android.graphics.Color as AndroidColor

/**
 * @object Color
 * @since 0.1.0
 */
public object Color {

	//--------------------------------------------------------------------------
	// Static Properties
	//--------------------------------------------------------------------------

	/**
	 * @const TRANSPARENT
	 * @since 0.1.0
	 */
	public const val TRANSPARENT: Int = 0

	/**
	 * @const BLACK
	 * @since 0.1.0
	 */
	public const val BLACK: Int = 0xFF000000.toInt()

	/**
	 * @const WHITE
	 * @since 0.1.0
	 */
	public const val WHITE: Int = 0xFFFFFFFF.toInt()

	/**'
	 * @const GRAY
	 * @since 0.3.0
	 */
	public const val GRAY: Int = 0xFF888888.toInt()

	/**
	 * @property cache
	 * @since 0.7.0
	 */
	private val cache: HashMap<String, Int> = hashMapOf()

	/**
	 * @property names
	 * @since 0.7.0
	 */
	private val names: HashMap<String, String> = object : HashMap<String, String>() {
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
	 * @method parse
	 * @since 0.7.0
	 */	
	public fun parse(color: JavaScriptProperty): Int {

		val function = color.function
		if (function == null) {
			return this.parse(color.string)
		}

		return this.parse(function)
	}

	/**
	 * @method parse
	 * @since 0.7.0
	 */
	public fun parse(color: JavaScriptPropertyValue): Int {

		val functions = color 
		if (functions is JavaScriptPropertyFunctionValue)  {

			if (functions.name == "rgb") {

				assert(functions.arguments.size == 3)

				val r = functions.arguments[0].number.toInt()
				val g = functions.arguments[1].number.toInt()
				val b = functions.arguments[2].number.toInt()

				return AndroidColor.rgb(r, g, b)
			}

			if (functions.name == "rgba") {

				assert(functions.arguments.size == 4)

				val r = functions.arguments[0].number.toInt()
				val g = functions.arguments[1].number.toInt()
				val b = functions.arguments[2].number.toInt()
				val a = functions.arguments[3].number * 255

				return AndroidColor.argb(a.toInt(), r, g, b)
			}
		}

		return this.parse(color.string)
	}

	/**
	 * @method parse
	 * @since 0.1.0
	 */
	public fun parse(from: String): Int {

		var color = from

		color = color.toLowerCase(Locale.ROOT).trim { it <= ' ' }

		if (color == "none" ||
			color == "transparent") {
			return TRANSPARENT
		}

		val cached = cache[color]
		if (cached != null) {
			return cached
		}

		val named = names[color]
		if (named != null) {
			return this.parse(named)
		}

		when (color.length - 1) {

			3 -> {

				val r = color.substring(1, 2)
				val g = color.substring(2, 3)
				val b = color.substring(3, 4)

				return AndroidColor.parseColor("#" + r + r + g + g + b + b)
			}

			4 -> {

				val a = color.substring(1, 2)
				val r = color.substring(2, 3)
				val g = color.substring(3, 4)
				val b = color.substring(4, 5)

				return AndroidColor.parseColor("#" + a + a + r + r + g + g + b + b)
			}

			6 -> {
				return AndroidColor.parseColor(color)
			}

			8 -> {
				return AndroidColor.parseColor(color)
			}
		}

		return BLACK
	}

	/**
	 * @method alpha
	 * @since 0.1.0
	 */
	public fun alpha(color: Int): Int {
		return AndroidColor.alpha(color)
	}
}
