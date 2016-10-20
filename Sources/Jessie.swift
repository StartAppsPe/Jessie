//
//  Jessie.swift
//  Jessie
//
//  Created by Gabriel Lanata on 16/10/16.
//
//

typealias JSON = Json
typealias Jessie = Json

public enum Json {
    case dictionary([String: Json])
    case array([Json])
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case null
}

public extension Json {
    
    public init() {
        self = .null
    }
    
    public init(_ rawValue: JsonRepresentable) {
        self = rawValue.toJson()
    }
    
    public init (_ rawDictionary: [String: JsonRepresentable]) {
        var dictionary = [String : Json](minimumCapacity: rawDictionary.count)
        for (key, value) in rawDictionary {
            dictionary[key] = Json(value)
        }
        self = .dictionary(dictionary)
    }
    
    public init (_ rawDictionary: [String: Json]) {
        self = .dictionary(rawDictionary)
    }
    
    public init (_ rawArray: [JsonRepresentable]) {
        self = .array(rawArray.map({ Json($0) }))
    }
    
    public init (_ rawArray: [Json]) {
        self = .array(rawArray)
    }
    
}

extension Json: JsonConvertible {
    
    public init(json: Json) throws {
        self = json
    }
    
    public func toJson() -> Json {
        return self
    }
    
}

extension Json: CustomStringConvertible {
    
    public var description: String {
        return rawString(pretty: true)
    }
    
}

public protocol JsonInitializable { init(json: Json) throws }
public protocol JsonRepresentable { func toJson() -> Json }
public protocol JsonConvertible: JsonInitializable, JsonRepresentable {}

