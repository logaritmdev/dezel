package ca.logaritm.dezel.extension.type

import ca.logaritm.dezel.view.graphic.Color
import java.lang.StringBuilder
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
 * @property isNumeric
 * @since 0.7.0
 * @hidden
 */
internal val String.isNumeric: Boolean; get() {

	val char = this.first
	if (char == null) {
		return false
	}

	return (
		char.isDigit() ||
		char == '+' ||
		char == '-' ||
		char == '.'
	)
}

/**
 * @property String.first
 * @since 0.7.0
 * @hidden
 */
internal val String.first: Char?
	get() = if (this.length > 0) this.first() else null

/**
 * @property String.last2
 * @since 0.7.0
 * @hidden
 */
internal val String.last2: String
	get() = this.takeLast(2)

/**
 * @property String.last2
 * @since 0.7.0
 * @hidden
 */
internal val String.last3: String
	get() = this.takeLast(3)

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

/**
 * Converts to a number.
 * @method toNumber
 * @since 0.7.0
 */
public fun String.toNumber(): Double {

	if (this == "") {
		return 0.0
	}

	var limit = 0
	val chars = StringBuilder()

	for (char in this) {

		limit += 1

		if (char.isDigit() == false &&
			char != '+' &&
			char != '-' &&
			char != '.') {
			break
		}

		chars.append(char)
	}

	if (limit == 1) {
		return Double.NaN
	}

	return chars.toString().toDouble()
}

/**
 * Converts to a color.
 * @method String.toNumber
 * @since 0.7.0
 */
public fun String.toColor(): Int {
	return Color.parse(this)
}

/**
 * Converts to a locale.
 * @method String.toLocale
 * @since 0.5.0
 */
public fun String.toLocale(): Locale {

	val components = this.split("-")
	if (components.size == 2) {
		return Locale(components[0], components[1])
	}

	return Locale.getDefault()
}

