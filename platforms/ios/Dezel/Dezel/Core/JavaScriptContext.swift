/**
 * @class JavaScriptContext
 * @since 0.1.0
 */
open class JavaScriptContext {

	//--------------------------------------------------------------------------
	// MARK: Constants
	//--------------------------------------------------------------------------

	/**
	 * @const Null
	 * @since 0.7.0
	 */
	private(set) public lazy var Null: JavaScriptValue = {
		return self.createNull()
	}()

	/**
	 * @const Undefined
	 * @since 0.7.0
	 */
	private(set) public lazy var Undefined: JavaScriptValue = {
		return self.createUndefined()
	}()

	/**
	 * @const True
	 * @since 0.7.0
	 */
	private(set) public lazy var True: JavaScriptValue = {
		return self.createBoolean(true)
	}()

	/**
	 * @const False
	 * @since 0.7.0
	 */
	private(set) public lazy var False: JavaScriptValue = {
		return self.createBoolean(false)
	}()

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
     * @property handle
     * @since 0.1.0
     */
	private(set) public var handle: JSContextRef!

	/**
     * @property global
     * @since 0.1.0
     */
	private(set) public var global: JavaScriptValue!

	/**
     * @property classes
     * @since 0.1.0
     */
	internal(set) public var classes: [String: JavaScriptValue] = [:]

	/**
     * @property objects
     * @since 0.1.0
     */
	internal(set) public var objects: [String: JavaScriptValue] = [:]

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
     * @constructor
     * @since 0.1.0
     */
	public init() {

		self.handle = JavaScriptContextCreate(Bundle.main.bundleIdentifier ?? "Dezel Context")

		self.global = JavaScriptValue.create(self, handle: JavaScriptContextGetGlobalObject(self.handle))
		self.global.defineProperty("global", value: self.global, getter: nil, setter: nil, writable: false, enumerable: false, configurable: false)
		self.global.defineProperty("window", value: self.global, getter: nil, setter: nil, writable: false, enumerable: false, configurable: false)
	}

	/**
	 * @destructor
     * @since 0.1.0
     */
	deinit {
		self.dispose()
	}

	/**
	 * @method registerClasses
	 * @since 0.7.0
	 */
	open func registerClasses(_ classes: [String: AnyClass]) {
		classes.forEach {
			self.registerClass($0.key, with: $0.value)
		}
	}

	/**
	 * @method registerObjects
	 * @since 0.7.0
	 */
	open func registerObjects(_ objects: [String: AnyClass]) {
		objects.forEach {
			self.registerObject($0.key, with: $0.value)
		}
	}

	/**
	 * @method registerClass
	 * @since 0.1.0
	 */
	open func registerClass(_ uid: String, with value: AnyClass) {
		self.classes[uid] = self.createClass(value)
	}

	/**
	 * @method registerObject
	 * @since 0.1.0
	 */
	open func registerObject(_ uid: String, with value: AnyClass) {
		self.objects[uid] = self.createObject(value)
	}

	/**
     * @method dispose
     * @since 0.1.0
     */
	open func dispose() {

		self.objects.removeAll()
		self.classes.removeAll()
		self.global.dispose()

		self.garbageCollect()

		JavaScriptContextDelete(self.handle)
	}

	/**
	 * @method createNull
	 * @since 0.1.0
	 */
	open func createNull() -> JavaScriptValue {
		return JavaScriptValue.createNull(self)
	}

	/**
	 * @method createUndefined
	 * @since 0.1.0
	 */
	open func createUndefined() -> JavaScriptValue {
		return JavaScriptValue.createUndefined(self)
	}

	/**
	 * @method createString
	 * @since 0.1.0
	 */
	open func createString(_ value: String) -> JavaScriptValue {
		return JavaScriptValue.createString(self, value: value)
	}

	/**
	 * @method createNumber
	 * @since 0.1.0
	 */
	open func createNumber(_ value: Double) -> JavaScriptValue {
		return JavaScriptValue.createNumber(self, value: value)
	}

	/**
	 * @method createNumber
	 * @since 0.3.0
	 */
	open func createNumber(_ value: Float) -> JavaScriptValue {
		return JavaScriptValue.createNumber(self, value: Double(value))
	}

	/**
	 * @method createNumber
	 * @since 0.3.0
	 */
	open func createNumber(_ value: Int) -> JavaScriptValue {
		return JavaScriptValue.createNumber(self, value: Double(value))
	}

	/**
	 * @method createNumber
	 * @since 0.3.0
	 */
	open func createNumber(_ value: CGFloat) -> JavaScriptValue {
		return JavaScriptValue.createNumber(self, value: Double(value))
	}

	/**
	 * @method createBoolean
	 * @since 0.1.0
	 */
	open func createBoolean(_ value: Bool) -> JavaScriptValue {
		return JavaScriptValue.createBoolean(self, value: value)
	}

	/**
	 * @method createEmptyObject
	 * @since 0.1.0
	 */
	open func createEmptyObject() -> JavaScriptValue {
		return JavaScriptValue.createEmptyObject(self)
	}

	/**
	 * @method createEmptyArray
	 * @since 0.1.0
	 */
	open func createEmptyArray() -> JavaScriptValue {
		return JavaScriptValue.createEmptyArray(self)
	}

	/**
	 * @method createFunction
	 * @since 0.1.0
	 */
	open func createFunction(_ handler: @escaping JavaScriptFunctionHandler) -> JavaScriptValue {
		return JavaScriptValue.createFunction(self, handler: handler)
	}

	/**
	 * @method createFunction
	 * @since 0.1.0
	 */
	open func createFunction(_ name: String, _ handler: @escaping JavaScriptFunctionHandler) -> JavaScriptValue {
		return JavaScriptValue.createFunction(self, handler: handler, name: name)
	}

	/**
	 * @method createObject
	 * @since 0.1.0
	 */
	open func createObject(_ template: AnyClass) -> JavaScriptValue {
		return JavaScriptValue.createObject(self, template: template)
	}

	/**
	 * @method createClass
	 * @since 0.1.0
	 */
	open func createClass(_ template: AnyClass) -> JavaScriptValue {
		return JavaScriptValue.createClass(self, template: template)
	}

	/**
     * @method createReturnValue
     * @since 0.1.0
     */
	open func createReturnValue() -> JavaScriptValue {
		return self.createUndefined()
	}

	/**
	 * @method evaluate
	 * @since 0.1.0
	 */
	open func evaluate(_ source: String) {
		JavaScriptContextEvaluate(self.handle, source, "<none>")
	}

	/**
     * @method evaluate
     * @since 0.1.0
     */
	open func evaluate(_ source: String, url: String) {
		JavaScriptContextEvaluate(self.handle, source, url)
	}

	/**
	 * @method attribute
	 * @since 0.1.0
	 */
	open func attribute(_ key: AnyObject, value: AnyObject?) {
		let hash = toHash(key)
		JavaScriptContextGetAttribute(self.handle, hash)?.release()
		JavaScriptContextSetAttribute(self.handle, hash, toRetainedOpaque(value))
	}

	/**
	 * @method attribute
	 * @since 0.1.0
	 */
	open func attribute(_ key: AnyObject) -> AnyObject? {
		return toUnretainedObject(JavaScriptContextGetAttribute(self.handle, toHash(key)))
	}

	/**
	 * @method handleError
	 * @since 0.6.0
	 */
	open func handleError(handler: @escaping JavaScriptExceptionHandler) {
		JavaScriptContextSetExceptionHandler(self.handle, javaScriptContextExceptionCallback)
		JavaScriptContextSetAttribute(self.handle, kExceptionWrapperKey, Unmanaged.passRetained(JavaScriptExceptionWrapper(context: self, handler: handler)).toOpaque())
	}

	/**
     * @method garbageCollect
     * @since 0.1.0
     */
	open func garbageCollect() {
		JSGarbageCollect(self.handle)
	}
}

/**
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
	 * @property controller
	 * @since 0.7.0
	 * @hidden
	 */
	var controller: ApplicationController {
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
 * @function javaScriptContextExceptionCallback
 * @since 0.1.0
 * @hidden
 */
private let javaScriptContextExceptionCallback: @convention(c) (JSContextRef?, JSValueRef?) -> Void = { context, error in

	let error = error!
	let context = context!

	let wrapper = Unmanaged<JavaScriptExceptionWrapper>.fromOpaque(
		JavaScriptContextGetAttribute(context, kExceptionWrapperKey)
	).takeUnretainedValue()

	wrapper.handler(JavaScriptValue.create(wrapper.context, handle: error))
}
