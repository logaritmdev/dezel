/**
 * @class CoreModule
 * @since 0.7.0
 * @hidden
 */
open class CoreModule: Module {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property importClass
	 * @since 0.7.0
	 * @hidden
	 */
	private lazy var importClass = self.context.createFunction { callback in
		if let result = self.context.classes[callback.argument(0).string] {
			callback.returns(result)
		}
	}

	/**
	 * @property importObject
	 * @since 0.7.0
	 * @hidden
	 */
	private lazy var importObject = self.context.createFunction { callback in
		if let result = self.context.objects[callback.argument(0).string] {
			callback.returns(result)
		}
	}

	/**
	 * @property registerApplication
	 * @since 0.7.0
	 * @hidden
	 */
	private lazy var registerApplication = self.context.createFunction { callback in

		let app = callback.argument(0)
		let uid = callback.argument(1).string

		if let application = app.cast(Application.self) {
			self.context.application.launch(application, identifier: uid)
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.7.0
	 */
	override open func initialize() {
		self.context.global.defineProperty("importClass", value: self.importClass)
		self.context.global.defineProperty("importObject", value: self.importObject)
		self.context.global.defineProperty("registerApplication", value: self.registerApplication)
	}
}
