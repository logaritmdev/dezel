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
		public fun forEach(from: Class<*>, callback: JavaScriptBuilderForEachHandler) {

			val processed = HashMap<String, Boolean>()

			var clazz: Class<*> = from

			while (true) {

				val methods = clazz.declaredMethods

				for (method in methods) {

					val name = method.name

					val isFunction = name.startsWith("jsFunction")
					val isGetter = name.startsWith("jsGet")
					val isSetter = name.startsWith("jsSet")

					if (isFunction == false &&
						isSetter == false &&
						isGetter == false) {
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
				}

				val parent = clazz.superclass
				if (parent == null ||
					parent == Any::class.java) {
					break
				}

				clazz = parent
			}
		}
	}
}
