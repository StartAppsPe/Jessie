import XCTest
@testable import Jessie

class ReadIntTests: XCTestCase {
    
    func testReadSimply() {
        let json = try! Json(["Key1": 1])
        let readValue = json["Key1"].int
        XCTAssertEqual(readValue, 1)
    }
    
    func testReadSimplyFail() {
        let json = try! Json(["Key1": "Value1"])
        let readValue = json["Key1"].int
        XCTAssertEqual(readValue, nil)
    }
    
    func testReadOperator() {
        let json = try! Json(["Key1": 1])
        let readValue: Int = try! json <~ ["Key1"]
        XCTAssertEqual(readValue, 1)
    }
    
    func testReadOperatorFail() {
        let json = try! Json(["Key1": "Value1"])
        do {
            let _: Int = try json <~ ["Key1"]
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromString() {
        let json = try! Json(["Key1": "Value1"])
        do {
            let _ = try json["Key1"].toInt()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromString2() {
        let json = try! Json(["Key1": "1"])
        do {
            let _ = try json["Key1"].toInt()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromInt() {
        let json = try! Json(["Key1": 1])
        let readValue = try? json["Key1"].toInt()
        XCTAssertEqual(readValue, 1)
    }
    
    func testReadFromDouble() {
        let json = try! Json(["Key1": 1.0])
        do {
            let _ = try json["Key1"].toInt()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromDouble2() {
        let json = try! Json(["Key1": 1.1])
        do {
            let _ = try json["Key1"].toInt()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromBool() {
        let json = try! Json(["Key1": true])
        do {
            let _ = try json["Key1"].toInt()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromDictionary() {
        let json = try! Json(["Key1": ["Key2": "Value2"]])
        do {
            let _ = try json["Key1"].toInt()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromArray() {
        let json = try! Json(["Key1": ["Value1", "Value2"]])
        do {
            let _ = try json["Key1"].toInt()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromNull() {
        let json = try! Json([:])
        do {
            let _ = try json["Key1"].toInt()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
}
