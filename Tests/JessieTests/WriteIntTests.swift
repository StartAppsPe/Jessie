import XCTest
@testable import Jessie

class WriteIntTests: XCTestCase {
    
    func testWriteAppendToDict() {
        var json = try! Json([:])
        json["Key1"] = 1
        let readValue = try? json["Key1"].toInt()
        XCTAssertEqual(readValue, 1)
    }
    
    func testWriteModifyToDict() {
        var json = try! Json(["Key1":9])
        json["Key1"] = 1
        let readValue = try? json["Key1"].toInt()
        XCTAssertEqual(readValue, 1)
    }
    
    func testWriteAppendToArray() {
        var json = try! Json([])
        json[0] = 1
        let readValue = try? json[0].toInt()
        XCTAssertEqual(readValue, 1)
    }
    
    func testWriteModifyToArray() {
        var json = try! Json([9])
        json[0] = 1
        let readValue = try? json[0].toInt()
        XCTAssertEqual(readValue, 1)
    }
    
    func testComplexWriteToDict() {
        var json = try! Json([:])
        json["Key1"] = [:]
        json["Key1"]["Key2"] = []
        json["Key1"]["Key2"][0] = [:]
        json["Key1"]["Key2"][0]["Key3"] = 1
        let readValue = try? json["Key1"]["Key2"][0]["Key3"].toInt()
        XCTAssertEqual(readValue, 1)
    }
    
    func testComplexWriteToArray() {
        var json = try! Json([])
        json[0] = [:]
        json[0]["Key1"] = []
        json[0]["Key1"][0] = [:]
        json[0]["Key1"][0]["Key2"] = 1
        let readValue = try? json[0]["Key1"][0]["Key2"].toInt()
        XCTAssertEqual(readValue, 1)
    }
    
}
