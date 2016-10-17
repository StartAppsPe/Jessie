import XCTest
@testable import Jessie

class ReadStringTests: XCTestCase {
    
    func testReadSimply() {
        let json = try! Json(["Key1": "Value1"])
        let readValue = json["Key1"].string
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testReadSimplyFail() {
        let json = try! Json(["Key1": 0])
        let readValue = json["Key1"].string
        XCTAssertEqual(readValue, nil)
    }
    
    func testReadOperator() {
        let json = try! Json(["Key1": "Value1"])
        let readValue: String = try! json <~ ["Key1"]
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testReadOperatorFail() {
        let json = try! Json(["Key1": 0])
        do {
            let _: String = try json <~ ["Key1"]
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromString() {
        let json = try! Json(["Key1": "Value1"])
        let readValue = try? json["Key1"].toString()
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testReadFromString2() {
        let json = try! Json(["Key1": "1"])
        let readValue = try? json["Key1"].toString()
        XCTAssertEqual(readValue, "1")
    }
    
    func testReadFromInt() {
        let json = try! Json(["Key1": 1])
        do {
            let _ = try json["Key1"].toString()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromDouble() {
        let json = try! Json(["Key1": 1.0])
        do {
            let _ = try json["Key1"].toString()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromDouble2() {
        let json = try! Json(["Key1": 1.1])
        do {
            let _ = try json["Key1"].toString()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromBool() {
        let json = try! Json(["Key1": true])
        do {
            let _ = try json["Key1"].toString()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromDictionary() {
        let json = try! Json(["Key1": ["Key2": "Value2"]])
        do {
            let _ = try json["Key1"].toString()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromArray() {
        let json = try! Json(["Key1": ["Value1", "Value2"]])
        do {
            let _ = try json["Key1"].toString()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromNull() {
        let json = try! Json([:])
        do {
            let _ = try json["Key1"].toString()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
}
