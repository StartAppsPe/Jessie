import XCTest
@testable import Jessie

class WriteBoolTests: XCTestCase {
    
    func testWriteAppendToDict() {
        var json = try! Json([:])
        json["Key1"] = true
        let readValue = try? json["Key1"].toBool()
        XCTAssertEqual(readValue, true)
    }
    
    func testWriteModifyToDict() {
        var json = try! Json(["Key1":false])
        json["Key1"] = true
        let readValue = try? json["Key1"].toBool()
        XCTAssertEqual(readValue, true)
    }
    
    func testWriteAppendToArray() {
        var json = try! Json([])
        json[0] = true
        let readValue = try? json[0].toBool()
        XCTAssertEqual(readValue, true)
    }
    
    func testWriteModifyToArray() {
        var json = try! Json([false])
        json[0] = true
        let readValue = try? json[0].toBool()
        XCTAssertEqual(readValue, true)
    }
    
    func testComplexWriteToDict() {
        var json = try! Json([:])
        json["Key1"] = [:]
        json["Key1"]["Key2"] = []
        json["Key1"]["Key2"][0] = [:]
        json["Key1"]["Key2"][0]["Key3"] = true
        let readValue = try? json["Key1"]["Key2"][0]["Key3"].toBool()
        XCTAssertEqual(readValue, true)
    }
    
    func testComplexWriteToArray() {
        var json = try! Json([])
        json[0] = [:]
        json[0]["Key1"] = []
        json[0]["Key1"][0] = [:]
        json[0]["Key1"][0]["Key2"] = true
        let readValue = try? json[0]["Key1"][0]["Key2"].toBool()
        XCTAssertEqual(readValue, true)
    }
    
}
