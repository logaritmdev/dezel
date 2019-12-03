import Foundation

/**
 * @class Source
 * @since 0.7.0
 */
open class Source {

	//--------------------------------------------------------------------------
	// MARK: Enum
	//--------------------------------------------------------------------------

	/**
	 * @enum Type
	 * @since 0.7.0
	 */
	public enum `Type` {
		case style
		case script
	}

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * @property type
	 * @since 0.7.0
	 */
	private(set) public var type: Type

	/**
	 * @property path
	 * @since 0.7.0
	 */
	private(set) public var path: String

	/**
	 * @property data
	 * @since 0.7.0
	 */
	public lazy var data: String = {
		return self.read()
	}()

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.7.0
	 */
	public init(type: Type, path: String) {
		self.type = type
		self.path = path
	}

	//--------------------------------------------------------------------------
	// MARK: Private API
	//--------------------------------------------------------------------------

	/**
	 * @method read
	 * @since 0.7.0
	 * @hidden
	 */
	private func read() -> String{

		do {

			if (self.path.hasPrefix("http://") ||
				self.path.hasPrefix("https://")) {
				return try String(contentsOf: URL(string: self.path)!)
			}

			return try String(contentsOfFile: Bundle.main.path(forResource: self.path, ofType: nil)!)

		} catch _ {
			fatalError("Cannot load source at location \(self.path).")
		}
	}
}
