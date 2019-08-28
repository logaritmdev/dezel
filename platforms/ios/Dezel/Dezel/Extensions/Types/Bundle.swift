/**
 * @extension Bundle
 * @since 0.1.0
 * @hidden
 */
internal extension Bundle {

	/**
	 * @method resource
	 * @since 0.1.0
	 * @hidden
	 */
	static func resource(_ string: String, bundle: String = "ca.logaritm.Dezel") -> String? {
		return Bundle(identifier: bundle)?.path(forResource: string, ofType: "")
	}

	/**
	 * @method resource
	 * @since 0.1.0
	 * @hidden
	 */
	func path(in directory: String) -> String? {

		guard let root = Bundle.main.resourcePath else {
			return nil
		}

		var path = directory
		if (path.hasSuffix("/") == false) {
			path.append("/")
		}

		return root + "/" + path
	}

	/**
	 * @method getFile
	 * @since 0.5.0
	 * @hidden
	 */
	func getFile(in directory: String, named file: String) -> String? {

		guard let root = self.path(in: directory) else {
			return nil
		}

		let path = root + file

		return FileManager.default.fileExists(atPath: path) ? path : nil
	}

	/**
	 * @method getFile
	 * @since 0.5.0
	 * @hidden
	 */
	func getFile(in directory: String, match regex: String) -> String? {

		guard let root = self.path(in: directory) else {
			return nil
		}

		for file in self.getFiles(in: directory) where file.match(regex) {
			return root + file
		}

		return nil
	}

	/**
	 * @method getFiles
	 * @since 0.5.0
	 * @hidden
	 */
	func getFiles(in directory: String) -> [String] {

		guard let path = self.path(in: directory) else {
			return []
		}

		do {
			return try FileManager.default.contentsOfDirectory(atPath: path)
		} catch {
			return []
		}
	}
}
