import XCTest
@testable import Jessie

class OperatorTests: XCTestCase {
    
    func testAssignString() {
        let json = Json(["Key1": "Value1"])
        let readValue: String = try! json <~ ["Key1"]
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testAssignDoubleString() {
        let json = Json(["Key1": ["Key2": "Value1"]])
        let readValue: String = try! json <~ ["Key1"] <~ ["Key2"]
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testAssignDoubleString2() {
        let json = Json(["Key1": ["Key2": "Value1"]])
        let readValue: String = try! json <~ ["Key1", "Key2"]
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testAssignDoubleInt() {
        let json = Json(["Key1": ["Key2": 1]])
        let readValue: Int = try! json <~ ["Key1"] <~ ["Key2"]
        XCTAssertEqual(readValue, 1)
    }
    
    func testAssignDoubleInt2() {
        let json = Json(["Key1": ["Key2": 1]])
        let readValue: Int = try! json <~ ["Key1", "Key2"]
        XCTAssertEqual(readValue, 1)
    }
    
}
