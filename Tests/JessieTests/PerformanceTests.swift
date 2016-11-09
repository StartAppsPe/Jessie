//
//  PerformanceTests.swift
//  Jessie
//
//  Created by Gabriel Lanata on 24/10/16.
//
//

import XCTest
import Jessie
import Foundation

class Jessie_Tests: XCTestCase {
    
    func testPerformance() {
        let fetchedData = self.data
        self.measure {
            let json = try! Json.parse(data: fetchedData)
            let programRA = json["ProgramList"]["Programs"].array!
            //            let programs = try! programRA.map(Program.init)
            print("programRA",programRA[0])
            XCTAssert(programRA.count > 1000)
            let programRA2 = programRA[0]["ProgramId"].string!
            print("programRA",programRA[0]["ProgramId"].string!)
            XCTAssert(programRA2 == "EP000441070779")
        }
    }
    
    private lazy var data:Data = {
        let rawFullFilePath = "/Users/Gabriel/Dropbox/Projects/JSONShootout/Tests/JSONShootoutTests/Large.json"
        let filePath = URL(fileURLWithPath: rawFullFilePath)
        return try! Data(contentsOf: filePath)
    }()
    
}
