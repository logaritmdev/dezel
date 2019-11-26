/**
 * @class JavaScriptClassBuilder
 * @super JavaScriptBuilder
 * @since 0.1.0
 * @hidden
 */
internal final class JavaScriptClassBuilder: JavaScriptBuilder {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
     * @method build
	 * @since 0.1.0
	 * @hidden
     */
	internal class func build(_ context: JavaScriptContext, template: AnyClass) -> JavaScriptValue {

		let prototype = context.createEmptyObject()
		let statics = context.createEmptyObject()

		JavaScriptBuilder.forEach(template, callback: { (name, type, sel, imp) -> Void in

			if (type == .function && name == "constructor") {
				JavaScriptValueDefineConstructor(context.handle, prototype.handle, JavaScriptClassConstructorWrapper(context: context, cls: template, sel: sel, imp: imp, name: String(describing: template)).function)
				return
			}

			if (type == .function) {
				JavaScriptValueDefineFunction(context.handle, prototype.handle, name, JavaScriptClassFunctionWrapper(context: context, cls: template, sel: sel, imp: imp, name: name).function)
				return
			}

			if (type == .getter) {
				JavaScriptValueDefinePropertyGetter(context.handle, prototype.handle, name, JavaScriptClassGetterWrapper(context: context, cls: template, sel: sel, imp: imp, name: name).function)
				return
			}

			if (type == .setter) {
				JavaScriptValueDefinePropertySetter(context.handle, prototype.handle, name, JavaScriptClassSetterWrapper(context: context, cls: template, sel: sel, imp: imp, name: name).function)
				return
			}

			if (type == .staticFunction) {
				JavaScriptValueDefineFunction(context.handle, statics.handle, name, JavaScriptClassStaticFunctionWrapper(context: context, cls: template, sel: sel, imp: imp, name: name).function)
				return
			}

			if (type == .staticGetter) {
				JavaScriptValueDefinePropertyGetter(context.handle, statics.handle, name, JavaScriptClassStaticGetterWrapper(context: context, cls: template, sel: sel, imp: imp, name: name).function)
				return
			}

			if (type == .staticSetter) {
				JavaScriptValueDefinePropertySetter(context.handle, statics.handle, name, JavaScriptClassStaticSetterWrapper(context: context, cls: template, sel: sel, imp: imp, name: name).function)
				return
			}
		})

		let constructor = prototype.property("constructor")
		constructor.property("prototype", value: prototype)
		constructor.property("statics", value: statics)

		return constructor
	}
}
