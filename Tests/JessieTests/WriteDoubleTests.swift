import XCTest
@testable import Jessie

class WriteDoubleTests: XCTestCase {
    
    func testWriteAppendToDict() {
        var json = try! Json([:])
        json["Key1"] = 1.0
        let readValue = try? json["Key1"].toDouble()
        XCTAssertEqual(readValue, 1.0)
    }
    
    func testWriteModifyToDict() {
        var json = try! Json(["Key1":9.0])
        json["Key1"] = 1.0
        let readValue = try? json["Key1"].toDouble()
        XCTAssertEqual(readValue, 1.0)
    }
    
    func testWriteAppendToArray() {
        var json = try! Json([])
        json[0] = 1.0
        let readValue = try? json[0].toDouble()
        XCTAssertEqual(readValue, 1.0)
    }
    
    func testWriteModifyToArray() {
        var json = try! Json([9.0])
        json[0] = 1.0
        let readValue = try? json[0].toDouble()
        XCTAssertEqual(readValue, 1.0)
    }
    
    func testComplexWriteToDict() {
        var json = try! Json([:])
        json["Key1"] = [:]
        json["Key1"]["Key2"] = []
        json["Key1"]["Key2"][0] = [:]
        json["Key1"]["Key2"][0]["Key3"] = 1.0
        let readValue = try? json["Key1"]["Key2"][0]["Key3"].toDouble()
        XCTAssertEqual(readValue, 1.0)
    }
    
    func testComplexWriteToArray() {
        var json = try! Json([])
        json[0] = [:]
        json[0]["Key1"] = []
        json[0]["Key1"][0] = [:]
        json[0]["Key1"][0]["Key2"] = 1.0
        let readValue = try? json[0]["Key1"][0]["Key2"].toDouble()
        XCTAssertEqual(readValue, 1.0)
    }
    
}
