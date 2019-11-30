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
	 * @property host
	 * @since 0.7.0
	 */
	private(set) public var host: String!

	/**
	 * @property port
	 * @since 0.7.0
	 */
	private(set) public var port: String!

	//--------------------------------------------------------------------------
	// MARK: Methods
	//--------------------------------------------------------------------------

	/**
	 * @method start
	 * @since 0.7.0
	 */
	open func start(host: String, port: String) {

		self.host = host
		self.port = port

		self.view.isOpaque = true // also call viewDidLoad

		self.context.global.property("KARMA_HOST", string: self.host)
		self.context.global.property("KARMA_PORT", string: self.port)

		do {
			self.context.evaluate(try String(contentsOfFile: Bundle.resource("TestRunner.js")!), url: "TestRunner.js")
		} catch {
			fatalError()
		}
	}
}
