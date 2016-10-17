import XCTest
@testable import Jessie

class OtherTests: XCTestCase {
    
    func testReadJsonFromJson() {
        let json = try! Json(["Key1": "Value1"])
        let json2 = try! json.toJson()
        let readValue = try? json2["Key1"].toString()
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testReadJsonFromJson2() {
        let json = try! Json(["Key1": "Value1"])
        let json2 = json.json
        let readValue = try? json2["Key1"].toString()
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testDescription() {
        let json = try! Json(["key":"value"])
        let description = json.description
        XCTAssertEqual(description, "{\n  \"key\" : \"value\"\n}")
    }
    
}
