//
//  JessieUrl.swift
//  Jessie
//
//  Created by Gabriel Lanata on 19/10/16.
//
//

import Foundation

extension URL: JsonConvertible {
    
    public init(json: Json) throws {
        guard case let .string(string) = json else {
            throw JsonError.couldNotParseValue(json, "url")
        }
        guard let value = URL(string: string) else {
            throw JsonError.couldNotParseValue(json, "url")
        }
        self = value
    }
    
    public func toJson() -> Json {
        return .string(self.absoluteString)
    }
    
}

public extension Json {
    
    public func toUrl() throws -> URL {
        return try URL(json: self)
    }
    
    public var url: URL? {
        return try? URL(json: self)
    }
    
}
