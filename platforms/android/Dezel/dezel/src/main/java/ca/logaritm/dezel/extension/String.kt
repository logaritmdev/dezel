package ca.logaritm.dezel.extension

import ca.logaritm.dezel.view.graphic.Color
import java.security.MessageDigest
import java.util.*
import java.util.regex.Pattern

public val spaces = Pattern.compile("[\t ]+").toRegex()

/**
 * @property isHTML
 * @since 0.5.0
 * @hidden
 */
internal val String.isHTML: Boolean
	get() = RegularExpression.isHTML(this)

/**
 * @property String.fileExt
 * @since 0.1.0
 * @hidden
 */
internal val String.fileExt: String; get() {

	val e = this.lastIndexOf(".")
	if (e == -1) {
		return ""
	}

	return this.substring(e)
}

/**
 * @property String.fileName
 * @since 0.1.0
 * @hidden
 */
internal val String.fileName: String; get() {

	val s = this.lastIndexOf("/")
	val e = this.lastIndexOf(".")
	if (s == -1 ||
		e == -1) {
		return ""
	}

	return this.substring(s + 1, e)
}

/**
 * @property String.baseName
 * @since 0.1.0
 * @hidden
 */
internal val String.baseName: String; get() {

	val e = this.lastIndexOf("/")
	if (e == -1) {
		return this
	}

	return this.substring(0, e)
}

/**
 * @method String.until
 * @since 0.2.0
 * @hidden
 */
internal fun String.until(char: Char): String {
	return this.substringBefore(char)
}

/**
 * @method String.normalize
 * @since 0.5.0
 * @hidden
 */
internal fun String.normalize(): String {
	return (
		this.trim()
			.replace("\\n", "\n")
			.replace(spaces, " ")
			.replace("\n ", "\n")
	)
}

/**
 * @method String.toColor
 * @since 0.1.0
 * @hidden
 */
internal fun String.toColor(): Int {
	return Color.parse(this)
}

/**
 * @method String.toLocale
 * @since 0.5.0
 * @hidden
 */
internal fun String.toLocale(): Locale {

	val components = this.split("-")
	if (components.size == 2) {
		return Locale(components[0], components[1])
	}

	return Locale.getDefault()
}

/**
 * @method String.md5
 * @since 0.1.0
 * @hidden
 */
internal fun String.md5(): String {
	val md = MessageDigest.getInstance("MD5")
	val digested = md.digest(toByteArray())
	return digested.joinToString("") {
		String.format("%02x", it)
	}
}

