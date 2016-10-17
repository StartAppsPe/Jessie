import XCTest
@testable import Jessie

class ParseTests: XCTestCase {
    
    func testParseWithEmptyStringFail() {
        do {
            let _ = try Json.parse("")
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testParseWithSpaceStringFail() {
        do {
            let _ = try Json.parse(" ")
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testParseWithWeirdStringFail() {
        do {
            let _ = try Json.parse("%")
            XCTFail()
        } catch {
            // Correctly caught
        }
    }
    
    func testParseWithEmptyDict() {
        let json = try! Json.parse("{}")
        let jsonString = try! json.rawString(prettyPrinted: false)
        XCTAssertEqual(jsonString, "{}")
    }
    
    func testParseWithEmptyArray() {
        let json = try! Json.parse("[]")
        let jsonString = try! json.rawString(prettyPrinted: false)
        XCTAssertEqual(jsonString, "[]")
    }
    
    func testParseWithSimpleDictString() {
        let json = try! Json.parse("{\"Key1\":\"Value1\"}")
        let readValue = json["Key1"].string
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testParseWithSimpleArrayString() {
        let json = try! Json.parse("[\"Value1\",\"Value2\"]")
        let readValue = json[0].string
        XCTAssertEqual(readValue, "Value1")
    }
    
    func testParseWithSimpleDictInt() {
        let json = try! Json.parse("{\"Key1\":1}")
        let readValue = json["Key1"].int
        XCTAssertEqual(readValue, 1)
    }
    
    func testParseWithSimpleArrayBool() {
        let json = try! Json.parse("[1,2]")
        let readValue = json[0].int
        XCTAssertEqual(readValue, 1)
    }
    
    func testParseWithSimpleDictBool() {
        let json = try! Json.parse("{\"Key1\":true}")
        let readValue = json["Key1"].bool
        XCTAssertEqual(readValue, true)
    }
    
    func testParseWithSimpleArrayInt() {
        let json = try! Json.parse("[true,true]")
        let readValue = json[0].bool
        XCTAssertEqual(readValue, true)
    }
    
    func testParseWithComplexDict() {
        let json = try! Json.parse(SampleDictionaryJson)
        let readValue = json["name"]["last"].string
        XCTAssertEqual(readValue, "Perry")
        let readValue2 = json["isActive"].bool
        XCTAssertEqual(readValue2, false)
    }
    
    func testParseWithComplexArray() {
        let json = try! Json.parse(SampleArrayJson)
        let readValue = json[1]["name"]["last"].string
        XCTAssertEqual(readValue, "Perry")
        let readValue2 = json[1]["isActive"].bool
        XCTAssertEqual(readValue2, false)
    }
    
    func testParseWithComplexDictBytes() {
        let data = SampleDictionaryJson.data(using: .utf8)!
        let bytes = [UInt8](data)
        let json = try! Json.parse(bytes)
        let readValue = json["name"]["last"].string
        XCTAssertEqual(readValue, "Perry")
        let readValue2 = json["isActive"].bool
        XCTAssertEqual(readValue2, false)
    }
    
    func testParseBytes() {
        let data = SampleDictionaryJson.data(using: .utf8)!
        let bytes = [UInt8](data)
        let json = try! Json.parse(bytes)
        let bytes2 = try! json.bytes()
        XCTAssertGreaterThan(bytes2.count, 500)
        XCTAssertLessThan(bytes2.count, 600)
    }
    
}
