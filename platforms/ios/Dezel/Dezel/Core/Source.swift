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
	public enum Category {
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
	private(set) public var category: Category

	/**
	 * The source's location.
	 * @property location
	 * @since 0.7.0
	 */
	private(set) public var location: String

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
	public init(location: String, category: Category) {
		self.location = location
		self.category = category
	}

	/**
	 * @method read
	 * @since 0.7.0
	 * @hidden
	 */
	private func read() -> String{

		do {

			if (self.location.hasPrefix("http://") ||
				self.location.hasPrefix("https://")) {
				return try String(contentsOf: URL(string: self.location)!)
			}

			return try String(contentsOfFile: Bundle.main.path(forResource: "app/" + self.location, ofType: nil)!)

		} catch _ {
			fatalError("Cannot load source at location \(self.location).")
		}
	}
}
