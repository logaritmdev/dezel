/**
 * A JavaScript execution environment.
 * @class JavaScriptContext
 * @since 0.1.0
 */
open class JavaScriptContext: NSObject {

	//--------------------------------------------------------------------------
	// MARK: Constants
	//--------------------------------------------------------------------------

	/**
	 * The null JavaScript value.
	 * @const jsnull
	 * @since 0.7.0
	 */
	private(set) public lazy var jsnull: JavaScriptValue = {
		return JavaScriptNull(context: self)
	}()

	/**
	 * The undefined JavaScript value.
	 * @const jsundefined
	 * @since 0.7.0
	 */
	private(set) public lazy var jsundefined: JavaScriptValue = {
		return JavaScriptUndefined(context: self)
	}()

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
     * The context's registered globals.
     * @property globals
     * @since 0.7.0
     */
	internal(set) public var globals: [String: JavaScriptValue] = [:]

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
		self.global.defineProperty("global", value: self.global, getter: nil, setter: nil, writable: false, enumerable: false, configurable: false)
		self.global.defineProperty("window", value: self.global, getter: nil, setter: nil, writable: false, enumerable: false, configurable: false)
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
	 * Register multiple modules.
	 * @method registerModules
	 * @since 0.7.0
	 */
	open func registerModules(_ modules: [String: AnyClass]) {
		modules.forEach {
			self.registerModule($0.key, with: $0.value)
		}
	}

	/**
	 * Register multiple objects.
	 * @method registerObjects
	 * @since 0.7.0
	 */
	open func registerObjects(_ objects: [String: AnyClass]) {
		objects.forEach {
			self.registerObject($0.key, with: $0.value)
		}
	}

	/**
	 * Register multiple classes.
	 * @method registerClasses
	 * @since 0.7.0
	 */
	open func registerClasses(_ classes: [String: AnyClass]) {
		classes.forEach {
			self.registerClass($0.key, with: $0.value)
		}
	}

	/**
     * Registers a context module.
     * @method registerModule
     * @since 0.1.0
     */
	open func registerModule(_ uid: String, with value: AnyClass) {
		self.modules[uid] = Module.create(value, context: self)
	}

	/**
	 * Registers a context object.
	 * @method registerObject
	 * @since 0.1.0
	 */
	open func registerObject(_ uid: String, with value: AnyClass) {
		self.objects[uid] = self.createObject(value)
	}

	/**
	 * Registers a context class.
	 * @method registerClass
	 * @since 0.1.0
	 */
	open func registerClass(_ uid: String, with value: AnyClass) {
		self.classes[uid] = self.createClass(value)
	}

	/**
     * Loads the context dependencies.
     * @method setup
     * @since 0.7.0
     */
	open func setup() {

		if (self.running) {
			return
		}

		self.running = true

		self.modules.forEach {
			$0.value.initialize()
		}
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
	open func attribute(_ key: AnyObject, value: AnyObject?) {
		let hash = toHash(key)
		DLContextGetAttribute(self.handle, hash)?.release()
		DLContextSetAttribute(self.handle, hash, toRetainedOpaque(value))
	}

	/**
	 * Returns an attribute from this cibtext.
	 * @method attribute
	 * @since 0.1.0
	 */
	open func attribute(_ key: AnyObject) -> AnyObject? {
		return toUnretainedObject(DLContextGetAttribute(self.handle, toHash(key)))
	}

	/**
	 * Assigns the context's exception handler.
	 * @method handleError
	 * @since 0.6.0
	 */
	open func handleError(handler: @escaping JavaScriptExceptionHandler) {
		DLContextSetExceptionHandler(self.handle, JavaScriptContextExceptionCallback)
		DLContextSetAttribute(self.handle, kExceptionWrapperKey, Unmanaged.passRetained(JavaScriptExceptionWrapper(context: self, handler: handler)).toOpaque())
	}

	/**
	 * Requests a garbage collection.
     * @method garbageCollect
     * @since 0.1.0
     */
	open func garbageCollect() {
		JSGarbageCollect(self.handle)
	}
}


/**
 * The type alias for an exception handler callback.
 * @alias ExceptionHandler
 * @since 0.1.0
 */
public typealias JavaScriptExceptionHandler = (JavaScriptValue) -> (Void)

/**
 * @extension JavaScriptContext
 * @since 0.7.0
 * @hidden
 */
public extension JavaScriptContext {

	/**
	 * @property application
	 * @since 0.7.0
	 * @hidden
	 */
	var application: ApplicationController {
		return self.attribute(kApplicationControllerKey) as! ApplicationController
	}

	/**
	 * @method createObject
	 * @since 0.7.0
	 * @hidden
	 */
	func createObject(_ dictionary: [String: String]) -> JavaScriptValue {

		let result = self.createEmptyObject()

		for (key, val) in dictionary {
			result.property(key, value: self.createString(val))
		}

		return result
	}

	/**
	 * @method createObject
	 * @since 0.7.0
	 * @hidden
	 */
	func createObject(_ dictionary: [String: Double]) -> JavaScriptValue {

		let result = self.createEmptyObject()

		for (key, val) in dictionary {
			result.property(key, value: self.createNumber(val))
		}

		return result
	}

	/**
	 * @method createString
	 * @since 0.7.0
	 * @hidden
	 */
	func createString(_ url: URL) -> JavaScriptValue {
		return self.createString(url.absoluteString)
	}
}



/**
 * @since 0.1.0
 * @hidden
 */
private let JavaScriptContextExceptionCallback: @convention(c) (JSContextRef?, JSValueRef?) -> Void = { context, error in

	let error = error!
	let context = context!

	let wrapper = Unmanaged<JavaScriptExceptionWrapper>.fromOpaque(
		DLContextGetAttribute(context, kExceptionWrapperKey)
	).takeUnretainedValue()

	wrapper.handler(JavaScriptValue.create(wrapper.context, handle: error))
}
