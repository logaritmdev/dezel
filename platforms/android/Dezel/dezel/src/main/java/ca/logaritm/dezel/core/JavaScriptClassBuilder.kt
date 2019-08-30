package ca.logaritm.dezel.core

import android.util.Log
import java.lang.reflect.Method

/**
 * @class JavaScriptClassBuilder
 * @since 0.1.0
 * @hidden
 */
internal class JavaScriptClassBuilder : JavaScriptBuilder() {

	companion object {

		/**
		 * @method build
		 * @since 0.1.0
		 * @hidden
		 */
		internal fun build(context: JavaScriptContext, template: Class<*>): JavaScriptValue {

			val statics = context.createEmptyObject()
			val prototype = context.createEmptyObject()

			forEach(template, fun(name: String, type: Type, method: Method) {

				if (type == Type.FUNCTION && name == "constructor") {
					this.createConstructor(context, prototype.handle, name, method.name, template)
					return
				}

				if (type == Type.FUNCTION) {
					this.createFunction(context, prototype.handle, name, method.name, template)
					return
				}

				if (type == Type.GETTER) {
					this.createGetter(context, prototype.handle, name, method.name, template)
					return
				}

				if (type == Type.SETTER) {
					this.createSetter(context, prototype.handle, name, method.name, template)
					return
				}

				if (type == Type.STATIC_FUNCTION) {
					this.createStaticFunction(context, prototype.handle, name, method.name, template)
					return
				}

				if (type == Type.STATIC_GETTER) {
					this.createStaticGetter(context, prototype.handle, name, method.name, template)
					return
				}

				if (type == Type.STATIC_SETTER) {
					this.createStaticSetter(context, prototype.handle, name, method.name, template)
					return
				}

			})

			val constructor = prototype.property("constructor")
			constructor.property("prototype", prototype)
			constructor.property("statics", statics)
			return constructor
		}

		/**
		 * @method createConstructor
		 * @since 0.1.0:
		 * @hidden
		 */
		private fun createConstructor(context: JavaScriptContext, target: Long, name: String, method: String, cls: Class<*>) {
			JavaScriptClassBuilderExternal.createConstructor(context.handle, target, name, method, cls, context)
		}

		/**
		 * @method createFunction
		 * @since 0.1.0:
		 * @hidden
		 */
		private fun createFunction(context: JavaScriptContext, target: Long, name: String, method: String, cls: Class<*>) {
			JavaScriptClassBuilderExternal.createFunction(context.handle, target, name, method, cls, context)
		}

		/**
		 * @method createGetter
		 * @since 0.1.0:
		 * @hidden
		 */
		private fun createGetter(context: JavaScriptContext, target: Long, name: String, method: String, cls: Class<*>) {
			JavaScriptClassBuilderExternal.createGetter(context.handle, target, name, method, cls, context)
		}

		/**
		 * @method createSetter
		 * @since 0.1.0:
		 * @hidden
		 */
		private fun createSetter(context: JavaScriptContext, target: Long, name: String, method: String, cls: Class<*>) {
			JavaScriptClassBuilderExternal.createSetter(context.handle, target, name, method, cls, context)
		}

		/**
		 * @method createStaticFunction
		 * @since 0.7.0:
		 * @hidden
		 */
		private fun createStaticFunction(context: JavaScriptContext, target: Long, name: String, method: String, cls: Class<*>) {
			JavaScriptClassBuilderExternal.createStaticFunction(context.handle, target, name, method, cls, context)
		}

		/**
		 * @method createStaticGetter
		 * @since 0.7.0:
		 * @hidden
		 */
		private fun createStaticGetter(context: JavaScriptContext, target: Long, name: String, method: String, cls: Class<*>) {
			JavaScriptClassBuilderExternal.createStaticGetter(context.handle, target, name, method, cls, context)
		}

		/**
		 * @method createStaticSetter
		 * @since 0.7.0:
		 * @hidden
		 */
		private fun createStaticSetter(context: JavaScriptContext, target: Long, name: String, method: String, cls: Class<*>) {
			JavaScriptClassBuilderExternal.createStaticSetter(context.handle, target, name, method, cls, context)
		}
	}
}