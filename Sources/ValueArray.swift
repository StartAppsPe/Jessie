//
//  ValueArray.swift
//  Jessie
//
//  Created by Gabriel Lanata on 19/10/16.
//
//

extension Sequence where Iterator.Element: JsonRepresentable {
    
    public func toJson() -> Json {
        return .array(self.map({ Json($0) }))
    }
    
}

extension Sequence where Iterator.Element == JsonRepresentable {
    
    public func toJson() -> Json {
        return .array(self.map({ Json($0) }))
    }
    
}

public extension Json {
    
    public func toArray() throws -> [Json] {
        guard case let .array(value) = try self.parsed() else {
            throw JsonError.couldNotParseValue(self, "array")
        }
        return value
    }
    
    public var array: [Json]? {
        return try? self.toArray()
    }
    
}

extension Json: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: Json...) {
        self = .array(elements)
    }
    
}




