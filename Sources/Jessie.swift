//
//  Jessie.swift
//  Jeeves
//
//  Created by Gabriel Lanata on 16/10/16.
//
//

import Foundation

public enum JsonParsingError: Error {
    case couldNotParseValue(Any, JsonType), indexOutOfBounds(Int, Int), keyNotFound(String)
}

public struct Json {
    
    public let rawValue: Any?
    
    public init(_ data: Data) throws {
        self.rawValue = try JSONSerialization.jsonObject(with: data, options: [])
    }
    
    public func data(prettyPrinted: Bool = false) throws -> Data {
        let options: JSONSerialization.WritingOptions = (prettyPrinted ? [.prettyPrinted] : [] )
        return try JSONSerialization.data(withJSONObject: rawValue, options: options)
    }
    
    public init(_ bytes: [UInt8]) throws {
        let data = Data(bytes)
        try self.init(data)
    }
    
    public func bytes() throws -> [UInt8] {
        let data = try self.data()
        return [UInt8](data)
    }
    
    public init(_ rawString: String) throws {
        let data = try rawString.data()
        try self.init(data)
    }
    
    public func rawString(prettyPrinted: Bool = true) throws -> String {
        let data = try self.data(prettyPrinted: prettyPrinted)
        let rawString = try String(data: data)
        return rawString
    }
    
    
    public init(_ rawValue: Any) {
        self.rawValue = rawValue
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

public enum JsonType: String {
    case dictionary
    case array
    case string
    case int
    case double
    case bool
    case null
    case unknown
}

public extension Json {
    
    public var type: JsonType {
        if rawValue == nil { return .null }
        if let _ = try? self.toDictionary() { return .dictionary }
        if let _ = try? self.toArray()      { return .array }
        if let _ = try? self.toString()     { return .string }
        if let _ = try? self.toInt()        { return .int }
        if let _ = try? self.toDouble()     { return .double }
        if let _ = try? self.toBool()       { return .bool }
        Log.warning("Unknown Json type detected (\(rawValue))")
        return .unknown
    }
    
}


public protocol JsonSubscriptable {}
extension String: JsonSubscriptable {}
extension Int: JsonSubscriptable {}

public extension Json {
    
    public func dive(_ subs: [JsonSubscriptable]) throws -> Json {
        var json = self
        for sub in subs {
            json = try json.dive(sub)
        }
        return json
    }
    
    public func dive(_ sub: JsonSubscriptable) throws -> Json {
        if let key = sub as? String {
            return try self.dive(key)
        } else if let index = sub as? Int {
            return try self.dive(index)
        }
        abort() // Should never get here
    }
    
    public func dive(_ key: String) throws -> Json {
        let dictionary = try self.toDictionary()
        guard let value = dictionary[key] else {
            throw JsonParsingError.keyNotFound(key)
        }
        return value
    }
    
    public func dive(_ index: Int) throws -> Json {
        let array = try self.toArray()
        guard array.count > index else {
            throw JsonParsingError.indexOutOfBounds(index, array.count)
        }
        return array[index]
    }
    
    public subscript(index: Int) -> Json {
        get {
            do {
                return try self.dive(index)
            } catch {
                Log.error(error)
                return Json.null
            }
        }
        set {
            do {
                Log.warning("Editing Json functionality has not been tested")
                var array = try self.toArray()
                guard array.count > index else {
                    throw JsonParsingError.indexOutOfBounds(index, array.count)
                }
                // This is useless because it is a struct
                array[index] = newValue
            } catch {
                Log.error(error)
            }
        }
    }
    
    public subscript(key: String) -> Json {
        get {
            do {
                return try self.dive(key)
            } catch {
                Log.error(error)
                return Json.null
            }
        }
        set {
            do {
                Log.warning("Editing Json functionality has not been tested")
                var dictionary = try self.toDictionary()
                // This is useless because it is a struct
                dictionary[key] = newValue
            } catch {
                Log.error(error)
            }
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
    return try json.dive(subs).toJson()
}


public extension Json {
    
    public func toArray() throws -> [Json] {
        if let rawArray = rawValue as? [Any] {
            var array = [Json]()
            for (value) in rawArray {
                array.append(Json(value))
            }
            return array
        }
        throw JsonParsingError.couldNotParseValue(rawValue, .array)
    }
    
    public var array: [Json]? {
        return try? self.toArray()
    }
    
}

public func <~(json: Json, subs: [JsonSubscriptable]) throws -> [Json] {
    return try json.dive(subs).toArray()
}


public extension Json {
    
    public func toDictionary() throws -> [String: Json] {
        if let rawDict = rawValue as? [String: Any] {
            var dict = [String : Json](minimumCapacity: rawDict.count)
            for (key, value) in rawDict {
                dict[key] = Json(value)
            }
            return dict
        }
        throw JsonParsingError.couldNotParseValue(rawValue, .dictionary)
    }
    
    public var dictionary: [String : Json]? {
        return try? self.toDictionary()
    }
    
}

public func <~(json: Json, subs: [JsonSubscriptable]) throws -> [String: Json] {
    return try json.dive(subs).toDictionary()
}


public extension Json {
    
    public func toString() throws -> String {
        if let value = rawValue as? String {
            return value
        }
        throw JsonParsingError.couldNotParseValue(rawValue, .string)
    }
    
    public var string: String? {
        return try? self.toString()
    }
    
}

public func <~(json: Json, subs: [JsonSubscriptable]) throws -> String {
    return try json.dive(subs).toString()
}


public extension Json {
    
    public func toInt() throws -> Int {
        if let value = rawValue as? Int {
            return value
        }
        throw JsonParsingError.couldNotParseValue(rawValue, .int)
    }
    
    public var int: Int? {
        return try? self.toInt()
    }
    
}

public func <~(json: Json, subs: [JsonSubscriptable]) throws -> Int {
    return try json.dive(subs).toInt()
}


public extension Json {
    
    public func toDouble() throws -> Double {
        if let value = rawValue as? Double {
            return value
        }
        throw JsonParsingError.couldNotParseValue(rawValue, .double)
    }
    
    public var double: Double? {
        return try? self.toDouble()
    }
    
}

public func <~(json: Json, subs: [JsonSubscriptable]) throws -> Double {
    return try json.dive(subs).toDouble()
}


public extension Json {
    
    public func toBool() throws -> Bool {
        if let value = rawValue as? Bool {
            return value
        }
        throw JsonParsingError.couldNotParseValue(rawValue, .bool)
    }
    
    public var bool: Bool? {
        return try? self.toBool()
    }
    
}

public func <~(json: Json, subs: [JsonSubscriptable]) throws -> Bool {
    return try json.dive(subs).toBool()
}

