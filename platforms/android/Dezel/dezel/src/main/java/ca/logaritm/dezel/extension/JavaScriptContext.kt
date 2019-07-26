package ca.logaritm.dezel.extension

import android.net.Uri
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptValue
import ca.logaritm.dezel.core.JavaScriptValueExternal
import java.net.URL

/**
 * @method JavaScriptContext.createObject
 * @since 0.7.0
 * @hidden
 */
internal fun JavaScriptContext.createObject(dictionary: Map<String, String>): JavaScriptValue {

	val result = this.createEmptyObject()

	for ((k, v) in dictionary) {
		result.property(k, this.createString(v))
	}

	return result
}

/**
 * @method JavaScriptContext.createObject
 * @since 0.7.0
 * @hidden
 */
internal fun JavaScriptContext.createString(url: URL): JavaScriptValue {
	return this.createString(url.toString())
}

/**
 * @method JavaScriptContext.createString
 * @since 0.7.0
 * @hidden
 */
internal fun JavaScriptContext.createString(url: Uri): JavaScriptValue {
	return this.createString(url.toString())
}