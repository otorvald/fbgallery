//
//  Data.swift
//
//  Created by Max Bystryk on 06.09.17
//  Copyright (c) . All rights reserved.
//

import ObjectMapper

public class AlbumProperties: Mappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let id = "id"
        static let name = "name"
        static let description = "description"
        static let coverPhoto = "cover_photo"
        static let picture = "picture"
        
    }
    
    // MARK: Properties
    public var id: String?
    public var name: String?
    public var description: String?
    public var coverPhoto: CoverPhoto?
    public var picture: Picture?
    
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
        name <- map[SerializationKeys.name]
        description <- map[SerializationKeys.description]
        coverPhoto <- map[SerializationKeys.coverPhoto]
        picture <- map[SerializationKeys.picture]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = name { dictionary[SerializationKeys.name] = value }
        if let value = description { dictionary[SerializationKeys.description] = value }
        if let value = coverPhoto { dictionary[SerializationKeys.coverPhoto] = value.dictionaryRepresentation() }
        if let value = picture { dictionary[SerializationKeys.picture] = value.dictionaryRepresentation() }
        return dictionary
    }
    
}
