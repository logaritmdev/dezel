package ca.logaritm.dezel.test

import ca.logaritm.dezel.application.ApplicationActivity
import ca.logaritm.dezel.core.JavaScriptContext
import ca.logaritm.dezel.core.getResource

open class TestRunner: ApplicationActivity() {

	//--------------------------------------------------------------------------
	// Properties
	//--------------------------------------------------------------------------

	/**
	 * The test runner host.
	 * @property host
	 * @since 0.7.0
	 */
	public lateinit var host: String
		private set

	/**
	 * The test runner port.
	 * @property port
	 * @since 0.7.0
	 */
	public lateinit var port: String
		private set

	//--------------------------------------------------------------------------
	// Methods
	//--------------------------------------------------------------------------

	/**
	 * Runs the tests using the specified server.
	 * @method start
	 * @since 0.7.0
	 */
	open fun start(host: String, port: String) {

		this.host = host
		this.port = port

		this.setup()
	}

	/**
	 * @inherited
	 * @method configure
	 * @since 0.7.0
	 */
	override fun configure() {
		this.context.global.property("KARMA_HOST", this.host)
		this.context.global.property("KARMA_PORT", this.port)
	}

	/**
	 * @inherited
	 * @method configure
	 * @since 0.7.0
	 */
	override fun onLoad() {
		this.context.evaluate(JavaScriptContext::class.getResource("res/raw/test_runner.js").reader().use { it.readText() }, "test_runner.js")
	}
}