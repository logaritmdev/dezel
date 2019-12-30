package ca.logaritm.dezel.core

import android.util.Log
import ca.logaritm.dezel.core.external.JavaScriptObjectBuilderExternal
import ca.logaritm.dezel.core.external.JavaScriptValueExternal
import java.lang.reflect.InvocationTargetException
import java.lang.reflect.Method

/**
 * @class JavaScriptObjectBuilder
 * @super JavaScriptBuilder
 * @since 0.1.0
 */
public class JavaScriptObjectBuilder : JavaScriptBuilder() {

	companion object {

		/**
		 * @method build
		 * @since 0.1.0
		 */
		public fun build(context: JavaScriptContext, template: Class<*>): JavaScriptValue {

			val value = context.createEmptyObject()

			forEach(template, fun(name: String, type: Type, method: Method) {

				if (type == Type.FUNCTION) {
					createFunction(context, value.handle, name, method.name, template)
					return
				}

				if (type == Type.GETTER) {
					createGetter(context, value.handle, name, method.name, template)
					return
				}

				if (type == Type.SETTER) {
					createSetter(context, value.handle, name, method.name, template)
					return
				}

			})

			try {

				val instance = template.getConstructor(JavaScriptContext::class.java).newInstance(context)
				if (instance is JavaScriptObject) {
					instance.reset(value.handle)
				}

				JavaScriptValueExternal.setAssociatedObject(context.handle, value.handle, instance)

			} catch (e: InstantiationException) {
				Log.e("DEZEL", "JavaScriptObjectBuilder Error", e)
			} catch (e: IllegalAccessException) {
				Log.e("DEZEL", "JavaScriptObjectBuilder Error", e)
			} catch (e: InvocationTargetException) {
				Log.e("DEZEL", "JavaScriptObjectBuilder Error", e)
			} catch (e: NoSuchMethodException) {
				Log.e("DEZEL", "JavaScriptObjectBuilder Error", e)
			}

			return value
		}

		/**
		 * @method createFunction
		 * @since 0.1.0
		 * @hidden
		 */
		private fun createFunction(context: JavaScriptContext, target: Long, name: String, method: String, cls: Class<*>) {
			JavaScriptObjectBuilderExternal.createFunction(context.handle, target, name, method, cls, context)
		}

		/**
		 * @method createGetter
		 * @since 0.1.0
		 * @hidden
		 */
		private fun createGetter(context: JavaScriptContext, target: Long, name: String, method: String, cls: Class<*>) {
			JavaScriptObjectBuilderExternal.createGetter(context.handle, target, name, method, cls, context)
		}

		/**
		 * @method createSetter
		 * @since 0.1.0
		 * @hidden
		 */
		private fun createSetter(context: JavaScriptContext, target: Long, name: String, method: String, cls: Class<*>) {
			JavaScriptObjectBuilderExternal.createSetter(context.handle, target, name, method, cls, context)
		}
	}
}
