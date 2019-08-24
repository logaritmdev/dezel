package ca.logaritm.dezel.core

import java.io.InputStream
import java.lang.reflect.Method
import kotlin.reflect.KClass

/**
 * The type alias for function callback.
 * @alias JavaScriptFinalizeHandler
 * @since 0.1.0
 */
public typealias JavaScriptFinalizeHandler = (JavaScriptFinalizeCallback) -> Unit

/**
 * The type alias for function callback.
 * @alias JavaScriptFunctionCallback
 * @since 0.1.0
 */
public typealias JavaScriptFunctionHandler = (JavaScriptFunctionCallback) -> Unit

/**
 * The type alias for property getter callback.
 * @alias JavaScriptGetterHandler
 * @since 0.1.0
 */
public typealias JavaScriptGetterHandler = (JavaScriptGetterCallback) -> Unit

/**
 * The type alias for property setter callback.
 * @alias JavaScriptSetterHandler
 * @since 0.1.0
 */
public typealias JavaScriptSetterHandler = (JavaScriptSetterCallback) -> Unit

/**
 * The type alias for the exception callback.
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
 * The object for each callback.
 * @alias JavaScriptForOwnHandler
 * @since 0.7.0
 */
public typealias JavaScriptForOwnHandler = (String, JavaScriptValue) -> Unit

/**
 * The array for each callback.
 * @alias JavaScriptForEachHandler
 * @since 0.7.0
 */
public typealias JavaScriptForEachHandler = (Int, JavaScriptValue) -> Unit

/**
 * The array for each callback.
 * @alias JavaScriptPropertyChangeHandler
 * @since 0.7.0
 */
public typealias JavaScriptPropertyChangeHandler = (value: JavaScriptProperty) -> Unit

/**
 * The builder for each callback alias.
 * @alias JavaScriptBuilderForEachHandler
 * @since 0.2.0
 */
public typealias JavaScriptBuilderForEachHandler = (String, JavaScriptBuilder.Type, Method) -> Unit

/**
 * @function toHandle
 * @since 0.1.0
 * @hidden
 */
internal fun toHandle(value: JavaScriptValue?, context: JavaScriptContext): Long {

    if (value == null) {
        return context.jsnull.handle
    }

    if (value is JavaScriptClass) {
        return toHandle(value.instance, context)
    }

    return value.handle
}

/**
 * @function toHandle
 * @since 0.7.0
 * @hidden
 */
internal fun toHandle(property: JavaScriptProperty?, context: JavaScriptContext): Long {

    if (property == null) {
        return context.jsnull.handle
    }

    return toHandle(property.value, context)
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
    for (i in values.indices) args[i] = toHandle(values[i], context)
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