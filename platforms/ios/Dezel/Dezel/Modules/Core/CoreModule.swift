/**
 * @class CoreModule
 * @since 0.7.0
 * @hidden
 */
open class CoreModule: Module {

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @inherited
	 * @method initialize
	 * @since 0.1.0
	 */
	override open func initialize() {
print("INIT CORE MODULE")
		/**
		 * Imports a registered class.
		 * @since 0.7.0
		 */
		let importClass = self.context.createFunction { callback in

			if (callback.arguments < 1) {
				return
			}

			let uid = callback.argument(0).string
			if (uid == "") {
				return
			}

			if let value = self.context.classes[uid] {
				callback.returns(value)
			}
		}

		let importObject = self.context.createFunction { callback in

			if (callback.arguments < 1) {
				return
			}

			let uid = callback.argument(0).string
			if (uid == "") {
				return
			}

			if let value = self.context.objects[uid] {
				callback.returns(value)
			}
		}

		/**
		 * Evaluates a local or remote file.
		 * @since 0.7.0
		 */
		let evaluateFile = self.context.createFunction { callback in
			// TODO
		}

		/**
		 * Evaluates code.
		 * @since 0.7.0
		 */
		let evaluateScript = self.context.createFunction { callback in
			// TODO
		}

		/**
		 * Registers the main application.
		 * @since 0.7.0
		 */
		let registerApplication = self.context.createFunction { callback in

			if (callback.arguments < 2) {
				return
			}

			let uid = callback.argument(0).string
			let app = callback.argument(1)

			if let application = app.cast(Application.self) {
				self.context.application.launch(application, identifier: uid)
			}
		}
print("DEFINE CORE STUFF")
		self.context.global.defineProperty("importClass", value: importClass, getter: nil, setter: nil, writable: false, enumerable: false, configurable: false)
		self.context.global.defineProperty("importObject", value: importObject, getter: nil, setter: nil, writable: false, enumerable: false, configurable: false)
		self.context.global.defineProperty("evaluateFile", value: evaluateFile, getter: nil, setter: nil, writable: false, enumerable: false, configurable: false)
		self.context.global.defineProperty("evaluateScript", value: evaluateScript, getter: nil, setter: nil, writable: false, enumerable: false, configurable: false)
		self.context.global.defineProperty("registerApplication", value: registerApplication, getter: nil, setter: nil, writable: false, enumerable: false, configurable: false)
	}
}
