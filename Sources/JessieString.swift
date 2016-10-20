//
//  JessieString.swift
//  Jessie
//
//  Created by Gabriel Lanata on 19/10/16.
//
//

extension String: JsonConvertible {
    
    public init(json: Json) throws {
        guard case let .string(value) = json else {
            throw JsonError.couldNotParseValue(json, "string")
        }
        self = value
    }
    
    public func toJson() -> Json {
        return .string(self)
    }
    
}

public extension Json {
    
    public func toString() throws -> String {
        return try String(json: self)
    }
    
    public var string: String? {
        return try? String(json: self)
    }
    
}

extension Json: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: StringLiteralType) {
        self = .string(value)
    }
    
    public init(extendedGraphemeClusterLiteral value: StringLiteralType) {
        self = .string(value)
    }
    
    public init(unicodeScalarLiteral value: StringLiteralType) {
        self = .string(value)
    }
    
}
