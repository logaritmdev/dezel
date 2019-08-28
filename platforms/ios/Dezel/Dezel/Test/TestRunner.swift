import Foundation

/**
 * @class TestRunner
 * @since 0.7.0
 * @hidden
 */
open class TestRunner: ApplicationController {

	//--------------------------------------------------------------------------
	// MARK: Properties
	//--------------------------------------------------------------------------

	/**
	 * The test runner host.
	 * @property host
	 * @since 0.7.0
	 */
	private(set) public var host: String!

	/**
	 * The test runner port.
	 * @property port
	 * @since 0.7.0
	 */
	private(set) public var port: String!

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * Runs the tests using the specified server.
	 * @method start
	 * @since 0.7.0
	 */
	open func start(host: String, port: String) {
		self.host = host
		self.port = port
		self.setup()
	}

	/**
	 * @inherited
	 * @method configure
	 * @since 0.7.0
	 */
	override open func configure() {
		self.context.global.property("KARMA_HOST", string: self.host)
		self.context.global.property("KARMA_PORT", string: self.port)
	}

	/**
	 * @inherited
	 * @method didLoad
	 * @since 0.7.0
	 */
	override open func didLoad() {
		do {
			self.context.evaluate(try String(contentsOfFile: Bundle.resource("TestRunner.js")!), file: "TestRunner.js")
		} catch {
			fatalError()
		}
	}
}
