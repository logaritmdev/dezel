/**
 * A JavaScript execution environment.
 * @class JavaScriptContext
 * @since 0.1.0
 */
open class JavaScriptContext: NSObject {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
     * The context's handle.
     * @property handle
     * @since 0.1.0
     */
	private(set) public var handle: JSContextRef!

	/**
     * The context global object.
     * @property global
     * @since 0.1.0
     */
	private(set) public var global: JavaScriptValue!

	/**
     * The context's registered modules.
     * @property modules
     * @since 0.1.0
     */
	internal(set) public var modules: [String: Module] = [:]

	/**
     * The context's registered objects.
     * @property objects
     * @since 0.1.0
     */
	internal(set) public var objects: [String: JavaScriptValue] = [:]

	/**
     * The context's registered classes.
     * @property classes
     * @since 0.1.0
     */
	internal(set) public var classes: [String: JavaScriptValue] = [:]

	/**
     * The context's imported values.
     * @property exports
     * @since 0.1.0
     */
	internal(set) public var exports: [String: JavaScriptValue] = [:]

	/**
	 * The context's console.
	 * @property exports
	 * @since 0.4.0
	 */
	internal(set) public lazy var console: JavaScriptConsole! = {
		return JavaScriptConsole(context: self)
	}()

	/**
	 * @property running
	 * @since 0.1.0
	 * @hidden
	 */
	private var running: Bool = false

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
     * @constructor
     * @since 0.1.0
     */
	public override init() {

		super.init()

		self.handle = DLContextCreate(Bundle.main.bundleIdentifier ?? "Dezel Context")

		self.global = JavaScriptValue.create(self, handle: DLContextGetGlobalObject(self.handle))

		let code = """

			self = this;
			global = this;
			window = this;

			(function() {

				var log = console.log.bind(console);

				console.log = function() {
					log.apply(this, arguments)
					dezel.log.apply(dezel, arguments)
				};

			})();

			const __throwError = function(error) {
				throw (typeof error == 'string' ? new Error(error) : error)
			}

		"""

		self.evaluate(code);
	}

	/**
     * Disposes of the context upon destruction.
	 * @destructor
     * @since 0.1.0
     */
	deinit {
		self.dispose()
	}

	/**
     * Registers a context module.
     * @method registerModule
     * @since 0.1.0
     */
	open func registerModule(_ ident: String, type: AnyClass) {
		self.modules[ident] = Module.create(type, context: self)
	}

	/**
	 * Registers a context object.
	 * @method registerObject
	 * @since 0.1.0
	 */
	open func registerObject(_ ident: String, type: AnyClass) {
		self.objects[ident] = self.createObject(type)
	}

	/**
	 * Registers a context class.
	 * @method registerClass
	 * @since 0.1.0
	 */
	open func registerClass(_ ident: String, type: AnyClass) {
		self.classes[ident] = self.createClass(type)
	}

	/**
     * Initializes the context after modules and classes have been regsitered.
     * @method initialize
     * @since 0.1.0
     */
	open func initialize() {

		if (self.running) {
			return
		}

		for (_, module) in self.modules {
			module.initialize()
		}

		self.running = true
	}

	/**
     * Disposes the context.
     * @method dispose
     * @since 0.1.0
     */
	open func dispose() {

		if (self.running == false) {
			return
		}

		for (_, module) in self.modules {
			module.dispose()
		}

		self.modules.removeAll()
		self.objects.removeAll()
		self.classes.removeAll()

		self.global.dispose()

		self.garbageCollect()

		DLContextDelete(self.handle)

		self.running = false
	}

	/**
	 * Creates a value which contains the null JavaScript value.
	 * @method createNull
	 * @since 0.1.0
	 */
	open func createNull() -> JavaScriptValue {
		return JavaScriptValue.createNull(self)
	}

	/**
	 * Creates a value which contains the undefined JavaScript value.
	 * @method createUndefined
	 * @since 0.1.0
	 */
	open func createUndefined() -> JavaScriptValue {
		return JavaScriptValue.createUndefined(self)
	}

	/**
	 * Creates a value which contains a string JavaScript value.
	 * @method createString
	 * @since 0.1.0
	 */
	open func createString(_ value: String) -> JavaScriptValue {
		return JavaScriptValue.createString(self, value: value)
	}

	/**
	 * Creates a value which contains a numeric JavaScript value.
	 * @method createNumber
	 * @since 0.1.0
	 */
	open func createNumber(_ value: Double) -> JavaScriptValue {
		return JavaScriptValue.createNumber(self, value: value)
	}

	/**
	 * Creates a handle which contains a numeric JavaScript handle with a specific unit.
	 * @method createNumber
	 * @since 0.2.0
	 */
	open func createNumber(_ value: Double, unit: PropertyUnit) -> JavaScriptValue {
		switch (unit) {
			case .px: return JavaScriptValue.createNumber(self, value: value)
			case .pc: return JavaScriptValue.createString(self, value: Conversion.ntos(value) + "%")
			case .vw: return JavaScriptValue.createString(self, value: Conversion.ntos(value) + "vw")
			case .vh: return JavaScriptValue.createString(self, value: Conversion.ntos(value) + "vh")
			case .pw: return JavaScriptValue.createString(self, value: Conversion.ntos(value) + "pw")
			case .ph: return JavaScriptValue.createString(self, value: Conversion.ntos(value) + "ph")
			case .cw: return JavaScriptValue.createString(self, value: Conversion.ntos(value) + "cw")
			case .ch: return JavaScriptValue.createString(self, value: Conversion.ntos(value) + "vh")
			case .deg: return JavaScriptValue.createString(self, value: Conversion.ntos(value) + "deg")
			case .rad: return JavaScriptValue.createString(self, value: Conversion.ntos(value) + "rad")
			default:   return JavaScriptValue.createNumber(self, value: value)
		}
	}

	/**
	 * Creates a value which contains a numeric JavaScript value.
	 * @method createNumber
	 * @since 0.3.0
	 */
	open func createNumber(_ value: Float) -> JavaScriptValue {
		return JavaScriptValue.createNumber(self, value: Double(value))
	}

	/**
	 * Creates a value which contains a numeric JavaScript value.
	 * @method createNumber
	 * @since 0.3.0
	 */
	open func createNumber(_ value: Int) -> JavaScriptValue {
		return JavaScriptValue.createNumber(self, value: Double(value))
	}

	/**
	 * Creates a value which contains a numeric JavaScript value.
	 * @method createNumber
	 * @since 0.3.0
	 */
	open func createNumber(_ value: CGFloat) -> JavaScriptValue {
		return JavaScriptValue.createNumber(self, value: Double(value))
	}

	/**
	 * Creates a value which contains a boolean JavaScript value.
	 * @method createBoolean
	 * @since 0.1.0
	 */
	open func createBoolean(_ value: Bool) -> JavaScriptValue {
		return JavaScriptValue.createBoolean(self, value: value)
	}

	/**
	 * Creates a value which contains an empty JavaScript object.
	 * @method createEmptyObject
	 * @since 0.1.0
	 */
	open func createEmptyObject() -> JavaScriptValue {
		return JavaScriptValue.createEmptyObject(self)
	}

	/**
	 * Creates a value which contains an empty JavaScript array.
	 * @method createEmptyArray
	 * @since 0.1.0
	 */
	open func createEmptyArray() -> JavaScriptValue {
		return JavaScriptValue.createEmptyArray(self)
	}

	/**
	 * Creates a value bound to a native function.
	 * @method createFunction
	 * @since 0.1.0
	 */
	open func createFunction(_ handler: @escaping JavaScriptFunctionHandler) -> JavaScriptValue {
		return JavaScriptValue.createFunction(self, handler: handler)
	}

	/**
	 * Creates a value bound to a native function.
	 * @method createFunction
	 * @since 0.1.0
	 */
	open func createFunction(_ name: String, _ handler: @escaping JavaScriptFunctionHandler) -> JavaScriptValue {
		return JavaScriptValue.createFunction(self, handler: handler, name: name)
	}

	/**
	 * Creates a value bound to an object template instance.
	 * @method createObject
	 * @since 0.1.0
	 */
	open func createObject(_ template: AnyClass) -> JavaScriptValue {
		return JavaScriptValue.createObject(self, template: template)
	}

	/**
	 * Creates an object using a registered identifier.
	 * @method createObject
	 * @since 0.1.0
	 */
	open func createObject<T>(_ identifier: String, values: JavaScriptArguments?, as type: T.Type, protect: Bool = false) -> T? {
		return (
			self.createObjectFromExports(identifier, values: values, as: type, protect: protect) ??
			self.createObjectFromClasses(identifier, values: values, as: type, protect: protect)
 		)
	}

	/**
	 * Creates a value bound to a class template.
	 * @method createClass
	 * @since 0.1.0
	 */
	open func createClass(_ template: AnyClass) -> JavaScriptValue {
		return JavaScriptValue.createClass(self, template: template)
	}

	/**
     * Creates an empty return value.
     * @method createReturnValue
     * @since 0.1.0
     */
	open func createReturnValue() -> JavaScriptValue {
		return self.createUndefined()
	}

	/**
	 * Evaluates JavaScript code.
	 * @method evaluate
	 * @since 0.1.0
	 */
	open func evaluate(_ code: String) {
		DLContextEvaluate(self.handle, code, "<none>")
	}

	/**
     * Evaluates JavaScript code with a file indicator.
     * @method evaluate
     * @since 0.1.0
     */
	open func evaluate(_ code: String, file: String) {
		DLContextEvaluate(self.handle, code, file)
	}

	/**
	 * Assigns an attribute on this context.
	 * @method attribute
	 * @since 0.1.0
	 */
	open func attribute(_ key: String, value: AnyObject) {
		DLContextSetAttribute(self.handle, toHash(key), UnsafeMutableRawPointer(Unmanaged.passRetained(value).toOpaque()))
	}

	/**
	 * Returns an attribute from this cibtext.
	 * @method attribute
	 * @since 0.1.0
	 */
	open func attribute(_ key: String) -> AnyObject? {

		let value = DLContextGetAttribute(self.handle, toHash(key))
		if (value == nil) {
			return nil
		}

		return Unmanaged<AnyObject>.fromOpaque(value!).takeUnretainedValue()
	}

	/**
	 * Deletes an attribute from this context.
	 * @method deleteAttribute
	 * @since 0.1.0
	 */
	open func deleteAttribute(_ key: String) {

		let value = DLContextGetAttribute(self.handle, toHash(key))
		if (value == nil) {
			return
		}

		Unmanaged<AnyObject>.fromOpaque(value!).release()

		DLContextDeleteAttribute(self.handle, toHash(key))
	}

	/**
	 * Assigns the context's exception handler.
	 * @method exception
	 * @since 0.1.0
	 */
	open func exception(handler: @escaping JavaScriptExceptionHandler) {
		DLContextSetExceptionHandler(self.handle, contextExceptionCallback)
		DLContextSetAttribute(self.handle, kExceptionWrapperKey, Unmanaged.passRetained(JavaScriptExceptionWrapper(context: self, handler: handler)).toOpaque())
	}

	/**
	 * Throws an error.
     * @method throwError
     * @since 0.1.0
     */
	open func throwError(_ error: JavaScriptValue) {
		self.global.callMethod("__throwError", arguments: [error])
	}

	/**
	 * Throws an error.
     * @method throwError
     * @since 0.1.0
     */
	open func throwError(string: String) {
		self.global.callMethod("__throwError", arguments: [self.createString(string)])
	}

	/**
	 * Requests a garbage collection.
     * @method garbageCollect
     * @since 0.1.0
     */
	open func garbageCollect() {
		JSGarbageCollect(self.handle)
	}

	//--------------------------------------------------------------------------
	// MARK: Extension
	//--------------------------------------------------------------------------

	/**
	 * Convenience property to return the application associated with a context.
     * @property application
     * @since 0.1.0
     */
	public lazy var application: DezelApplicationController = {
		return DezelApplicationController.from(self)
	}()

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
     * @method createObjectFromExports
     * @since 0.1.0
     * @hidden
     */
	private func createObjectFromExports<T>(_ ident: String, values: JavaScriptArguments?, as type: T.Type, protect: Bool = false) -> T? {

		guard let constructor = self.exports[ident] else {
			return nil
		}

		let result = self.createReturnValue()

		constructor.construct(values, result: result)

		let native = result.property("native").cast(type)
		if (native == nil) {
			print("Unable to cast object to type \(type), is it the right type ?")
			return nil
		}

		if (protect) {

			if let target = native as? JavaScriptValue {
				target.protect()
			}

			if let target = native as? JavaScriptObject {
				target.protect()
			}
		}

		return native
	}

	/**
     * @method createObjectFromClasses
     * @since 0.1.0
     * @hidden
     */
	private func createObjectFromClasses<T>(_ ident: String, values: JavaScriptArguments?, as type: T.Type, protect: Bool = false) -> T? {

		guard let constructor = self.classes[ident] else {
			return nil
		}

		let result = self.createReturnValue()

		constructor.construct(values, result: result)

		let native = result.property("native").cast(type)
		if (native == nil) {
			print("Unable to cast object to type \(type), is it the right type ?")
			return nil
		}

		if (protect) {

			if let target = native as? JavaScriptValue {
				target.protect()
			}

			if let target = native as? JavaScriptObject {
				target.protect()
			}
		}

		return native
	}
}

/**
 * The type alias for an exception handler callback.
 * @alias ExceptionHandler
 * @since 0.1.0
 */
public typealias JavaScriptExceptionHandler = (JavaScriptValue) -> (Void)

/**
 * @since 0.1.0
 * @hidden
 */
private let contextExceptionCallback: @convention(c) (JSContextRef?, JSValueRef?) -> Void = { context, error in

	let error = error!
	let context = context!

	let wrapper = Unmanaged<JavaScriptExceptionWrapper>.fromOpaque(
		DLContextGetAttribute(context, kExceptionWrapperKey)
	).takeUnretainedValue()

	wrapper.handler(JavaScriptValue.create(wrapper.context, handle: error))
}
