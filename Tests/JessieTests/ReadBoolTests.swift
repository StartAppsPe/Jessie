import XCTest
@testable import Jessie

class ReadBoolTests: XCTestCase {
    
    func testReadSimply() {
        let json = Json(["Key1": true])
        let readValue = json["Key1"].bool
        XCTAssertEqual(readValue, true)
    }
    
    func testReadSimplyFail() {
        let json = Json(["Key1": "Value1"])
        let readValue = json["Key1"].bool
        XCTAssertEqual(readValue, nil)
    }
    
    func testReadOperator() {
        let json = Json(["Key1": true])
        let readValue: Bool = try! json <~ ["Key1"]
        XCTAssertEqual(readValue, true)
    }
    
    func testReadOperatorOptional() {
        let json = Json(["Key1": true])
        let readValue: Bool? = try! json <~ ["Key1"]
        XCTAssertEqual(readValue, true)
    }
    
    func testReadOperatorFail() {
        let json = Json(["Key1": "Value1"])
        do {
            let _: Bool = try json <~ ["Key1"]
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromString() {
        let json = Json(["Key1": "Value1"])
        do {
            let _ = try json["Key1"].toBool()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromString2T() {
        let json = Json(["Key1": "true"])
        let readValue = try? json["Key1"].toBool()
        XCTAssertEqual(readValue, true)
    }
    
    func testReadFromString2F() {
        let json = Json(["Key1": "false"])
        let readValue = try? json["Key1"].toBool()
        XCTAssertEqual(readValue, false)
    }
    
    func testReadFromString3T() {
        let json = Json(["Key1": "yes"])
        let readValue = try? json["Key1"].toBool()
        XCTAssertEqual(readValue, true)
    }
    
    func testReadFromString3F() {
        let json = Json(["Key1": "no"])
        let readValue = try? json["Key1"].toBool()
        XCTAssertEqual(readValue, false)
    }
    
    func testReadFromString4T() {
        let json = Json(["Key1": "y"])
        let readValue = try? json["Key1"].toBool()
        XCTAssertEqual(readValue, true)
    }
    
    func testReadFromString4F() {
        let json = Json(["Key1": "n"])
        let readValue = try? json["Key1"].toBool()
        XCTAssertEqual(readValue, false)
    }
    
    func testReadFromString5T() {
        let json = Json(["Key1": "1"])
        let readValue = try? json["Key1"].toBool()
        XCTAssertEqual(readValue, true)
    }
    
    func testReadFromString5F() {
        let json = Json(["Key1": "0"])
        let readValue = try? json["Key1"].toBool()
        XCTAssertEqual(readValue, false)
    }
    
    func testReadFromString5E() {
        let json = Json(["Key1": "3"])
        do {
            let _ = try json["Key1"].toBool()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromInt() {
        let json = Json(["Key1": 2])
        do {
            let _ = try json["Key1"].toBool()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromInt2() {
        let json = Json(["Key1": 0])
        let readValue = try? json["Key1"].toBool()
        XCTAssertEqual(readValue, false)
    }
    
    func testReadFromInt3() {
        let json = Json(["Key1": 1])
        let readValue = try? json["Key1"].toBool()
        XCTAssertEqual(readValue, true)
    }
    
    func testReadFromDouble() {
        let json = Json(["Key1": 1.0])
        let readValue = try? json["Key1"].toBool()
        XCTAssertEqual(readValue, true)
    }
    
    func testReadFromDouble2() {
        let json = Json(["Key1": 1.1])
        do {
            let _ = try json["Key1"].toBool()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromBool() {
        let json = Json(["Key1": true])
        let readValue = try? json["Key1"].toBool()
        XCTAssertEqual(readValue, true)
    }
    
    func testReadFromDictionary() {
        let json = Json(["Key1": ["Key2": "Value2"]])
        do {
            let _ = try json["Key1"].toBool()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromArray() {
        let json = Json(["Key1": ["Value1", "Value2"]])
        do {
            let _ = try json["Key1"].toBool()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testReadFromNull() {
        let json = Json([:])
        do {
            let _ = try json["Key1"].toBool()
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
}
