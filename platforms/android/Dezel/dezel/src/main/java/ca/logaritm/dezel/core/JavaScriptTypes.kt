package ca.logaritm.dezel.core

import java.io.InputStream
import java.lang.reflect.Method
import kotlin.reflect.KClass

/**
 * The type alias for function handler.
 * @alias JavaScriptFinalizeHandler
 * @since 0.1.0
 */
public typealias JavaScriptFinalizeHandler = (JavaScriptFinalizeCallback) -> Unit

/**
 * The type alias for function handler.
 * @alias JavaScriptFunctionCallback
 * @since 0.1.0
 */
public typealias JavaScriptFunctionHandler = (JavaScriptFunctionCallback) -> Unit

/**
 * The type alias for property getter handler.
 * @alias JavaScriptGetterHandler
 * @since 0.1.0
 */
public typealias JavaScriptGetterHandler = (JavaScriptGetterCallback) -> Unit

/**
 * The type alias for property setter handler.
 * @alias JavaScriptSetterHandler
 * @since 0.1.0
 */
public typealias JavaScriptSetterHandler = (JavaScriptSetterCallback) -> Unit

/**
 * The type alias for the exception handler.
 * @alias JavaScriptExceptionHandler
 * @since 0.1.0
 */
public typealias JavaScriptExceptionHandler = (JavaScriptValue) -> Unit

/**
 * The type alias for handle arrays.
 * @alias ValueArray
 * @since 0.1.0
 */
public typealias JavaScriptArguments = Array<JavaScriptValue?>

/**
 * The object for each handler.
 * @alias JavaScriptForOwnHandler
 * @since 0.7.0
 */
public typealias JavaScriptForOwnHandler = (String, JavaScriptValue) -> Unit

/**
 * The array for each handler.
 * @alias JavaScriptForEachHandler
 * @since 0.7.0
 */
public typealias JavaScriptForEachHandler = (Int, JavaScriptValue) -> Unit

/**
 * The property change handler.
 * @alias JavaScriptPropertyHandler
 * @since 0.7.0
 */
public typealias JavaScriptPropertyHandler = (JavaScriptProperty) -> Unit

/**
 * The builder for each handler alias.
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