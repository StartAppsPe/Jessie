//
//  JessieFloat.swift
//  Jessie
//
//  Created by Gabriel Lanata on 19/10/16.
//
//

extension Float: JsonConvertible {
    
    public init(json: Json) throws {
        self = Float(try Double(json: json))
    }
    
    public func toJson() -> Json {
        return .double(Double(self))
    }
    
}
