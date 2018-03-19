//
//  AlbumData.swift
//
//  Created by Max Bystryk on 06.09.17
//  Copyright (c) . All rights reserved.
//

import ObjectMapper

public class AlbumData: Mappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let data = "data"
    }
    
    // MARK: Properties
    public var data: [AlbumProperties]?
    
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
        data <- map[SerializationKeys.data]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = data { dictionary[SerializationKeys.data] = value.map { $0.dictionaryRepresentation() } }
        return dictionary
    }
    
}
