/**
 * @class WebModule
 * @since 0.1.0
 * @hidden
 */
open class WebModule : Module {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

    /**
     * @inherited
     * @method initialize
     * @since 0.1.0
     */
	override open func initialize() {

		self.context.registerClass("dezel.web.XMLHttpRequest", type: XMLHttpRequest.self)
		self.context.registerClass("dezel.web.XMLHttpRequestUpload", type: XMLHttpRequestUpload.self)
		self.context.registerClass("dezel.web.WebSocket", type: WebSocket.self)
		self.context.registerClass("dezel.web.WebGlobal", type: WebGlobal.self)

		self.context.global.defineProperty(
			"localStorage",
			value: self.context.createObject(LocalStorage.self), // TODO, create a JS local storage (dezel.storage.Storage)
			getter: nil,
			setter: nil,
			writable: false,
			enumerable: false,
			configurable: true
		)

		do {
			self.context.evaluate(try String(contentsOfFile: Bundle.resource("WebRuntime.js")!), file: "WebRuntime.js")
		} catch _ {
			fatalError("Cannot load the web runtime, the path is invalid.")
		}
	}
}
