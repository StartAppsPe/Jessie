import Foundation
import XCTest
@testable import Jessie

class ReadUrlTests: XCTestCase {
    
    func testReadSimply() {
        let json = Json(["Key1": URL(string: "http://google.com")!])
        let readValue = json["Key1"].url
        XCTAssertEqual(readValue, URL(string: "http://google.com")!)
    }
    
    func testReadSimply2() {
        let json = Json(["Key1": "http://google.com"])
        let readValue = json["Key1"].url
        XCTAssertEqual(readValue, URL(string: "http://google.com")!)
    }
    
    func testReadSimplyFail() {
        let json = Json(["Key1": "Value1"])
        let readValue = json["Key1"].url
        XCTAssertEqual(readValue, URL(string: "Value1")!)
    }
    
    func testReadOperator() {
        let json = Json(["Key1": URL(string: "http://google.com")!])
        let readValue: URL = try! json <~ ["Key1"]
        XCTAssertEqual(readValue, URL(string: "http://google.com")!)
    }
    
    func testReadOperator2() {
        let json = Json(["Key1": "http://google.com"])
        let readValue: URL = try! json <~ ["Key1"]
        XCTAssertEqual(readValue, URL(string: "http://google.com")!)
    }
    
    func testReadOperatorFail() {
        let json = Json(["Key1": 9])
        do {
            let _: URL = try json <~ ["Key1"]
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromString() {
        let json = Json(["Key1": "Value1"])
        let readValue = try? json["Key1"].toUrl()
        XCTAssertEqual(readValue, URL(string: "Value1")!)
    }
    
    func testReadFromString2() {
        let json = Json(["Key1": "1"])
        let readValue = try? json["Key1"].toUrl()
        XCTAssertEqual(readValue, URL(string: "1")!)
    }
    
    func testReadFromString3() {
        let json = Json(["Key1": "http://google.com"])
        let readValue = try? json["Key1"].toUrl()
        XCTAssertEqual(readValue, URL(string: "http://google.com")!)
    }
    
    func testReadFromInt() {
        let json = Json(["Key1": 1])
        do {
            let _ = try json["Key1"].toUrl()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromDouble() {
        let json = Json(["Key1": 1.0])
        do {
            let _ = try json["Key1"].toUrl()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromDouble2() {
        let json = Json(["Key1": 1.1])
        do {
            let _ = try json["Key1"].toUrl()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromBool() {
        let json = Json(["Key1": true])
        do {
            let _ = try json["Key1"].toUrl()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromDictionary() {
        let json = Json(["Key1": ["Key2": "Value2"]])
        do {
            let _ = try json["Key1"].toUrl()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromArray() {
        let json = Json(["Key1": ["Value1", "Value2"]])
        do {
            let _ = try json["Key1"].toUrl()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromNull() {
        let json = Json([:])
        do {
            let _ = try json["Key1"].toUrl()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromURL() {
        let json = Json(["Key1": URL(string: "http://google.com")!])
        let readValue = try? json["Key1"].toUrl()
        XCTAssertEqual(readValue, URL(string: "http://google.com")!)
    }
    
}
