import Foundation
import XCTest
@testable import Jessie

class WriteUrlTests: XCTestCase {
    
    func testWriteAppendToDict() {
        var json = Json([:])
        json["Key1"] = URL(string: "http://google.com")!.toJson()
        let readValue = try? json["Key1"].toUrl()
        XCTAssertEqual(readValue, URL(string: "http://google.com")!)
    }
    
    func testWriteModifyToDict() {
        var json = Json(["Key1":"OldValue"])
        json["Key1"] = URL(string: "http://google.com")!.toJson()
        let readValue = try? json["Key1"].toUrl()
        XCTAssertEqual(readValue, URL(string: "http://google.com")!)
    }
    
    func testWriteAppendToArray() {
        var json = Json([])
        json[0] = URL(string: "http://google.com")!.toJson()
        let readValue = try? json[0].toUrl()
        XCTAssertEqual(readValue, URL(string: "http://google.com")!)
    }
    
    func testWriteModifyToArray() {
        var json = Json(["OldValue"])
        json[0] = URL(string: "http://google.com")!.toJson()
        let readValue = try? json[0].toUrl()
        XCTAssertEqual(readValue, URL(string: "http://google.com")!)
    }
    
    func testComplexWriteToDict() {
        var json = Json([:])
        json["Key1"] = [:]
        json["Key1"]["Key2"] = []
        json["Key1"]["Key2"][0] = [:]
        json["Key1"]["Key2"][0]["Key3"] = URL(string: "http://google.com")!.toJson()
        let readValue = try? json["Key1"]["Key2"][0]["Key3"].toUrl()
        XCTAssertEqual(readValue, URL(string: "http://google.com")!)
    }
    
    func testComplexWriteToArray() {
        var json = Json([])
        json[0] = [:]
        json[0]["Key1"] = []
        json[0]["Key1"][0] = [:]
        json[0]["Key1"][0]["Key2"] = URL(string: "http://google.com")!.toJson()
        let readValue = try? json[0]["Key1"][0]["Key2"].toUrl()
        XCTAssertEqual(readValue, URL(string: "http://google.com")!)
    }
    
}
