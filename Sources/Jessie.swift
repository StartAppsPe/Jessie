//
//  Jessie.swift
//  Jessie
//
//  Created by Gabriel Lanata on 16/10/16.
//
//

import Foundation

public enum JsonError: Error {
    case unsupportedType(String)
    case couldNotParseRawString(String)
    case couldNotParseData
    case couldNotParseValue(Any, String)
    case indexOutOfBounds(Int, Int)
    case keyNotFound(String)
}

public struct Json {
    
    public let rawValue: Any?
    
    public static func parse(_ data: Data) throws -> Json {
        let rawValue = try JSONSerialization.jsonObject(with: data, options: [])
        return try Json(rawValue)
    }
    
    public func data(prettyPrinted: Bool = false) throws -> Data {
        guard let rawValue = rawValue else {
            return Data()
        }
        if let data = (rawValue as? String)?.data(using: .utf8) {
            return data
        }
        if var rawNumber = rawValue as? Int {
            return Data(bytes: &rawNumber, count: MemoryLayout<Int>.size)
        }
        if var rawNumber = rawValue as? Double {
            return Data(bytes: &rawNumber, count: MemoryLayout<Double>.size)
        }
        if var rawBool = rawValue as? Bool {
            return Data(bytes: &rawBool, count: MemoryLayout<Bool>.size)
        }
        let options: JSONSerialization.WritingOptions = (prettyPrinted ? [.prettyPrinted] : [] )
        return try JSONSerialization.data(withJSONObject: rawValue, options: options)
    }
    
    public static func parse(_ bytes: [UInt8]) throws -> Json {
        let data = Data(bytes)
        return try parse(data)
    }
    
    public func bytes() throws -> [UInt8] {
        let data = try self.data(prettyPrinted: false)
        return [UInt8](data)
    }
    
    public static func parse(_ string: String, enconding: String.Encoding = .utf8) throws -> Json {
        guard let data = string.data(using: enconding) else {
            throw JsonError.couldNotParseRawString(string)
        }
        return try parse(data)
    }
    
    public func rawString(prettyPrinted: Bool = true, enconding: String.Encoding = .utf8) throws -> String {
        if let rawString = rawValue as? String {
            return rawString
        }
        if let rawNumber = rawValue as? Int {
            return "\(rawNumber)"
        }
        if let rawNumber = rawValue as? Double {
            return "\(rawNumber)"
        }
        if let rawBool = rawValue as? Bool {
            return "\(rawBool)"
        }
        let data = try self.data(prettyPrinted: prettyPrinted)
        guard data.count > 0 else { return "NULL" }
        guard let rawString = String(data: data, encoding: enconding) else {
            throw JsonError.couldNotParseData
        }
        return rawString
    }
    
    public init(_ rawValue: Any) throws {
        if let rawValue = rawValue as? String {
            self.rawValue = rawValue
            return
        }
        if let rawValue = rawValue as? Int {
            self.rawValue = rawValue
            return
        }
        if let rawValue = rawValue as? Double {
            self.rawValue = rawValue
            return
        }
        if let rawValue = rawValue as? Bool {
            self.rawValue = rawValue
            return
        }
        if let rawDictionary = rawValue as? [String: Any] {
            for (_, rawValue) in rawDictionary {
                let _ = try Json(rawValue)
            }
            self.rawValue = rawValue
            return
        }
        if let rawArray = rawValue as? [Any] {
            for rawValue in rawArray {
                let _ = try Json(rawValue)
            }
            self.rawValue = rawArray
            return
        }
        if let rawValue = rawValue as? Json {
            self.rawValue = rawValue.rawValue
            return
        }
        throw JsonError.couldNotParseValue(rawValue, "any")
    }
    
    public init() {
        self.rawValue = nil
    }
    
    public static var null: Json {
        return Json()
    }
    
}

extension Json: CustomStringConvertible {
    
    public var description: String {
        do {
            return try rawString()
        } catch {
            return "\(error)"
        }
    }
    
}


public protocol JsonInitializable {
    init(json: Json) throws
}
public protocol JsonRepresentable {
    func toJson() throws -> Json
}
public protocol JsonConvertible: JsonInitializable, JsonRepresentable {}


public enum JsonType {
    case dictionary([String: Json])
    case array([Json])
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case null
    case unknown
}

public extension Json {
    
    public var type: JsonType {
        if rawValue == nil { return .null }
        if let value = try? self.toDictionary() { return .dictionary(value) }
        if let value = try? self.toArray()      { return .array(value)      }
        if let value = try? self.toString()     { return .string(value)     }
        if let value = try? self.toInt()        { return .int(value)        }
        if let value = try? self.toDouble()     { return .double(value)     }
        if let value = try? self.toBool()       { return .bool(value)       }
        print("Warning: Unknown Json type detected (\(rawValue))")
        return .unknown
    }
    
}


public protocol JsonSubscriptable {}
extension String: JsonSubscriptable {}
extension Int: JsonSubscriptable {}

public extension Json {
    
    public func read(_ subs: [JsonSubscriptable]) throws -> Json {
        var json = self
        for sub in subs {
            json = try json.read(sub)
        }
        return json
    }
    
    public func read(_ sub: JsonSubscriptable) throws -> Json {
        if let key = sub as? String {
            return try self.read(key)
        } else if let index = sub as? Int {
            return try self.read(index)
        }
        abort() // Should never get here
    }
    
    public func read(_ key: String) throws -> Json {
        let dictionary = try self.toDictionary()
        guard let value = dictionary[key] else {
            throw JsonError.keyNotFound(key)
        }
        return value
    }
    
    public func read(_ index: Int) throws -> Json {
        let array = try self.toArray()
        guard array.count > index else {
            throw JsonError.indexOutOfBounds(index, array.count)
        }
        return array[index]
    }
    
    public mutating func set(_ key: String, value newValue: Json) throws {
        do {
            var dictionary = try self.toRawDictionary()
            dictionary[key] = newValue.rawValue
            self = try Json(dictionary)
        } catch {
            print("Error: \(error)")
        }
    }
    
    public mutating func set(_ index: Int, value newValue: Json) throws {
        var array = try self.toRawArray()
        guard array.count >= index else {
            throw JsonError.indexOutOfBounds(index, array.count)
        }
        if let newValue = newValue.rawValue {
            if array.count == index {
                array.append(newValue)
            } else {
                array[index] = newValue
            }
        } else {
            guard array.count == index else {
                throw JsonError.indexOutOfBounds(index, array.count)
            }
            array.remove(at: index)
        }
        self = try Json(array)
    }
    
    public subscript(index: Int) -> Json {
        get {
            do {
                return try self.read(index)
            } catch {
                print("Error: \(error)")
                return Json.null
            }
        }
        set {
            try! set(index, value: newValue)
        }
    }
    
    public subscript(key: String) -> Json {
        get {
            do {
                return try self.read(key)
            } catch {
                print("Error: \(error)")
                return Json.null
            }
        }
        set {
            try! set(key, value: newValue)
        }
    }
    
}



precedencegroup JsonParsePrecedence {
    associativity: left
    higherThan: AssignmentPrecedence
}
infix operator <~ : JsonParsePrecedence


public extension Json {
    
    public func toJson() throws -> Json {
        return self
    }
    
    public var json: Json {
        return self
    }
    
}

public func <~(json: Json, subs: [JsonSubscriptable]) throws -> Json {
    return try json.read(subs).toJson()
}


public extension Json {
    
    public func toRawArray() throws -> [Any] {
        guard let rawArray = rawValue as? [Any] else {
            throw JsonError.couldNotParseValue(rawValue, "array")
        }
        return rawArray
    }
    
    public func toArray() throws -> [Json] {
        let rawArray = try toRawArray()
        var array = [Json]()
        for (value) in rawArray {
            array.append(try Json(value))
        }
        return array
    }
    
    public var array: [Json]? {
        return try? self.toArray()
    }
    
}

public func <~(json: Json, subs: [JsonSubscriptable]) throws -> [Json] {
    return try json.read(subs).toArray()
}

extension Json: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: Any...) {
        try! self.init(elements)
    }
    
}




public extension Json {
    
    public func toRawDictionary() throws -> [String: Any] {
        guard let rawDict = rawValue as? [String: Any] else {
            throw JsonError.couldNotParseValue(rawValue, "dictionary")
        }
        return rawDict
    }
    
    public func toDictionary() throws -> [String: Json] {
        let rawDict = try toRawDictionary()
        var dict = [String : Json](minimumCapacity: rawDict.count)
        for (key, value) in rawDict {
            dict[key] = try Json(value)
        }
        return dict
    }
    
    public var dictionary: [String : Json]? {
        return try? self.toDictionary()
    }
    
}

public func <~(json: Json, subs: [JsonSubscriptable]) throws -> [String: Json] {
    return try json.read(subs).toDictionary()
}

extension Json: ExpressibleByDictionaryLiteral {
    
    public init(dictionaryLiteral elements: (String, Any)...) {
        var dictionary = [String : Any](minimumCapacity: elements.count)
        for element in elements {
            dictionary[element.0] = element.1
        }
        try! self.init(dictionary)
    }
    
}





public extension Json {
    
    public func toString() throws -> String {
        guard let value = rawValue as? String else {
            throw JsonError.couldNotParseValue(rawValue, "string")
        }
        return value
    }
    
    public var string: String? {
        return try? self.toString()
    }
    
}

public func <~(json: Json, subs: [JsonSubscriptable]) throws -> String {
    return try json.read(subs).toString()
}

extension Json: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: StringLiteralType) {
        try! self.init(value as Any)
    }
    
    public init(extendedGraphemeClusterLiteral value: StringLiteralType) {
        try! self.init(value as Any)
    }
    
    public init(unicodeScalarLiteral value: StringLiteralType) {
        try! self.init(value as Any)
    }
    
}






public extension Json {
    
    public func toInt() throws -> Int {
        guard let value = rawValue as? Int else {
            throw JsonError.couldNotParseValue(rawValue, "int")
        }
        return value
    }
    
    public var int: Int? {
        return try? self.toInt()
    }
    
}

public func <~(json: Json, subs: [JsonSubscriptable]) throws -> Int {
    return try json.read(subs).toInt()
}

extension Json: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: IntegerLiteralType) {
        try! self.init(value as Any)
    }
    
}





public extension Json {
    
    public func toDouble() throws -> Double {
        guard let value = rawValue as? Double else {
            throw JsonError.couldNotParseValue(rawValue, "double")
        }
        return value
    }
    
    public var double: Double? {
        return try? self.toDouble()
    }
    
}

public func <~(json: Json, subs: [JsonSubscriptable]) throws -> Double {
    return try json.read(subs).toDouble()
}

extension Json: ExpressibleByFloatLiteral {
    
    public init(floatLiteral value: FloatLiteralType) {
        try! self.init(value as Any)
    }
    
}




public extension Json {
    
    public func toBool() throws -> Bool {
        guard let value = rawValue as? Bool else {
            guard let intValue = rawValue as? Int else {
                throw JsonError.couldNotParseValue(rawValue, "bool")
            }
            switch intValue {
            case 0:  return false
            case 1:  return true
            default: throw JsonError.couldNotParseValue(rawValue, "bool")
            }
        }
        return value
    }
    
    public var bool: Bool? {
        return try? self.toBool()
    }
    
}

public func <~(json: Json, subs: [JsonSubscriptable]) throws -> Bool {
    return try json.read(subs).toBool()
}

extension Json: ExpressibleByBooleanLiteral {
    
    public init(booleanLiteral value: BooleanLiteralType) {
        try! self.init(value as Any)
    }
    
}

