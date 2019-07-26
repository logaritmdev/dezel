package ca.logaritm.dezel.extension

import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.JavaScriptValue
import ca.logaritm.dezel.core.JavaScriptValueExternal

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