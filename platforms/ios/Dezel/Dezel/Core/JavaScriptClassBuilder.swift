/**
 * Creates a JavaScript constructor from a native class.
 * @class JavaScriptClassBuilder
 * @since 0.1.0
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

		JavaScriptBuilder.forEach(template, callback: { (name, type, sel, imp) -> Void in

			if (type == .function && name == "constructor") {
				DLValueDefineConstructor(context.handle, prototype.handle, JavaScriptClassConstructorWrapper(context: context, cls: template, sel: sel, imp: imp, name: String(describing: template)).function)
				return
			}

			if (type == .function) {
				DLValueDefineFunction(context.handle, prototype.handle, name, JavaScriptClassFunctionWrapper(context: context, cls: template, sel: sel, imp: imp, name: name).function)
				return
			}

			if (type == .getter) {
				DLValueDefinePropertyGetter(context.handle, prototype.handle, name, JavaScriptClassGetterWrapper(context: context, cls: template, sel: sel, imp: imp, name: name).function)
				return
			}

			if (type == .setter) {
				DLValueDefinePropertySetter(context.handle, prototype.handle, name, JavaScriptClassSetterWrapper(context: context, cls: template, sel: sel, imp: imp, name: name).function)
				return
			}

		})

		let constructor = prototype.property("constructor")
		constructor.property("prototype", value: prototype)
		return constructor
	}
}
