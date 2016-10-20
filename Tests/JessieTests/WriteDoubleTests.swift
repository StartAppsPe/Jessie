import XCTest
@testable import Jessie

class WriteDoubleTests: XCTestCase {
    
    func testCreate() {
        let value: Double = 1.1
        let json = Json(["key": value])
        let jsonString = json["key"].rawString(pretty: false)
        XCTAssertEqual(jsonString, "1.1")
    }
    
    func testCreateWithOptional() {
        let value: Double? = 1.1
        let json = Json(["key": value])
        let jsonString = json["key"].rawString(pretty: false)
        XCTAssertEqual(jsonString, "1.1")
    }
    
    func testWriteAppendToDict() {
        var json = Json([:])
        json["Key1"] = 1.0
        let readValue = try? json["Key1"].toDouble()
        XCTAssertEqual(readValue, 1.0)
    }
    
    func testWriteModifyToDict() {
        var json = Json(["Key1":9.0])
        json["Key1"] = 1.0
        let readValue = try? json["Key1"].toDouble()
        XCTAssertEqual(readValue, 1.0)
    }
    
    func testWriteAppendToArray() {
        var json = Json([])
        json[0] = 1.0
        let readValue = try? json[0].toDouble()
        XCTAssertEqual(readValue, 1.0)
    }
    
    func testWriteModifyToArray() {
        var json = Json([9.0])
        json[0] = 1.0
        let readValue = try? json[0].toDouble()
        XCTAssertEqual(readValue, 1.0)
    }
    
    func testComplexWriteToDict() {
        var json = Json([:])
        json["Key1"] = [:]
        json["Key1"]["Key2"] = []
        json["Key1"]["Key2"][0] = [:]
        json["Key1"]["Key2"][0]["Key3"] = 1.0
        let readValue = try? json["Key1"]["Key2"][0]["Key3"].toDouble()
        XCTAssertEqual(readValue, 1.0)
    }
    
    func testComplexWriteToArray() {
        var json = Json([])
        json[0] = [:]
        json[0]["Key1"] = []
        json[0]["Key1"][0] = [:]
        json[0]["Key1"][0]["Key2"] = 1.0
        let readValue = try? json[0]["Key1"][0]["Key2"].toDouble()
        XCTAssertEqual(readValue, 1.0)
    }
    
}
