package ca.logaritm.dezel.core

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

			})

			val constructor = prototype.property("constructor")
			constructor.property("prototype", prototype)
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
	}
}