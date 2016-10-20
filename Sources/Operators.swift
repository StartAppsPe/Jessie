//
//  Operators.swift
//  Jessie
//
//  Created by Gabriel Lanata on 19/10/16.
//
//

precedencegroup JsonParsePrecedence {
    associativity: left
    higherThan: BitwiseShiftPrecedence
}
infix operator <~ : JsonParsePrecedence


public func <~(json: Json, subs: [JsonSubscriptable]) throws -> Json {
    return try json.get(subs)
}
public func <~<T: JsonInitializable>(json: Json, subs: [JsonSubscriptable]) throws -> T {
    return try T(json: try json.get(subs))
}
public func <~<T: JsonInitializable>(json: Json, subs: [JsonSubscriptable]) throws -> [T] {
    return try json.get(subs).toArray().map({ try T(json: $0) })
}
public func <~<T: JsonInitializable>(json: Json, subs: [JsonSubscriptable]) throws -> [String: T] {
    var newDict: [String: T] = [:]
    let dict = try json.get(subs).toDictionary()
    for (key, value) in dict {
        newDict[key] = try T(json: value)
    }
    return newDict
}


public func <~(json: Json, subs: [JsonSubscriptable]) throws -> Json? {
    return try? json.get(subs)
}
public func <~<T: JsonInitializable>(json: Json, subs: [JsonSubscriptable]) throws -> T? {
    return try? T(json: try json.get(subs))
}
public func <~<T: JsonInitializable>(json: Json, subs: [JsonSubscriptable]) throws -> [T]? {
    return try? json.get(subs).toArray().map({ try T(json: $0) })
}
public func <~<T: JsonInitializable>(json: Json, subs: [JsonSubscriptable]) throws -> [String: T]? {
    var newDict: [String: T] = [:]
    guard let dict = try? json.get(subs).toDictionary() else {
        return nil
    }
    for (key, value) in dict {
        newDict[key] = try T(json: value)
    }
    return newDict
}
