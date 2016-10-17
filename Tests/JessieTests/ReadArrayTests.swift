import XCTest
@testable import Jessie

class ReadArrayTests: XCTestCase {
    
    func testReadSimply() {
        let json = try! Json(["Key1": ["Value1", "Value2"]])
        let readArray = json["Key1"].array
        let readValue = readArray?[0].string
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testReadSimplyFail() {
        let json = try! Json(["Key1": "Value1"])
        let readArray = json["Key1"].array
        let readValue = readArray?[0].string
        XCTAssertEqual(readValue, nil)
    }
    
    func testReadOperator() {
        let json = try! Json(["Key1": ["Value1", "Value2"]])
        let readArray: [Json] = try! json <~ ["Key1"]
        let readValue = readArray[0].string
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testReadOperatorFail() {
        let json = try! Json(["Key1": "Value1"])
        do {
            let _: [Json] = try json <~ ["Key1"]
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromString() {
        let json = try! Json(["Key1": "Value1"])
        do {
            let _ = try json["Key1"].toArray()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromString2() {
        let json = try! Json(["Key1": "1"])
        do {
            let _ = try json["Key1"].toArray()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromInt() {
        let json = try! Json(["Key1": 1])
        do {
            let _ = try json["Key1"].toArray()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromDouble() {
        let json = try! Json(["Key1": 1.0])
        do {
            let _ = try json["Key1"].toArray()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromDouble2() {
        let json = try! Json(["Key1": 1.1])
        do {
            let _ = try json["Key1"].toArray()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromBool() {
        let json = try! Json(["Key1": true])
        do {
            let _ = try json["Key1"].toArray()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromDictionary() {
        let json = try! Json(["Key1": ["Key2": "Value2"]])
        do {
            let _ = try json["Key1"].toArray()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromArray() {
        let json = try! Json(["Key1": ["Value1", "Value2"]])
        let readArray = try! json["Key1"].toArray()
        let readValue = readArray[0].string
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testReadFromArray2() {
        let json = try! Json(["Key1": ["Value1", "Value2"]])
        let readArray = try! json["Key1"].toArray()
        let readValue = readArray[1].string
        XCTAssertEqual(readValue, "Value2")
    }
    
    func testReadFromNull() {
        let json = try! Json([:])
        do {
            let _ = try json["Key1"].toArray()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadOutOfBounds() {
        let json = try! Json(["Key1": ["Value1", "Value2"]])
        let readValue = json["Key1"][2].string
        XCTAssertEqual(readValue, nil)
    }
    
}
