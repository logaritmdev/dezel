package ca.logaritm.dezel.font

import android.content.Context
import android.graphics.Typeface

/**
 * @object FontManager
 * @since 0.1.0
 */
public object FontManager {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * @property natives
	 * @since 0.1.0
	 */
	private var natives: List<String> = listOf(
		"roboto thin",
		"roboto light",
		"roboto regular",
		"roboto bold",
		"roboto medium",
		"roboto black",
		"roboto condensed light",
		"roboto condensed regular",
		"roboto condensed medium",
		"roboto condensed bold",
		"noto serif",
		"noto serif bold",
		"droid sans mono",
		"cutive mono",
		"coming soon",
		"dancing script",
		"dancing script bold",
		"carrois gothic sc",
		"sans-serif-thin",
		"sans-serif-light",
		"sans-serif",
		"sans-serif-medium",
		"sans-serif-black",
		"sans-serif-condensed-light",
		"sans-serif-condensed",
		"sans-serif-condensed-medium",
		"serif",
		"monospace",
		"serif-monospace",
		"casual",
		"cursive",
		"sans-serif-smallcaps"
	)

	/**
	 * @property cache
	 * @since 0.1.0
	 */
	private var cache: MutableMap<String, Typeface> = mutableMapOf()

	/**
	 * @property fonts
	 * @since 0.1.0
	 */
	private var fonts: MutableList<FontFile> = mutableListOf()

	/**
	 * @method load
	 * @since 0.1.0
	 */
	public fun load(context: Context) {
		context.assets.list("fonts")?.forEach { file ->
			this.fonts.add(FontFile(context, "fonts", file))
		}
	}

	/**
	 * @method get
	 * @since 0.1.0
	 */
	public fun get(family: String, weight: String, style: String): Typeface {

		var fontFamily = family.toLowerCase().trim()
		var fontWeight = weight.toLowerCase().trim()
		var fontStyle = style.toLowerCase().trim()

		if (fontFamily == "" ||
			fontFamily == "default") {
			fontFamily = "sans-serif"
		}

		if (fontWeight == "" ||
			fontWeight == "default") {
			fontWeight = "normal"
		}

		if (this.isSystemFont(fontFamily)) {

			fontWeight = when (fontWeight) {
				"100" -> "thin"
				"200" -> "thin"
				"300" -> "light"
				"400" -> ""
				"500" -> "medium"
				"600" -> "medium"
				"700" -> "bold"
				"800" -> "black"
				"900" -> "black"
				else  -> fontWeight
			}

			return this.getSystemFontByName("$fontFamily-$fontWeight", fontStyle == "italic") ?: Typeface.DEFAULT
		}

		when (fontWeight) {
			"extralight" -> fontWeight = "100"
			"ultralight" -> fontWeight = "100"
			"light"      -> fontWeight = "200"
			"thin"       -> fontWeight = "200"
			"book"       -> fontWeight = "300"
			"demi"       -> fontWeight = "300"
			"normal"     -> fontWeight = "400"
			"regular"    -> fontWeight = "400"
			"medium"     -> fontWeight = "500"
			"semibold"   -> fontWeight = "600"
			"demibold"   -> fontWeight = "600"
			"bold"       -> fontWeight = "700"
			"black"      -> fontWeight = "800"
			"heavy"      -> fontWeight = "800"
			"extrabold"  -> fontWeight = "800"
			"extrablack" -> fontWeight = "900"
			"ultrablack" -> fontWeight = "900"
		}

		val key = "$fontFamily-$fontWeight-$fontStyle"

		val cache = this.cache[key]
		if (cache == null) {

			fontWeight = this.getClosestFontWeight(fontFamily, fontWeight)
			fontStyle = this.getClosestFontStyle(fontFamily, fontWeight, fontStyle)

			for (font in this.fonts) {
				if (font.fontFamilyNormalized == fontFamily &&
					font.fontWeightNormalized == fontWeight &&
					font.fontStyleNormalized == fontStyle) {
					val typeface = Typeface.createFromAsset(font.context.assets, font.path + "/" + font.file)
					this.cache[key] = typeface
					return typeface
				}
			}
		}

		when (fontStyle) {
			"normal" -> return Typeface.create("$fontFamily-$fontWeight", Typeface.NORMAL)
			"italic" -> return Typeface.create("$fontFamily-$fontWeight", Typeface.ITALIC)
		}

		return Typeface.DEFAULT
	}

	//-------------------------------------------------------------------------
	// Private API
	//-------------------------------------------------------------------------

	/**
	 * @method isSystemFont
	 * @since 0.1.0
	 * @hidden
	 */
	private fun isSystemFont(name: String): Boolean {
		return this.natives.indexOf(name) > -1
	}

	/**
	 * @method getSystemFontByName
	 * @since 0.1.0
	 * @hidden
	 */
	private fun getSystemFontByName(name: String, italic: Boolean): Typeface? {

		var typefaceNorm = Typeface.NORMAL
		var typefaceBold = Typeface.BOLD

		if (italic) {
			typefaceNorm = Typeface.ITALIC
			typefaceBold = Typeface.BOLD_ITALIC
		}

		return when (name) {
			"roboto thin"                 -> Typeface.create("sans-serif-thin", typefaceNorm)
			"roboto light"                -> Typeface.create("sans-serif-light", typefaceNorm)
			"roboto regular"              -> Typeface.create("sans-serif", typefaceNorm)
			"roboto bold"                 -> Typeface.create("sans-serif", typefaceBold)
			"roboto medium"               -> Typeface.create("sans-serif-medium", typefaceNorm)
			"roboto black"                -> Typeface.create("sans-serif-black", typefaceNorm)
			"roboto condensed light"      -> Typeface.create("sans-serif-condensed-light", typefaceNorm)
			"roboto condensed regular"    -> Typeface.create("sans-serif-condensed", typefaceNorm)
			"roboto condensed medium"     -> Typeface.create("sans-serif-condensed-medium", typefaceNorm)
			"roboto condensed bold"       -> Typeface.create("sans-serif-condensed", typefaceBold)
			"noto serif"                  -> Typeface.create("serif", typefaceNorm)
			"noto serif bold"             -> Typeface.create("serif", typefaceBold)
			"droid sans mono"             -> Typeface.create("monospace", typefaceNorm)
			"cutive mono"                 -> Typeface.create("serif-monospace", typefaceNorm)
			"coming soon"                 -> Typeface.create("casual", typefaceNorm)
			"dancing script"              -> Typeface.create("cursive", typefaceNorm)
			"dancing script bold"         -> Typeface.create("cursive", typefaceBold)
			"carrois gothic sc"           -> Typeface.create("sans-serif-smallcaps", typefaceNorm)
			"sans-serif-thin"             -> Typeface.create("sans-serif-thin", typefaceNorm)
			"sans-serif-light"            -> Typeface.create("sans-serif-light", typefaceNorm)
			"sans-serif"                  -> Typeface.create("sans-serif", typefaceNorm)
			"sans-serif-medium"           -> Typeface.create("sans-serif-medium", typefaceNorm)
			"sans-serif-bold"             -> Typeface.create("sans-serif", typefaceBold)
			"sans-serif-black"            -> Typeface.create("sans-serif-black", typefaceNorm)
			"sans-serif-condensed-light"  -> Typeface.create("sans-serif-condensed-light", typefaceNorm)
			"sans-serif-condensed"        -> Typeface.create("sans-serif-condensed", typefaceNorm)
			"sans-serif-condensed-medium" -> Typeface.create("sans-serif-condensed-medium", typefaceNorm)
			"sans-serif-condensed-bold"   -> Typeface.create("sans-serif-condensed", typefaceBold)
			"serif"                       -> Typeface.create("serif", typefaceNorm)
			"serif-bold"                  -> Typeface.create("serif", typefaceBold)
			"monospace"                   -> Typeface.create("monospace", typefaceNorm)
			"serif-monospace"             -> Typeface.create("serif-monospace", typefaceNorm)
			"casual"                      -> Typeface.create("casual", typefaceNorm)
			"cursive"                     -> Typeface.create("cursive", typefaceNorm)
			"cursive-bold"                -> Typeface.create("cursive", typefaceBold)
			"sans-serif-smallcaps"        -> Typeface.create("sans-serif-smallcaps", typefaceNorm)
			else                          -> null
		}
	}

	/**
	 * @method getClosestFontWeight
	 * @since 0.1.0
	 * @hidden
	 */
	private fun getClosestFontWeight(fontFamily: String, fontWeight: String): String {

		val list = mutableSetOf<String>()

		for (font in this.fonts) {
			if (font.fontFamilyNormalized == fontFamily) {
				list.add(font.fontWeightNormalized)
			}
		}

		list.sorted().forEach { value ->
			if (fontWeight <= value) return value
		}

		return "400"
	}

	/**
	 * @method getClosestFontStyle
	 * @since 0.1.0
	 * @hidden
	 */
	private fun getClosestFontStyle(fontFamily: String, fontWeight: String, fontStyle: String): String {

		val list = mutableSetOf<String>()

		for (font in this.fonts) {
			if (font.fontFamilyNormalized == fontFamily &&
				font.fontWeightNormalized == fontWeight) {
				list.add(font.fontStyleNormalized)
			}
		}

		list.forEach { value ->
			if (fontStyle == value) return value
		}

		return "normal"
	}
}
