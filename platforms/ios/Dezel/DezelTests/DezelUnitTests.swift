import XCTest
import Dezel

class DezelUnitTests: XCTestCase {

	private var runner: TestRunner!

	override func setUp() {
		self.runner = TestRunner()
	}

    func testAPI() {
     	let expectation = XCTestExpectation(description: "Tests should pass")
		self.runner.start(host: "192.168.2.115", port: "9876")
		wait(for: [expectation], timeout: 3600.0)
    }
}
