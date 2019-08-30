package ca.logaritm.dezel.core

import java.util.*

/**
 * @class JavaScriptBuilder
 * @since 0.1.0
 * @hidden
 */
open class JavaScriptBuilder {

	/**
	 * @enum JavaScriptType
	 * @since 0.1.0
	 * @hidden
	 */
	enum class Type {
		STATIC_FUNCTION,
		STATIC_GETTER,
		STATIC_SETTER,
		FUNCTION,
		GETTER,
		SETTER
	}

	companion object {

		/**
		 * @method forEach
		 * @since 0.1.0
		 * @hidden
		 */
		public fun forEach(clazz: Class<*>, callback: JavaScriptBuilderForEachHandler) {

			val processed = HashMap<String, Boolean>()

			for (method in clazz.methods) {

				val name = method.name

				val isFunction = name.startsWith("jsFunction")
				val isGetter = name.startsWith("jsGet")
				val isSetter = name.startsWith("jsSet")

				val isStaticFunction = name.startsWith("jsStaticFunction")
				val isStaticGetter = name.startsWith("jsStaticGet")
				val isStaticSetter = name.startsWith("jsStaticSet")

				if (isFunction == false &&
					isSetter == false &&
					isGetter == false &&
					isStaticFunction == false &&
					isStaticGetter == false &&
					isStaticSetter == false) {
					continue
				}

				if (processed[name] == null) {
					processed.put(name, true)
				} else {
					continue
				}

				val s = name.indexOf("_")
				val e = name.length
				val key = name.substring(s + 1, e)

				if (isFunction) {
					callback(key, Type.FUNCTION, method)
					continue
				}

				if (isGetter) {
					callback(key, Type.GETTER, method)
					continue
				}

				if (isSetter) {
					callback(key, Type.SETTER, method)
					continue
				}

				if (isStaticFunction) {
					callback(key, Type.STATIC_FUNCTION, method)
					continue
				}

				if (isStaticGetter) {
					callback(key, Type.STATIC_GETTER, method)
					continue
				}

				if (isStaticSetter) {
					callback(key, Type.STATIC_SETTER, method)
					continue
				}
			}
		}
	}
}
