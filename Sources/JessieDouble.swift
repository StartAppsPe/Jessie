//
//  JessieDouble.swift
//  Jessie
//
//  Created by Gabriel Lanata on 19/10/16.
//
//

extension Double: JsonConvertible {
    
    public init(json: Json) throws {
        guard case let .double(value) = json else {
            throw JsonError.couldNotParseValue(json, "double")
        }
        self = value
    }
    
    public func toJson() -> Json {
        return .double(self)
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
        self = .double(value)
    }
    
}
