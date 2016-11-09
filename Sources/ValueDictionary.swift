//
//  ValueDictionary.swift
//  Jessie
//
//  Created by Gabriel Lanata on 19/10/16.
//
//

// TODO: Update this when Swift 3.1 is released
extension Dictionary where Key: ExpressibleByStringLiteral, Value: JsonRepresentable {
    
    public func toJson() -> Json {
        var dictionary = [String: Json](minimumCapacity: self.count)
        for (key, value) in self {
            dictionary[String(describing: key)] = Json(value)
        }
        return .dictionary(dictionary)
    }
    
}

public extension Json {
    
    public func toDictionary() throws -> [String: Json] {
        guard case let .dictionary(value) = try self.parsed() else {
            throw JsonError.couldNotParseValue(self, "dictionary")
        }
        return value
    }
    
    public var dictionary: [String : Json]? {
        return try? self.toDictionary()
    }
    
}

extension Json: ExpressibleByDictionaryLiteral {
    
    public init(dictionaryLiteral elements: (String, JsonRepresentable?)...) {
        var dictionary = [String : Json](minimumCapacity: elements.count)
        for (key, value) in elements {
            dictionary[key] = value?.toJson() ?? .null
        }
        self = .dictionary(dictionary)
    }
    
}
