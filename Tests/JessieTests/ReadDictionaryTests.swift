import XCTest
@testable import Jessie

class ReadDictionaryTests: XCTestCase {
    
    func testReadSimply() {
        let json = try! Json(["Key1": ["Key2": "Value1"]])
        let readDict = json["Key1"].dictionary
        let readValue = readDict?["Key2"]?.string
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testReadSimplyFail() {
        let json = try! Json(["Key1": "Value1"])
        let readDict = json["Key1"].dictionary
        let readValue = readDict?["Key2"]?.string
        XCTAssertEqual(readValue, nil)
    }
    
    func testReadOperator() {
        let json = try! Json(["Key1": ["Key2": "Value1"]])
        let readDict: [String: Json] = try! json <~ ["Key1"]
        let readValue = readDict["Key2"]?.string
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testReadOperatorFail() {
        let json = try! Json(["Key1": "Value1"])
        do {
            let _: [String: Json] = try json <~ ["Key1"]
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromString() {
        let json = try! Json(["Key1": "Value1"])
        do {
            let _ = try json["Key1"].toDictionary()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromString2() {
        let json = try! Json(["Key1": "1"])
        do {
            let _ = try json["Key1"].toDictionary()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromInt() {
        let json = try! Json(["Key1": 1])
        do {
            let _ = try json["Key1"].toDictionary()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromDouble() {
        let json = try! Json(["Key1": 1.0])
        do {
            let _ = try json["Key1"].toDictionary()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromDouble2() {
        let json = try! Json(["Key1": 1.1])
        do {
            let _ = try json["Key1"].toDictionary()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromBool() {
        let json = try! Json(["Key1": true])
        do {
            let _ = try json["Key1"].toDictionary()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromDictionary() {
        let json = try! Json(["Key1": ["Key2": "Value2"]])
        let readDict = try! json["Key1"].toDictionary()
        let readValue = readDict["Key2"]!.string
        XCTAssertEqual(readValue, "Value2")
    }
    
    func testReadFromArray() {
        let json = try! Json(["Key1": ["Value1", "Value2"]])
        do {
            let _ = try json["Key1"].toDictionary()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromNull() {
        let json = try! Json([:])
        do {
            let _ = try json["Key1"].toDictionary()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
}
