package ca.logaritm.dezel.core

/**
 * The arguments object provided to a property getter.
 * @class JavaScriptGetterCallback
 * @since 0.1.0
 */
public class JavaScriptGetterCallback(context: JavaScriptContext, target: Long, callee: Long, argc: Int, argv: LongArray) : JavaScriptCallback(context, target, callee, argc, argv) {

}