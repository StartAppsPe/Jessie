//
//  ValueNull.swift
//  Jessie
//
//  Created by Gabriel Lanata on 27/11/16.
//
//

import Foundation

extension NSNull: JsonRepresentable {
    
//    public init(json: Json) throws {
//        guard case .null = json else {
//            throw JsonError.couldNotParseValue(json, "null")
//        }
//        self = NSNull.null
//    }
    
    public func toJson() -> Json {
        return .null
    }
    
}

//public extension Json {
//    
//    public func toNull() throws -> NSNull {
//        return try NSNull(json: self)
//    }
//    
//    public var null: NSNull? {
//        return try? NSNull(json: self)
//    }
//    
//}

extension Json: ExpressibleByNilLiteral {
    
    public init(nilLiteral: ()) {
        self = .null
    }
    
}
