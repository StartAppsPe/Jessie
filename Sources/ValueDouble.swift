//
//  ValueDouble.swift
//  Jessie
//
//  Created by Gabriel Lanata on 19/10/16.
//
//

import Foundation

extension Double: JsonConvertible {
    
    public init(json: Json) throws {
        guard case let .number(value) = json else {
            throw JsonError.couldNotParseValue(json, "double")
        }
        self = value.doubleValue
    }
    
    public func toJson() -> Json {
        return .number(self as NSNumber)
    }
    
}

public extension Json {
    
    public func toDouble() throws -> Double {
        return try Double(json: self)
    }
    
    public var double: Double? {
        return try? Double(json: self)
    }
    
}

extension Json: ExpressibleByFloatLiteral {
    
    public init(floatLiteral value: FloatLiteralType) {
        self = .number(value as NSNumber)
    }
    
}
