import Foundation

/**
 * A context source file.
 * @class Source
 * @since 0.7.0
 */
open class Source {

	//--------------------------------------------------------------------------
	// MARK: Enum
	//--------------------------------------------------------------------------

	/**
	 * Source categories.
	 * @enum Category
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
	 * The source's category.
	 * @property category
	 * @since 0.7.0
	 */
	private(set) public var type: Type

	/**
	 * The source's location.
	 * @property location
	 * @since 0.7.0
	 */
	private(set) public var path: String

	/**
	 * The source's data.
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
	 * @hidden
	 */
	public init(type: Type, path: String) {
		self.type = type
		self.path = path
	}

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
