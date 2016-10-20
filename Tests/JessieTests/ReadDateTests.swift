import Foundation
import XCTest
@testable import Jessie

class ReadDateTests: XCTestCase {
    
    func testReadSimply() {
        let json = Json(["Key1": Date(timeIntervalSinceReferenceDate: 0)])
        let readValue = json["Key1"].date
        XCTAssertEqual(readValue, Date(timeIntervalSinceReferenceDate: 0))
    }
    
    func testReadSimplyFail() {
        let json = Json(["Key1": "Value1"])
        let readValue = json["Key1"].date
        XCTAssertEqual(readValue, nil)
    }
    
    func testReadOperator() {
        let json = Json(["Key1": Date(timeIntervalSinceReferenceDate: 0)])
        let readValue: Date = try! json <~ ["Key1"]
        XCTAssertEqual(readValue, Date(timeIntervalSinceReferenceDate: 0))
    }
    
    func testReadOperatorFail() {
        let json = Json(["Key1": "Value1"])
        do {
            let _: Date = try json <~ ["Key1"]
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromString() {
        let json = Json(["Key1": "Value1"])
        do {
            let _ = try json["Key1"].toDate()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromString2() {
        let json = Json(["Key1": "1"])
        do {
            let _ = try json["Key1"].toDate()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromString3() {
        let json = Json(["Key1": "2000-12-31T19:00:00-0500"])
        let readValue = try? json["Key1"].toDate()
        XCTAssertEqual(readValue, Date(timeIntervalSinceReferenceDate: 0))
    }
    
    func testReadFromInt() {
        let json = Json(["Key1": 1])
        do {
            let _ = try json["Key1"].toDate()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromDouble() {
        let json = Json(["Key1": 1.0])
        do {
            let _ = try json["Key1"].toDate()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromDouble2() {
        let json = Json(["Key1": 1.1])
        do {
            let _ = try json["Key1"].toDate()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromBool() {
        let json = Json(["Key1": true])
        do {
            let _ = try json["Key1"].toDate()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromDictionary() {
        let json = Json(["Key1": ["Key2": "Value2"]])
        do {
            let _ = try json["Key1"].toDate()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromArray() {
        let json = Json(["Key1": ["Value1", "Value2"]])
        do {
            let _ = try json["Key1"].toDate()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromNull() {
        let json = Json([:])
        do {
            let _ = try json["Key1"].toDate()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromDate() {
        let json = Json(["Key1": Date(timeIntervalSinceReferenceDate: 0)])
        let readValue = try? json["Key1"].toDate()
        XCTAssertEqual(readValue, Date(timeIntervalSinceReferenceDate: 0))
    }
    
}
