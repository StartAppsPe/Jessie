//
//  Parsers.swift
//  Jessie
//
//  Created by Gabriel Lanata on 19/10/16.
//
//

import Foundation

public extension Json {
    
    public static func parse(string: String, enconding: String.Encoding = .utf8) throws -> Json {
        guard let data = string.data(using: enconding) else {
            throw JsonError.couldNotParseRawString(string)
        }
        return try parse(data: data)
    }
    
    public static func parse(bytes: [UInt8]) throws -> Json {
        let data = Data(bytes)
        return try parse(data: data)
    }
    
    public static func parse(data: Data) throws -> Json {
        let rawAny = try JSONSerialization.jsonObject(with: data, options: [])
        return try parse(any: rawAny)
    }
    
    public static func parse(any: Any) throws -> Json {
        return .unparsed(any)
    }
    
    public mutating func parse() throws {
        self = try self.parsed()
    }
    
    public func parsed() throws -> Json {
        switch self {
        case .unparsed(let any):
            if let rawDictionary = any as? [String: Any] {
                var dictionary: [String: Json] = [:]
                for (key, value) in rawDictionary {
                    dictionary[key] = .unparsed(value)
                }
                return .dictionary(dictionary)
            } else if let rawArray = any as? [Any] {
                let array: [Json] = rawArray.map({ .unparsed($0) })
                return .array(array)
            } else if let rawValue = any as? String {
                return .string(rawValue)
            } else if let rawValue = any as? Int {
                return .int(rawValue)
            } else if let rawValue = any as? Double {
                return .double(rawValue)
            } else if let rawValue = any as? Bool {
                return .bool(rawValue)
            } else if let rawValue = any as? JsonRepresentable {
                return Json(rawValue)
            }
            throw JsonError.couldNotParseValue(any, "any")
        default:
            return self
        }
    }
    
    public func rawString(pretty: Bool = true) -> String {
        let l = (pretty ? "\n" : "")
        let s = (pretty ? " "  : "")
        switch self {
        case .unparsed(_):
            return try! self.parsed().rawString(pretty: pretty)
        case .dictionary(let dictionary):
            var string = "{"
            for (key, value) in dictionary {
                if string.characters.count > 1 { string += "," }
                string += "\(l)\(s)\(s)\"\(key)\":\(s)\(value.rawString(pretty: pretty))"
            }
            string += "\(l)}"
            return string
        case .array(let array):
            var string = "["
            for value in array {
                if string.characters.count > 1 { string += "," }
                string += "\(l)\(s)\(s)\(value.rawString(pretty: pretty))"
            }
            string += "\(l)]"
            return string
        case .string(let value):
            return "\"\(value)\""
        case .int(let value):
            return "\(value)"
        case .double(let value):
            return "\(value)"
        case .bool(let value):
            return "\(value)"
        case .null:
            return "null"
        }
    }
    
    public func data(pretty: Bool = false, encoding: String.Encoding = .utf8) throws -> Data {
        let rawString = self.rawString(pretty: pretty)
        guard let data = rawString.data(using: encoding) else {
            throw JsonError.couldNotParseRawString(rawString)
        }
        return data
    }
    
    public func bytes() throws -> [UInt8] {
        let data = try self.data(pretty: false)
        return [UInt8](data)
    }
    
}
