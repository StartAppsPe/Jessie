import XCTest
@testable import Jessie

class ReadBoolTests: XCTestCase {
    
    func testReadSimply() {
        let json = try! Json(["Key1": true])
        let readValue = json["Key1"].bool
        XCTAssertEqual(readValue, true)
    }
    
    func testReadSimplyFail() {
        let json = try! Json(["Key1": "Value1"])
        let readValue = json["Key1"].bool
        XCTAssertEqual(readValue, nil)
    }
    
    func testReadOperator() {
        let json = try! Json(["Key1": true])
        let readValue: Bool = try! json <~ ["Key1"]
        XCTAssertEqual(readValue, true)
    }
    
    func testReadOperatorFail() {
        let json = try! Json(["Key1": "Value1"])
        do {
            let _: Bool = try json <~ ["Key1"]
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromString() {
        let json = try! Json(["Key1": "Value1"])
        do {
            let _ = try json["Key1"].toBool()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromString2() {
        let json = try! Json(["Key1": "1"])
        do {
            let _ = try json["Key1"].toBool()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromInt() {
        let json = try! Json(["Key1": 2])
        do {
            let _ = try json["Key1"].toBool()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromInt2() {
        let json = try! Json(["Key1": 0])
        let readValue = try? json["Key1"].toBool()
        XCTAssertEqual(readValue, false)
    }
    
    func testReadFromInt3() {
        let json = try! Json(["Key1": 1])
        let readValue = try? json["Key1"].toBool()
        XCTAssertEqual(readValue, true)
    }
    
    func testReadFromDouble() {
        let json = try! Json(["Key1": 1.0])
        do {
            let _ = try json["Key1"].toBool()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromDouble2() {
        let json = try! Json(["Key1": 1.1])
        do {
            let _ = try json["Key1"].toBool()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromBool() {
        let json = try! Json(["Key1": true])
        let readValue = try? json["Key1"].toBool()
        XCTAssertEqual(readValue, true)
    }
    
    func testReadFromDictionary() {
        let json = try! Json(["Key1": ["Key2": "Value2"]])
        do {
            let _ = try json["Key1"].toBool()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromArray() {
        let json = try! Json(["Key1": ["Value1", "Value2"]])
        do {
            let _ = try json["Key1"].toBool()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromNull() {
        let json = try! Json([:])
        do {
            let _ = try json["Key1"].toBool()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
}
