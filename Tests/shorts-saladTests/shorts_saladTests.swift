import XCTest
@testable import shorts_salad

class shorts_saladTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(shorts_salad().text, "Hello, World!")
    }


    static var allTests : [(String, (shorts_saladTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
