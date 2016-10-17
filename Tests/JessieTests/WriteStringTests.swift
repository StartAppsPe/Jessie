import XCTest
@testable import Jessie

class WriteStringTests: XCTestCase {
    
    func testWriteAppendToDict() {
        var json = try! Json([:])
        json["Key1"] = "Value1"
        let readValue = try? json["Key1"].toString()
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testWriteModifyToDict() {
        var json = try! Json(["Key1":"OldValue"])
        json["Key1"] = "Value1"
        let readValue = try? json["Key1"].toString()
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testWriteAppendToArray() {
        var json = try! Json([])
        json[0] = "Value1"
        let readValue = try? json[0].toString()
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testWriteModifyToArray() {
        var json = try! Json(["OldValue"])
        json[0] = "Value1"
        let readValue = try? json[0].toString()
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testComplexWriteToDict() {
        var json = try! Json([:])
        json["Key1"] = [:]
        json["Key1"]["Key2"] = []
        json["Key1"]["Key2"][0] = [:]
        json["Key1"]["Key2"][0]["Key3"] = "Value1"
        let readValue = try? json["Key1"]["Key2"][0]["Key3"].toString()
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testComplexWriteToArray() {
        var json = try! Json([])
        json[0] = [:]
        json[0]["Key1"] = []
        json[0]["Key1"][0] = [:]
        json[0]["Key1"][0]["Key2"] = "Value1"
        let readValue = try? json[0]["Key1"][0]["Key2"].toString()
        XCTAssertEqual(readValue, "Value1")
    }
    
}
