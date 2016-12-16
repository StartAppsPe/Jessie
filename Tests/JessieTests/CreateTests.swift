import XCTest
@testable import Jessie

class CreateTests: XCTestCase {
    
    func testCreateWithNull() {
        let json = Json()
        let jsonString = json.rawString(pretty: false)
        XCTAssertEqual(jsonString, "null")
    }
    
    func testCreateWithEmptyArray() {
        let json = Json([])
        let jsonString = json.rawString(pretty: false)
        XCTAssertEqual(jsonString, "[]")
    }
    
    func testCreateWithArray() {
        let json = Json(["value1","value2"])
        let jsonString = json.rawString(pretty: false)
        XCTAssertEqual(jsonString, "[\"value1\",\"value2\"]")
    }
    
    func testCreateWithEmptyDictionary() {
        let json = Json([:])
        let jsonString = json.rawString(pretty: false)
        XCTAssertEqual(jsonString, "{}")
    }
    
    func testCreateWithDictionary() {
        let json = Json(["key":"value"])
        let jsonString = json.rawString(pretty: false)
        XCTAssertEqual(jsonString, "{\"key\":\"value\"}")
    }
    
    func testCreateWithEmptyString() {
        let json = Json("")
        let jsonString = json.rawString(pretty: false)
        XCTAssertEqual(jsonString, "\"\"")
    }
    
    func testCreateWithString() {
        let json = Json("Value")
        let jsonString = json.rawString(pretty: false)
        XCTAssertEqual(jsonString, "\"Value\"")
    }
    
    func testCreateWithZeroInt() {
        let json = Json(0)
        let jsonString = json.rawString(pretty: false)
        XCTAssertEqual(jsonString, "0")
    }
    
    func testCreateWithInt() {
        let json = Json(1)
        let jsonString = json.rawString(pretty: false)
        XCTAssertEqual(jsonString, "1")
    }
    
    func testCreateWithInt2() {
        let json = Json(-1)
        let jsonString = json.rawString(pretty: false)
        XCTAssertEqual(jsonString, "-1")
    }
    
    func testCreateWithZeroDouble() {
        let json = Json(0.0)
        let jsonString = json.rawString(pretty: false)
        XCTAssertEqual(jsonString, "0")
    }
    
    func testCreateWithDouble() {
        let json = Json(1.0)
        let jsonString = json.rawString(pretty: false)
        XCTAssertEqual(jsonString, "1")
    }
    
    func testCreateWithZeroDouble2() {
        let json = Json(1.1)
        let jsonString = json.rawString(pretty: false)
        XCTAssertEqual(jsonString, "1.1")
    }
    
    func testCreateWithBool() {
        let json = Json(true)
        let jsonString = json.rawString(pretty: false)
        XCTAssertEqual(jsonString, "true")
    }
    
    func testCreateWithBool2() {
        let json = Json(false)
        let jsonString = json.rawString(pretty: false)
        XCTAssertEqual(jsonString, "false")
    }
    
}
