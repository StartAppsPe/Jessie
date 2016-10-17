import XCTest
@testable import Jessie

class CreateTests: XCTestCase {
    
    func testCreateWithNull() {
        let json = Json()
        let jsonString = try! json.rawString(prettyPrinted: false)
        XCTAssertEqual(jsonString, "NULL")
    }
    
    func testCreateWithEmptyArray() {
        let json = try! Json([])
        let jsonString = try! json.rawString(prettyPrinted: false)
        XCTAssertEqual(jsonString, "[]")
    }
    
    func testCreateWithArray() {
        let json = try! Json(["value1","value2"])
        let jsonString = try! json.rawString(prettyPrinted: false)
        XCTAssertEqual(jsonString, "[\"value1\",\"value2\"]")
    }
    
    func testCreateWithEmptyDictionary() {
        let json = try! Json([:])
        let jsonString = try! json.rawString(prettyPrinted: false)
        XCTAssertEqual(jsonString, "{}")
    }
    
    func testCreateWithDictionary() {
        let json = try! Json(["key":"value"])
        let jsonString = try! json.rawString(prettyPrinted: false)
        XCTAssertEqual(jsonString, "{\"key\":\"value\"}")
    }
    
    func testCreateWithEmptyString() {
        let json = try! Json("")
        let jsonString = try! json.rawString(prettyPrinted: false)
        XCTAssertEqual(jsonString, "")
    }
    
    func testCreateWithString() {
        let json = try! Json("Value")
        let jsonString = try! json.rawString(prettyPrinted: false)
        XCTAssertEqual(jsonString, "Value")
    }
    
    func testCreateWithZeroInt() {
        let json = try! Json(0)
        let jsonString = try! json.rawString(prettyPrinted: false)
        XCTAssertEqual(jsonString, "0")
    }
    
    func testCreateWithInt() {
        let json = try! Json(1)
        let jsonString = try! json.rawString(prettyPrinted: false)
        XCTAssertEqual(jsonString, "1")
    }
    
    func testCreateWithInt2() {
        let json = try! Json(-1)
        let jsonString = try! json.rawString(prettyPrinted: false)
        XCTAssertEqual(jsonString, "-1")
    }
    
    func testCreateWithZeroDouble() {
        let json = try! Json(0.0)
        let jsonString = try! json.rawString(prettyPrinted: false)
        XCTAssertEqual(jsonString, "0.0")
    }
    
    func testCreateWithDouble() {
        let json = try! Json(1.0)
        let jsonString = try! json.rawString(prettyPrinted: false)
        XCTAssertEqual(jsonString, "1.0")
    }
    
    func testCreateWithZeroDouble2() {
        let json = try! Json(1.1)
        let jsonString = try! json.rawString(prettyPrinted: false)
        XCTAssertEqual(jsonString, "1.1")
    }
    
    func testCreateWithBool() {
        let json = try! Json(true)
        let jsonString = try! json.rawString(prettyPrinted: false)
        XCTAssertEqual(jsonString, "true")
    }
    
    func testCreateWithBool2() {
        let json = try! Json(false)
        let jsonString = try! json.rawString(prettyPrinted: false)
        XCTAssertEqual(jsonString, "false")
    }
    
}
