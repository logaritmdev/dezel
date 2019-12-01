package ca.logaritm.dezel.view.type

import java.util.*

/**
 * @enum TextTransform
 * @since 0.1.0
 * @hidden
 */
enum class TextTransform  {

	NONE,
	CAPITALIZE,
	UPPERCASE,
	LOWERCASE;

	companion object {

		fun capitalize(text:String) : String {

			val chars = text.toLowerCase().toCharArray()

			var found = false

			for (i in chars.indices) {
				if (found == false && Character.isLetter(chars[i])) {
					chars[i] = Character.toUpperCase(chars[i])
					found = true
				} else if (Character.isWhitespace(chars[i]) || chars[i] == '.' || chars[i] == '\'') {
					found = false
				}
			}

			return String(chars)
		}

		fun uppercase(text:String) : String {
			return text.toUpperCase(Locale.ROOT)
		}

		fun lowercase(text:String) : String {
			return text.toLowerCase(Locale.ROOT)
		}
	}
}