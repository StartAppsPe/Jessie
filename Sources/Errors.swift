//
//  Errors.swift
//  Jessie
//
//  Created by Gabriel Lanata on 19/10/16.
//
//

public enum JsonError: Error {

    case couldNotParseRawString(String)
    case couldNotParseValue(Any, String)
    case jsonIsNotADictionary(Json)
    case jsonIsNotAnArray(Json)
    case indexOutOfBounds(Int, Int)
    case keyNotFound(String)
    
}

extension JsonError: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .couldNotParseRawString(let string):
            return "Could not parse raw string: \"\(string)\""
        case .couldNotParseValue(let value, let typeString):
            return "Could not parse value as \(typeString): \(value)"
        case .jsonIsNotADictionary(let json):
            return "Json is not a dictionary: \(json)"
        case .jsonIsNotAnArray(let json):
            return "Json is not an array: \(json)"
        case .indexOutOfBounds(let index, let count):
            return "Index is out of bounds: \(index) >= \(count)"
        case .keyNotFound(let key):
            return "Key not found in dictionary: \(key)"
        }
    }
    
}
