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

		self.context.registerClass("dezel.web.XMLHttpRequest", value: XMLHttpRequest.self)
		self.context.registerClass("dezel.web.XMLHttpRequestUpload", value: XMLHttpRequestUpload.self)
		self.context.registerClass("dezel.web.WebSocket", value: WebSocket.self)
		self.context.registerClass("dezel.web.WebGlobal", value: WebGlobal.self)

		self.context.global.defineProperty(
			"localStorage",
			value: self.context.createObject(LocalStorage.self), // TODO, create a JS local storage (dezel.storage.Storage)
			getter: nil,
			setter: nil,
			writable: false,
			enumerable: false,
			configurable: true
		)


	}
}
