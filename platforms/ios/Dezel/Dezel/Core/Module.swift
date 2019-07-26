/**
 * The base class for context modules.
 * @class Module
 * @since 0.1.0
 */
open class Module : NSObject {

	//--------------------------------------------------------------------------
	// MARK: Static
	//--------------------------------------------------------------------------

	/**
	 * @method create
	 * @since 0.1.0
	 * @hidden
	 */
	internal static func create(_ module: AnyClass, context: JavaScriptContext) -> Module {
		return (module as! Module.Type).init(context: context)
	}

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The module context.
	 * @var context
	 * @since 0.1.0
	 */
	public var context: JavaScriptContext

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @constructor
	 * @since 0.1.0
	 * @hidden
	 */
	public required init(context: JavaScriptContext) {
		self.context = context
		super.init()
	}

	/**
	 * Initializes the module.
	 * @method initialize
	 * @since 0.1.0
	 */
	open func initialize() {

	}

	/**
	 * Disposes the module.
	 * @method dispose
	 * @since 0.1.0
	 */
	open func dispose() {

	}
}
