/**
 * Translation file locator and loader.
 * @class TranslationFile
 * @since 0.5.0
 */
open class TranslationFile {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * Whether the translation file has been loaded.
	 * @property loaded
	 * @since 0.5.0
	 */
	private(set) public var loaded: Bool = false

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * Finds a translation file for the specified language and country.
	 * @constructor
	 * @since 0.5.0
	 */
	public init() {

		let lan = Locale.current.language
		let reg = Locale.current.region

		if (lan == "" ||
			reg == "") {
			return
		}

		if let path = self.getFile(named: "\(lan)_\(reg).mo") {
			self.load(path)
			return
		}

		if let path = self.getFile(match: "^\(lan)_[a-zA-Z]+\\.mo$") {
			self.load(path)
			return
		}
	}

	/**
	 * Finds a translation file with the specified path.
	 * @constructor
	 * @since 0.5.0
	 */
	public init(file: String) {
		if let path = self.getFile(named: file) {
			self.load(path)
		}
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
     * @method load
     * @since 0.5.0
     * @hidden
     */
	private func load(_ path: String) {

		do {

			var data = try Data(contentsOf: URL(fileURLWithPath: path))

			data.withUnsafeMutableBytes {
				DLTranslationManagerLoad($0)
			}

			self.loaded = true

		} catch {
			NSLog("Unable to load translation file \(path)")
		}
	}

	/**
	 * @method getFile
	 * @since 0.5.0
	 * @hidden
	 */
	private func getFile(named file: String) -> String? {
		return Bundle.main.getFile(in: "app/languages", named: file)
	}

	/**
	 * @method getFile
	 * @since 0.5.0
	 * @hidden
	 */
	private func getFile(match regex: String) -> String? {
		return Bundle.main.getFile(in: "app/languages", match: regex)
	}
}
