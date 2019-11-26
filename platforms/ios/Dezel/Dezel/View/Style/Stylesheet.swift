/**
 * @class Stylesheet
 * @since 0.7.0
 */
open class Stylesheet {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property delegate
	 * @since 0.7.0
	 */
	open weak var delegate: StylesheetDelegate?

	/**
	 * @property handle
	 * @since 0.7.0
	 * @hidden
	 */
	internal var handle: StylesheetRef

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public init() {
		self.handle = StylesheetCreate()
	}

	/**
	 * @destructor
	 * @since 0.7.0
	 */
	deinit {
		StylesheetDelete(self.handle)
	}

	/**
	 * @method setVariable
	 * @since 0.7.0
	 */
	public func setVariable(_ name: String, value: String) {

		var error: UnsafeMutablePointer<ParseError>?

		StylesheetSetVariable(self.handle, name, value, &error)

		if let error = error {
			self.delegate?.didThrowError(
				stylesheet: self,
				error: error.pointee.message.string,
				col: Int(error.pointee.col),
				row: Int(error.pointee.row),
				url: error.pointee.url.string
			)
		}
	}

	/**
	 * @method evaluate
	 * @since 0.7.0
	 */
	public func evaluate(_ source: String, url: String) {

		var error: UnsafeMutablePointer<ParseError>?

		StylesheetEvaluate(self.handle, source, url, &error)

		if let error = error {
			self.delegate?.didThrowError(
				stylesheet: self,
				error: error.pointee.message.string,
				col: Int(error.pointee.col),
				row: Int(error.pointee.row),
				url: error.pointee.url.string
			)
		}
	}
}
