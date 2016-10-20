import XCTest
@testable import Jessie

class WriteDictionayTests: XCTestCase {
    
    // TODO: Add creation tests on Swift 3.1
    
    func testWriteAppendToDict() {
        var json = Json([:])
        json["Key1"] = ["Key2": "Value1"]
        let readDict = try? json["Key1"].toDictionary()
        let readValue = readDict?["Key2"]?.string
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testWriteModifyToDict() {
        var json = Json(["Key1":"OldValue"])
        json["Key1"] = ["Key2": "Value1"]
        let readDict = try? json["Key1"].toDictionary()
        let readValue = readDict?["Key2"]?.string
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testWriteAppendToArray() {
        var json = Json([])
        json[0] = ["Key2": "Value1"]
        let readDict = try? json[0].toDictionary()
        let readValue = readDict?["Key2"]?.string
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testWriteModifyToArray() {
        var json = Json(["OldValue"])
        json[0] = ["Key2": "Value1"]
        let readDict = try? json[0].toDictionary()
        let readValue = readDict?["Key2"]?.string
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testComplexWriteToDict() {
        var json = Json([:])
        json["Key1"] = [:]
        json["Key1"]["Key2"] = []
        json["Key1"]["Key2"][0] = [:]
        json["Key1"]["Key2"][0]["Key3"] = ["Key4": "Value1"]
        let readDict = try? json["Key1"]["Key2"][0]["Key3"].toDictionary()
        let readValue = readDict?["Key4"]?.string
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testComplexWriteToArray() {
        var json = Json([])
        json[0] = [:]
        json[0]["Key1"] = []
        json[0]["Key1"][0] = [:]
        json[0]["Key1"][0]["Key2"] = ["Key3": "Value1"]
        let readDict = try? json[0]["Key1"][0]["Key2"].toDictionary()
        let readValue = readDict?["Key3"]?.string
        XCTAssertEqual(readValue, "Value1")
    }
    
}
