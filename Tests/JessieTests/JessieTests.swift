import XCTest
@testable import Jessie

class JessieTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(Jessie().text, "Hello, World!")
    }


    static var allTests : [(String, (JessieTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
