//
//  ValueInt.swift
//  Jessie
//
//  Created by Gabriel Lanata on 19/10/16.
//
//

extension Int: JsonConvertible {
    
    public init(json: Json) throws {
        guard case let .int(value) = json else {
            throw JsonError.couldNotParseValue(json, "int")
        }
        self = value
    }
    
    public func toJson() -> Json {
        return .int(self)
    }
    
}

public extension Json {
    
    public func toInt() throws -> Int {
        return try Int(json: self)
    }
    
    public var int: Int? {
        return try? Int(json: self)
    }
    
}

extension Json: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: IntegerLiteralType) {
        self = .int(value)
    }
    
}

// Additional Int variations

extension Int64: JsonConvertible {
    public init(json: Json) throws {
        self = Int64(try Int(json: json))
    }
    public func toJson() -> Json {
        return .int(Int(self))
    }
}

extension Int32: JsonConvertible {
    public init(json: Json) throws {
        self = Int32(try Int(json: json))
    }
    public func toJson() -> Json {
        return .int(Int(self))
    }
}

extension Int16: JsonConvertible {
    public init(json: Json) throws {
        self = Int16(try Int(json: json))
    }
    public func toJson() -> Json {
        return .int(Int(self))
    }
}

extension Int8: JsonConvertible {
    public init(json: Json) throws {
        self = Int8(try Int(json: json))
    }
    public func toJson() -> Json {
        return .int(Int(self))
    }
}

extension UInt64: JsonConvertible {
    public init(json: Json) throws {
        self = UInt64(try Int(json: json))
    }
    public func toJson() -> Json {
        return .int(Int(self))
    }
}

extension UInt32: JsonConvertible {
    public init(json: Json) throws {
        self = UInt32(try Int(json: json))
    }
    public func toJson() -> Json {
        return .int(Int(self))
    }
}

extension UInt16: JsonConvertible {
    public init(json: Json) throws {
        self = UInt16(try Int(json: json))
    }
    public func toJson() -> Json {
        return .int(Int(self))
    }
}

extension UInt8: JsonConvertible {
    public init(json: Json) throws {
        self = UInt8(try Int(json: json))
    }
    public func toJson() -> Json {
        return .int(Int(self))
    }
}
