//
//  Subscripts.swift
//  Jessie
//
//  Created by Gabriel Lanata on 19/10/16.
//
//


public protocol JsonSubscriptable {}
extension String: JsonSubscriptable {}
extension Int: JsonSubscriptable {}

public extension Json {
    
    public func get(_ subs: [JsonSubscriptable]) throws -> Json {
        var json = self
        for sub in subs {
            json = try json.get(sub)
        }
        return json
    }
    
    public func get(_ sub: JsonSubscriptable) throws -> Json {
        if let key = sub as? String {
            return try self.get(key)
        } else {
            let index = sub as! Int
            return try self.get(index)
        }
    }
    
    public func get(_ key: String) throws -> Json {
        guard case let .dictionary(dictionary) = self else {
            throw JsonError.jsonIsNotADictionary(self)
        }
        guard let value = dictionary[key] else {
            throw JsonError.keyNotFound(key)
        }
        return value
    }
    
    public func get(_ index: Int) throws -> Json {
        guard case let .array(array) = self else {
            throw JsonError.jsonIsNotAnArray(self)
        }
        guard array.count > index else {
            throw JsonError.indexOutOfBounds(index, array.count)
        }
        return array[index]
    }
    
    public mutating func set(_ key: String, value newValue: Json?) throws {
        guard case var .dictionary(dictionary) = self else {
            throw JsonError.jsonIsNotADictionary(self)
        }
        dictionary[key] = newValue
        self = .dictionary(dictionary)
    }
    
    public mutating func set(_ index: Int, value newValue: Json?) throws {
        guard case var .array(array) = self else {
            throw JsonError.jsonIsNotAnArray(self)
        }
        guard array.count >= index else {
            throw JsonError.indexOutOfBounds(index, array.count)
        }
        if let newValue = newValue {
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
        self = .array(array)
    }
    
    public subscript(index: Int) -> Json {
        get {
            do {
                return try self.get(index)
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
                return try self.get(key)
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
