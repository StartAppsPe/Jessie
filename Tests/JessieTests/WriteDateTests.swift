import Foundation
import XCTest
@testable import Jessie

class WriteDateTests: XCTestCase {
    
    func testWriteAppendToDict() {
        var json = Json([:])
        json["Key1"] = Date(timeIntervalSinceReferenceDate: 0).toJson()
        let readValue = try? json["Key1"].toDate()
        XCTAssertEqual(readValue, Date(timeIntervalSinceReferenceDate: 0))
    }
    
    func testWriteModifyToDict() {
        var json = Json(["Key1":"OldValue"])
        json["Key1"] = Date(timeIntervalSinceReferenceDate: 0).toJson()
        let readValue = try? json["Key1"].toDate()
        XCTAssertEqual(readValue, Date(timeIntervalSinceReferenceDate: 0))
    }
    
    func testWriteAppendToArray() {
        var json = Json([])
        json[0] = Date(timeIntervalSinceReferenceDate: 0).toJson()
        let readValue = try? json[0].toDate()
        XCTAssertEqual(readValue, Date(timeIntervalSinceReferenceDate: 0))
    }
    
    func testWriteModifyToArray() {
        var json = Json(["OldValue"])
        json[0] = Date(timeIntervalSinceReferenceDate: 0).toJson()
        let readValue = try? json[0].toDate()
        XCTAssertEqual(readValue, Date(timeIntervalSinceReferenceDate: 0))
    }
    
    func testComplexWriteToDict() {
        var json = Json([:])
        json["Key1"] = [:]
        json["Key1"]["Key2"] = []
        json["Key1"]["Key2"][0] = [:]
        json["Key1"]["Key2"][0]["Key3"] = Date(timeIntervalSinceReferenceDate: 0).toJson()
        let readValue = try? json["Key1"]["Key2"][0]["Key3"].toDate()
        XCTAssertEqual(readValue, Date(timeIntervalSinceReferenceDate: 0))
    }
    
    func testComplexWriteToArray() {
        var json = Json([])
        json[0] = [:]
        json[0]["Key1"] = []
        json[0]["Key1"][0] = [:]
        json[0]["Key1"][0]["Key2"] = Date(timeIntervalSinceReferenceDate: 0).toJson()
        let readValue = try? json[0]["Key1"][0]["Key2"].toDate()
        XCTAssertEqual(readValue, Date(timeIntervalSinceReferenceDate: 0))
    }
    
}
