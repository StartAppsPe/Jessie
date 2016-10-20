import XCTest
@testable import Jessie

class ReadDoubleTests: XCTestCase {
    
    func testReadSimply() {
        let json = Json(["Key1": 1.0])
        let readValue = json["Key1"].double
        XCTAssertEqual(readValue, 1.0)
    }
    
    func testReadSimplyFail() {
        let json = Json(["Key1": "Value1"])
        let readValue = json["Key1"].double
        XCTAssertEqual(readValue, nil)
    }
    
    func testReadOperator() {
        let json = Json(["Key1": 1.0])
        let readValue: Double = try! json <~ ["Key1"]
        XCTAssertEqual(readValue, 1.0)
    }
    
    func testReadOperatorFail() {
        let json = Json(["Key1": "Value1"])
        do {
            let _: Double = try json <~ ["Key1"]
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromString() {
        let json = Json(["Key1": "Value1"])
        do {
            let _ = try json["Key1"].toDouble()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromString2() {
        let json = Json(["Key1": "1"])
        do {
            let _ = try json["Key1"].toDouble()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromInt() {
        let json = Json(["Key1": 1])
        do {
            let _ = try json["Key1"].toDouble()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromDouble() {
        let json = Json(["Key1": 1.0])
        let readValue = try? json["Key1"].toDouble()
        XCTAssertEqual(readValue, 1.0)
    }
    
    func testReadFromDouble2() {
        let json = Json(["Key1": 1.1])
        let readValue = try? json["Key1"].toDouble()
        XCTAssertEqual(readValue, 1.1)
    }
    
    func testReadFromBool() {
        let json = Json(["Key1": true])
        do {
            let _ = try json["Key1"].toDouble()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromDictionary() {
        let json = Json(["Key1": ["Key2": "Value2"]])
        do {
            let _ = try json["Key1"].toDouble()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromArray() {
        let json = Json(["Key1": ["Value1", "Value2"]])
        do {
            let _ = try json["Key1"].toDouble()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromNull() {
        let json = Json([:])
        do {
            let _ = try json["Key1"].toDouble()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
}
