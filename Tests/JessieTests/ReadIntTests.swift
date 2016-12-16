import XCTest
@testable import Jessie

class ReadIntTests: XCTestCase {
    
    func testReadSimply() {
        let json = Json(["Key1": 1])
        let readValue = json["Key1"].int
        XCTAssertEqual(readValue, 1)
    }
    
    func testReadSimplyFail() {
        let json = Json(["Key1": "Value1"])
        let readValue = json["Key1"].int
        XCTAssertEqual(readValue, nil)
    }
    
    func testReadOperator() {
        let json = Json(["Key1": 1])
        let readValue: Int = try! json <~ ["Key1"]
        XCTAssertEqual(readValue, 1)
    }
    
    func testReadOperatorOptional() {
        let json = Json(["Key1": 1])
        let readValue: Int? = try! json <~ ["Key1"]
        XCTAssertEqual(readValue, 1)
    }
    
    func testReadOperatorFail() {
        let json = Json(["Key1": "Value1"])
        do {
            let _: Int = try json <~ ["Key1"]
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromString() {
        let json = Json(["Key1": "Value1"])
        do {
            let _ = try json["Key1"].toInt()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromString2() {
        let json = Json(["Key1": "1"])
        do {
            let _ = try json["Key1"].toInt()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromInt() {
        let json = Json(["Key1": 1])
        let readValue = try? json["Key1"].toInt()
        XCTAssertEqual(readValue, 1)
    }
    
    func testReadFromDouble() {
        let json = Json(["Key1": 1.0])
        let readValue = try? json["Key1"].toInt()
        XCTAssertEqual(readValue, 1)
    }
    
    func testReadFromDouble2() {
        let json = Json(["Key1": 1.1])
        let readValue = try? json["Key1"].toInt()
        XCTAssertEqual(readValue, 1)
    }
    
    func testReadFromDouble3() {
        let json = Json(["Key1": 1.9])
        let readValue = try? json["Key1"].toInt()
        XCTAssertEqual(readValue, 1)
    }
    
    func testReadFromBool() {
        let json = Json(["Key1": true])
        do {
            let _ = try json["Key1"].toInt()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromDictionary() {
        let json = Json(["Key1": ["Key2": "Value2"]])
        do {
            let _ = try json["Key1"].toInt()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromArray() {
        let json = Json(["Key1": ["Value1", "Value2"]])
        do {
            let _ = try json["Key1"].toInt()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromNull() {
        let json = Json([:])
        do {
            let _ = try json["Key1"].toInt()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
}
