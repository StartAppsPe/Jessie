//
//  JessieBool.swift
//  Jessie
//
//  Created by Gabriel Lanata on 19/10/16.
//
//

extension Bool: JsonConvertible {
    
    public init(json: Json) throws {
        switch json {
        case .bool(let value):
            self = value
            return
        case .int(let int):
            if int == 1 {
                self = true
                return
            } else if int == 0 {
                self = false
                return
            }
        case .string(let string):
            let s = string.lowercased()
            if s == "true" || s == "yes" || s == "y" || s == "1" {
                self = true
                return
            } else if s == "false" || s == "no" || s == "n" || s == "0" {
                self = false
                return
            }
        default: ()
        }
        throw JsonError.couldNotParseValue(json, "bool")
    }
    
    public func toJson() -> Json {
        return .bool(self)
    }
    
}

public extension Json {
    
    public func toBool() throws -> Bool {
        return try Bool(json: self)
    }
    
    public var bool: Bool? {
        return try? Bool(json: self)
    }
    
}

extension Json: ExpressibleByBooleanLiteral {
    
    public init(booleanLiteral value: BooleanLiteralType) {
        self = .bool(value)
    }
    
}
