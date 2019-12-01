package ca.logaritm.dezel.core

import java.io.InputStream
import java.lang.reflect.Method
import kotlin.reflect.KClass

/**
 * @alias JavaScriptFinalizeHandler
 * @since 0.1.0
 */
const val kJavaScriptValueTypeUndefined = 1
const val kJavaScriptValueTypeNull = 2
const val kJavaScriptValueTypeBoolean = 3
const val kJavaScriptValueTypeNumber = 4
const val kJavaScriptValueTypeString = 5
const val kJavaScriptValueTypeObject = 6
const val kJavaScriptValueTypeArray = 7
const val kJavaScriptValueTypeFunction = 8

/**
 * @alias JavaScriptFinalizeHandler
 * @since 0.1.0
 */
public typealias JavaScriptFinalizeHandler = (JavaScriptFinalizeCallback) -> Unit

/**
 * @alias JavaScriptFunctionCallback
 * @since 0.1.0
 */
public typealias JavaScriptFunctionHandler = (JavaScriptFunctionCallback) -> Unit

/**
 * @alias JavaScriptGetterHandler
 * @since 0.1.0
 */
public typealias JavaScriptGetterHandler = (JavaScriptGetterCallback) -> Unit

/**
 * @alias JavaScriptSetterHandler
 * @since 0.1.0
 */
public typealias JavaScriptSetterHandler = (JavaScriptSetterCallback) -> Unit

/**
 * @alias JavaScriptExceptionHandler
 * @since 0.1.0
 */
public typealias JavaScriptExceptionHandler = (JavaScriptValue) -> Unit

/**
 * @alias ValueArray
 * @since 0.1.0
 */
public typealias JavaScriptArguments = Array<JavaScriptValue?>

/**
 * @alias JavaScriptForOwnHandler
 * @since 0.7.0
 */
public typealias JavaScriptForOwnHandler = (String, JavaScriptValue) -> Unit

/**
 * @alias JavaScriptForEachHandler
 * @since 0.7.0
 */
public typealias JavaScriptForEachHandler = (Int, JavaScriptValue) -> Unit

/**
 * @alias JavaScriptPropertyHandler
 * @since 0.7.0
 */
public typealias JavaScriptPropertyHandler = (JavaScriptProperty) -> Unit

/**
 * @alias JavaScriptBuilderForEachHandler
 * @since 0.2.0
 */
public typealias JavaScriptBuilderForEachHandler = (String, JavaScriptBuilder.Type, Method) -> Unit

/**
 * @function toJs
 * @since 0.7.0
 * @hidden
 */
internal fun toJs(value: JavaScriptValue?, context: JavaScriptContext): Long {
    return value?.toHandle(context) ?: context.jsnull.handle
}

/**
 * @function toJs
 * @since 0.7.0
 * @hidden
 */
internal fun toJs(value: JavaScriptProperty?, context: JavaScriptContext): Long {
    return value?.toHandle(context) ?: context.jsnull.handle
}

/**
 * @function toArgv
 * @since 0.1.0
 * @hidden
 */
internal fun toArgv(values: JavaScriptArguments?, context: JavaScriptContext) : LongArray? {

    if (values == null) {
        return null
    }

    val args = LongArray(values.size)
    for (i in values.indices) args[i] = toJs(values[i], context)
    return args
}

/**
 * @function toArgc
 * @since 0.1.0
 * @hidden
 */
internal fun toArgc(values: JavaScriptArguments?) : Int {
	return if (values == null) 0 else values.size
}

/**
 * @since 0.1.0
 * @hidden
 */
public fun <T:Any> KClass<T>.getResource(path:String) : InputStream {
    return this.java.classLoader.getResourceAsStream(path)
}