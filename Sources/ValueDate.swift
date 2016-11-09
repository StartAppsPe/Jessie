//
//  ValueDate.swift
//  Jessie
//
//  Created by Gabriel Lanata on 19/10/16.
//
//

import Foundation

extension Date: JsonConvertible {
    
    public init(json: Json) throws {
        guard case let .string(string) = try json.parsed() else {
            throw JsonError.couldNotParseValue(json, "date")
        }
        guard let value = Json.dateFormatter.date(from: string) else {
            throw JsonError.couldNotParseValue(json, "date")
        }
        self = value
    }
    
    public func toJson() -> Json {
        return .string(Json.dateFormatter.string(from: self))
    }
    
}

public extension Json {
    
    public func toDate() throws -> Date {
        return try Date(json: self)
    }
    
    public var date: Date? {
        return try? Date(json: self)
    }
    
}


private var _jsonDateFormatter: DateFormatter?

public extension Json {
    
    // Defaults to ISO standard date
    public static var dateFormatter: DateFormatter {
        if _jsonDateFormatter == nil {
            _jsonDateFormatter = DateFormatter()
            _jsonDateFormatter!.locale = Locale(identifier: "en_US_POSIX")
            _jsonDateFormatter!.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        }
        return _jsonDateFormatter!
    }
    
}
