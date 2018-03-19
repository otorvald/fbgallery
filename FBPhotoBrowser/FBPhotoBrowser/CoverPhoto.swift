//
//  CoverPhoto.swift
//
//  Created by Max Bystryk on 06.09.17
//  Copyright (c) . All rights reserved.
//

import ObjectMapper

public class CoverPhoto: Mappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        
        static let id = "id"
        static let createdTime = "created_time"
    }
    
    // MARK: Properties
    public var id: String?
    public var createdTime: String?
    
    // MARK: ObjectMapper Initializers
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public required init?(map: Map){
        
    }
    
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public func mapping(map: Map) {
        id <- map[SerializationKeys.id]
        createdTime <- map[SerializationKeys.createdTime]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = createdTime { dictionary[SerializationKeys.createdTime] = value }
        return dictionary
    }
    
}
