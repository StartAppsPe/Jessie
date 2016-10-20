import XCTest
@testable import Jessie

class OtherTests: XCTestCase {
    
    func testReadJsonFromJson() {
        let json = Json(["Key1": "Value1"])
        let json2 = json.toJson()
        let readValue = try? json2["Key1"].toString()
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testDescription() {
        let json = Json(["key":"value"])
        let description = json.description
        XCTAssertEqual(description, "{\n  \"key\": \"value\"\n}")
    }
    
}
