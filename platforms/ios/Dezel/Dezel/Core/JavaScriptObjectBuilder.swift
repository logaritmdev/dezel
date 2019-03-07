/**
 * @class JavaScriptObjectBuilder
 * @since 0.1.0
 * @hidden
 */
internal final class JavaScriptObjectBuilder: JavaScriptBuilder {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
     * @method build
	 * @since 0.1.0
	 * @hidden
     */
	internal class func build(_ context: JavaScriptContext, template: AnyClass) -> JavaScriptValue {

		guard let klass = template as? JavaScriptObject.Type else {
			fatalError("Error creating object instance. Expected JavaScriptObject, found \(template)")
		}

		let value = context.createEmptyObject()

		self.forEach(template, callback: { (name, type, sel, imp) -> Void in

			if (type == .function) {
				DLValueDefineFunction(context.handle, value.handle, name, JavaScriptClassFunctionWrapper(context: context, cls: template, sel: sel, imp: imp, name: name).function)
				return
			}

			if (type == .getter) {
				DLValueDefinePropertyGetter(context.handle, value.handle, name, JavaScriptClassGetterWrapper(context: context, cls: template, sel: sel, imp: imp, name: name).function)
				return
			}

			if (type == .setter) {
				DLValueDefinePropertySetter(context.handle, value.handle, name, JavaScriptClassSetterWrapper(context: context, cls: template, sel: sel, imp: imp, name: name).function)
				return
			}

		})

		let instance = klass.init(context: context)
		instance.reset(value.handle)

		DLValueSetAssociatedObject(context.handle, value.handle, UnsafeMutableRawPointer(value: instance))

		return value
	}
}
