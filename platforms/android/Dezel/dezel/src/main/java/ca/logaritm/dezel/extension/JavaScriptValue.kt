package ca.logaritm.dezel.extension

import android.net.Uri
import ca.logaritm.dezel.core.JavaScriptValue
import java.net.URL

/**
 * @method JavaScriptValue.toURL
 * @since 0.7.0
 * @hidden
 */
internal fun JavaScriptValue.toURL(): URL {
	return URL(this.string)
}

/**
 * @method JavaScriptValue.toArrayOfString
 * @since 0.7.0
 * @hidden
 */
internal fun JavaScriptValue.toArrayOfString(): MutableList<String> {

	val array = mutableListOf<String>()

	this.forEach { _, value ->
		array.append(value.string)
	}

	return array
}

/**
 * @method JavaScriptValue.toArrayOfNumber
 * @since 0.7.0
 * @hidden
 */
internal fun JavaScriptValue.toArrayOfNumber(): MutableList<Double> {

	val array = mutableListOf<Double>()

	this.forEach { _, value ->
		array.append(value.number)
	}

	return array
}

/**
 * @method JavaScriptValue.toDictionaryOfString
 * @since 0.7.0
 * @hidden
 */
internal fun JavaScriptValue.toDictionaryOfString(): MutableMap<String, String> {

	val dictionary = mutableMapOf<String, String>()

	this.forOwn { key, value ->
		dictionary.put(key, value.string)
	}

	return dictionary
}

/**
 * @method JavaScriptValue.toDictionaryOfNumber
 * @since 0.7.0
 * @hidden
 */
internal fun JavaScriptValue.toDictionaryOfNumber(): Map<String, Double> {

	val dictionary = mutableMapOf<String, Double>()

	this.forOwn { key, value ->
		dictionary.put(key, value.number)
	}

	return dictionary
}
