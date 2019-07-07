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

		let importClass = self.context.createFunction { callback in

			if (callback.arguments < 1) {
				callback.returns(nil)
				return
			}

			let identifier = callback.argument(0).string

			if let value = self.context.classes[identifier] {
				callback.returns(value)
				return
			}
		}

		let evaluateFile = self.context.createFunction { callback in

			if (callback.arguments < 1) {
				return
			}

			let src = callback.argument(0).string

			do {

				if (src.hasPrefix("http://") ||
					src.hasPrefix("https://")) {
					self.context.evaluate(try String(contentsOf: URL(string: src)!), file: src)
					return
				}

				self.context.evaluate(try String(contentsOfFile: Bundle.main.path(forResource: "app/" + src, ofType: nil)!), file: src)

			} catch _ {
				NSLog("Cannot evaluate file at \(src), the file does not exists.")
			}
		}

		let evaluateScript = self.context.createFunction { callback in

			if (callback.arguments < 1) {
				callback.returns(nil)
				return
			}

			self.context.evaluate(callback.argument(0).string)
		}

		self.context.global.defineProperty("importClass", value: importClass, getter: nil, setter: nil, writable: false, enumerable: false, configurable: false)
		self.context.global.defineProperty("evaluateFile", value: evaluateFile, getter: nil, setter: nil, writable: false, enumerable: false, configurable: false)
		self.context.global.defineProperty("evaluateScript", value: evaluateScript, getter: nil, setter: nil, writable: false, enumerable: false, configurable: false)
	}
}
